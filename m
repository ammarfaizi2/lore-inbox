Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264679AbSLLN71>; Thu, 12 Dec 2002 08:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264686AbSLLN71>; Thu, 12 Dec 2002 08:59:27 -0500
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:40719 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S264679AbSLLN7H>; Thu, 12 Dec 2002 08:59:07 -0500
Date: Thu, 12 Dec 2002 08:06:47 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for drivers/scsi (2 of 4)
Message-ID: <20021212140647.GD1794@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here are some more patches for converting drivers/scsi to use C99
initializers. The patches are all against 2.5.51.

Art Haas

--- linux-2.5.51/drivers/scsi/dc390.h.old	2002-10-31 16:20:04.000000000 -0600
+++ linux-2.5.51/drivers/scsi/dc390.h	2002-12-10 14:28:33.000000000 -0600
@@ -52,41 +52,41 @@
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,30)
 #define DC390_T    {					\
-   proc_name:      "tmscsim",                           \
-   proc_info:      DC390_proc_info,			\
-   name:           DC390_BANNER " V" DC390_VERSION,	\
-   detect:         DC390_detect,			\
-   release:        DC390_release,			\
-   queuecommand:   DC390_queue_command,			\
-   abort:          DC390_abort,				\
-   reset:          DC390_reset,				\
-   bios_param:     DC390_bios_param,			\
-   can_queue:      42,					\
-   this_id:        7,					\
-   sg_tablesize:   SG_ALL,				\
-   cmd_per_lun:    16,					\
-   unchecked_isa_dma: 0,				\
-   use_clustering: DISABLE_CLUSTERING			\
+   .proc_name      = "tmscsim",                           \
+   .proc_info      = DC390_proc_info,			\
+   .name           = DC390_BANNER " V" DC390_VERSION,	\
+   .detect         = DC390_detect,			\
+   .release        = DC390_release,			\
+   .queuecommand   = DC390_queue_command,			\
+   .abort          = DC390_abort,				\
+   .reset          = DC390_reset,				\
+   .bios_param     = DC390_bios_param,			\
+   .can_queue      = 42,					\
+   .this_id        = 7,					\
+   .sg_tablesize   = SG_ALL,				\
+   .cmd_per_lun    = 16,					\
+   .unchecked_isa_dma = 0,				\
+   .use_clustering = DISABLE_CLUSTERING			\
    }
 #else
 extern struct proc_dir_entry DC390_proc_scsi_tmscsim;
 #define DC390_T    {					\
-   proc_dir:       &DC390_proc_scsi_tmscsim,		\
-   proc_info:      DC390_proc_info,			\
-   name:           DC390_BANNER " V" DC390_VERSION,	\
-   detect:         DC390_detect,			\
-   release:        DC390_release,			\
-   queuecommand:   DC390_queue_command,			\
-   abort:          DC390_abort,				\
-   reset:          DC390_reset,				\
-   bios_param:     DC390_bios_param,			\
-   can_queue:      42,					\
-   this_id:        7,					\
-   sg_tablesize:   SG_ALL,				\
-   cmd_per_lun:    16,					\
+   .proc_dir       = &DC390_proc_scsi_tmscsim,		\
+   .proc_info      = DC390_proc_info,			\
+   .name           = DC390_BANNER " V" DC390_VERSION,	\
+   .detect         = DC390_detect,			\
+   .release        = DC390_release,			\
+   .queuecommand   = DC390_queue_command,			\
+   .abort          = DC390_abort,				\
+   .reset          = DC390_reset,				\
+   .bios_param     = DC390_bios_param,			\
+   .can_queue      = 42,					\
+   .this_id        = 7,					\
+   .sg_tablesize   = SG_ALL,				\
+   .cmd_per_lun    = 16,					\
    NEW_EH						\
-   unchecked_isa_dma: 0,				\
-   use_clustering: DISABLE_CLUSTERING			\
+   .unchecked_isa_dma = 0,				\
+   .use_clustering = DISABLE_CLUSTERING			\
    }
 #endif
 #endif /* defined(HOSTS_C) || defined(MODULE) */
--- linux-2.5.51/drivers/scsi/dec_esp.h.old	2002-07-05 18:42:05.000000000 -0500
+++ linux-2.5.51/drivers/scsi/dec_esp.h	2002-12-10 14:28:33.000000000 -0600
@@ -27,19 +27,19 @@
 			 int hostno, int inout);
 
 #define SCSI_DEC_ESP {                                         \
-		proc_name:      "esp",				\
-		proc_info:      &esp_proc_info,			\
-		name:           "NCR53C94",			\
-		detect:         dec_esp_detect,			\
-		info:           esp_info,			\
-		command:        esp_command,			\
-		queuecommand:   esp_queue,			\
-		abort:          esp_abort,			\
-		reset:          esp_reset,			\
-		can_queue:      7,				\
-		this_id:        7,				\
-		sg_tablesize:   SG_ALL,				\
-		cmd_per_lun:    1,				\
-		use_clustering: DISABLE_CLUSTERING, }
+		.proc_name      = "esp",				\
+		.proc_info      = &esp_proc_info,			\
+		.name           = "NCR53C94",			\
+		.detect         = dec_esp_detect,			\
+		.info           = esp_info,			\
+		.command        = esp_command,			\
+		.queuecommand   = esp_queue,			\
+		.abort          = esp_abort,			\
+		.reset          = esp_reset,			\
+		.can_queue      = 7,				\
+		.this_id        = 7,				\
+		.sg_tablesize   = SG_ALL,				\
+		.cmd_per_lun    = 1,				\
+		.use_clustering = DISABLE_CLUSTERING, }
 
 #endif /* DEC_ESP_H */
--- linux-2.5.51/drivers/scsi/dmx3191d.h.old	2002-10-31 16:20:04.000000000 -0600
+++ linux-2.5.51/drivers/scsi/dmx3191d.h	2002-12-10 14:28:34.000000000 -0600
@@ -32,22 +32,22 @@
 
 
 #define DMX3191D {				\
