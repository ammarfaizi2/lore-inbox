Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbUKOCtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbUKOCtp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 21:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbUKOCsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:48:25 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43529 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261487AbUKOCnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:43:50 -0500
Date: Mon, 15 Nov 2004 03:33:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI sim710.c: make some code static
Message-ID: <20041115023319.GA2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/sim710.c.old	2004-11-14 01:27:51.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/sim710.c	2004-11-14 01:28:48.000000000 +0100
@@ -47,7 +47,7 @@
 #define MAX_SLOTS 8
 static __u8 __initdata id_array[MAX_SLOTS] = { [0 ... MAX_SLOTS-1] = 7 };
 
-char *sim710;		/* command line passed by insmod */
+static char *sim710;		/* command line passed by insmod */
 
 MODULE_AUTHOR("Richard Hirst");
 MODULE_DESCRIPTION("Simple NCR53C710 driver");
@@ -61,7 +61,7 @@
 #define ARG_SEP ','
 #endif
 
-__init int
+static __init int
 param_setup(char *str)
 {
 	char *pos = str, *next;
@@ -314,7 +314,7 @@
 				   differential, scsi_id);
 }
 
-struct eisa_driver sim710_eisa_driver = {
+static struct eisa_driver sim710_eisa_driver = {
 	.id_table		= sim710_eisa_ids,
 	.driver = {
 		.name		= "sim710",

