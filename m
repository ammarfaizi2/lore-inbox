Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVDWVYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVDWVYO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 17:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVDWVYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 17:24:14 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9487 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261806AbVDWVYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 17:24:07 -0400
Date: Sat, 23 Apr 2005 23:24:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Gerd Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: [-mm patch] drivers/scsi/ch.c: make a struct static
Message-ID: <20050423212404.GD4355@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 28 Feb 2005

--- linux-2.6.11-rc4-mm1-full/drivers/scsi/ch.c.old	2005-02-28 18:14:48.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/ch.c	2005-02-28 18:14:55.000000000 +0100
@@ -118,7 +118,7 @@
 static spinlock_t ch_devlist_lock = SPIN_LOCK_UNLOCKED;
 static int ch_devcount;
 
-struct scsi_driver ch_template =
+static struct scsi_driver ch_template =
 {
 	.owner     	= THIS_MODULE,
 	.gendrv     	= {


