Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVEAPuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVEAPuP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 11:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVEAPtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 11:49:06 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52232 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261679AbVEAPnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 11:43:10 -0400
Date: Sun, 1 May 2005 17:43:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: adaplas@pol.net, James Simmons <jsimmons@infradead.org>,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/video/fbsysfs.c: make a struct static
Message-ID: <20050501154308.GS3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 18 Apr 2005

--- linux-2.6.12-rc2-mm3-full/drivers/video/fbsysfs.c.old	2005-04-18 00:40:01.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/video/fbsysfs.c	2005-04-18 00:40:09.000000000 +0200
@@ -354,7 +354,7 @@
 			fb_info->var.xoffset);
 }
 
-struct class_device_attribute class_device_attrs[] = {
+static struct class_device_attribute class_device_attrs[] = {
 	__ATTR(bits_per_pixel, S_IRUGO|S_IWUSR, show_bpp, store_bpp),
 	__ATTR(blank, S_IRUGO|S_IWUSR, show_blank, store_blank),
 	__ATTR(color_map, S_IRUGO|S_IWUSR, show_cmap, store_cmap),

