Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbUKOCrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbUKOCrj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 21:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbUKOCra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:47:30 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17930 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261494AbUKOCps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:45:48 -0500
Date: Mon, 15 Nov 2004 03:34:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI sr.c: make a struct static
Message-ID: <20041115023430.GB2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global struct static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/sr.c.old	2004-11-14 01:29:29.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/sr.c	2004-11-14 01:29:39.000000000 +0100
@@ -512,7 +512,7 @@
 	return cdrom_media_changed(&cd->cdi);
 }
 
-struct block_device_operations sr_bdops =
+static struct block_device_operations sr_bdops =
 {
 	.owner		= THIS_MODULE,
 	.open		= sr_block_open,

