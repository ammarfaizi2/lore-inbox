Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965173AbVLRPps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965173AbVLRPps (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 10:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbVLRPp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 10:45:27 -0500
Received: from smtp4.brturbo.com.br ([200.199.201.180]:40887 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S965173AbVLRPpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 10:45:23 -0500
Subject: [PATCH 4/5] - Fix compilation failure with gcc 2.95.3.
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: linux-kernel@vger.kernel.org
Cc: js@linuxtv.org, linux-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com
Date: Sun, 18 Dec 2005 13:23:45 -0200
Message-Id: <1134920704.6702.28.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Fix compilation failure with gcc 2.95.3.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

---

 drivers/media/video/em28xx/em28xx-core.c   |    6 +++---
 drivers/media/video/em28xx/em28xx-i2c.c    |    2 +-
 drivers/media/video/em28xx/em28xx-video.c  |    2 +-
 drivers/media/video/em28xx/em28xx.h        |    8 ++++----
 drivers/media/video/saa7134/saa7134-alsa.c |    2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

ae88ad6fa26db7b7bfe52255325985994fcbee02
diff --git a/drivers/media/video/em28xx/em28xx-core.c b/drivers/media/video/em28xx/em28xx-core.c
index ec11619..0cfe754 100644
--- a/drivers/media/video/em28xx/em28xx-core.c
+++ b/drivers/media/video/em28xx/em28xx-core.c
@@ -39,7 +39,7 @@ MODULE_PARM_DESC(core_debug,"enable debu
 #define em28xx_coredbg(fmt, arg...) do {\
 	if (core_debug) \
 		printk(KERN_INFO "%s %s :"fmt, \
-			 dev->name, __FUNCTION__, ##arg); } while (0)
+			 dev->name, __FUNCTION__ , ##arg); } while (0)
 
 static unsigned int reg_debug;
 module_param(reg_debug,int,0644);
@@ -48,7 +48,7 @@ MODULE_PARM_DESC(reg_debug,"enable debug
 #define em28xx_regdbg(fmt, arg...) do {\
 	if (reg_debug) \
 		printk(KERN_INFO "%s %s :"fmt, \
-			 dev->name, __FUNCTION__, ##arg); } while (0)
+			 dev->name, __FUNCTION__ , ##arg); } while (0)
 
 static unsigned int isoc_debug;
 module_param(isoc_debug,int,0644);
@@ -57,7 +57,7 @@ MODULE_PARM_DESC(isoc_debug,"enable debu
 #define em28xx_isocdbg(fmt, arg...) do {\
 	if (isoc_debug) \
 		printk(KERN_INFO "%s %s :"fmt, \
-			 dev->name, __FUNCTION__, ##arg); } while (0)
+			 dev->name, __FUNCTION__ , ##arg); } while (0)
 
 static int alt = EM28XX_PINOUT;
 module_param(alt, int, 0644);
diff --git a/drivers/media/video/em28xx/em28xx-i2c.c b/drivers/media/video/em28xx/em28xx-i2c.c
index 29e21ad..7f56030 100644
--- a/drivers/media/video/em28xx/em28xx-i2c.c
+++ b/drivers/media/video/em28xx/em28xx-i2c.c
@@ -44,7 +44,7 @@ MODULE_PARM_DESC(i2c_debug, "enable debu
 			printk(fmt, ##args); } while (0)
 #define dprintk2(lvl,fmt, args...) if (i2c_debug>=lvl) do{ \
 			printk(KERN_DEBUG "%s at %s: " fmt, \
-			dev->name, __FUNCTION__, ##args); } while (0)
+			dev->name, __FUNCTION__ , ##args); } while (0)
 
 /*
  * em2800_i2c_send_max4()
diff --git a/drivers/media/video/em28xx/em28xx-video.c b/drivers/media/video/em28xx/em28xx-video.c
index 8ecaa08..06d7687 100644
--- a/drivers/media/video/em28xx/em28xx-video.c
+++ b/drivers/media/video/em28xx/em28xx-video.c
@@ -45,7 +45,7 @@
 #define em28xx_videodbg(fmt, arg...) do {\
 	if (video_debug) \
 		printk(KERN_INFO "%s %s :"fmt, \
-			 dev->name, __FUNCTION__, ##arg); } while (0)
+			 dev->name, __FUNCTION__ , ##arg); } while (0)
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
diff --git a/drivers/media/video/em28xx/em28xx.h b/drivers/media/video/em28xx/em28xx.h
index 1e2ee43..5c7a41c 100644
--- a/drivers/media/video/em28xx/em28xx.h
+++ b/drivers/media/video/em28xx/em28xx.h
@@ -392,18 +392,18 @@ extern const unsigned int em28xx_bcount;
 /* printk macros */
 
 #define em28xx_err(fmt, arg...) do {\
-	printk(KERN_ERR fmt, ##arg); } while (0)
+	printk(KERN_ERR fmt , ##arg); } while (0)
 
 #define em28xx_errdev(fmt, arg...) do {\
 	printk(KERN_ERR "%s: "fmt,\
-			dev->name, ##arg); } while (0)
+			dev->name , ##arg); } while (0)
 
 #define em28xx_info(fmt, arg...) do {\
 	printk(KERN_INFO "%s: "fmt,\
-			dev->name, ##arg); } while (0)
+			dev->name , ##arg); } while (0)
 #define em28xx_warn(fmt, arg...) do {\
 	printk(KERN_WARNING "%s: "fmt,\
-			dev->name, ##arg); } while (0)
+			dev->name , ##arg); } while (0)
 
 inline static int em28xx_audio_source(struct em28xx *dev, int input)
 {
diff --git a/drivers/media/video/saa7134/saa7134-alsa.c b/drivers/media/video/saa7134/saa7134-alsa.c
index b24a26b..953d5fe 100644
--- a/drivers/media/video/saa7134/saa7134-alsa.c
+++ b/drivers/media/video/saa7134/saa7134-alsa.c
@@ -60,7 +60,7 @@ module_param_array(index, int, NULL, 044
 MODULE_PARM_DESC(index, "Index value for SAA7134 capture interface(s).");
 
 #define dprintk(fmt, arg...)    if (debug) \
-	printk(KERN_DEBUG "%s/alsa: " fmt, dev->name, ## arg)
+	printk(KERN_DEBUG "%s/alsa: " fmt, dev->name , ##arg)
 
 
 
-- 
0.99.9.GIT

