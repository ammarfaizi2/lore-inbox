Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261723AbSKCKkm>; Sun, 3 Nov 2002 05:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261725AbSKCKkk>; Sun, 3 Nov 2002 05:40:40 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:50708 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id <S261723AbSKCKkX>; Sun, 3 Nov 2002 05:40:23 -0500
Date: Sun, 3 Nov 2002 11:46:48 +0100
Message-Id: <200211031046.gA3AkmN2000902@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] NCR53C9x ESP: C99 designated initializers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NCR53C9x ESP: C99 designated initializers

--- linux-2.5.45/drivers/scsi/blz1230.h	Fri Nov  1 12:49:23 2002
+++ linux-m68k-2.5.45/drivers/scsi/blz1230.h	Sun Nov  3 10:58:48 2002
@@ -57,19 +57,21 @@
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
-#define SCSI_BLZ1230      { proc_name:		"esp-blz1230", \
-			    proc_info:		esp_proc_info, \
-			    name:		"Blizzard1230 SCSI IV", \
-			    detect:		blz1230_esp_detect, \
-			    release:		blz1230_esp_release, \
-			    command:		esp_command, \
-			    queuecommand:	esp_queue, \
-			    eh_abort_handler:		esp_abort, \
-			    eh_bus_reset_handler:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	ENABLE_CLUSTERING }
+#define SCSI_BLZ1230	{						\
+		.proc_name		= "esp-blz1230",		\
+		.proc_info		= esp_proc_info,		\
+		.name			= "Blizzard1230 SCSI IV",	\
+		.detect			= blz1230_esp_detect,		\
+		.release		= blz1230_esp_release,		\
+		.command		= esp_command,			\
+		.queuecommand		= esp_queue,			\
+		.eh_abort_handler	= esp_abort,			\
+		.eh_bus_reset_handler	= esp_reset,			\
+		.can_queue		= 7,				\
+		.this_id		= 7,				\
+		.sg_tablesize		= SG_ALL,			\
+		.cmd_per_lun		= 1,				\
+		.use_clustering		= ENABLE_CLUSTERING		\
+}
 
 #endif /* BLZ1230_H */
--- linux-2.5.45/drivers/scsi/blz2060.h	Fri Nov  1 12:49:23 2002
+++ linux-m68k-2.5.45/drivers/scsi/blz2060.h	Sun Nov  3 10:59:03 2002
@@ -53,18 +53,20 @@
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
-#define SCSI_BLZ2060      { proc_name:		"esp-blz2060", \
-			    proc_info:		esp_proc_info, \
-			    name:		"Blizzard2060 SCSI", \
-			    detect:		blz2060_esp_detect, \
-			    release:		blz2060_esp_release, \
-			    queuecommand:	esp_queue, \
-			    eh_abort_handler:		esp_abort, \
-			    eh_bus_reset_handler:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	ENABLE_CLUSTERING }
+#define SCSI_BLZ2060	{					\
+		.proc_name		= "esp-blz2060",	\
+		.proc_info		= esp_proc_info,	\
+		.name			= "Blizzard2060 SCSI",	\
+		.detect			= blz2060_esp_detect,	\
+		.release		= blz2060_esp_release,	\
+		.queuecommand		= esp_queue,		\
+		.eh_abort_handler	= esp_abort,		\
+		.eh_bus_reset_handler	= esp_reset,		\
+		.can_queue		= 7,			\
+		.this_id		= 7,			\
+		.sg_tablesize		= SG_ALL,		\
+		.cmd_per_lun		= 1,			\
+		.use_clustering		= ENABLE_CLUSTERING	\
+}
 
 #endif /* BLZ2060_H */
--- linux-2.5.45/drivers/scsi/cyberstorm.h	Fri Nov  1 12:49:23 2002
+++ linux-m68k-2.5.45/drivers/scsi/cyberstorm.h	Sun Nov  3 10:59:23 2002
@@ -56,18 +56,20 @@
 			 int hostno, int inout);
 
 
-#define SCSI_CYBERSTORM   { proc_name:		"esp-cyberstorm", \
-			    proc_info:		esp_proc_info, \
-			    name:		"CyberStorm SCSI", \
-			    detect:		cyber_esp_detect, \
-			    release:		cyber_esp_release, \
-			    queuecommand:	esp_queue, \
-			    eh_abort_handler:		esp_abort, \
-			    eh_bus_reset_handler:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	ENABLE_CLUSTERING }
+#define SCSI_CYBERSTORM	{					\
+		.proc_name		= "esp-cyberstorm",	\
+		.proc_info		= esp_proc_info,	\
+		.name			= "CyberStorm SCSI",	\
+		.detect			= cyber_esp_detect,	\
+		.release		= cyber_esp_release,	\
+		.queuecommand		= esp_queue,		\
+		.eh_abort_handler	= esp_abort,		\
+		.eh_bus_reset_handler	= esp_reset,		\
+		.can_queue		= 7,			\
+		.this_id		= 7,			\
+		.sg_tablesize		= SG_ALL,		\
+		.cmd_per_lun		= 1,			\
+		.use_clustering		= ENABLE_CLUSTERING	\
+}
 
 #endif /* CYBER_ESP_H */