-	proc_info:	dmx3191d_proc_info,		\
-	name:		"Domex DMX3191D",		\
-	detect:		dmx3191d_detect,		\
-	release:	dmx3191d_release_resources,	\
-	info:		dmx3191d_info,			\
-	queuecommand:	dmx3191d_queue_command,		\
-	eh_abort_handler:	dmx3191d_abort,		\
-	eh_bus_reset_handler:	dmx3191d_bus_reset, 	\
-	eh_device_reset_handler:dmx3191d_device_reset, 	\
-	eh_host_reset_handler:	dmx3191d_host_reset, 	\
-	bios_param:	NULL,				\
-	can_queue:	32,				\
-        this_id:	7,				\
-        sg_tablesize:	SG_ALL,				\
-	cmd_per_lun:	2,				\
-        use_clustering:	DISABLE_CLUSTERING		\
+	.proc_info	= dmx3191d_proc_info,		\
+	.name		= "Domex DMX3191D",		\
+	.detect		= dmx3191d_detect,		\
+	.release	= dmx3191d_release_resources,	\
+	.info		= dmx3191d_info,			\
+	.queuecommand	= dmx3191d_queue_command,		\
+	.eh_abort_handler	= dmx3191d_abort,		\
+	.eh_bus_reset_handler	= dmx3191d_bus_reset, 	\
+	.eh_device_reset_handler = dmx3191d_device_reset, 	\
+	.eh_host_reset_handler	= dmx3191d_host_reset, 	\
+	.bios_param	= NULL,				\
+	.can_queue	= 32,				\
+        .this_id	= 7,				\
+        .sg_tablesize	= SG_ALL,				\
+	.cmd_per_lun	= 2,				\
+        .use_clustering	= DISABLE_CLUSTERING		\
 }
 
 
--- linux-2.5.51/drivers/scsi/dpti.h.old	2002-11-29 09:24:17.000000000 -0600
+++ linux-2.5.51/drivers/scsi/dpti.h	2002-12-10 14:28:32.000000000 -0600
@@ -62,44 +62,44 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,00)
 #define DPT_I2O { \
-	proc_info: adpt_proc_info,					\
-	detect: adpt_detect,						\
-	release: adpt_release,						\
-	info: adpt_info,						\
-	queuecommand: adpt_queue,					\
-	eh_abort_handler: adpt_abort,					\
-	eh_device_reset_handler: adpt_device_reset,			\
-	eh_bus_reset_handler: adpt_bus_reset,				\
-	eh_host_reset_handler: adpt_reset,				\
-	bios_param: adpt_bios_param,					\
-	can_queue: MAX_TO_IOP_MESSAGES ,/* max simultaneous cmds      */\
-	this_id: 7,			/* scsi id of host adapter    */\
-	sg_tablesize: 0,		/* max scatter-gather cmds    */\
-	cmd_per_lun: 256,		/* cmds per lun (linked cmds) */\
-	use_clustering: ENABLE_CLUSTERING,				\
-	use_new_eh_code: 1						\
+	.proc_info = adpt_proc_info,					\
+	.detect = adpt_detect,						\
+	.release = adpt_release,						\
+	.info = adpt_info,						\
+	.queuecommand = adpt_queue,					\
+	.eh_abort_handler = adpt_abort,					\
+	.eh_device_reset_handler = adpt_device_reset,			\
+	.eh_bus_reset_handler = adpt_bus_reset,				\
+	.eh_host_reset_handler = adpt_reset,				\
+	.bios_param = adpt_bios_param,					\
+	.can_queue = MAX_TO_IOP_MESSAGES ,/* max simultaneous cmds      */\
+	.this_id = 7,			/* scsi id of host adapter    */\
+	.sg_tablesize = 0,		/* max scatter-gather cmds    */\
+	.cmd_per_lun = 256,		/* cmds per lun (linked cmds) */\
+	.use_clustering = ENABLE_CLUSTERING,				\
+	.use_new_eh_code = 1						\
 }
 
 #else				/* KERNEL_VERSION > 2.2.16 */
 
 #define DPT_I2O { \
-	proc_info: adpt_proc_info,					\
-	detect: adpt_detect,						\
-	release: adpt_release,						\
-	info: adpt_info,						\
-	queuecommand: adpt_queue,					\
-	eh_abort_handler: adpt_abort,					\
-	eh_device_reset_handler: adpt_device_reset,			\
-	eh_bus_reset_handler: adpt_bus_reset,				\
-	eh_host_reset_handler: adpt_reset,				\
-	bios_param: adpt_bios_param,					\
-	slave_configure: adpt_slave_configure,				\
-	can_queue: MAX_TO_IOP_MESSAGES,	/* max simultaneous cmds      */\
-	this_id: 7,			/* scsi id of host adapter    */\
-	sg_tablesize: 0,		/* max scatter-gather cmds    */\
-	cmd_per_lun: 1,			/* cmds per lun (linked cmds) */\
-	use_clustering: ENABLE_CLUSTERING,				\
-	proc_name: "dpt_i2o"	/* this is the name of our proc node*/	\
+	.proc_info = adpt_proc_info,					\
+	.detect = adpt_detect,						\
+	.release = adpt_release,						\
+	.info = adpt_info,						\
+	.queuecommand = adpt_queue,					\
+	.eh_abort_handler = adpt_abort,					\
+	.eh_device_reset_handler = adpt_device_reset,			\
+	.eh_bus_reset_handler = adpt_bus_reset,				\
+	.eh_host_reset_handler = adpt_reset,				\
+	.bios_param = adpt_bios_param,					\
+	.slave_configure = adpt_slave_configure,				\
+	.can_queue = MAX_TO_IOP_MESSAGES,	/* max simultaneous cmds      */\
+	.this_id = 7,			/* scsi id of host adapter    */\
+	.sg_tablesize = 0,		/* max scatter-gather cmds    */\
+	.cmd_per_lun = 1,			/* cmds per lun (linked cmds) */\
+	.use_clustering = ENABLE_CLUSTERING,				\
+	.proc_name = "dpt_i2o"	/* this is the name of our proc node*/	\
 }
 #endif
 
--- linux-2.5.51/drivers/scsi/dtc.h.old	2002-10-31 16:20:04.000000000 -0600
+++ linux-2.5.51/drivers/scsi/dtc.h	2002-12-10 14:28:33.000000000 -0600
@@ -54,19 +54,19 @@
  */
 
 #define DTC3x80 {						\
-	name:				"DTC 3180/3280 ",	\
-	detect:				dtc_detect,		\
-	queuecommand:			dtc_queue_command,	\
-	eh_abort_handler:		dtc_abort,		\
-	eh_bus_reset_handler:		dtc_bus_reset,		\
-	eh_device_reset_handler:	dtc_device_reset,	\
-	eh_host_reset_handler:          dtc_host_reset,		\
-	bios_param:     dtc_biosparam,				\
-	can_queue:      CAN_QUEUE,				\
-	this_id:        7,					\
-	sg_tablesize:   SG_ALL,					\
-	cmd_per_lun:    CMD_PER_LUN ,				\
-	use_clustering: DISABLE_CLUSTERING}
+	.name				= "DTC 3180/3280 ",	\
+	.detect				= dtc_detect,		\
+	.queuecommand			= dtc_queue_command,	\
+	.eh_abort_handler		= dtc_abort,		\
+	.eh_bus_reset_handler		= dtc_bus_reset,		\
+	.eh_device_reset_handler	= dtc_device_reset,	\
+	.eh_host_reset_handler          = dtc_host_reset,		\
+	.bios_param     = dtc_biosparam,				\
+	.can_queue      = CAN_QUEUE,				\
+	.this_id        = 7,					\
+	.sg_tablesize   = SG_ALL,					\
+	.cmd_per_lun    = CMD_PER_LUN ,				\
+	.use_clustering = DISABLE_CLUSTERING}
 
 #define NCR5380_implementation_fields \
     unsigned int base
