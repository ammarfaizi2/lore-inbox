Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVAWKTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVAWKTR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 05:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVAWKSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 05:18:01 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62471 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261285AbVAWKRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 05:17:01 -0500
Date: Sun, 23 Jan 2005 11:17:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/rd.c: make two variables static
Message-ID: <20050123101700.GI3212@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global variables static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/block/rd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

This patch was already sent on:
- 29 Nov 2004

--- linux-2.6.10-rc1-mm3-full/drivers/block/rd.c.old	2004-11-06 20:18:40.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/rd.c	2004-11-06 20:19:25.000000000 +0100
@@ -77,7 +77,7 @@
  * architecture-specific setup routine (from the stored boot sector
  * information).
  */
-int rd_size = CONFIG_BLK_DEV_RAM_SIZE;		/* Size of the RAM disks */
+static int rd_size = CONFIG_BLK_DEV_RAM_SIZE;	/* Size of the RAM disks */
 /*
  * It would be very desirable to have a soft-blocksize (that in the case
  * of the ramdisk driver is also the hardblocksize ;) of PAGE_SIZE because
@@ -89,7 +89,7 @@
  * behaviour. The default is still BLOCK_SIZE (needed by rd_load_image that
  * supposes the filesystem in the image uses a BLOCK_SIZE blocksize).
  */
-int rd_blocksize = BLOCK_SIZE;			/* blocksize of the RAM disks */
+static int rd_blocksize = BLOCK_SIZE;		/* blocksize of the RAM disks */
 
 /*
  * Copyright (C) 2000 Linus Torvalds.

