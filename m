Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbUKOCbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbUKOCbz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 21:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbUKOC3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:29:43 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42500 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261456AbUKOC3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:29:02 -0500
Date: Mon, 15 Nov 2004 03:16:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI ncr53c8xx.c: make a variable static
Message-ID: <20041115021612.GR2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global variable static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/ncr53c8xx.c.old	2004-11-13 22:27:21.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/ncr53c8xx.c	2004-11-13 22:28:07.000000000 +0100
@@ -7738,7 +7738,7 @@
 **==========================================================
 */
 #ifdef	MODULE
-char *ncr53c8xx;	/* command line passed by insmod */
+static char *ncr53c8xx;		/* command line passed by insmod */
 module_param(ncr53c8xx, charp, 0);
 #endif
 

