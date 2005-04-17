Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVDQXZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVDQXZr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 19:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVDQXZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 19:25:46 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45829 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261551AbVDQXZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 19:25:31 -0400
Date: Mon, 18 Apr 2005 01:25:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: adaplas@pol.net, James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/video/fbsysfs.c: make a struct static
Message-ID: <20050417232528.GV3625@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

