Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263337AbTDVSOd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 14:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbTDVSOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 14:14:32 -0400
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:24328 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S263328AbTDVSOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 14:14:16 -0400
Date: Tue, 22 Apr 2003 11:02:03 -0500
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] C99 initializers for drivers/scsi
Message-ID: <20030422160203.GD7260@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This set of 4 patches convert files to use C99 initializers. The patches
are against the current BK.

Art Haas

===== drivers/scsi/aic7xxx_old/aic7xxx.h 1.12 vs edited =====
--- 1.12/drivers/scsi/aic7xxx_old/aic7xxx.h	Fri Dec 20 20:00:57 2002
+++ edited/drivers/scsi/aic7xxx_old/aic7xxx.h	Sat Mar  1 15:43:30 2003
@@ -30,26 +30,26 @@
  * to do with card config are filled in after the card is detected.
  */
 #define AIC7XXX	{						\
-	proc_info: aic7xxx_proc_info,				\
-	detect: aic7xxx_detect,					\
-	release: aic7xxx_release,				\
-	info: aic7xxx_info,					\
-	queuecommand: aic7xxx_queue,				\
-	slave_alloc: aic7xxx_slave_alloc,			\
-	slave_configure: aic7xxx_slave_configure,		\
-	slave_destroy: aic7xxx_slave_destroy,			\
-	bios_param: aic7xxx_biosparam,				\
-	eh_abort_handler: aic7xxx_abort,			\
-	eh_device_reset_handler: aic7xxx_bus_device_reset,	\
-	eh_host_reset_handler: aic7xxx_reset,			\
-	can_queue: 255,		/* max simultaneous cmds      */\
-	this_id: -1,		/* scsi id of host adapter    */\
-	sg_tablesize: 0,	/* max scatter-gather cmds    */\
-	max_sectors: 2048,	/* max physical sectors in 1 cmd */\
-	cmd_per_lun: 3,		/* cmds per lun (linked cmds) */\
-	present: 0,		/* number of 7xxx's present   */\
-	unchecked_isa_dma: 0,	/* no memory DMA restrictions */\
-	use_clustering: ENABLE_CLUSTERING,			\
+	.proc_info		= aic7xxx_proc_info,		\
+	.detect			= aic7xxx_detect,		\
+	.release		= aic7xxx_release,		\
+	.info			= aic7xxx_info,			\
+	.queuecommand		= aic7xxx_queue,		\
+	.slave_alloc		= aic7xxx_slave_alloc,		\
+	.slave_configure	= aic7xxx_slave_configure,	\
+	.slave_destroy		= aic7xxx_slave_destroy,	\
+	.bios_param		= aic7xxx_biosparam,		\
+	.eh_abort_handler	= aic7xxx_abort,		\
+	.eh_device_reset_handler	= aic7xxx_bus_device_reset,	\
+	.eh_host_reset_handler	= aic7xxx_reset,			\
+	.can_queue		= 255,	/* max simultaneous cmds      */\
+	.this_id		= -1,	/* scsi id of host adapter    */\
+	.sg_tablesize		= 0,	/* max scatter-gather cmds    */\
+	.max_sectors		= 2048,	/* max physical sectors in 1 cmd */\
+	.cmd_per_lun		= 3,	/* cmds per lun (linked cmds) */\
+	.present		= 0,	/* number of 7xxx's present   */\
+	.unchecked_isa_dma	= 0,	/* no memory DMA restrictions */\
+	.use_clustering		= ENABLE_CLUSTERING,			\
 }
 
 extern int aic7xxx_queue(Scsi_Cmnd *, void (*)(Scsi_Cmnd *));
===== drivers/scsi/sym53c8xx_2/sym53c8xx.h 1.7 vs edited =====
--- 1.7/drivers/scsi/sym53c8xx_2/sym53c8xx.h	Thu Nov 21 23:34:45 2002
+++ edited/drivers/scsi/sym53c8xx_2/sym53c8xx.h	Sat Mar  1 15:48:32 2003
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
+	.eh_device_reset_handler	= sym53c8xx_eh_device_reset_handler,\
+	.eh_bus_reset_handler	= sym53c8xx_eh_bus_reset_handler,	\
+	.eh_host_reset_handler	= sym53c8xx_eh_host_reset_handler,	\
+	.can_queue		= 0,					\
+	.this_id		= 7,					\
+	.sg_tablesize		= 0,					\
+	.cmd_per_lun		= 0,					\
+	.use_clustering		= DISABLE_CLUSTERING,			\
+	.highmem_io		= 1}
 
 #endif /* defined(HOSTS_C) || defined(MODULE) */ 
 
===== drivers/scsi/3w-xxxx.c 1.28 vs edited =====
--- 1.28/drivers/scsi/3w-xxxx.c	Wed Mar 26 14:10:23 2003
+++ edited/drivers/scsi/3w-xxxx.c	Wed Apr  2 07:15:18 2003
@@ -226,10 +226,10 @@
 
 /* File operations struct for character device */
 static struct file_operations tw_fops = {
-	owner: THIS_MODULE,
-	ioctl: tw_chrdev_ioctl,
-	open: tw_chrdev_open,
-	release: tw_chrdev_release
+	.owner		= THIS_MODULE,
+	.ioctl		= tw_chrdev_ioctl,
+	.open		= tw_chrdev_open,
+	.release	= tw_chrdev_release
 };
 
 /* Globals */
===== drivers/scsi/gdth.c 1.22 vs edited =====
--- 1.22/drivers/scsi/gdth.c	Thu Mar  6 17:11:01 2003
+++ edited/drivers/scsi/gdth.c	Wed Apr  2 07:14:37 2003
@@ -747,9 +747,9 @@
 #ifdef GDTH_IOCTL_CHRDEV
 /* ioctl interface */
 static struct file_operations gdth_fops = {
-    ioctl:gdth_ioctl,
-    open:gdth_open,
-    release:gdth_close,
+	.ioctl		= gdth_ioctl,
+	.open		= gdth_open,
+	.release	= gdth_close,
 };
 #endif
 
-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
 -- Theodore Roosevelt, Kansas City Star, 1918
