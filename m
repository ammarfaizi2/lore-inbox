Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbUKSREq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUKSREq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 12:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbUKSREq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 12:04:46 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:29159 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261497AbUKSREL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 12:04:11 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 19 Nov 2004 17:57:05 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: more modparam
Message-ID: <20041119165705.GA2852@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

convert more modules to new-style insmod options.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/tvaudio.c |   28 ++++++++++++++--------------
 drivers/media/video/tvmixer.c |    2 +-
 2 files changed, 15 insertions(+), 15 deletions(-)

diff -u linux-2.6.10/drivers/media/video/tvaudio.c linux/drivers/media/video/tvaudio.c
--- linux-2.6.10/drivers/media/video/tvaudio.c	2004-11-17 18:39:47.000000000 +0100
+++ linux/drivers/media/video/tvaudio.c	2004-11-19 14:51:57.876833350 +0100
@@ -37,8 +37,8 @@
 /* ---------------------------------------------------------------------- */
 /* insmod args                                                            */
 
-MODULE_PARM(debug,"i");
 static int debug = 0;	/* insmod parameter */
+module_param(debug, int, 0644);
 
 MODULE_DESCRIPTION("device driver for various i2c TV sound decoder / audiomux chips");
 MODULE_AUTHOR("Eric Sandeen, Steve VanDeBogart, Greg Alexander, Gerd Knorr");
@@ -764,9 +764,9 @@
 static unsigned int tda9874a_SIF   = UNSET;
 static unsigned int tda9874a_AMSEL = UNSET;
 static unsigned int tda9874a_STD   = UNSET;
-MODULE_PARM(tda9874a_SIF,"i");
-MODULE_PARM(tda9874a_AMSEL,"i");
-MODULE_PARM(tda9874a_STD,"i");
+module_param(tda9874a_SIF, int, 0444);
+module_param(tda9874a_AMSEL, int, 0444);
+module_param(tda9874a_STD, int, 0444);
 
 /*
  * initialization table for tda9874 decoder:
@@ -1218,16 +1218,16 @@
 int pic16c54 = 1;
 int ta8874z  = 0;  // address clash with tda9840
 
-MODULE_PARM(tda8425,"i");
-MODULE_PARM(tda9840,"i");
-MODULE_PARM(tda9850,"i");
-MODULE_PARM(tda9855,"i");
-MODULE_PARM(tda9873,"i");
-MODULE_PARM(tda9874a,"i");
-MODULE_PARM(tea6300,"i");
-MODULE_PARM(tea6420,"i");
-MODULE_PARM(pic16c54,"i");
-MODULE_PARM(ta8874z,"i");
+module_param(tda8425, int, 0444);
+module_param(tda9840, int, 0444);
+module_param(tda9850, int, 0444);
+module_param(tda9855, int, 0444);
+module_param(tda9873, int, 0444);
+module_param(tda9874a, int, 0444);
+module_param(tea6300, int, 0444);
+module_param(tea6420, int, 0444);
+module_param(pic16c54, int, 0444);
+module_param(ta8874z, int, 0444);
 
 static struct CHIPDESC chiplist[] = {
 	{
diff -u linux-2.6.10/drivers/media/video/tvmixer.c linux/drivers/media/video/tvmixer.c
--- linux-2.6.10/drivers/media/video/tvmixer.c	2004-11-17 18:41:41.000000000 +0100
+++ linux/drivers/media/video/tvmixer.c	2004-11-19 14:51:57.893830174 +0100
@@ -20,7 +20,7 @@
 #define DEV_MAX  4
 
 static int devnr = -1;
-MODULE_PARM(devnr,"i");
+module_param(devnr, int, 0644);
 
 MODULE_AUTHOR("Gerd Knorr");
 MODULE_LICENSE("GPL");

-- 
#define printk(args...) fprintf(stderr, ## args)
