Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVB0Azz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVB0Azz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 19:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVB0Azs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 19:55:48 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6406 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261325AbVB0Azk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 19:55:40 -0500
Date: Sun, 27 Feb 2005 01:55:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI NCR_D700.c: make some code static
Message-ID: <20050227005536.GU3311@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc4-mm1-full/drivers/scsi/NCR_D700.c.old	2005-02-27 01:03:50.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/NCR_D700.c	2005-02-27 01:04:25.000000000 +0100
@@ -106,7 +106,7 @@
 #include "53c700.h"
 #include "NCR_D700.h"
 
-char *NCR_D700;			/* command line from insmod */
+static char *NCR_D700;		/* command line from insmod */
 
 MODULE_AUTHOR("James Bottomley");
 MODULE_DESCRIPTION("NCR Dual700 SCSI Driver");
@@ -352,7 +352,7 @@
 
 static short NCR_D700_id_table[] = { NCR_D700_MCA_ID, 0 };
 
-struct mca_driver NCR_D700_driver = {
+static struct mca_driver NCR_D700_driver = {
 	.id_table = NCR_D700_id_table,
 	.driver = {
 		.name		= "NCR_D700",

