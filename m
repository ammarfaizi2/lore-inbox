Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTDGTF1 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 15:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbTDGTF1 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 15:05:27 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:32979 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S263590AbTDGTFX (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 15:05:23 -0400
Date: Mon, 7 Apr 2003 21:16:51 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] C99 Initialisers around scsi + ac97_codec.c
In-Reply-To: <Pine.LNX.4.51.0304051607310.32140@dns.toxicfilms.tv>
Message-ID: <Pine.LNX.4.51.0304072115010.19830@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0304051607310.32140@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

here is a set of C99 initialisers to 2.5.66-bk13 drivers/scsi and
sound/pci/ac97/ac97_codec.c files.

 drivers/scsi/3w-xxxx.c                 |    8 +-
 drivers/scsi/aic7xxx/aic79xx_osm_pci.c |    8 +-
 drivers/scsi/aic7xxx/aic7xxx_osm_pci.c |    8 +-
 drivers/scsi/gdth.h                    |   92 ++++++++++++++++-----------------
 drivers/scsi/sym53c8xx_2/sym53c8xx.h   |   32 +++++------
 sound/pci/ac97/ac97_codec.c            |   10 +--
 6 files changed, 79 insertions(+), 79 deletions(-)

Regards,
Maciej

diff -Nru linux-2.5.66.orig/drivers/scsi/3w-xxxx.c linux-2.5.66/drivers/scsi/3w-xxxx.c
--- linux-2.5.66.orig/drivers/scsi/3w-xxxx.c	2003-04-07 20:57:44.000000000 +0200
+++ linux-2.5.66/drivers/scsi/3w-xxxx.c	2003-04-07 20:51:07.000000000 +0200
@@ -226,10 +226,10 @@

 /* File operations struct for character device */
 static struct file_operations tw_fops = {
-	owner: THIS_MODULE,
-	ioctl: tw_chrdev_ioctl,
-	open: tw_chrdev_open,
-	release: tw_chrdev_release
+	.owner	= THIS_MODULE,
+	.ioctl	= tw_chrdev_ioctl,
+	.open	= tw_chrdev_open,
+	.release	= tw_chrdev_release
 };

 /* Globals */
diff -Nru linux-2.5.66.orig/drivers/scsi/aic7xxx/aic79xx_osm_pci.c linux-2.5.66/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
--- linux-2.5.66.orig/drivers/scsi/aic7xxx/aic79xx_osm_pci.c	2003-03-05 04:29:04.000000000 +0100
+++ linux-2.5.66/drivers/scsi/aic7xxx/aic79xx_osm_pci.c	2003-04-07 20:51:04.000000000 +0200
@@ -70,10 +70,10 @@
 MODULE_DEVICE_TABLE(pci, ahd_linux_pci_id_table);

 struct pci_driver aic79xx_pci_driver = {
-	name:		"aic79xx",
-	probe:		ahd_linux_pci_dev_probe,
-	remove:		ahd_linux_pci_dev_remove,
-	id_table:	ahd_linux_pci_id_table
+	.name		= "aic79xx",
+	.probe		= ahd_linux_pci_dev_probe,
+	.remove		= ahd_linux_pci_dev_remove,
+	.id_table	= ahd_linux_pci_id_table
 };

 static void
diff -Nru linux-2.5.66.orig/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c linux-2.5.66/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
--- linux-2.5.66.orig/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2003-03-05 04:29:04.000000000 +0100
+++ linux-2.5.66/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2003-04-07 20:51:04.000000000 +0200
@@ -75,10 +75,10 @@
 MODULE_DEVICE_TABLE(pci, ahc_linux_pci_id_table);

 struct pci_driver aic7xxx_pci_driver = {
-	name:		"aic7xxx",
-	probe:		ahc_linux_pci_dev_probe,
-	remove:		ahc_linux_pci_dev_remove,
-	id_table:	ahc_linux_pci_id_table
+	.name		= "aic7xxx",
+	.probe		= ahc_linux_pci_dev_probe,
+	.remove		= ahc_linux_pci_dev_remove,
+	.id_table	= ahc_linux_pci_id_table
 };

 static void
