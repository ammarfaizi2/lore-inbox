Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVCYB0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVCYB0i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 20:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVCYBZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 20:25:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29457 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261359AbVCYBK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 20:10:58 -0500
Date: Fri, 25 Mar 2005 02:10:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Guenter Geiger <geiger@debian.org>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/oss/rme96xx.c: remove kernel 2.2 #if's
Message-ID: <20050325011056.GR3966@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes #if's for kernel 2.2 .

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 12 Mar 2005

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

