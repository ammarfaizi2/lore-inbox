Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbTHTIDv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 04:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbTHTIDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 04:03:17 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:32461 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S261775AbTHTIAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 04:00:49 -0400
Date: Wed, 20 Aug 2003 18:01:56 +1000
Message-Id: <200308200801.h7K81uAS011691@theirongiant.lochness.weebeastie.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 7/16] C99: 2.6.0-t3-bk7/arch/ia64
Cc: Linus Torvalds <torvalds@osdl.org>
From: CaT <cat@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -aur linux.backup/arch/ia64/hp/common/sba_iommu.c linux/arch/ia64/hp/common/sba_iommu.c
--- linux.backup/arch/ia64/hp/common/sba_iommu.c	Sat Aug 16 15:02:36 2003
+++ linux/arch/ia64/hp/common/sba_iommu.c	Wed Aug 20 16:40:22 2003
@@ -1935,10 +1935,10 @@
 }
 
 static struct acpi_driver acpi_sba_ioc_driver = {
-	name:		"IOC IOMMU Driver",
-	ids:		"HWP0001,HWP0004",
-	ops: {
-		add:	acpi_sba_ioc_add,
+	.name		= "IOC IOMMU Driver",
+	.ids		= "HWP0001,HWP0004",
+	.ops		= {
+		.add	= acpi_sba_ioc_add,
 	},
 };
 
diff -aur linux.backup/arch/ia64/kernel/perfmon.c linux/arch/ia64/kernel/perfmon.c
--- linux.backup/arch/ia64/kernel/perfmon.c	Wed Aug 20 16:38:54 2003
+++ linux/arch/ia64/kernel/perfmon.c	Wed Aug 20 16:40:22 2003
@@ -2114,7 +2114,7 @@
 	return 1;
 }
 static struct dentry_operations pfmfs_dentry_operations = {
-	d_delete:	pfmfs_delete_dentry,
+	.d_delete	= pfmfs_delete_dentry,
 };
 
 
diff -aur linux.backup/arch/ia64/sn/io/drivers/ioconfig_bus.c linux/arch/ia64/sn/io/drivers/ioconfig_bus.c
--- linux.backup/arch/ia64/sn/io/drivers/ioconfig_bus.c	Thu Jun 26 23:48:30 2003
+++ linux/arch/ia64/sn/io/drivers/ioconfig_bus.c	Wed Aug 20 16:40:22 2003
@@ -346,9 +346,9 @@
 }
 
 struct file_operations ioconfig_bus_fops = {
-	ioctl:ioconfig_bus_ioctl,
-	open:ioconfig_bus_open,		/* open */
-	release:ioconfig_bus_close	/* release */
+	.ioctl = ioconfig_bus_ioctl,
+	.open = ioconfig_bus_open,		/* open */
+	.release = ioconfig_bus_close	/* release */
 };
 
 
diff -aur linux.backup/arch/ia64/sn/io/sn2/shub.c linux/arch/ia64/sn/io/sn2/shub.c
--- linux.backup/arch/ia64/sn/io/sn2/shub.c	Sat Aug 16 15:02:37 2003
+++ linux/arch/ia64/sn/io/sn2/shub.c	Wed Aug 20 16:40:22 2003
@@ -243,7 +243,7 @@
 }
 
 struct file_operations shub_mon_fops = {
-	        ioctl:          shubstats_ioctl,
+	        .ioctl          = shubstats_ioctl,
 };
 
 /*
diff -aur linux.backup/arch/ia64/sn/kernel/setup.c linux/arch/ia64/sn/kernel/setup.c
--- linux.backup/arch/ia64/sn/kernel/setup.c	Sat Aug 16 15:02:37 2003
+++ linux/arch/ia64/sn/kernel/setup.c	Wed Aug 20 16:40:22 2003
@@ -117,14 +117,14 @@
  * VGA color display.
  */
 struct screen_info sn_screen_info = {
-	orig_x:			 0,
-	orig_y:			 0,
-	orig_video_mode:	 3,
-	orig_video_cols:	80,
-	orig_video_ega_bx:	 3,
-	orig_video_lines:	25,
-	orig_video_isVGA:	 1,
-	orig_video_points:	16
+	.orig_x			= 0,
+	.orig_y			= 0,
+	.orig_video_mode	= 3,
+	.orig_video_cols	= 80,
+	.orig_video_ega_bx	= 3,
+	.orig_video_lines	= 25,
+	.orig_video_isVGA	= 1,
+	.orig_video_points	= 16
 };
 
 /*
