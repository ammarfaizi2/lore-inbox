Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbUKODES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbUKODES (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 22:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbUKODBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 22:01:49 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:49162 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261488AbUKOCrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:47:21 -0500
Date: Mon, 15 Nov 2004 03:35:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI sym53c416.c: make a function static
Message-ID: <20041115023543.GC2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/sym53c416.c.old	2004-11-14 01:30:23.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/sym53c416.c	2004-11-14 01:30:32.000000000 +0100
@@ -616,7 +616,7 @@
 
 MODULE_DEVICE_TABLE(isapnp, id_table);
 
-void sym53c416_probe(void)
+static void sym53c416_probe(void)
 {
 	int *base = probeaddrs;
 	int ints[2];