--- linux-2.5.51/drivers/scsi/eata.h.old	2002-11-29 09:24:17.000000000 -0600
+++ linux-2.5.51/drivers/scsi/eata.h	2002-12-10 14:28:33.000000000 -0600
@@ -14,17 +14,17 @@
 #define EATA_VERSION "8.00.00"
 
 #define EATA {                                                               \
-                name:              "EATA/DMA 2.0x rev. " EATA_VERSION " ",   \
-                detect:                  eata2x_detect,                      \
-                release:                 eata2x_release,                     \
-                queuecommand:            eata2x_queuecommand,                \
-                eh_abort_handler:        eata2x_eh_abort,                    \
-                eh_device_reset_handler: NULL,                               \
-                eh_bus_reset_handler:    NULL,                               \
-                eh_host_reset_handler:   eata2x_eh_host_reset,               \
-                bios_param:              eata2x_bios_param,                  \
-		slave_configure:	 eata2x_slave_configure,	     \
-                this_id:                 7,                                  \
-                unchecked_isa_dma:       1,                                  \
-                use_clustering:          ENABLE_CLUSTERING                   \
+                .name              = "EATA/DMA 2.0x rev. " EATA_VERSION " ",   \
+                .detect                  = eata2x_detect,                      \
+                .release                 = eata2x_release,                     \
+                .queuecommand            = eata2x_queuecommand,                \
+                .eh_abort_handler        = eata2x_eh_abort,                    \
+                .eh_device_reset_handler = NULL,                               \
+                .eh_bus_reset_handler    = NULL,                               \
+                .eh_host_reset_handler   = eata2x_eh_host_reset,               \
+                .bios_param              = eata2x_bios_param,                  \
+		.slave_configure	 = eata2x_slave_configure,	     \
+                .this_id                 = 7,                                  \
+                .unchecked_isa_dma       = 1,                                  \
+                .use_clustering          = ENABLE_CLUSTERING                   \
              }
--- linux-2.5.51/drivers/scsi/eata_dma.h.old	2002-10-31 16:20:04.000000000 -0600
+++ linux-2.5.51/drivers/scsi/eata_dma.h	2002-12-10 14:28:35.000000000 -0600
@@ -81,15 +81,15 @@
 #include <scsi/scsicam.h>
 
 #define EATA_DMA {                                      \
-        proc_info:         eata_proc_info,     /* procinfo       */ \
-        name:              "EATA (Extended Attachment) HBA driver", \
-        detect:            eata_detect,                 \
-        release:           eata_release,                \
-	queuecommand:      eata_queue,                  \
-	abort:             eata_abort,                  \
-	reset:             eata_reset,                  \
-	unchecked_isa_dma: 1,      /* True if ISA  */   \
-	use_clustering:    ENABLE_CLUSTERING }
+        .proc_info         = eata_proc_info,     /* procinfo       */ \
+        .name              = "EATA (Extended Attachment) HBA driver", \
+        .detect            = eata_detect,                 \
+        .release           = eata_release,                \
+	.queuecommand      = eata_queue,                  \
+	.abort             = eata_abort,                  \
+	.reset             = eata_reset,                  \
+	.unchecked_isa_dma = 1,      /* True if ISA  */   \
+	.use_clustering    = ENABLE_CLUSTERING }
 
 
 #endif /* _EATA_DMA_H */
--- linux-2.5.51/drivers/scsi/eata_pio.h.old	2002-11-11 07:14:45.000000000 -0600
+++ linux-2.5.51/drivers/scsi/eata_pio.h	2002-12-10 14:28:35.000000000 -0600
@@ -65,14 +65,14 @@
 static int eata_pio_release(struct Scsi_Host *);
 
 #define EATA_PIO {							\
-	proc_info:         	eata_pio_proc_info, /* procinfo	  */	\
-	name:              	"EATA (Extended Attachment) PIO driver",\
-	detect:            	eata_pio_detect,			\
-	release:           	eata_pio_release,			\
-	queuecommand:      	eata_pio_queue,				\
-	eh_abort_handler:  	eata_pio_abort,				\
-	eh_host_reset_handler:	eata_pio_host_reset,			\
-	use_clustering:    	ENABLE_CLUSTERING 			\
+	.proc_info         	= eata_pio_proc_info, /* procinfo	  */	\
+	.name              	= "EATA (Extended Attachment) PIO driver",\
+	.detect            	= eata_pio_detect,			\
+	.release           	= eata_pio_release,			\
+	.queuecommand      	= eata_pio_queue,				\
+	.eh_abort_handler  	= eata_pio_abort,				\
+	.eh_host_reset_handler	= eata_pio_host_reset,			\
+	.use_clustering    	= ENABLE_CLUSTERING 			\
 }
 
 #endif				/* _EATA_PIO_H */
--- linux-2.5.51/drivers/scsi/fastlane.h.old	2002-07-05 18:42:03.000000000 -0500
+++ linux-2.5.51/drivers/scsi/fastlane.h	2002-12-10 14:28:32.000000000 -0600
@@ -48,18 +48,18 @@
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
-#define SCSI_FASTLANE     { proc_name:		"esp-fastlane", \
-			    proc_info:		esp_proc_info, \
-			    name:		"Fastlane SCSI", \
-			    detect:		fastlane_esp_detect, \
-			    release:		fastlane_esp_release, \
-			    queuecommand:	esp_queue, \
-			    abort:		esp_abort, \
-			    reset:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	ENABLE_CLUSTERING }
+#define SCSI_FASTLANE     { .proc_name		= "esp-fastlane", \
+			    .proc_info		= esp_proc_info, \
+			    .name		= "Fastlane SCSI", \
+			    .detect		= fastlane_esp_detect, \
+			    .release		= fastlane_esp_release, \
+			    .queuecommand	= esp_queue, \
+			    .abort		= esp_abort, \
+			    .reset		= esp_reset, \
+			    .can_queue          = 7, \
+			    .this_id		= 7, \
+			    .sg_tablesize	= SG_ALL, \
+			    .cmd_per_lun	= 1, \
+			    .use_clustering	= ENABLE_CLUSTERING }
 
 #endif /* FASTLANE_H */
