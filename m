Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbUKOCef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbUKOCef (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 21:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbUKOCeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:34:23 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56325 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261456AbUKOCcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:32:39 -0500
Date: Mon, 15 Nov 2004 03:19:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI NCR_D700.c: make some code static
Message-ID: <20041115021924.GT2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/NCR_D700.c.old	2004-11-13 16:32:50.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/NCR_D700.c	2004-11-13 16:45:48.000000000 +0100
@@ -106,7 +106,9 @@
 #include "53c700.h"
 #include "NCR_D700.h"
 
-char *NCR_D700;			/* command line from insmod */
+#ifdef MODULE
+static char *NCR_D700;		/* command line from insmod */
+#endif
 
 MODULE_AUTHOR("James Bottomley");
 MODULE_DESCRIPTION("NCR Dual700 SCSI Driver");
@@ -352,7 +354,7 @@
 
 static short NCR_D700_id_table[] = { NCR_D700_MCA_ID, 0 };
 
-struct mca_driver NCR_D700_driver = {
+static struct mca_driver NCR_D700_driver = {
 	.id_table = NCR_D700_id_table,
 	.driver = {
 		.name		= "NCR_D700",

