Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbUKMXYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbUKMXYz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 18:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUKMXYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 18:24:54 -0500
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:8350 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261199AbUKMXXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 18:23:50 -0500
Message-ID: <41969773.70006@ppp0.net>
Date: Sun, 14 Nov 2004 00:23:31 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
CC: kraxel@bytesex.org
Subject: [PATCH] tvaudio and tvmixer module_param conversion
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

module_param conversion for tvaudio and tvmixer

Signed-off-by: Jan Dittmer <jdittmer@ppp0.net>


diff -Nru a/drivers/media/video/tvaudio.c b/drivers/media/video/tvaudio.c
--- a/drivers/media/video/tvaudio.c	2004-11-14 00:20:58 +01:00
+++ b/drivers/media/video/tvaudio.c	2004-11-14 00:20:58 +01:00
@@ -37,8 +37,8 @@
 /* ---------------------------------------------------------------------- */
 /* insmod args                                                            */

-MODULE_PARM(debug,"i");
 static int debug = 0;	/* insmod parameter */
+module_param(debug, int, S_IRUGO | S_IWUSR);

 MODULE_DESCRIPTION("device driver for various i2c TV sound decoder / audiomux chips");
 MODULE_AUTHOR("Eric Sandeen, Steve VanDeBogart, Greg Alexander, Gerd Knorr");
@@ -764,9 +764,9 @@
 static unsigned int tda9874a_SIF   = UNSET;
 static unsigned int tda9874a_AMSEL = UNSET;
 static unsigned int tda9874a_STD   = UNSET;
-MODULE_PARM(tda9874a_SIF,"i");
-MODULE_PARM(tda9874a_AMSEL,"i");
-MODULE_PARM(tda9874a_STD,"i");
+module_param(tda9874a_SIF, int, 0);
+module_param(tda9874a_AMSEL, int, 0);
+module_param(tda9874a_STD, int, 0);

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
+module_param(tda8425, int, 0);
+module_param(tda9840, int, 0);
+module_param(tda9850, int, 0);
+module_param(tda9855, int, 0);
+module_param(tda9873, int, 0);
+module_param(tda9874a, int, 0);
+module_param(tea6300, int, 0);
+module_param(tea6420, int, 0);
+module_param(pic16c54, int, 0);
+module_param(ta8874z, int, 0);

 static struct CHIPDESC chiplist[] = {
 	{
diff -Nru a/drivers/media/video/tvmixer.c b/drivers/media/video/tvmixer.c
--- a/drivers/media/video/tvmixer.c	2004-11-14 00:20:58 +01:00
+++ b/drivers/media/video/tvmixer.c	2004-11-14 00:20:58 +01:00
@@ -20,7 +20,7 @@
 #define DEV_MAX  4

 static int devnr = -1;
-MODULE_PARM(devnr,"i");
+module_param(devnr, int, 0);

 MODULE_AUTHOR("Gerd Knorr");
 MODULE_LICENSE("GPL");
