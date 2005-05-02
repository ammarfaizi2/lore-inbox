Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVEBByL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVEBByL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 21:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVEBBwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 21:52:53 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42256 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261694AbVEBBrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:47:21 -0400
Date: Mon, 2 May 2005 03:47:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/rd.c: make a variable static
Message-ID: <20050502014719.GE3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global variable static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 10 Apr 2005

--- linux-2.6.12-rc2-mm2-full/drivers/block/rd.c.old	2005-04-10 02:00:08.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/drivers/block/rd.c	2005-04-10 02:01:00.000000000 +0200
@@ -74,7 +74,7 @@
  * architecture-specific setup routine (from the stored boot sector
  * information).
  */
-int rd_size = CONFIG_BLK_DEV_RAM_SIZE;		/* Size of the RAM disks */
+static int rd_size = CONFIG_BLK_DEV_RAM_SIZE;	/* Size of the RAM disks */
 /*
  * It would be very desirable to have a soft-blocksize (that in the case
  * of the ramdisk driver is also the hardblocksize ;) of PAGE_SIZE because

