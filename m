Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbUKUPn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbUKUPn6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 10:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbUKUPnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 10:43:16 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56840 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261702AbUKUPgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 10:36:42 -0500
Date: Sun, 21 Nov 2004 16:36:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Hannu Mallat <hmallat@cc.hut.fi>
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: [2.6 patch] tdfxfb.c: make some code static
Message-ID: <20041121153639.GY2829@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlesly global code static.


diffstat output:
 drivers/video/tdfxfb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/drivers/video/tdfxfb.c.old	2004-11-21 15:00:22.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/tdfxfb.c	2004-11-21 15:00:55.000000000 +0100
@@ -154,8 +154,8 @@
 /*
  *  Frame buffer device API
  */
-int tdfxfb_init(void);
-void tdfxfb_setup(char *options);
+static int tdfxfb_init(void);
+static void tdfxfb_setup(char *options);
 
 static int tdfxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *fb); 
 static int tdfxfb_set_par(struct fb_info *info); 
@@ -1356,7 +1356,7 @@
 	framebuffer_release(info);
 }
 
-int __init tdfxfb_init(void)
+static int __init tdfxfb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
@@ -1383,7 +1383,7 @@
 
 
 #ifndef MODULE
-void tdfxfb_setup(char *options)
+static void tdfxfb_setup(char *options)
 { 
 	char* this_opt;
 