--- linux-2.5.45/drivers/scsi/cyberstormII.h	Fri Nov  1 12:49:23 2002
+++ linux-m68k-2.5.45/drivers/scsi/cyberstormII.h	Sun Nov  3 10:59:38 2002
@@ -43,18 +43,20 @@
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
-#define SCSI_CYBERSTORMII { proc_name:		"esp-cyberstormII", \
-			    proc_info:		esp_proc_info, \
-			    name:		"CyberStorm Mk II SCSI", \
-			    detect:		cyberII_esp_detect, \
-			    release:		cyberII_esp_release, \
-			    queuecommand:	esp_queue, \
-			    eh_abort_handler:		esp_abort, \
-			    eh_bus_reset_handler:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	ENABLE_CLUSTERING }
+#define SCSI_CYBERSTORMII	{					\
+		.proc_name		= "esp-cyberstormII",		\
+		.proc_info		= esp_proc_info,		\
+		.name			= "CyberStorm Mk II SCSI",	\
+		.detect			= cyberII_esp_detect,		\
+		.release		= cyberII_esp_release,		\
+		.queuecommand		= esp_queue,			\
+		.eh_abort_handler	= esp_abort,			\
+		.eh_bus_reset_handler	= esp_reset,			\
+		.can_queue		= 7,				\
+		.this_id		= 7,				\
+		.sg_tablesize		= SG_ALL,			\
+		.cmd_per_lun		= 1,				\
+		.use_clustering		= ENABLE_CLUSTERING		\
+}
 
 #endif /* CYBERII_ESP_H */
--- linux-2.5.45/drivers/scsi/dec_esp.h	Fri Nov  1 12:49:24 2002
+++ linux-m68k-2.5.45/drivers/scsi/dec_esp.h	Sun Nov  3 11:00:01 2002
@@ -26,20 +26,21 @@
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
-#define SCSI_DEC_ESP {                                         \
-		proc_name:      "esp",				\
-		proc_info:      &esp_proc_info,			\
-		name:           "NCR53C94",			\
-		detect:         dec_esp_detect,			\
-		info:           esp_info,			\
-		command:        esp_command,			\
-		queuecommand:   esp_queue,			\
-		eh_abort_handler:          esp_abort,			\
-		eh_bus_reset_handler:          esp_reset,			\
-		can_queue:      7,				\
-		this_id:        7,				\
-		sg_tablesize:   SG_ALL,				\
-		cmd_per_lun:    1,				\
-		use_clustering: DISABLE_CLUSTERING, }
+#define SCSI_DEC_ESP	{					\
+		.proc_name		= "esp",		\
+		.proc_info		= &esp_proc_info,	\
+		.name			= "NCR53C94",		\
+		.detect			= dec_esp_detect,	\
+		.info			= esp_info,		\
+		.command		= esp_command,		\
+		.queuecommand		= esp_queue,		\
+		.eh_abort_handler	= esp_abort,		\
+		.eh_bus_reset_handler	= esp_reset,		\
+		.can_queue		= 7,			\
+		.this_id		= 7,			\
+		.sg_tablesize		= SG_ALL,		\
+		.cmd_per_lun		= 1,			\
+		.use_clustering		= DISABLE_CLUSTERING,	\
+}
 
 #endif /* DEC_ESP_H */
--- linux-2.5.45/drivers/scsi/fastlane.h	Fri Nov  1 12:49:24 2002
+++ linux-m68k-2.5.45/drivers/scsi/fastlane.h	Sun Nov  3 11:00:15 2002
@@ -48,18 +48,20 @@
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
-#define SCSI_FASTLANE     { proc_name:		"esp-fastlane", \
-			    proc_info:		esp_proc_info, \
-			    name:		"Fastlane SCSI", \
-			    detect:		fastlane_esp_detect, \
-			    release:		fastlane_esp_release, \
-			    queuecommand:	esp_queue, \
-			    eh_abort_handler:		esp_abort, \
-			    eh_bus_reset_handler:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	ENABLE_CLUSTERING }
+#define SCSI_FASTLANE	{					\
+		.proc_name		= "esp-fastlane",	\
+		.proc_info		= esp_proc_info,	\
+		.name			= "Fastlane SCSI",	\
+		.detect			= fastlane_esp_detect,	\
+		.release		= fastlane_esp_release,	\
+		.queuecommand		= esp_queue,		\
+		.eh_abort_handler	= esp_abort,		\
+		.eh_bus_reset_handler	= esp_reset,		\
+		.can_queue		= 7,			\
+		.this_id		= 7,			\
+		.sg_tablesize		= SG_ALL,		\
+		.cmd_per_lun		= 1,			\
+		.use_clustering		= ENABLE_CLUSTERING	\
+}
 
 #endif /* FASTLANE_H */
