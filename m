Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVCLQEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVCLQEP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 11:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVCLQBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 11:01:53 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35855 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261950AbVCLP7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 10:59:47 -0500
Date: Sat, 12 Mar 2005 16:59:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Guenter Geiger <geiger@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/oss/rme96xx.c: remove kernel 2.2 #if's
Message-ID: <20050312155940.GD3814@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes #if's for kernel 2.2 .

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-mm2-full/sound/oss/rme96xx.c.old	2005-03-12 12:24:43.000000000 +0100
+++ linux-2.6.11-mm2-full/sound/oss/rme96xx.c	2005-03-12 12:25:02.000000000 +0100
@@ -1750,9 +1750,7 @@
 
 
 static struct file_operations rme96xx_audio_fops = {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	.owner	 = THIS_MODULE,
-#endif
 	.read	 = rme96xx_read,
 	.write	 = rme96xx_write,
 	.poll	 = rme96xx_poll,
@@ -1852,9 +1850,7 @@
 }
 
 static /*const*/ struct file_operations rme96xx_mixer_fops = {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	.owner	 = THIS_MODULE,
-#endif
 	.ioctl	 = rme96xx_mixer_ioctl,
 	.open	 = rme96xx_mixer_open,
 	.release = rme96xx_mixer_release,

