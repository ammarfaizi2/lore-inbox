Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVB1SHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVB1SHz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 13:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVB1SHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 13:07:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26373 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261645AbVB1SHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 13:07:34 -0500
Date: Mon, 28 Feb 2005 19:07:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org
Subject: [-mm patch] drivers/scsi/ch.c: make a struct static
Message-ID: <20050228180733.GF4021@stusta.de>
References: <20050223014233.6710fd73.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050223014233.6710fd73.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

