Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbUKHJAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbUKHJAg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 04:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbUKHJAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 04:00:36 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:17374 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261789AbUKHJAL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 04:00:11 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 8 Nov 2004 09:53:32 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: tuner modparam
Message-ID: <20041108085332.GA19292@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert leftover insmod options to new-style.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/tda9887.c |   18 +++++++++---------
 drivers/media/video/tuner.c   |    6 +++---
 2 files changed, 12 insertions(+), 12 deletions(-)

diff -u linux-2.6.10/drivers/media/video/tuner.c linux/drivers/media/video/tuner.c
--- linux-2.6.10/drivers/media/video/tuner.c	2004-11-07 12:24:52.000000000 +0100
+++ linux/drivers/media/video/tuner.c	2004-11-07 16:07:15.403303277 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: tuner.c,v 1.27 2004/10/20 09:43:34 kraxel Exp $
+ * $Id: tuner.c,v 1.29 2004/11/07 13:17:15 kraxel Exp $
  */
 
 #include <linux/module.h>
@@ -1102,8 +1102,8 @@
 	}
 }
 
-static char *pal = "-";
-MODULE_PARM(pal,"s");
+static char pal[] = "-";
+module_param_string(pal, pal, 0644, sizeof(pal));
 
 static int tuner_fixup_std(struct tuner *t)
 {
diff -u linux-2.6.10/drivers/media/video/tda9887.c linux/drivers/media/video/tda9887.c
--- linux-2.6.10/drivers/media/video/tda9887.c	2004-11-07 12:24:40.000000000 +0100
+++ linux/drivers/media/video/tda9887.c	2004-11-07 16:07:15.415301014 +0100
@@ -36,7 +36,7 @@
 
 /* insmod options */
 static unsigned int debug = 0;
-MODULE_PARM(debug,"i");
+module_param(debug, int, 0644);
 MODULE_LICENSE("GPL");
 
 /* ---------------------------------------------------------------------- */
@@ -377,10 +377,10 @@
 static unsigned int port2  = 1;
 static unsigned int qss    = UNSET;
 static unsigned int adjust = 0x10;
-MODULE_PARM(port1,"i");
-MODULE_PARM(port2,"i");
-MODULE_PARM(qss,"i");
-MODULE_PARM(adjust,"i");
+module_param(port1, int, 0644);
+module_param(port2, int, 0644);
+module_param(qss, int, 0644);
+module_param(adjust, int, 0644);
 
 static int tda9887_set_insmod(struct tda9887 *t, char *buf)
 {
@@ -460,10 +460,10 @@
 
 /* ---------------------------------------------------------------------- */
 
-static char *pal = "-";
-MODULE_PARM(pal,"s");
-static char *secam = "-";
-MODULE_PARM(secam,"s");
+static char pal[] = "-";
+module_param_string(pal, pal, 0644, sizeof(pal));
+static char secam[] = "-";
+module_param_string(secam, secam, 0644, sizeof(secam));
 
 static int tda9887_fixup_std(struct tda9887 *t)
 {

-- 
#define printk(args...) fprintf(stderr, ## args)