--- linux-2.5.51/drivers/scsi/fcal.h.old	2002-11-29 09:24:18.000000000 -0600
+++ linux-2.5.51/drivers/scsi/fcal.h	2002-12-10 14:28:32.000000000 -0600
@@ -26,21 +26,21 @@
 int fcal_slave_configure(Scsi_Device *);
 
 #define FCAL {							\
-	name:			"Fibre Channel Arbitrated Loop",\
-	detect:			fcal_detect,			\
-	release:		fcal_release,			\
-	proc_info:		fcal_proc_info,			\
-	queuecommand:		fcp_scsi_queuecommand,		\
-	slave_configure:	fcal_slave_configure,		\
-	can_queue:		FCAL_CAN_QUEUE,			\
-	this_id:		-1,				\
-	sg_tablesize:		1,				\
-	cmd_per_lun:		1,				\
-	use_clustering:		ENABLE_CLUSTERING,		\
-	eh_abort_handler:	fcp_scsi_abort,			\
-	eh_device_reset_handler:fcp_scsi_dev_reset,		\
-	eh_bus_reset_handler:	fcp_scsi_bus_reset,		\
-	eh_host_reset_handler:	fcp_scsi_host_reset,		\
+	.name			= "Fibre Channel Arbitrated Loop",\
+	.detect			= fcal_detect,			\
+	.release		= fcal_release,			\
+	.proc_info		= fcal_proc_info,			\
+	.queuecommand		= fcp_scsi_queuecommand,		\
+	.slave_configure	= fcal_slave_configure,		\
+	.can_queue		= FCAL_CAN_QUEUE,			\
+	.this_id		= -1,				\
+	.sg_tablesize		= 1,				\
+	.cmd_per_lun		= 1,				\
+	.use_clustering		= ENABLE_CLUSTERING,		\
+	.eh_abort_handler	= fcp_scsi_abort,			\
+	.eh_device_reset_handler = fcp_scsi_dev_reset,		\
+	.eh_bus_reset_handler	= fcp_scsi_bus_reset,		\
+	.eh_host_reset_handler	= fcp_scsi_host_reset,		\
 }	
 
 #endif /* !(_FCAL_H) */
--- linux-2.5.51/drivers/scsi/fd_mcs.h.old	2002-11-11 07:14:46.000000000 -0600
+++ linux-2.5.51/drivers/scsi/fd_mcs.h	2002-12-10 14:28:33.000000000 -0600
@@ -36,23 +36,23 @@
 static const char *fd_mcs_info(struct Scsi_Host *);
 
 #define FD_MCS {\
-                    proc_name:			"fd_mcs",		\
-                    proc_info:			fd_mcs_proc_info,	\
-		    detect:			fd_mcs_detect,		\
-		    release:			fd_mcs_release,		\
-		    info:			fd_mcs_info,		\
-		    command:			fd_mcs_command,		\
-		    queuecommand:   		fd_mcs_queue,           \
-		    eh_abort_handler:		fd_mcs_abort,           \
-		    eh_bus_reset_handler:	fd_mcs_bus_reset,       \
-		    eh_host_reset_handler:	fd_mcs_host_reset,      \
-		    eh_device_reset_handler:	fd_mcs_device_reset,    \
-		    bios_param:     		fd_mcs_biosparam,       \
-		    can_queue:      		1, 			\
-		    this_id:        		7, 			\
-		    sg_tablesize:   		64, 			\
-		    cmd_per_lun:    		1, 			\
-		    use_clustering: 		DISABLE_CLUSTERING	\
+                    .proc_name			= "fd_mcs",		\
+                    .proc_info			= fd_mcs_proc_info,	\
+		    .detect			= fd_mcs_detect,		\
+		    .release			= fd_mcs_release,		\
+		    .info			= fd_mcs_info,		\
+		    .command			= fd_mcs_command,		\
+		    .queuecommand   		= fd_mcs_queue,           \
+		    .eh_abort_handler		= fd_mcs_abort,           \
+		    .eh_bus_reset_handler	= fd_mcs_bus_reset,       \
+		    .eh_host_reset_handler	= fd_mcs_host_reset,      \
+		    .eh_device_reset_handler	= fd_mcs_device_reset,    \
+		    .bios_param     		= fd_mcs_biosparam,       \
+		    .can_queue      		= 1, 			\
+		    .this_id        		= 7, 			\
+		    .sg_tablesize   		= 64, 			\
+		    .cmd_per_lun    		= 1, 			\
+		    .use_clustering 		= DISABLE_CLUSTERING	\
 		}
 
 #endif				/* _FD_MCS_H */
--- linux-2.5.51/drivers/scsi/fdomain.h.old	2002-10-31 16:20:04.000000000 -0600
+++ linux-2.5.51/drivers/scsi/fdomain.h	2002-12-10 14:28:33.000000000 -0600
@@ -39,21 +39,21 @@
 				   int length, int hostno, int inout );
 static int        fdomain_16x0_release(struct Scsi_Host *shpnt);
 
-#define FDOMAIN_16X0 { proc_info:      		fdomain_16x0_proc_info,           \
-		       detect:         		fdomain_16x0_detect,              \
-		       info:           		fdomain_16x0_info,                \
-		       command:        		fdomain_16x0_command,             \
-		       queuecommand:   		fdomain_16x0_queue,               \
-		       eh_abort_handler:	fdomain_16x0_abort,               \
-		       eh_bus_reset_handler:	fdomain_16x0_bus_reset,           \
-		       eh_device_reset_handler:	fdomain_16x0_device_reset,        \
-		       eh_host_reset_handler:	fdomain_16x0_host_reset,          \
-		       bios_param:		fdomain_16x0_biosparam,           \
-		       release:			fdomain_16x0_release,		  \
-		       can_queue:		1, 				  \
-		       this_id:  		6, 				  \
-		       sg_tablesize:		64, 				  \
-		       cmd_per_lun:		1, 				  \
-		       use_clustering:		DISABLE_CLUSTERING		  \
+#define FDOMAIN_16X0 { .proc_info      		= fdomain_16x0_proc_info,           \
+		       .detect         		= fdomain_16x0_detect,              \
+		       .info           		= fdomain_16x0_info,                \
+		       .command        		= fdomain_16x0_command,             \
+		       .queuecommand   		= fdomain_16x0_queue,               \
+		       .eh_abort_handler	= fdomain_16x0_abort,               \
+		       .eh_bus_reset_handler	= fdomain_16x0_bus_reset,           \
+		       .eh_device_reset_handler	= fdomain_16x0_device_reset,        \
+		       .eh_host_reset_handler	= fdomain_16x0_host_reset,          \
+		       .bios_param		= fdomain_16x0_biosparam,           \
+		       .release			= fdomain_16x0_release,		  \
+		       .can_queue		= 1, 				  \
+		       .this_id  		= 6, 				  \
+		       .sg_tablesize		= 64, 				  \
+		       .cmd_per_lun		= 1, 				  \
+		       .use_clustering		= DISABLE_CLUSTERING		  \
 }
 #endif
