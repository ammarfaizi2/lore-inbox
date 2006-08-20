Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751790AbWHTW7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbWHTW7T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 18:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWHTW7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 18:59:19 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:64015 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750783AbWHTW7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 18:59:15 -0400
Date: Mon, 21 Aug 2006 00:59:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/video/console/: make 3 functions static
Message-ID: <20060820225914.GU7813@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes three needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/video/console/fbcon_ccw.c |    2 +-
 drivers/video/console/fbcon_cw.c  |    2 +-
 drivers/video/console/fbcon_ud.c  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.18-rc4-mm2/drivers/video/console/fbcon_cw.c.old	2006-08-20 23:07:14.000000000 +0200
+++ linux-2.6.18-rc4-mm2/drivers/video/console/fbcon_cw.c	2006-08-20 23:07:31.000000000 +0200
@@ -375,7 +375,7 @@
 	ops->cursor_reset = 0;
 }
 
-int cw_update_start(struct fb_info *info)
+static int cw_update_start(struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 	u32 vxres = GETVXRES(ops->p->scrollmode, info);
--- linux-2.6.18-rc4-mm2/drivers/video/console/fbcon_ccw.c.old	2006-08-20 23:07:58.000000000 +0200
+++ linux-2.6.18-rc4-mm2/drivers/video/console/fbcon_ccw.c	2006-08-20 23:08:03.000000000 +0200
@@ -391,7 +391,7 @@
 	ops->cursor_reset = 0;
 }
 
-int ccw_update_start(struct fb_info *info)
+static int ccw_update_start(struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 	u32 yoffset;
--- linux-2.6.18-rc4-mm2/drivers/video/console/fbcon_ud.c.old	2006-08-20 23:08:31.000000000 +0200
+++ linux-2.6.18-rc4-mm2/drivers/video/console/fbcon_ud.c	2006-08-20 23:08:45.000000000 +0200
@@ -415,7 +415,7 @@
 	ops->cursor_reset = 0;
 }
 
-int ud_update_start(struct fb_info *info)
+static int ud_update_start(struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 	int xoffset, yoffset;

