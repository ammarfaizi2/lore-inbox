Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264654AbSLLOBM>; Thu, 12 Dec 2002 09:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264677AbSLLOBM>; Thu, 12 Dec 2002 09:01:12 -0500
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:17936 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S264654AbSLLOAt>; Thu, 12 Dec 2002 09:00:49 -0500
Date: Thu, 12 Dec 2002 08:08:31 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for drivers/scsi (4 of 4)
Message-ID: <20021212140831.GF1794@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's the last set of patches for converting drivers/scsi to C99
initializers. The patches are against 2.5.51.

Art Haas

--- linux-2.5.51/drivers/scsi/qla1280.h.old	2002-11-29 09:24:20.000000000 -0600
+++ linux-2.5.51/drivers/scsi/qla1280.h	2002-12-10 14:28:34.000000000 -0600
@@ -1325,25 +1325,25 @@
  */
 
 #define QLA1280_LINUX_TEMPLATE {				\
-	proc_info: qla1280_proc_info,				\
-	name: "Qlogic ISP 1280/12160",				\
-	detect: qla1280_detect,					\
-	release: qla1280_release,				\
-	info: qla1280_info,					\
-	queuecommand: qla1280_queuecommand,			\
+	.proc_info = qla1280_proc_info,				\
+	.name = "Qlogic ISP 1280/12160",				\
+	.detect = qla1280_detect,					\
+	.release = qla1280_release,				\
+	.info = qla1280_info,					\
+	.queuecommand = qla1280_queuecommand,			\
 /*	use_new_eh_code: 0, */					\
-	abort: qla1280_abort,					\
-	reset: qla1280_reset,					\
-	slave_configure: qla1280_slave_configure,		\
-	bios_param: qla1280_biosparam,				\
-	can_queue: 255,		/* max simultaneous cmds      */\
-	this_id: -1,		/* scsi id of host adapter    */\
-	sg_tablesize: SG_ALL,	/* max scatter-gather cmds    */\
-	cmd_per_lun: 3,		/* cmds per lun (linked cmds) */\
-	present: 0,		/* number of 1280's present   */\
-	unchecked_isa_dma: 0,	/* no memory DMA restrictions */\
-	use_clustering: ENABLE_CLUSTERING,			\
-	emulated: 0						\
+	.abort = qla1280_abort,					\
+	.reset = qla1280_reset,					\
+	.slave_configure = qla1280_slave_configure,		\
+	.bios_param = qla1280_biosparam,				\
+	.can_queue = 255,		/* max simultaneous cmds      */\
+	.this_id = -1,		/* scsi id of host adapter    */\
+	.sg_tablesize = SG_ALL,	/* max scatter-gather cmds    */\
+	.cmd_per_lun = 3,		/* cmds per lun (linked cmds) */\
+	.present = 0,		/* number of 1280's present   */\
+	.unchecked_isa_dma = 0,	/* no memory DMA restrictions */\
+	.use_clustering = ENABLE_CLUSTERING,			\
+	.emulated = 0						\
 }
 
 #endif				/* _IO_HBA_QLA1280_H */
--- linux-2.5.51/drivers/scsi/qlogicfas.h.old	2002-10-31 16:20:08.000000000 -0600
+++ linux-2.5.51/drivers/scsi/qlogicfas.h	2002-12-10 14:28:33.000000000 -0600
@@ -13,20 +13,20 @@
 			       sector_t, int[]);
 
 #define QLOGICFAS {						\
-	detect:         		qlogicfas_detect,	\
-	info:           		qlogicfas_info,		\
-	command:     			qlogicfas_command, 	\
-	queuecommand:			qlogicfas_queuecommand,	\
-	eh_abort_handler:          	qlogicfas_abort,	\
-	eh_bus_reset_handler:		qlogicfas_bus_reset,	\
-	eh_device_reset_handler:        qlogicfas_device_reset,	\
-	eh_host_reset_handler:          qlogicfas_host_reset,	\
-	bios_param:     qlogicfas_biosparam,			\
-	can_queue:      0,					\
-	this_id:        -1,					\
-	sg_tablesize:   SG_ALL,					\
-	cmd_per_lun:    1,					\
-	use_clustering: DISABLE_CLUSTERING			\
+	.detect         		= qlogicfas_detect,	\
+	.info           		= qlogicfas_info,		\
+	.command     			= qlogicfas_command, 	\
+	.queuecommand			= qlogicfas_queuecommand,	\
+	.eh_abort_handler          	= qlogicfas_abort,	\
+	.eh_bus_reset_handler		= qlogicfas_bus_reset,	\
+	.eh_device_reset_handler        = qlogicfas_device_reset,	\
+	.eh_host_reset_handler          = qlogicfas_host_reset,	\
+	.bios_param     = qlogicfas_biosparam,			\
+	.can_queue      = 0,					\
+	.this_id        = -1,					\
+	.sg_tablesize   = SG_ALL,					\
+	.cmd_per_lun    = 1,					\
+	.use_clustering = DISABLE_CLUSTERING			\
 }
 #endif /* _QLOGICFAS_H */
 