--- linux-2.5.51/drivers/scsi/g_NCR5380.h.old	2002-11-11 07:14:46.000000000 -0600
+++ linux-2.5.51/drivers/scsi/g_NCR5380.h	2002-12-10 14:28:32.000000000 -0600
@@ -66,22 +66,22 @@
 #endif
 
 #define GENERIC_NCR5380 {						\
-	proc_info:      generic_NCR5380_proc_info,			\
-	name:           "Generic NCR5380/NCR53C400 Scsi Driver",	\
-	detect:         generic_NCR5380_detect,				\
-	release:        generic_NCR5380_release_resources,		\
-	info:           (void *)generic_NCR5380_info,			\
-	queuecommand:   generic_NCR5380_queue_command,			\
-	eh_abort_handler:generic_NCR5380_abort,				\
-	eh_bus_reset_handler:generic_NCR5380_bus_reset,			\
-	eh_device_reset_handler:generic_NCR5380_device_reset,		\
-	eh_host_reset_handler:generic_NCR5380_host_reset,			\
-	bios_param:     NCR5380_BIOSPARAM,				\
-	can_queue:      CAN_QUEUE,					\
-        this_id:        7,						\
-        sg_tablesize:   SG_ALL,						\
-	cmd_per_lun:    CMD_PER_LUN ,					\
-        use_clustering: DISABLE_CLUSTERING}
+	.proc_info      = generic_NCR5380_proc_info,			\
+	.name           = "Generic NCR5380/NCR53C400 Scsi Driver",	\
+	.detect         = generic_NCR5380_detect,				\
+	.release        = generic_NCR5380_release_resources,		\
+	.info           = (void *)generic_NCR5380_info,			\
+	.queuecommand   = generic_NCR5380_queue_command,			\
+	.eh_abort_handler = generic_NCR5380_abort,				\
+	.eh_bus_reset_handler = generic_NCR5380_bus_reset,			\
+	.eh_device_reset_handler = generic_NCR5380_device_reset,		\
+	.eh_host_reset_handler = generic_NCR5380_host_reset,			\
+	.bios_param     = NCR5380_BIOSPARAM,				\
+	.can_queue      = CAN_QUEUE,					\
+        .this_id        = 7,						\
+        .sg_tablesize   = SG_ALL,						\
+	.cmd_per_lun    = CMD_PER_LUN ,					\
+        .use_clustering = DISABLE_CLUSTERING}
 
 #ifndef HOSTS_C
 
--- linux-2.5.51/drivers/scsi/gdth.h.old	2002-10-31 16:20:05.000000000 -0600
+++ linux-2.5.51/drivers/scsi/gdth.h	2002-12-10 14:28:33.000000000 -0600
@@ -1037,28 +1037,28 @@
 int gdth_eh_device_reset(Scsi_Cmnd *scp);
 int gdth_eh_bus_reset(Scsi_Cmnd *scp);
 int gdth_eh_host_reset(Scsi_Cmnd *scp);
-#define GDTH { proc_name:       "gdth",                          \
-               proc_info:       gdth_proc_info,                  \
-               name:            "GDT SCSI Disk Array Controller",\
-               detect:          gdth_detect,                     \
-               release:         gdth_release,                    \
-               info:            gdth_info,                       \
-               command:         NULL,                            \
-               queuecommand:    gdth_queuecommand,               \
-               eh_abort_handler: gdth_eh_abort,                  \
-               eh_device_reset_handler: gdth_eh_device_reset,    \
-               eh_bus_reset_handler: gdth_eh_bus_reset,          \
-               eh_host_reset_handler: gdth_eh_host_reset,        \
-               abort:           gdth_abort,                      \
-               reset:           gdth_reset,                      \
-               bios_param:      gdth_bios_param,                 \
-               can_queue:       GDTH_MAXCMDS,                    \
-               this_id:         -1,                              \
-               sg_tablesize:    GDTH_MAXSG,                      \
-               cmd_per_lun:     GDTH_MAXC_P_L,                   \
-               present:         0,                               \
-               unchecked_isa_dma: 1,                             \
-               use_clustering:  ENABLE_CLUSTERING }
+#define GDTH { .proc_name       = "gdth",                          \
+               .proc_info       = gdth_proc_info,                  \
+               .name            = "GDT SCSI Disk Array Controller",\
+               .detect          = gdth_detect,                     \
+               .release         = gdth_release,                    \
+               .info            = gdth_info,                       \
+               .command         = NULL,                            \
+               .queuecommand    = gdth_queuecommand,               \
+               .eh_abort_handler = gdth_eh_abort,                  \
+               .eh_device_reset_handler = gdth_eh_device_reset,    \
+               .eh_bus_reset_handler = gdth_eh_bus_reset,          \
+               .eh_host_reset_handler = gdth_eh_host_reset,        \
+               .abort           = gdth_abort,                      \
+               .reset           = gdth_reset,                      \
+               .bios_param      = gdth_bios_param,                 \
+               .can_queue       = GDTH_MAXCMDS,                    \
+               .this_id         = -1,                              \
+               .sg_tablesize    = GDTH_MAXSG,                      \
+               .cmd_per_lun     = GDTH_MAXC_P_L,                   \
+               .present         = 0,                               \
+               .unchecked_isa_dma = 1,                             \
+               .use_clustering  = ENABLE_CLUSTERING }
 
 #endif
 
--- linux-2.5.51/drivers/scsi/gvp11.h.old	2002-07-05 18:42:33.000000000 -0500
+++ linux-2.5.51/drivers/scsi/gvp11.h	2002-12-10 14:28:34.000000000 -0600
@@ -32,18 +32,18 @@
 
 #ifdef HOSTS_C
 