--- linux-2.5.45/drivers/scsi/jazz_esp.h	Fri Nov  1 12:49:24 2002
+++ linux-m68k-2.5.45/drivers/scsi/jazz_esp.h	Sun Nov  3 11:00:41 2002
@@ -20,20 +20,21 @@
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
-#define SCSI_JAZZ_ESP {                                         \
-		proc_name:      "esp",				\
-		proc_info:      &esp_proc_info,			\
-		name:           "ESP 100/100a/200",		\
-		detect:         jazz_esp_detect,		\
-		info:           esp_info,			\
-		command:        esp_command,			\
-		queuecommand:   esp_queue,			\
-		eh_abort_handler:          esp_abort,			\
-		eh_bus_reset_handler:          esp_reset,			\
-		can_queue:      7,				\
-		this_id:        7,				\
-		sg_tablesize:   SG_ALL,				\
-		cmd_per_lun:    1,				\
-		use_clustering: DISABLE_CLUSTERING, }
+#define SCSI_JAZZ_ESP	{					\
+		.proc_name		= "esp",		\
+		.proc_info		= &esp_proc_info,	\
+		.name			= "ESP 100/100a/200",	\
+		.detect			= jazz_esp_detect,	\
+		.info			= esp_info,		\
+		.command		= esp_command,		\
+		.queuecommand		= esp_queue,		\
+		.eh_abort_handler	= esp_abort,		\
+		.eh_bus_reset_handler	= esp_reset,		\
+		.can_queue		= 7,			\
+		.this_id		= 7,			\
+		.sg_tablesize		= SG_ALL,		\
+		.cmd_per_lun		= 1,			\
+		.use_clustering		= DISABLE_CLUSTERING,	\
+}
 
 #endif /* JAZZ_ESP_H */
--- linux-2.5.45/drivers/scsi/mac_esp.h	Fri Nov  1 12:49:24 2002
+++ linux-m68k-2.5.45/drivers/scsi/mac_esp.h	Sun Nov  3 11:00:57 2002
@@ -21,20 +21,22 @@
 extern int esp_reset(Scsi_Cmnd *);
 
 
-#define SCSI_MAC_ESP      { proc_name:		"esp", \
-			    name:		"Mac 53C9x SCSI", \
-			    detect:		mac_esp_detect, \
-			    release:		NULL, \
-			    info:		esp_info, \
-			    /* command:		esp_command, */ \
-			    queuecommand:	esp_queue, \
-			    eh_abort_handler:		esp_abort, \
-			    eh_bus_reset_handler:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	DISABLE_CLUSTERING }
+#define SCSI_MAC_ESP	{					\
+		.proc_name		= "esp",		\
+		.name			= "Mac 53C9x SCSI",	\
+		.detect			= mac_esp_detect,	\
+		.release		= NULL,			\
+		.info			= esp_info,		\
+		/* .command		= esp_command, */	\
+		.queuecommand		= esp_queue,		\
+		.eh_abort_handler	= esp_abort,		\
+		.eh_bus_reset_handler	= esp_reset,		\
+		.can_queue		= 7,			\
+		.this_id		= 7,			\
+		.sg_tablesize		= SG_ALL,		\
+		.cmd_per_lun		= 1,			\
+		.use_clustering		= DISABLE_CLUSTERING	\
+}
 
 #endif /* MAC_ESP_H */
 
--- linux-2.5.45/drivers/scsi/mca_53c9x.h	Fri Nov  1 12:49:24 2002
+++ linux-m68k-2.5.45/drivers/scsi/mca_53c9x.h	Sun Nov  3 11:01:09 2002
@@ -31,18 +31,20 @@
 			 int hostno, int inout);
 
 