--- linux-2.5.51/drivers/scsi/qlogicfc.h.old	2002-10-31 16:20:08.000000000 -0600
+++ linux-2.5.51/drivers/scsi/qlogicfc.h	2002-12-10 14:28:33.000000000 -0600
@@ -83,20 +83,20 @@
 #endif
 
 #define QLOGICFC {							   \
-        detect:                 isp2x00_detect,                            \
-        release:                isp2x00_release,                           \
-        info:                   isp2x00_info,                              \
-        queuecommand:           isp2x00_queuecommand,                      \
-        eh_abort_handler:       isp2x00_abort,                             \
-        bios_param:             isp2x00_biosparam,                         \
-        can_queue:              QLOGICFC_REQ_QUEUE_LEN,                    \
-        this_id:                -1,                                        \
-        sg_tablesize:           QLOGICFC_MAX_SG(QLOGICFC_REQ_QUEUE_LEN),   \
-	cmd_per_lun:		QLOGICFC_CMD_PER_LUN, 			   \
-        present:                0,                                         \
-        unchecked_isa_dma:      0,                                         \
-        use_clustering:         ENABLE_CLUSTERING, 			   \
-	highmem_io:		1					   \
+        .detect                 = isp2x00_detect,                            \
+        .release                = isp2x00_release,                           \
+        .info                   = isp2x00_info,                              \
+        .queuecommand           = isp2x00_queuecommand,                      \
+        .eh_abort_handler       = isp2x00_abort,                             \
+        .bios_param             = isp2x00_biosparam,                         \
+        .can_queue              = QLOGICFC_REQ_QUEUE_LEN,                    \
+        .this_id                = -1,                                        \
+        .sg_tablesize           = QLOGICFC_MAX_SG(QLOGICFC_REQ_QUEUE_LEN),   \
+	.cmd_per_lun		= QLOGICFC_CMD_PER_LUN, 			   \
+        .present                = 0,                                         \
+        .unchecked_isa_dma      = 0,                                         \
+        .use_clustering         = ENABLE_CLUSTERING, 			   \
+	.highmem_io		= 1					   \
 }
 
 #endif /* _QLOGICFC_H */
--- linux-2.5.51/drivers/scsi/qlogicisp.h.old	2002-10-31 16:20:08.000000000 -0600
+++ linux-2.5.51/drivers/scsi/qlogicisp.h	2002-12-10 14:28:32.000000000 -0600
@@ -72,18 +72,18 @@
 #endif
 
 #define QLOGICISP {							   \
-	detect:			isp1020_detect,				   \
-	release:		isp1020_release,			   \
-	info:			isp1020_info,				   \
-	queuecommand:		isp1020_queuecommand,			   \
-	bios_param:		isp1020_biosparam,			   \
-	can_queue:		QLOGICISP_REQ_QUEUE_LEN,		   \
-	this_id:		-1,					   \
-	sg_tablesize:		QLOGICISP_MAX_SG(QLOGICISP_REQ_QUEUE_LEN), \
-	cmd_per_lun:		1,					   \
-	present:		0,					   \
-	unchecked_isa_dma:	0,					   \
-	use_clustering:		DISABLE_CLUSTERING			   \
+	.detect			= isp1020_detect,				   \
+	.release		= isp1020_release,			   \
+	.info			= isp1020_info,				   \
+	.queuecommand		= isp1020_queuecommand,			   \
+	.bios_param		= isp1020_biosparam,			   \
+	.can_queue		= QLOGICISP_REQ_QUEUE_LEN,		   \
+	.this_id		= -1,					   \
+	.sg_tablesize		= QLOGICISP_MAX_SG(QLOGICISP_REQ_QUEUE_LEN), \
+	.cmd_per_lun		= 1,					   \
+	.present		= 0,					   \
+	.unchecked_isa_dma	= 0,					   \
+	.use_clustering		= DISABLE_CLUSTERING			   \
 }
 
 #endif /* _QLOGICISP_H */
