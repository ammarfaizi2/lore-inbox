Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVAaMm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVAaMm3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 07:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVAaMm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 07:42:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45063 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261177AbVAaMmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 07:42:25 -0500
Date: Mon, 31 Jan 2005 13:42:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Robert Love <rml@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] inotify.c: make code static
Message-ID: <20050131124223.GF18316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc2-mm2-full/drivers/char/inotify.c.old	2005-01-31 13:14:31.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/inotify.c	2005-01-31 13:15:59.000000000 +0100
@@ -201,8 +201,8 @@
 	return error;
 }
 
-struct inotify_kernel_event * kernel_event(s32 wd, u32 mask, u32 cookie,
-					   const char *filename)
+static struct inotify_kernel_event * kernel_event(s32 wd, u32 mask, u32 cookie,
+						  const char *filename)
 {
 	struct inotify_kernel_event *kevent;
 
@@ -1032,7 +1032,7 @@
 	.ioctl		= inotify_ioctl,
 };
 
-struct miscdevice inotify_device = {
+static struct miscdevice inotify_device = {
 	.minor  = MISC_DYNAMIC_MINOR,
 	.name	= "inotify",
 	.fops	= &inotify_fops,

