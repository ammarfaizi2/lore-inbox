Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVAWKW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVAWKW3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 05:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVAWKUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 05:20:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53767 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261271AbVAWKQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 05:16:17 -0500
Date: Sun, 23 Jan 2005 11:16:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Antonino Daplas <adaplas@pol.net>,
       linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: [2.6 patch] matroxfb_base.c: make some code static
Message-ID: <20050123101616.GD3212@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/video/matrox/matroxfb_base.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

This patch was already sent on:
- 21 Nov 2004

--- linux-2.6.10-rc2-mm2-full/drivers/video/matrox/matroxfb_base.c.old	2004-11-21 14:40:28.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/matrox/matroxfb_base.c	2004-11-21 14:41:35.000000000 +0100
@@ -1908,8 +1908,8 @@
 	return err;
 }
 
-LIST_HEAD(matroxfb_list);
-LIST_HEAD(matroxfb_driver_list);
+static LIST_HEAD(matroxfb_list);
+static LIST_HEAD(matroxfb_driver_list);
 
 #define matroxfb_l(x) list_entry(x, struct matrox_fb_info, next_fb)
 #define matroxfb_driver_l(x) list_entry(x, struct matroxfb_driver, node)
@@ -2287,7 +2287,7 @@
 
 /* ************************* init in-kernel code ************************** */
 
-int __init matroxfb_setup(char *options) {
+static int __init matroxfb_setup(char *options) {
 	char *this_opt;
 
 	DBG(__FUNCTION__)
@@ -2428,7 +2428,7 @@
 
 static int __initdata initialized = 0;
 
-int __init matroxfb_init(void)
+static int __init matroxfb_init(void)
 {
 	char *option = NULL;
 

