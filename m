Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbUKUQNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbUKUQNx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 11:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbUKUPm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 10:42:57 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53256 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261675AbUKUPgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 10:36:37 -0500
Date: Sun, 21 Nov 2004 16:36:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jim.hague@acm.org
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: [2.6 patch] pm2fb.c: make some code static
Message-ID: <20041121153632.GW2829@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


diffstat output:
 drivers/video/pm2fb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/drivers/video/pm2fb.c.old	2004-11-21 14:56:25.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/pm2fb.c	2004-11-21 14:56:49.000000000 +0100
@@ -1215,9 +1215,9 @@
  *  Initialization
  */
 
-int __init pm2fb_setup(char *options);
+static int __init pm2fb_setup(char *options);
 
-int __init pm2fb_init(void)
+static int __init pm2fb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
@@ -1248,7 +1248,7 @@
  *
  * This is, comma-separated options following `video=pm2fb:'.
  */
-int __init pm2fb_setup(char *options)
+static int __init pm2fb_setup(char *options)
 {
 	char* this_opt;
 

