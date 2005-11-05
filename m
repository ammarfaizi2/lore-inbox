Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbVKEXtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbVKEXtq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 18:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbVKEXtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 18:49:46 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:38429 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S932213AbVKEXtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 18:49:45 -0500
Date: Sun, 6 Nov 2005 00:49:39 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] Framebuffer mode required for PowerBook Titanium
Message-ID: <20051105234938.GA18608@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the framebuffer mode required for an Apple PowerBook G4
Titanium.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>

---
--- linux-2.6.14/drivers/video/modedb.c.orig	2005-11-05 22:29:02.000000000 +0100
+++ linux-2.6.14/drivers/video/modedb.c	2005-11-05 22:31:15.000000000 +0100
@@ -251,6 +251,10 @@ static const struct fb_videomode modedb[
 	NULL, 60, 1920, 1200, 5177, 128, 336, 1, 38, 208, 3,
 	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 	FB_VMODE_NONINTERLACED
+    }, {
+	/* 1152x768, 60 Hz, PowerBook G4 Titanium I and II */
+	"mac21", 60, 1152, 768, 15386, 158, 26, 29, 3, 136, 6,
+	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
     },
 };