-#define MCA_53C9X         { proc_name:		"esp", \
-			    name:		"NCR 53c9x SCSI", \
-			    detect:		mca_esp_detect, \
-			    release:		mca_esp_release, \
-			    queuecommand:	esp_queue, \
-			    eh_abort_handler:		esp_abort, \
-			    eh_bus_reset_handler:		esp_reset, \
-			    can_queue:          7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-                            unchecked_isa_dma:  1, \
-			    use_clustering:	DISABLE_CLUSTERING }
+#define MCA_53C9X	{					\
+		.proc_name		= "esp",		\
+		.name			= "NCR 53c9x SCSI",	\
+		.detect			= mca_esp_detect,	\
+		.release		= mca_esp_release,	\
+		.queuecommand		= esp_queue,		\
+		.eh_abort_handler	= esp_abort,		\
+		.eh_bus_reset_handler	= esp_reset,		\
+		.can_queue		= 7,			\
+		.sg_tablesize		= SG_ALL,		\
+		.cmd_per_lun		= 1,			\
+		.unchecked_isa_dma	= 1,			\
+		.use_clustering		= DISABLE_CLUSTERING	\
+}
 
 /* Ports the ncr's 53c94 can be put at; indexed by pos register value */
 
--- linux-2.5.45/drivers/scsi/oktagon_esp.h	Fri Nov  1 12:49:24 2002
+++ linux-m68k-2.5.45/drivers/scsi/oktagon_esp.h	Sun Nov  3 11:01:23 2002
@@ -39,19 +39,20 @@
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			int hostno, int inout);
 
-#define SCSI_OKTAGON_ESP {                       \
-   proc_name:           "esp-oktagon",           \
-   proc_info:           &esp_proc_info,          \
-   name:                "BSC Oktagon SCSI",      \
-   detect:              oktagon_esp_detect,      \
-   release:             oktagon_esp_release,     \
-   queuecommand:        esp_queue,               \
-   eh_abort_handler:               esp_abort,               \
-   eh_bus_reset_handler:               esp_reset,               \
-   can_queue:           7,                       \
-   this_id:             7,                       \
-   sg_tablesize:        SG_ALL,                  \
-   cmd_per_lun:         1,                       \
-   use_clustering:      ENABLE_CLUSTERING }
+#define SCSI_OKTAGON_ESP	{				\
+		.proc_name		= "esp-oktagon",	\
+		.proc_info		= &esp_proc_info,	\
+		.name			= "BSC Oktagon SCSI",	\
+		.detect			= oktagon_esp_detect,	\
+		.release		= oktagon_esp_release,	\
+		.queuecommand		= esp_queue,		\
+		.eh_abort_handler	= esp_abort,		\
+		.eh_bus_reset_handler	= esp_reset,		\
+		.can_queue		= 7,			\
+		.this_id		= 7,			\
+		.sg_tablesize		= SG_ALL,		\
+		.cmd_per_lun		= 1,			\
+		.use_clustering		= ENABLE_CLUSTERING	\
+}
 
 #endif /* OKTAGON_ESP_H */
--- linux-2.5.45/drivers/scsi/sun3x_esp.h	Fri Nov  1 12:49:24 2002
+++ linux-m68k-2.5.45/drivers/scsi/sun3x_esp.h	Sun Nov  3 11:01:46 2002
@@ -20,20 +20,21 @@
 
 #define DMA_PORTS_P        (dregs->cond_reg & DMA_INT_ENAB)
 
-#define SCSI_SUN3X_ESP {                                        \
-		proc_name:      "esp",  			\
-		proc_info:      &esp_proc_info,			\
-		name:           "Sun ESP 100/100a/200",		\
-		detect:         sun3x_esp_detect,		\
-		info:           esp_info,			\
-		command:        esp_command,			\
-		queuecommand:   esp_queue,			\
-		eh_abort_handler:          esp_abort,			\
-		eh_bus_reset_handler:          esp_reset,			\
-		can_queue:      7,				\
-		this_id:        7,				\
-		sg_tablesize:   SG_ALL,				\
-		cmd_per_lun:    1,				\
-		use_clustering: DISABLE_CLUSTERING, }
+#define SCSI_SUN3X_ESP	{						\
+		.proc_name		= "esp",			\
+		.proc_info		= &esp_proc_info,		\
+		.name			= "Sun ESP 100/100a/200",	\
+		.detect			= sun3x_esp_detect,		\
+		.info			= esp_info,			\
+		.command		= esp_command,			\
+		.queuecommand		= esp_queue,			\
+		.eh_abort_handler	= esp_abort,			\
+		.eh_bus_reset_handler	= esp_reset,			\
+		.can_queue		= 7,				\
+		.this_id		= 7,				\
+		.sg_tablesize		= SG_ALL,			\
+		.cmd_per_lun		= 1,				\
+		.use_clustering		= DISABLE_CLUSTERING,		\
+}
 
 #endif /* !(_SUN3X_ESP_H) */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