-#define GVP11_SCSI {  proc_name:	   "GVP11", \
-		      name:                "GVP Series II SCSI", \
-		      detect:              gvp11_detect,    \
-		      release:             gvp11_release,   \
-		      queuecommand:        wd33c93_queuecommand, \
-		      abort:               wd33c93_abort,   \
-		      reset:               wd33c93_reset,   \
-		      can_queue:           CAN_QUEUE,       \
-		      this_id:             7,               \
-		      sg_tablesize:        SG_ALL,          \
-		      cmd_per_lun:	   CMD_PER_LUN,     \
-		      use_clustering:      DISABLE_CLUSTERING }
+#define GVP11_SCSI {  .proc_name	   = "GVP11", \
+		      .name                = "GVP Series II SCSI", \
+		      .detect              = gvp11_detect,    \
+		      .release             = gvp11_release,   \
+		      .queuecommand        = wd33c93_queuecommand, \
+		      .abort               = wd33c93_abort,   \
+		      .reset               = wd33c93_reset,   \
+		      .can_queue           = CAN_QUEUE,       \
+		      .this_id             = 7,               \
+		      .sg_tablesize        = SG_ALL,          \
+		      .cmd_per_lun	   = CMD_PER_LUN,     \
+		      .use_clustering      = DISABLE_CLUSTERING }
 #else
 
 /*
--- linux-2.5.51/drivers/scsi/ibmmca.h.old	2002-11-18 01:02:09.000000000 -0600
+++ linux-2.5.51/drivers/scsi/ibmmca.h	2002-12-10 14:28:33.000000000 -0600
@@ -27,22 +27,22 @@
  * about this, but it will break things in the future.
  */
 #define IBMMCA {                                                      \
-          proc_name:      "ibmmca",             /*proc_name*/         \
-	  proc_info:	  ibmmca_proc_info,     /*proc info fn*/      \
-          name:           "IBM SCSI-Subsystem", /*name*/              \
-          detect:         ibmmca_detect,        /*detect fn*/         \
-          release:        ibmmca_release,       /*release fn*/        \
-          command:        ibmmca_command,       /*command fn*/        \
-          queuecommand:   ibmmca_queuecommand,  /*queuecommand fn*/   \
-	  eh_abort_handler:ibmmca_abort,         /*abort fn*/          \
-	  eh_host_reset_handler:ibmmca_host_reset,         /*reset fn*/          \
-          bios_param:     ibmmca_biosparam,     /*bios fn*/           \
-          can_queue:      16,                   /*can_queue*/         \
-          this_id:        7,                    /*set by detect*/     \
-          sg_tablesize:   16,                   /*sg_tablesize*/      \
-          cmd_per_lun:    1,                    /*cmd_per_lun*/       \
-          unchecked_isa_dma: 0,                 /*32-Bit Busmaster */ \
-          use_clustering: ENABLE_CLUSTERING     /*use_clustering*/    \
+          .proc_name      = "ibmmca",             /*proc_name*/         \
+	  .proc_info	  = ibmmca_proc_info,     /*proc info fn*/      \
+          .name           = "IBM SCSI-Subsystem", /*name*/              \
+          .detect         = ibmmca_detect,        /*detect fn*/         \
+          .release        = ibmmca_release,       /*release fn*/        \
+          .command        = ibmmca_command,       /*command fn*/        \
+          .queuecommand   = ibmmca_queuecommand,  /*queuecommand fn*/   \
+	  .eh_abort_handler = ibmmca_abort,         /*abort fn*/          \
+	  .eh_host_reset_handler = ibmmca_host_reset,         /*reset fn*/          \
+          .bios_param     = ibmmca_biosparam,     /*bios fn*/           \
+          .can_queue      = 16,                   /*can_queue*/         \
+          .this_id        = 7,                    /*set by detect*/     \
+          .sg_tablesize   = 16,                   /*sg_tablesize*/      \
+          .cmd_per_lun    = 1,                    /*cmd_per_lun*/       \
+          .unchecked_isa_dma = 0,                 /*32-Bit Busmaster */ \
+          .use_clustering = ENABLE_CLUSTERING     /*use_clustering*/    \
           }
 
 #endif /* _IBMMCA_H */
--- linux-2.5.51/drivers/scsi/imm.h.old	2002-10-31 16:20:05.000000000 -0600
+++ linux-2.5.51/drivers/scsi/imm.h	2002-12-10 14:28:32.000000000 -0600
@@ -163,21 +163,21 @@
 int imm_biosparam(struct scsi_device *, struct block_device *,
 		sector_t, int *);
 
-#define IMM {	proc_name:			"imm",			\
-		proc_info:			imm_proc_info,		\
-		name:				"Iomega VPI2 (imm) interface",\
-		detect:				imm_detect,		\
-		release:			imm_release,		\
-		command:			imm_command,		\
-		queuecommand:			imm_queuecommand,	\
-                eh_abort_handler:               imm_abort,              \
-                eh_device_reset_handler:        NULL,                   \
-                eh_bus_reset_handler:           imm_reset,              \
-                eh_host_reset_handler:          imm_reset,              \
-		bios_param:		        imm_biosparam,		\
-		this_id:			7,			\
-		sg_tablesize:			SG_ALL,			\
-		cmd_per_lun:			1,			\
-		use_clustering:			ENABLE_CLUSTERING	\
+#define IMM {	.proc_name			= "imm",			\
+		.proc_info			= imm_proc_info,		\
+		.name				= "Iomega VPI2 (imm) interface",\
+		.detect				= imm_detect,		\
+		.release			= imm_release,		\
+		.command			= imm_command,		\
+		.queuecommand			= imm_queuecommand,	\
+                .eh_abort_handler               = imm_abort,              \
+                .eh_device_reset_handler        = NULL,                   \
+                .eh_bus_reset_handler           = imm_reset,              \
+                .eh_host_reset_handler          = imm_reset,              \
+		.bios_param		        = imm_biosparam,		\
+		.this_id			= 7,			\
+		.sg_tablesize			= SG_ALL,			\
+		.cmd_per_lun			= 1,			\
+		.use_clustering			= ENABLE_CLUSTERING	\
 }
 #endif				/* _IMM_H */
--- linux-2.5.51/drivers/scsi/in2000.h.old	2002-10-31 16:20:05.000000000 -0600
+++ linux-2.5.51/drivers/scsi/in2000.h	2002-12-10 14:28:32.000000000 -0600
@@ -414,22 +414,22 @@
 #define IN2000_CPL      2
 #define IN2000_HOST_ID  7
 
