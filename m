Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbUKNA2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbUKNA2O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 19:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbUKNA2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 19:28:14 -0500
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:43171
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261217AbUKNA2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 19:28:09 -0500
Message-ID: <4196A691.8060403@ppp0.net>
Date: Sun, 14 Nov 2004 01:28:01 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
CC: kraxel@bytesex.org
Subject: [PATCH] media/video module_param conversion
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert module_param in tda7432 and tda9875. I hope I got the
file permissions right.

Signed-off-by: Jan Dittmer <jdittmer@ppp0.net>

diff -Nru a/drivers/media/video/tda7432.c b/drivers/media/video/tda7432.c
--- a/drivers/media/video/tda7432.c	2004-11-14 01:24:43 +01:00
+++ b/drivers/media/video/tda7432.c	2004-11-14 01:24:43 +01:00
@@ -60,13 +60,13 @@
 MODULE_DESCRIPTION("bttv driver for the tda7432 audio processor chip");
 MODULE_LICENSE("GPL");

-MODULE_PARM(debug,"i");
-MODULE_PARM(loudness,"i");
+static int maxvol;
+static int loudness; /* disable loudness by default */
+static int debug;	 /* insmod parameter */
+module_param(debug, int, S_IRUGO | S_IWUSR);
+module_param(loudness, int, S_IRUGO);
 MODULE_PARM_DESC(maxvol,"Set maximium volume to +20db (0), default is 0db(1)");
-MODULE_PARM(maxvol,"i");
-static int maxvol = 0;
-static int loudness = 0; /* disable loudness by default */
-static int debug = 0;	 /* insmod parameter */
+module_param(maxvol, int, S_IRUGO | S_IWUSR);


 /* Address to scan (I2C address of this chip) */
diff -Nru a/drivers/media/video/tda9875.c b/drivers/media/video/tda9875.c
--- a/drivers/media/video/tda9875.c	2004-11-14 01:24:43 +01:00
+++ b/drivers/media/video/tda9875.c	2004-11-14 01:24:43 +01:00
@@ -34,10 +34,10 @@
 #include <media/audiochip.h>
 #include <media/id.h>

-MODULE_PARM(debug,"i");
+static int debug; /* insmod parameter */
+module_param(debug, int, S_IRUGO | S_IWUSR);
 MODULE_LICENSE("GPL");

-static int debug = 0;	/* insmod parameter */

 /* Addresses to scan */
 static unsigned short normal_i2c[] =  {