diff -Nru linux-2.5.66.orig/drivers/scsi/gdth.h linux-2.5.66/drivers/scsi/gdth.h
--- linux-2.5.66.orig/drivers/scsi/gdth.h	2003-04-07 20:57:14.000000000 +0200
+++ linux-2.5.66/drivers/scsi/gdth.h	2003-04-07 20:51:06.000000000 +0200
@@ -1013,29 +1013,29 @@
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
-               use_clustering:  ENABLE_CLUSTERING,               \
-               use_new_eh_code: 1       /* use new error code */ }
+#define GDTH { .proc_name		= "gdth",                          \
+               .proc_info		= gdth_proc_info,                  \
+               .name			= "GDT SCSI Disk Array Controller",\
+               .detect			= gdth_detect,                     \
+               .release			= gdth_release,                    \
+               .info			= gdth_info,                       \
+               .command			= NULL,                            \
+               .queuecommand		= gdth_queuecommand,               \
+               .eh_abort_handler	= gdth_eh_abort,                  \
+               .eh_device_reset_handler	= gdth_eh_device_reset,    \
+               .eh_bus_reset_handler	= gdth_eh_bus_reset,          \
+               .eh_host_reset_handler	= gdth_eh_host_reset,        \
+               .abort			= gdth_abort,                      \
+               .reset			= gdth_reset,                      \
+               .bios_param		= gdth_bios_param,                 \
+               .can_queue		= GDTH_MAXCMDS,                    \
+               .this_id			= -1,                              \
+               .sg_tablesize		= GDTH_MAXSG,                      \
+               .cmd_per_lun		= GDTH_MAXC_P_L,                   \
+               .present			= 0,                               \
+               .unchecked_isa_dma	= 1,                             \
+               .use_clustering		= ENABLE_CLUSTERING,               \
+               .use_new_eh_code		= 1       /* use new error code */ }

 #elif LINUX_VERSION_CODE >= 0x02015F
 int gdth_bios_param(Disk *,kdev_t,int *);
@@ -1045,29 +1045,29 @@
 int gdth_eh_device_reset(Scsi_Cmnd *scp);
 int gdth_eh_bus_reset(Scsi_Cmnd *scp);
 int gdth_eh_host_reset(Scsi_Cmnd *scp);
-#define GDTH { proc_dir:        &proc_scsi_gdth,                 \
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
-               use_clustering:  ENABLE_CLUSTERING,               \
-               use_new_eh_code: 1       /* use new error code */ }
+#define GDTH { .proc_dir		= &proc_scsi_gdth,                 \
+               .proc_info		= gdth_proc_info,                  \
+               .name			= "GDT SCSI Disk Array Controller",\
+               .detect			= gdth_detect,                     \
+               .release			= gdth_release,                    \
+               .info			= gdth_info,                       \
+               .command			= NULL,                            \
+               .queuecommand		= gdth_queuecommand,               \
+               .eh_abort_handler	= gdth_eh_abort,                  \
+               .eh_device_reset_handler	= gdth_eh_device_reset,    \
+               .eh_bus_reset_handler	= gdth_eh_bus_reset,          \
+               .eh_host_reset_handler	= gdth_eh_host_reset,        \
+               .abort			= gdth_abort,                      \
+               .reset			= gdth_reset,                      \
+               .bios_param		= gdth_bios_param,                 \
+               .can_queue		= GDTH_MAXCMDS,                    \
+               .this_id			= -1,                              \
+               .sg_tablesize		= GDTH_MAXSG,                      \
+               .cmd_per_lun		= GDTH_MAXC_P_L,                   \
+               .present			= 0,                               \
+               .unchecked_isa_dma	= 1,                             \
+               .use_clustering		= ENABLE_CLUSTERING,               \
+               .use_new_eh_code		= 1       /* use new error code */ }

 #elif LINUX_VERSION_CODE >= 0x010300
 int gdth_bios_param(Disk *,kdev_t,int *);
