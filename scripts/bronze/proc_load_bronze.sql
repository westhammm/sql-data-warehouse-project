/*
=======================================================================================
Stored Procedure: Load Bronze Layer (Source > Bronze)
=======================================================================================
Script Purpose:
      This stored proceddure loads data into the 'bronze' schema from external CSV files.
      It perform the following actions:
      - Truncate the bronze tables before loading data.
      - Uses the 'BULK INSERT' command to load data from CSV files to bronze tables.

Parameters;
      None.
    This stored procedure does not accept any parametre or return any values.

Usage Exaamples:
    EXEC bronze.load_bronze;
=======================================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS

	BEGIN
		DECLARE @start_time DATETIME, @end_time DATETIME
		DECLARE @batch_start  DATETIME, @batch_end DATETIME ;
		BEGIN TRY
			SET @batch_start = GETDATE();
			PRINT '==========================================================';
			PRINT 'Loading Bronze layer';
			PRINT '==========================================================';

			PRINT '----------------------------------------------------------';
			PRINT 'Loading CRM Tables';
			PRINT '----------------------------------------------------------';

			SET @start_time = GETDATE();
			PRINT '>> Truncating Table: bronze.crm_cust_info';
			TRUNCATE TABLE bronze.crm_cust_info;

			PRINT '>> Inserting Data Into: bronze.crm_cust_info';
			BULK INSERT bronze.crm_cust_info
			FROM 'F:\TUTORIALS\SQL Full Course for Beginners (30 Hours) – From Zero to Hero\SQL PROJECTS\datasets\source_crm\cust_info.csv'
			WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '-------------------------------------------'

			SET @start_time = GETDATE();
			PRINT 'Truncating Table: bronze.crm_prd_info';
			TRUNCATE TABLE bronze.crm_prd_info;

			PRINT 'Inserting Data Into: bronze.crm_prd_info';
			BULK INSERT bronze.crm_prd_info
			FROM 'F:\TUTORIALS\SQL Full Course for Beginners (30 Hours) – From Zero to Hero\SQL PROJECTS\datasets\source_crm\prd_info.csv'
			WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '-------------------------------------------'

			SET @start_time = GETDATE();
			PRINT 'Truncating Table: bronze.crm_sales_details';
			TRUNCATE TABLE bronze.crm_sales_details;

			PRINT 'Inserting Data Into: bronze.crm_sales_details';
			BULK INSERT bronze.crm_sales_details
			FROM 'F:\TUTORIALS\SQL Full Course for Beginners (30 Hours) – From Zero to Hero\SQL PROJECTS\datasets\source_crm\sales_details.csv'
			WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '-------------------------------------------';

			PRINT '----------------------------------------------------------';
			PRINT 'Loading ERP Tables';
			PRINT '----------------------------------------------------------';

			SET @start_time = GETDATE();
			PRINT 'Truncating Table: bronze.erp_cust_az12';
			TRUNCATE TABLE bronze.erp_cust_az12;

			PRINT'Inserting data Into: bronze.erp_cust_az12';
			BULK INSERT bronze.erp_cust_az12
			FROM 'F:\TUTORIALS\SQL Full Course for Beginners (30 Hours) – From Zero to Hero\SQL PROJECTS\datasets\source_erp\cust_az12.csv'
			WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);

			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '-------------------------------------------';

			SET @start_time = GETDATE();
			PRINT 'Truncating Table: bronze.erp_loc_a101';
			TRUNCATE TABLE bronze.erp_loc_a101;

			PRINT 'Inserting Data Into: bronze.erp_loc_a101';
			BULK INSERT bronze.erp_loc_a101
			FROM 'F:\TUTORIALS\SQL Full Course for Beginners (30 Hours) – From Zero to Hero\SQL PROJECTS\datasets\source_erp\loc_a101.csv'
			WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '-------------------------------------------';


			SET @start_time = GETDATE();
			PRINT 'Truncate table: bronze.erp_px_cat_g1v2';
			TRUNCATE TABLE bronze.erp_px_cat_g1v2;

			PRINT 'Inserting data Into:  bronze.erp_px_cat_g1v2';
			BULK INSERT bronze.erp_px_cat_g1v2
			FROM 'F:\TUTORIALS\SQL Full Course for Beginners (30 Hours) – From Zero to Hero\SQL PROJECTS\datasets\source_erp\px_cat_g1v2.csv'
			WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
			PRINT '-------------------------------------------';

			SET @batch_end = GETDATE();
			PRINT '================================================='
			PRINT 'Loading Bronze layer Completed'
			PRINT 'Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start, @batch_end) AS VARCHAR) + 'seconds';
			PRINT '================================================='



		END TRY
		BEGIN CATCH
		PRINT '======================================================';
		PRINT 'Error Occured during Loading the Bronze Layer';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '=======================================================';

		END CATCH
	END