-#define IN2000 {  proc_name:       		"in2000",	     /* name of /proc/scsi directory entry */ \
-                  proc_info:       		in2000_proc_info,    /* pointer to proc info function */ \
-                  name:            		"Always IN2000",     /* device name */ \
-                  detect:          		in2000_detect,       /* returns number of in2000's found */ \
-                  release:			in2000_release,	     /* release the in2000 controller */ \
-                  queuecommand:    		in2000_queuecommand, /* queue scsi command, don't wait */ \
-                  eh_abort_handler:		in2000_abort,        /* abort current command */ \
-                  eh_bus_reset_handler:		in2000_bus_reset,    /* reset scsi bus */ \
-                  eh_device_reset_handler:	in2000_device_reset, /* reset scsi device */ \
-                  eh_host_reset_handler:	in2000_host_reset,   /* reset scsi hba */ \
-                  bios_param:      		in2000_biosparam,    /* figures out BIOS parameters for lilo, etc */ \
-                  can_queue:       		IN2000_CAN_Q,        /* max commands we can queue up */ \
-                  this_id:         		IN2000_HOST_ID,      /* host-adapter scsi id */ \
-                  sg_tablesize:    		IN2000_SG,           /* scatter-gather table size */ \
-                  cmd_per_lun:     		IN2000_CPL,          /* commands per lun */ \
-                  use_clustering:  		DISABLE_CLUSTERING,  /* ENABLE_CLUSTERING may speed things up */ \
+#define IN2000 {  .proc_name       		= "in2000",	     /* name of /proc/scsi directory entry */ \
+                  .proc_info       		= in2000_proc_info,    /* pointer to proc info function */ \
+                  .name            		= "Always IN2000",     /* device name */ \
+                  .detect          		= in2000_detect,       /* returns number of in2000's found */ \
+                  .release			= in2000_release,	     /* release the in2000 controller */ \
+                  .queuecommand    		= in2000_queuecommand, /* queue scsi command, don't wait */ \
+                  .eh_abort_handler		= in2000_abort,        /* abort current command */ \
+                  .eh_bus_reset_handler		= in2000_bus_reset,    /* reset scsi bus */ \
+                  .eh_device_reset_handler	= in2000_device_reset, /* reset scsi device */ \
+                  .eh_host_reset_handler	= in2000_host_reset,   /* reset scsi hba */ \
+                  .bios_param      		= in2000_biosparam,    /* figures out BIOS parameters for lilo, etc */ \
+                  .can_queue       		= IN2000_CAN_Q,        /* max commands we can queue up */ \
+                  .this_id         		= IN2000_HOST_ID,      /* host-adapter scsi id */ \
+                  .sg_tablesize    		= IN2000_SG,           /* scatter-gather table size */ \
+                  .cmd_per_lun     		= IN2000_CPL,          /* commands per lun */ \
+                  .use_clustering  		= DISABLE_CLUSTERING,  /* ENABLE_CLUSTERING may speed things up */ \
                 }
 
 #endif /* IN2000_H */
--- linux-2.5.51/drivers/scsi/ini9100u.h.old	2002-11-29 09:24:18.000000000 -0600
+++ linux-2.5.51/drivers/scsi/ini9100u.h	2002-12-10 14:28:34.000000000 -0600
@@ -88,31 +88,31 @@
 #define i91u_REVID "Initio INI-9X00U/UW SCSI device driver; Revision: 1.03g"
 
 #define INI9100U	{ \
-	next:		NULL,						\
-	module:		NULL,						\
-	proc_name:	"INI9100U", \
-	proc_info:	NULL,				\
-	name:		i91u_REVID, \
-	detect:		i91u_detect, \
-	release:	i91u_release, \
-	info:		NULL,					\
-	command:	i91u_command, \
-	queuecommand:	i91u_queue, \
- 	eh_strategy_handler: NULL, \
- 	eh_abort_handler: NULL, \
- 	eh_device_reset_handler: NULL, \
- 	eh_bus_reset_handler: NULL, \
- 	eh_host_reset_handler: NULL, \
-	abort:		i91u_abort, \
-	reset:		i91u_reset, \
-	bios_param:	i91u_biosparam, \
-	can_queue:	1, \
-	this_id:	1, \
-	sg_tablesize:	SG_ALL, \
-	cmd_per_lun: 	1, \
-	present:	0, \
-	unchecked_isa_dma: 0, \
-	use_clustering:	ENABLE_CLUSTERING, \
+	.next		= NULL,						\
+	.module		= NULL,						\
+	.proc_name	= "INI9100U", \
+	.proc_info	= NULL,				\
+	.name		= i91u_REVID, \
+	.detect		= i91u_detect, \
+	.release	= i91u_release, \
+	.info		= NULL,					\
+	.command	= i91u_command, \
+	.queuecommand	= i91u_queue, \
+ 	.eh_strategy_handler = NULL, \
+ 	.eh_abort_handler = NULL, \
+ 	.eh_device_reset_handler = NULL, \
+ 	.eh_bus_reset_handler = NULL, \
+ 	.eh_host_reset_handler = NULL, \
+	.abort		= i91u_abort, \
+	.reset		= i91u_reset, \
+	.bios_param	= i91u_biosparam, \
+	.can_queue	= 1, \
+	.this_id	= 1, \
+	.sg_tablesize	= SG_ALL, \
+	.cmd_per_lun 	= 1, \
+	.present	= 0, \
+	.unchecked_isa_dma = 0, \
+	.use_clustering	= ENABLE_CLUSTERING, \
 }
 
 #define VIRT_TO_BUS(i)  (unsigned int) virt_to_bus((void *)(i))
--- linux-2.5.51/drivers/scsi/inia100.h.old	2002-11-29 09:24:18.000000000 -0600
+++ linux-2.5.51/drivers/scsi/inia100.h	2002-12-10 14:28:32.000000000 -0600
@@ -85,21 +85,21 @@
 #define inia100_REVID "Initio INI-A100U2W SCSI device driver; Revision: 1.02d"
 
 #define INIA100	{ \
-	proc_name:	"inia100", \
-	name:		inia100_REVID, \
-	detect:		inia100_detect, \
-	release:	inia100_release, \
-	queuecommand:	inia100_queue, \
-	eh_abort_handler:inia100_abort, \
-	eh_bus_reset_handler:	inia100_bus_reset, \
-	eh_device_reset_handler:inia100_device_reset, \
-	can_queue:	1, \
-	this_id:	1, \
-	sg_tablesize:	SG_ALL, \
-	cmd_per_lun: 	1, \
-	present:	0, \
-	unchecked_isa_dma: 0, \
-	use_clustering:	ENABLE_CLUSTERING, \
+	.proc_name	= "inia100", \
+	.name		= inia100_REVID, \
+	.detect		= inia100_detect, \
+	.release	= inia100_release, \
+	.queuecommand	= inia100_queue, \
+	.eh_abort_handler = inia100_abort, \
+	.eh_bus_reset_handler	= inia100_bus_reset, \
+	.eh_device_reset_handler = inia100_device_reset, \
+	.can_queue	= 1, \
+	.this_id	= 1, \
+	.sg_tablesize	= SG_ALL, \
+	.cmd_per_lun 	= 1, \
+	.present	= 0, \
+	.unchecked_isa_dma = 0, \
+	.use_clustering	= ENABLE_CLUSTERING, \
 }
 
 #define ULONG   unsigned long