--- linux-2.5.51/drivers/scsi/scsi_debug.c.old	2002-12-10 09:34:02.000000000 -0600
+++ linux-2.5.51/drivers/scsi/scsi_debug.c	2002-12-10 14:28:32.000000000 -0600
@@ -1636,8 +1636,8 @@
 }
 
 static struct bus_type pseudo_lld_bus = {
-        name: "pseudo",
-        match: pseudo_lld_bus_match,
+        .name = "pseudo",
+        .match = pseudo_lld_bus_match,
 };
 
 int scsi_debug_register_driver(struct device_driver *dev_driver)
--- linux-2.5.51/drivers/scsi/seagate.h.old	2002-10-31 16:20:08.000000000 -0600
+++ linux-2.5.51/drivers/scsi/seagate.h	2002-12-10 14:28:33.000000000 -0600
@@ -19,19 +19,19 @@
 static int seagate_st0x_device_reset(Scsi_Cmnd *);
 static int seagate_st0x_host_reset(Scsi_Cmnd *);
 
-#define SEAGATE_ST0X  {  detect:         seagate_st0x_detect,			\
-			 release:        seagate_st0x_release,			\
-			 info:           seagate_st0x_info,			\
-			 command:        seagate_st0x_command,			\
-			 queuecommand:   seagate_st0x_queue_command,		\
-			 eh_abort_handler:	seagate_st0x_abort,		\
-			 eh_bus_reset_handler:  seagate_st0x_bus_reset,		\
-			 eh_host_reset_handler: seagate_st0x_host_reset,	\
-			 eh_device_reset_handler:seagate_st0x_device_reset,	\
-			 can_queue:      1,					\
-			 this_id:        7,					\
-			 sg_tablesize:   SG_ALL,				\
-			 cmd_per_lun:    1,					\
-			 use_clustering: DISABLE_CLUSTERING}
+#define SEAGATE_ST0X  {  .detect         = seagate_st0x_detect,			\
+			 .release        = seagate_st0x_release,			\
+			 .info           = seagate_st0x_info,			\
+			 .command        = seagate_st0x_command,			\
+			 .queuecommand   = seagate_st0x_queue_command,		\
+			 .eh_abort_handler	= seagate_st0x_abort,		\
+			 .eh_bus_reset_handler  = seagate_st0x_bus_reset,		\
+			 .eh_host_reset_handler = seagate_st0x_host_reset,	\
+			 .eh_device_reset_handler = seagate_st0x_device_reset,	\
+			 .can_queue      = 1,					\
+			 .this_id        = 7,					\
+			 .sg_tablesize   = SG_ALL,				\
+			 .cmd_per_lun    = 1,					\
+			 .use_clustering = DISABLE_CLUSTERING}
 
 #endif /* _SEAGATE_H */
--- linux-2.5.51/drivers/scsi/sgiwd93.h.old	2002-07-05 18:42:21.000000000 -0500
+++ linux-2.5.51/drivers/scsi/sgiwd93.h	2002-12-10 14:28:33.000000000 -0600
@@ -25,17 +25,17 @@
 int wd33c93_abort(Scsi_Cmnd *);
 int wd33c93_reset(Scsi_Cmnd *, unsigned int);
 
-#define SGIWD93_SCSI {proc_name:	   "SGIWD93", \
-		      name:                "SGI WD93", \
-		      detect:              sgiwd93_detect,    \
-		      release:             sgiwd93_release,   \
-		      queuecommand:        wd33c93_queuecommand, \
-		      abort:               wd33c93_abort,   \
-		      reset:               wd33c93_reset,   \
-		      can_queue:           CAN_QUEUE,       \
-		      this_id:             7,               \
-		      sg_tablesize:        SG_ALL,          \
-		      cmd_per_lun:	   CMD_PER_LUN,     \
-		      use_clustering:      DISABLE_CLUSTERING }
+#define SGIWD93_SCSI {.proc_name	   = "SGIWD93", \
+		      .name                = "SGI WD93", \
+		      .detect              = sgiwd93_detect,    \
+		      .release             = sgiwd93_release,   \
+		      .queuecommand        = wd33c93_queuecommand, \
+		      .abort               = wd33c93_abort,   \
+		      .reset               = wd33c93_reset,   \
+		      .can_queue           = CAN_QUEUE,       \
+		      .this_id             = 7,               \
+		      .sg_tablesize        = SG_ALL,          \
+		      .cmd_per_lun	   = CMD_PER_LUN,     \
+		      .use_clustering      = DISABLE_CLUSTERING }
 
 #endif /* !(_SGIWD93_H) */
