Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVEBCLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVEBCLT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 22:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVEBByZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 21:54:25 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40464 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261671AbVEBBrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:47:14 -0400
Date: Mon, 2 May 2005 03:47:13 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/cdrom/cdu31a.c: make some code static
Message-ID: <20050502014713.GB3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 10 Apr 2005

 drivers/cdrom/cdu31a.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.12-rc2-mm2-full/drivers/cdrom/cdu31a.c.old	2005-04-10 02:01:50.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/drivers/cdrom/cdu31a.c	2005-04-10 02:02:38.000000000 +0200
@@ -292,7 +292,7 @@
 
 /* The interrupt handler will wake this queue up when it gets an
    interrupts. */
-DECLARE_WAIT_QUEUE_HEAD(cdu31a_irq_wait);
+static DECLARE_WAIT_QUEUE_HEAD(cdu31a_irq_wait);
 static int irq_flag = 0;
 
 static int curr_control_reg = 0;	/* Current value of the control register */
@@ -2947,7 +2947,7 @@
 	return cdrom_media_changed(&scd_info);
 }
 
-struct block_device_operations scd_bdops =
+static struct block_device_operations scd_bdops =
 {
 	.owner		= THIS_MODULE,
 	.open		= scd_block_open,
@@ -3216,7 +3216,7 @@
 }
 
 
-void __exit cdu31a_exit(void)
+static void __exit cdu31a_exit(void)
 {
 	del_gendisk(scd_gendisk);
 	put_disk(scd_gendisk);

