Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbULHB1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbULHB1J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 20:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbULHBSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 20:18:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21010 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261985AbULHBOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 20:14:55 -0500
Date: Wed, 8 Dec 2004 02:14:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] scsi/aic7xxx/ : remove two useless variables
Message-ID: <20041208011450.GK5496@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes two useless variables.


diffstat output:
 drivers/scsi/aic7xxx/aic79xx_osm.c |   12 ------------
 drivers/scsi/aic7xxx/aic7xxx_osm.c |   12 ------------
 2 files changed, 24 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/drivers/scsi/aic7xxx/aic7xxx_osm.c.old	2004-12-08 01:06:02.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-12-08 01:06:15.000000000 +0100
@@ -427,12 +427,6 @@
  * Module information and settable options.
  */
 static char *aic7xxx = NULL;
-/*
- * Just in case someone uses commas to separate items on the insmod
- * command line, we define a dummy buffer here to avoid having insmod
- * write wild stuff into our code segment
- */
-static char dummy_buffer[60] = "Please don't trounce on me insmod!!\n";
 
 MODULE_AUTHOR("Maintainer: Justin T. Gibbs <gibbs@scsiguy.com>");
 MODULE_DESCRIPTION("Adaptec Aic77XX/78XX SCSI Host Bus Adapter driver");
@@ -850,12 +844,6 @@
 	 */
 	if (aic7xxx)
 		aic7xxx_setup(aic7xxx);
-	if (dummy_buffer[0] != 'P')
-		printk(KERN_WARNING
-"aic7xxx: Please read the file /usr/src/linux/drivers/scsi/README.aic7xxx\n"
-"aic7xxx: to see the proper way to specify options to the aic7xxx module\n"
-"aic7xxx: Specifically, don't use any commas when passing arguments to\n"
-"aic7xxx: insmod or else it might trash certain memory areas.\n");
 
 	template->proc_name = "aic7xxx";
 
--- linux-2.6.10-rc2-mm4-full/drivers/scsi/aic7xxx/aic79xx_osm.c.old	2004-12-08 01:06:25.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-12-08 01:06:42.000000000 +0100
@@ -407,12 +407,6 @@
  * Module information and settable options.
  */
 static char *aic79xx = NULL;
-/*
- * Just in case someone uses commas to separate items on the insmod
- * command line, we define a dummy buffer here to avoid having insmod
- * write wild stuff into our code segment
- */
-static char dummy_buffer[60] = "Please don't trounce on me insmod!!\n";
 
 MODULE_AUTHOR("Maintainer: Justin T. Gibbs <gibbs@scsiguy.com>");
 MODULE_DESCRIPTION("Adaptec Aic790X U320 SCSI Host Bus Adapter driver");
@@ -835,12 +829,6 @@
 	 */
 	if (aic79xx)
 		aic79xx_setup(aic79xx);
-	if (dummy_buffer[0] != 'P')
-		printk(KERN_WARNING
-"aic79xx: Please read the file /usr/src/linux/drivers/scsi/README.aic79xx\n"
-"aic79xx: to see the proper way to specify options to the aic79xx module\n"
-"aic79xx: Specifically, don't use any commas when passing arguments to\n"
-"aic79xx: insmod or else it might trash certain memory areas.\n");
 #endif
 
 	template->proc_name = "aic79xx";