--- linux-2.5.51/drivers/scsi/sim710.h.old	2002-12-10 09:34:04.000000000 -0600
+++ linux-2.5.51/drivers/scsi/sim710.h	2002-12-10 14:28:34.000000000 -0600
@@ -22,20 +22,20 @@
 
 #include <scsi/scsicam.h>
 
-#define SIM710_SCSI { proc_name:		"sim710",		\
-		      name:			"53c710",	 	\
-		      detect:			sim710_detect,		\
-		      release:			sim710_release,		\
-		      queuecommand:		sim710_queuecommand,	\
-		      eh_abort_handler:		sim710_abort,		\
-		      eh_device_reset_handler:	sim710_dev_reset,	\
-		      eh_bus_reset_handler:	sim710_bus_reset,	\
-		      eh_host_reset_handler:	sim710_host_reset,	\
-		      can_queue:		8,		 	\
-		      this_id:			7, 			\
-		      sg_tablesize:		128,		 	\
-		      cmd_per_lun:		1,		 	\
-		      use_clustering:		DISABLE_CLUSTERING }
+#define SIM710_SCSI { .proc_name		= "sim710",		\
+		      .name			= "53c710",	 	\
+		      .detect			= sim710_detect,		\
+		      .release			= sim710_release,		\
+		      .queuecommand		= sim710_queuecommand,	\
+		      .eh_abort_handler		= sim710_abort,		\
+		      .eh_device_reset_handler	= sim710_dev_reset,	\
+		      .eh_bus_reset_handler	= sim710_bus_reset,	\
+		      .eh_host_reset_handler	= sim710_host_reset,	\
+		      .can_queue		= 8,		 	\
+		      .this_id			= 7, 			\
+		      .sg_tablesize		= 128,		 	\
+		      .cmd_per_lun		= 1,		 	\
+		      .use_clustering		= DISABLE_CLUSTERING }
 
 #ifndef HOSTS_C
 
--- linux-2.5.51/drivers/scsi/sun3x_esp.h.old	2002-07-05 18:42:19.000000000 -0500
+++ linux-2.5.51/drivers/scsi/sun3x_esp.h	2002-12-10 14:28:33.000000000 -0600
@@ -21,19 +21,19 @@
 #define DMA_PORTS_P        (dregs->cond_reg & DMA_INT_ENAB)
 
 #define SCSI_SUN3X_ESP {                                        \
-		proc_name:      "esp",  			\
-		proc_info:      &esp_proc_info,			\
-		name:           "Sun ESP 100/100a/200",		\
-		detect:         sun3x_esp_detect,		\
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
+		.proc_name      = "esp",  			\
+		.proc_info      = &esp_proc_info,			\
+		.name           = "Sun ESP 100/100a/200",		\
+		.detect         = sun3x_esp_detect,		\
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
 
 #endif /* !(_SUN3X_ESP_H) */
--- linux-2.5.51/drivers/scsi/sym53c8xx.h.old	2002-11-29 09:24:21.000000000 -0600
+++ linux-2.5.51/drivers/scsi/sym53c8xx.h	2002-12-10 14:28:33.000000000 -0600
@@ -85,21 +85,21 @@
 
 #if	LINUX_VERSION_CODE >= LinuxVersionCode(2,1,75)
 
-#define SYM53C8XX {     name:           "",			\
-			detect:         sym53c8xx_detect,	\
-			release:        sym53c8xx_release,	\
-			info:           sym53c8xx_info, 	\
-			queuecommand:   sym53c8xx_queue_command,\
-			slave_configure:sym53c8xx_slave_configure,\
-			abort:          sym53c8xx_abort,	\
-			reset:          sym53c8xx_reset,	\
-			can_queue:      SCSI_NCR_CAN_QUEUE,	\
-			this_id:        7,			\
-			sg_tablesize:   SCSI_NCR_SG_TABLESIZE,	\
-			cmd_per_lun:    SCSI_NCR_CMD_PER_LUN,	\
-			max_sectors:	MAX_HW_SEGMENTS*8,	\
-			use_clustering: DISABLE_CLUSTERING,	\
-			highmem_io:	1} 
+#define SYM53C8XX {     .name           = "",			\
+			.detect         = sym53c8xx_detect,	\
+			.release        = sym53c8xx_release,	\
+			.info           = sym53c8xx_info, 	\
+			.queuecommand   = sym53c8xx_queue_command,\
+			.slave_configure = sym53c8xx_slave_configure,\
+			.abort          = sym53c8xx_abort,	\
+			.reset          = sym53c8xx_reset,	\
+			.can_queue      = SCSI_NCR_CAN_QUEUE,	\
+			.this_id        = 7,			\
+			.sg_tablesize   = SCSI_NCR_SG_TABLESIZE,	\
+			.cmd_per_lun    = SCSI_NCR_CMD_PER_LUN,	\
+			.max_sectors	= MAX_HW_SEGMENTS*8,	\
+			.use_clustering = DISABLE_CLUSTERING,	\
+			.highmem_io	= 1} 
 
 #else
 