--- linux-2.5.51/drivers/scsi/ips.h.old	2002-11-29 09:24:19.000000000 -0600
+++ linux-2.5.51/drivers/scsi/ips.h	2002-12-10 14:28:33.000000000 -0600
@@ -407,80 +407,80 @@
     * Scsi_Host Template
     */
 #if LINUX_VERSION_CODE < LinuxVersionCode(2,4,0)
- #define IPS {                            \
-    module : NULL,                        \
-    proc_info : NULL,                     \
-    proc_dir : NULL,                      \
-    name : NULL,                          \
-    detect : ips_detect,                  \
-    release : ips_release,                \
-    info : ips_info,                      \
-    command : NULL,                       \
-    queuecommand : ips_queue,             \
-    eh_strategy_handler : NULL,           \
-    eh_abort_handler : ips_eh_abort,      \
-    eh_device_reset_handler : NULL,       \
-    eh_bus_reset_handler : NULL,          \
-    eh_host_reset_handler : ips_eh_reset, \
-    abort : NULL,                         \
-    reset : NULL,                         \
-    slave_attach : NULL,                  \
-    bios_param : ips_biosparam,           \
-    can_queue : 0,                        \
-    this_id: -1,                          \
-    sg_tablesize : IPS_MAX_SG,            \
-    cmd_per_lun: 3,                       \
-    present : 0,                          \
-    unchecked_isa_dma : 0,                \
-    use_clustering : ENABLE_CLUSTERING,   \
-    use_new_eh_code : 1                   \
+#define IPS {	\
+	.module				= NULL,		\
+	.proc_info			= NULL,		\
+	.proc_dir			= NULL,		\
+	.name				= NULL,		\
+	.detect				= ips_detect,	\
+	.release			= ips_release,	\
+	.info				= ips_info,	\
+	.command			= NULL,		\
+	.queuecommand			= ips_queue,	\
+	.eh_strategy_handler		= NULL,		\
+	.eh_abort_handler		= ips_eh_abort,	\
+	.eh_device_reset_handler	= NULL,		\
+	.eh_bus_reset_handler		= NULL,		\
+	.eh_host_reset_handler		= ips_eh_reset,	\
+	.abort				= NULL,		\
+	.reset				= NULL,		\
+	.slave_attach			= NULL,		\
+	.bios_param			= ips_biosparam,\
+	.can_queue			= 0,		\
+	.this_id			= -1,		\
+	.sg_tablesize			= IPS_MAX_SG,	\
+	.cmd_per_lun			= 3,		\
+	.present			= 0,		\
+	.unchecked_isa_dma		= 0,		\
+	.use_clustering			= ENABLE_CLUSTERING,	\
+	.use_new_eh_code		= 1 \
 }
 #elif LINUX_VERSION_CODE < LinuxVersionCode(2,5,0)
- #define IPS {                            \
-    module : NULL,                        \
-    proc_info : NULL,                     \
-    name : NULL,                          \
-    detect : ips_detect,                  \
-    release : ips_release,                \
-    info : ips_info,                      \
-    command : NULL,                       \
-    queuecommand : ips_queue,             \
-    eh_strategy_handler : NULL,           \
-    eh_abort_handler : ips_eh_abort,      \
-    eh_device_reset_handler : NULL,       \
-    eh_bus_reset_handler : NULL,          \
-    eh_host_reset_handler : ips_eh_reset, \
-    abort : NULL,                         \
-    reset : NULL,                         \
-    slave_attach : NULL,                  \
-    bios_param : ips_biosparam,           \
-    can_queue : 0,                        \
-    this_id: -1,                          \
-    sg_tablesize : IPS_MAX_SG,            \
-    cmd_per_lun: 3,                       \
-    present : 0,                          \
-    unchecked_isa_dma : 0,                \
-    use_clustering : ENABLE_CLUSTERING,   \
-    use_new_eh_code : 1                   \
+#define IPS{	\
+	.module				= NULL,		\
+	.proc_info			= NULL,		\
+	.name				= NULL,		\
+	.detect				= ips_detect,	\
+	.release			= ips_release,	\
+	.info				= ips_info,	\
+	.command			= NULL,		\
+	.queuecommand			= ips_queue,	\
+	.eh_strategy_handler		= NULL,		\
+	.eh_abort_handler		= ips_eh_abort,	\
+	.eh_device_reset_handler	= NULL,		\
+	.eh_bus_reset_handler		= NULL,		\
+	.eh_host_reset_handler		= ips_eh_reset,	\
+	.abort				= NULL,		\
+	.reset				= NULL,		\
+	.slave_attach			= NULL,		\
+	.bios_param			= ips_biosparam,\
+	.can_queue			= 0,		\
+	.this_id			= -1,		\
+	.sg_tablesize			= IPS_MAX_SG,	\
+	.cmd_per_lun			= 3,		\
+	.present			= 0,		\
+	.unchecked_isa_dma		= 0,		\
+	.use_clustering			= ENABLE_CLUSTERING,\
+	.use_new_eh_code		= 1 \
 }
 #else
- #define IPS {                            \
-    detect : ips_detect,                  \
-    release : ips_release,                \
-    info : ips_info,                      \
-    queuecommand : ips_queue,             \
-    eh_abort_handler : ips_eh_abort,      \
-    eh_host_reset_handler : ips_eh_reset, \
-    slave_configure : ips_slave_configure,\
-    bios_param : ips_biosparam,           \
-    can_queue : 0,                        \
-    this_id: -1,                          \
-    sg_tablesize : IPS_MAX_SG,            \
-    cmd_per_lun: 3,                       \
-    present : 0,                          \
-    unchecked_isa_dma : 0,                \
-    use_clustering : ENABLE_CLUSTERING,   \
-    highmem_io : 1                        \
+#define IPS {	\
+	.detect			= ips_detect,		\
+	.release		= ips_release,		\
+	.info			= ips_info,		\
+	.queuecommand		= ips_queue,		\
+	.eh_abort_handler	= ips_eh_abort,		\
+	.eh_host_reset_handler	= ips_eh_reset,		\
+	.slave_configure	= ips_slave_configure,	\
+	.bios_param		= ips_biosparam,	\
+	.can_queue		= 0,			\
+	.this_id		= -1,			\
+	.sg_tablesize		= IPS_MAX_SG,		\
+	.cmd_per_lun		= 3,			\
+	.present		= 0,			\
+	.unchecked_isa_dma	= 0,			\
+	.use_clustering		= ENABLE_CLUSTERING,	\
+	.highmem_io		= 1 \
 }
 #endif
 
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
