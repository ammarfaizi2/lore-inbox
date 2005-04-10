Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVDJSSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVDJSSe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 14:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVDJSRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 14:17:44 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27921 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261550AbVDJSPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 14:15:20 -0400
Date: Sun, 10 Apr 2005 20:15:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/rd.c: make a variable static
Message-ID: <20050410181519.GG4204@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global variable static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