--- linux-2.5.51/drivers/scsi/t128.h.old	2002-10-31 16:20:09.000000000 -0600
+++ linux-2.5.51/drivers/scsi/t128.h	2002-12-10 14:28:33.000000000 -0600
@@ -121,19 +121,19 @@
  */
 
 #define TRANTOR_T128 {					\
-	name:           "Trantor T128/T128F/T228",	\
-	detect:         t128_detect,			\
-	queuecommand:   t128_queue_command,		\
-	eh_abort_handler: t128_abort,			\
-	eh_bus_reset_handler:    t128_bus_reset,	\
-	eh_host_reset_handler:   t128_host_reset,	\
-	eh_device_reset_handler: t128_device_reset,	\
-	bios_param:     t128_biosparam,			\
-	can_queue:      CAN_QUEUE,			\
-        this_id:        7,				\
-	sg_tablesize:   SG_ALL,				\
-	cmd_per_lun:    CMD_PER_LUN,			\
-	use_clustering: DISABLE_CLUSTERING}
+	.name           = "Trantor T128/T128F/T228",	\
+	.detect         = t128_detect,			\
+	.queuecommand   = t128_queue_command,		\
+	.eh_abort_handler = t128_abort,			\
+	.eh_bus_reset_handler    = t128_bus_reset,	\
+	.eh_host_reset_handler   = t128_host_reset,	\
+	.eh_device_reset_handler = t128_device_reset,	\
+	.bios_param     = t128_biosparam,			\
+	.can_queue      = CAN_QUEUE,			\
+        .this_id        = 7,				\
+	.sg_tablesize   = SG_ALL,				\
+	.cmd_per_lun    = CMD_PER_LUN,			\
+	.use_clustering = DISABLE_CLUSTERING}
 
 #ifndef HOSTS_C
 
--- linux-2.5.51/drivers/scsi/u14-34f.h.old	2002-11-29 09:24:22.000000000 -0600
+++ linux-2.5.51/drivers/scsi/u14-34f.h	2002-12-10 14:28:34.000000000 -0600
@@ -13,17 +13,17 @@
 #define U14_34F_VERSION "8.00.00"
 
 #define ULTRASTOR_14_34F {                                                   \
-                name:         "UltraStor 14F/34F rev. " U14_34F_VERSION " ", \
-                detect:                  u14_34f_detect,                     \
-                release:                 u14_34f_release,                    \
-                queuecommand:            u14_34f_queuecommand,               \
-                eh_abort_handler:        u14_34f_eh_abort,                   \
-                eh_device_reset_handler: NULL,                               \
-                eh_bus_reset_handler:    NULL,                               \
-                eh_host_reset_handler:   u14_34f_eh_host_reset,              \
-                bios_param:              u14_34f_bios_param,                 \
-                slave_configure:         u14_34f_slave_configure,            \
-                this_id:                 7,                                  \
-                unchecked_isa_dma:       1,                                  \
-                use_clustering:          ENABLE_CLUSTERING                   \
+                .name         = "UltraStor 14F/34F rev. " U14_34F_VERSION " ", \
+                .detect                  = u14_34f_detect,                     \
+                .release                 = u14_34f_release,                    \
+                .queuecommand            = u14_34f_queuecommand,               \
+                .eh_abort_handler        = u14_34f_eh_abort,                   \
+                .eh_device_reset_handler = NULL,                               \
+                .eh_bus_reset_handler    = NULL,                               \
+                .eh_host_reset_handler   = u14_34f_eh_host_reset,              \
+                .bios_param              = u14_34f_bios_param,                 \
+                .slave_configure         = u14_34f_slave_configure,            \
+                .this_id                 = 7,                                  \
+                .unchecked_isa_dma       = 1,                                  \
+                .use_clustering          = ENABLE_CLUSTERING                   \
                 }
