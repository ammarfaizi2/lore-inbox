Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbUKHJAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbUKHJAT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 04:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbUKHJAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 04:00:18 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:17118 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261788AbUKHJAL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 04:00:11 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 8 Nov 2004 09:53:44 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: ir-common modparam
Message-ID: <20041108085344.GA19307@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ir-common module to new-style insmod options.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/common/ir-common.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -u linux-2.6.10/drivers/media/common/ir-common.c linux/drivers/media/common/ir-common.c
--- linux-2.6.10/drivers/media/common/ir-common.c	2004-11-07 12:23:30.784211678 +0100
+++ linux/drivers/media/common/ir-common.c	2004-11-07 16:07:15.079364384 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: ir-common.c,v 1.4 2004/10/13 10:39:00 kraxel Exp $
+ * $Id: ir-common.c,v 1.5 2004/11/07 13:17:15 kraxel Exp $
  *
  * some common structs and functions to handle infrared remotes via
  * input layer ...
@@ -31,11 +31,11 @@
 MODULE_LICENSE("GPL");
 
 static int repeat = 1;
-MODULE_PARM(repeat,"i");
+module_param(repeat, int, 0444);
 MODULE_PARM_DESC(repeat,"auto-repeat for IR keys (default: on)");
 
 static int debug = 0;    /* debug level (0,1,2) */
-MODULE_PARM(debug,"i");
+module_param(debug, int, 0644);
 
 #define dprintk(level, fmt, arg...)	if (debug >= level) \
 	printk(KERN_DEBUG fmt , ## arg)

-- 
#define printk(args...) fprintf(stderr, ## args)
