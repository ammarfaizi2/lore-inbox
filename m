Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbUKOCGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbUKOCGS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 21:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbUKOCEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:04:40 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3083 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261404AbUKOCEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:04:22 -0500
Date: Mon, 15 Nov 2004 02:51:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI: aha1542.c: make some code static
Message-ID: <20041115015117.GD2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly gloal code static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/aha1542.c.old	2004-11-13 16:58:35.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/aha1542.c	2004-11-13 16:59:41.000000000 +0100
@@ -129,8 +129,8 @@
  */
 
 #if defined(MODULE)
-int isapnp = 0;
-int aha1542[] = {0x330, 11, 4, -1};
+static int isapnp = 0;
+static int aha1542[] = {0x330, 11, 4, -1};
 MODULE_PARM(aha1542, "1-4i");
 MODULE_PARM(isapnp, "i");
 
@@ -951,7 +951,7 @@
 static char *setup_str[MAXBOARDS] __initdata;
 static int setup_idx = 0;
 
-void __init aha1542_setup(char *str, int *ints)
+static void __init aha1542_setup(char *str, int *ints)
 {
 	const char *ahausage = "aha1542: usage: aha1542=<PORTBASE>[,<BUSON>,<BUSOFF>[,<DMASPEED>]]\n";
 	int setup_portbase;