--- linux-2.5.51/drivers/scsi/ultrastor.h.old	2002-11-11 07:14:47.000000000 -0600
+++ linux-2.5.51/drivers/scsi/ultrastor.h	2002-12-10 14:28:33.000000000 -0600
@@ -30,19 +30,19 @@
 #define ULTRASTOR_24F_PORT 0xC80
 
 
-#define ULTRASTOR_14F {   name:              "UltraStor 14F/24F/34F", 	\
-			  detect:            ultrastor_detect, 		\
-			  info:              ultrastor_info, 		\
-			  queuecommand:      ultrastor_queuecommand,	\
-			  eh_abort_handler:  ultrastor_abort, 		\
-			  eh_host_reset_handler:  ultrastor_host_reset,	\
-			  bios_param:        ultrastor_biosparam, 	\
-			  can_queue:         ULTRASTOR_MAX_CMDS,	\
-			  this_id:           0, 			\
-			  sg_tablesize:      ULTRASTOR_14F_MAX_SG, 	\
-			  cmd_per_lun:       ULTRASTOR_MAX_CMDS_PER_LUN,\
-			  unchecked_isa_dma: 1, 			\
-			  use_clustering:    ENABLE_CLUSTERING }
+#define ULTRASTOR_14F {   .name              = "UltraStor 14F/24F/34F", 	\
+			  .detect            = ultrastor_detect, 		\
+			  .info              = ultrastor_info, 		\
+			  .queuecommand      = ultrastor_queuecommand,	\
+			  .eh_abort_handler  = ultrastor_abort, 		\
+			  .eh_host_reset_handler  = ultrastor_host_reset,	\
+			  .bios_param        = ultrastor_biosparam, 	\
+			  .can_queue         = ULTRASTOR_MAX_CMDS,	\
+			  .this_id           = 0, 			\
+			  .sg_tablesize      = ULTRASTOR_14F_MAX_SG, 	\
+			  .cmd_per_lun       = ULTRASTOR_MAX_CMDS_PER_LUN,\
+			  .unchecked_isa_dma = 1, 			\
+			  .use_clustering    = ENABLE_CLUSTERING }
 
 
 #ifdef ULTRASTOR_PRIVATE
--- linux-2.5.51/drivers/scsi/wd7000.h.old	2002-10-31 16:20:10.000000000 -0600
+++ linux-2.5.51/drivers/scsi/wd7000.h	2002-12-10 14:28:34.000000000 -0600
@@ -44,21 +44,21 @@
 #define WD7000_SG   16
 
 #define WD7000 {						\
-	proc_name:		"wd7000",			\
-	proc_info:		wd7000_proc_info,		\
-	name:			"Western Digital WD-7000",	\
-	detect:			wd7000_detect,			\
-	command:		wd7000_command,			\
-	queuecommand:		wd7000_queuecommand,		\
-	eh_bus_reset_handler:	wd7000_bus_reset,		\
-	eh_device_reset_handler:wd7000_device_reset,		\
-	eh_host_reset_handler:	wd7000_host_reset,		\
-	bios_param:		wd7000_biosparam,		\
-	can_queue:		WD7000_Q,			\
-	this_id:		7,				\
-	sg_tablesize:		WD7000_SG,			\
-	cmd_per_lun:		1,				\
-	unchecked_isa_dma:	1,				\
-	use_clustering:		ENABLE_CLUSTERING,		\
+	.proc_name		= "wd7000",			\
+	.proc_info		= wd7000_proc_info,		\
+	.name			= "Western Digital WD-7000",	\
+	.detect			= wd7000_detect,			\
+	.command		= wd7000_command,			\
+	.queuecommand		= wd7000_queuecommand,		\
+	.eh_bus_reset_handler	= wd7000_bus_reset,		\
+	.eh_device_reset_handler = wd7000_device_reset,		\
+	.eh_host_reset_handler	= wd7000_host_reset,		\
+	.bios_param		= wd7000_biosparam,		\
+	.can_queue		= WD7000_Q,			\
+	.this_id		= 7,				\
+	.sg_tablesize		= WD7000_SG,			\
+	.cmd_per_lun		= 1,				\
+	.unchecked_isa_dma	= 1,				\
+	.use_clustering		= ENABLE_CLUSTERING,		\
 }
 #endif
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