diff -Nru linux-2.5.66.orig/drivers/scsi/sym53c8xx_2/sym53c8xx.h linux-2.5.66/drivers/scsi/sym53c8xx_2/sym53c8xx.h
--- linux-2.5.66.orig/drivers/scsi/sym53c8xx_2/sym53c8xx.h	2003-03-05 04:29:55.000000000 +0100
+++ linux-2.5.66/drivers/scsi/sym53c8xx_2/sym53c8xx.h	2003-04-07 20:51:05.000000000 +0200
@@ -106,22 +106,22 @@
 #include <scsi/scsicam.h>

 #define SYM53C8XX {							\
-	name:			"sym53c8xx",				\
-	detect:			sym53c8xx_detect,			\
-	release:		sym53c8xx_release,			\
-	info:			sym53c8xx_info, 			\
-	queuecommand:		sym53c8xx_queue_command,		\
-	slave_configure:	sym53c8xx_slave_configure,		\
-	eh_abort_handler:	sym53c8xx_eh_abort_handler,		\
-	eh_device_reset_handler:sym53c8xx_eh_device_reset_handler,	\
-	eh_bus_reset_handler:	sym53c8xx_eh_bus_reset_handler,		\
-	eh_host_reset_handler:	sym53c8xx_eh_host_reset_handler,	\
-	can_queue:		0,					\
-	this_id:		7,					\
-	sg_tablesize:		0,					\
-	cmd_per_lun:		0,					\
-	use_clustering:		DISABLE_CLUSTERING,			\
-	highmem_io:		1}
+	.name			= "sym53c8xx",				\
+	.detect			= sym53c8xx_detect,			\
+	.release		= sym53c8xx_release,			\
+	.info			= sym53c8xx_info, 			\
+	.queuecommand		= sym53c8xx_queue_command,		\
+	.slave_configure	= sym53c8xx_slave_configure,		\
+	.eh_abort_handler	= sym53c8xx_eh_abort_handler,		\
+	.eh_device_reset_handler:sym53c8xx_eh_device_reset_handler,	\
+	.eh_bus_reset_handler	= sym53c8xx_eh_bus_reset_handler,		\
+	.eh_host_reset_handler	= sym53c8xx_eh_host_reset_handler,	\
+	.can_queue		= 0,					\
+	.this_id		= 7,					\
+	.sg_tablesize		= 0,					\
+	.cmd_per_lun		= 0,					\
+	.use_clustering		= DISABLE_CLUSTERING,			\
+	.highmem_io		= 1}

 #endif /* defined(HOSTS_C) || defined(MODULE) */

diff -Nru linux-2.5.66.orig/sound/pci/ac97/ac97_codec.c linux-2.5.66/sound/pci/ac97/ac97_codec.c
--- linux-2.5.66.orig/sound/pci/ac97/ac97_codec.c	2003-04-07 20:57:26.000000000 +0200
+++ linux-2.5.66/sound/pci/ac97/ac97_codec.c	2003-04-07 20:52:53.000000000 +0200
@@ -1058,11 +1058,11 @@

 static const snd_kcontrol_new_t snd_ac97_ad1980_spdif_source =
 	{
-		iface: SNDRV_CTL_ELEM_IFACE_MIXER,
-		name: SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "Source",
-		info: snd_ac97_ad1980_spdif_source_info,
-		get: snd_ac97_ad1980_spdif_source_get,
-		put: snd_ac97_ad1980_spdif_source_put,
+		.iface	= SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name	= SNDRV_CTL_NAME_IEC958("",PLAYBACK,NONE) "Source",
+		.info	= snd_ac97_ad1980_spdif_source_info,
+		.get	= snd_ac97_ad1980_spdif_source_get,
+		.put	= snd_ac97_ad1980_spdif_source_put,
 	};


