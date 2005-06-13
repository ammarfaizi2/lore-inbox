Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVFMC6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVFMC6u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 22:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVFMC6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 22:58:49 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:44983 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261330AbVFMC6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 22:58:41 -0400
Message-ID: <42ACF624.3050904@brturbo.com.br>
Date: Sun, 12 Jun 2005 23:57:40 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
CC: Andrew Morton <akpm@osdl.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fixes removal of normal_i2c_range on V4L
References: <42ACF389.40205@brturbo.com.br>
In-Reply-To: <42ACF389.40205@brturbo.com.br>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------040904080604070308040301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040904080604070308040301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Mauro Carvalho Chehab wrote:

>This patch is necessary to correct I2C detect after normal_i2c_range
>removal applied by  gregkh-i2c-i2c-address_range_removal.patch at -mm
>series.
>
>Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
>
>
>  
>
Now with attachment :-)

--------------040904080604070308040301
Content-Type: text/x-patch;
 name="patch07-remove_i2c_range.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch07-remove_i2c_range.diff"

diff -ur linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/bt832.c linux-2.6.12-rc6-mm1/drivers/media/video/bt832.c
--- linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/bt832.c	2005-06-12 12:14:10.000000000 -0300
+++ linux-2.6.12-rc6-mm1/drivers/media/video/bt832.c	2005-06-12 23:15:26.000000000 -0300
@@ -39,8 +39,8 @@
 MODULE_LICENSE("GPL");
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = {I2C_CLIENT_END};
-static unsigned short normal_i2c_range[] = {I2C_BT832_ALT1>>1,I2C_BT832_ALT2>>1,I2C_CLIENT_END};
+static unsigned short normal_i2c[] = { I2C_BT832_ALT1>>1, I2C_BT832_ALT2>>1,
+				       I2C_CLIENT_END };
 I2C_CLIENT_INSMOD;
 
 /* ---------------------------------------------------------------------- */
diff -ur linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/msp3400.c linux-2.6.12-rc6-mm1/drivers/media/video/msp3400.c
--- linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/msp3400.c	2005-06-12 12:14:10.000000000 -0300
+++ linux-2.6.12-rc6-mm1/drivers/media/video/msp3400.c	2005-06-12 23:15:26.000000000 -0300
@@ -147,7 +147,6 @@
 	I2C_MSP3400C_ALT  >> 1,
 	I2C_CLIENT_END
 };
-static unsigned short normal_i2c_range[] = {I2C_CLIENT_END,I2C_CLIENT_END};
 I2C_CLIENT_INSMOD;
 
 /* ----------------------------------------------------------------------- */
diff -ur linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/saa7134/saa6752hs.c linux-2.6.12-rc6-mm1/drivers/media/video/saa7134/saa6752hs.c
--- linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/saa7134/saa6752hs.c	2005-06-12 12:14:13.000000000 -0300
+++ linux-2.6.12-rc6-mm1/drivers/media/video/saa7134/saa6752hs.c	2005-06-12 23:15:26.000000000 -0300
@@ -22,7 +22,6 @@
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = {0x20, I2C_CLIENT_END};
-static unsigned short normal_i2c_range[] = {I2C_CLIENT_END};
 I2C_CLIENT_INSMOD;
 
 MODULE_DESCRIPTION("device driver for saa6752hs MPEG2 encoder");
diff -ur linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/tda7432.c linux-2.6.12-rc6-mm1/drivers/media/video/tda7432.c
--- linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/tda7432.c	2005-06-12 12:14:10.000000000 -0300
+++ linux-2.6.12-rc6-mm1/drivers/media/video/tda7432.c	2005-06-12 23:15:26.000000000 -0300
@@ -74,7 +74,6 @@
 	I2C_TDA7432 >> 1,
 	I2C_CLIENT_END,
 };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END, I2C_CLIENT_END };
 I2C_CLIENT_INSMOD;
 
 /* Structure of address and subaddresses for the tda7432 */
diff -ur linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/tda9875.c linux-2.6.12-rc6-mm1/drivers/media/video/tda9875.c
--- linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/tda9875.c	2005-06-12 12:14:10.000000000 -0300
+++ linux-2.6.12-rc6-mm1/drivers/media/video/tda9875.c	2005-06-12 23:15:26.000000000 -0300
@@ -44,7 +44,6 @@
     I2C_TDA9875 >> 1,
     I2C_CLIENT_END
 };
-static unsigned short normal_i2c_range[] = {I2C_CLIENT_END};
 I2C_CLIENT_INSMOD;
 
 /* This is a superset of the TDA9875 */
diff -ur linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/tda9887.c linux-2.6.12-rc6-mm1/drivers/media/video/tda9887.c
--- linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/tda9887.c	2005-06-12 12:14:10.000000000 -0300
+++ linux-2.6.12-rc6-mm1/drivers/media/video/tda9887.c	2005-06-12 23:15:26.000000000 -0300
@@ -33,7 +33,6 @@
 	0x96 >>1,
 	I2C_CLIENT_END,
 };
-static unsigned short normal_i2c_range[] = {I2C_CLIENT_END,I2C_CLIENT_END};
 I2C_CLIENT_INSMOD;
 
 /* insmod options */
diff -ur linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/tuner-core.c linux-2.6.12-rc6-mm1/drivers/media/video/tuner-core.c
--- linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/tuner-core.c	2005-06-12 12:14:10.000000000 -0300
+++ linux-2.6.12-rc6-mm1/drivers/media/video/tuner-core.c	2005-06-12 23:26:42.000000000 -0300
@@ -26,17 +26,14 @@
 /*
  * comment line bellow to return to old behavor, where only one I2C device is supported
  */
-#define CONFIG_TUNER_MULTI_I2C /**/
 
 #define UNSET (-1U)
 
 /* standard i2c insmod options */
 static unsigned short normal_i2c[] = {
 	0x4b, /* tda8290 */
-	I2C_CLIENT_END
-};
-static unsigned short normal_i2c_range[] = {
-	0x60, 0x6f,
+	0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
+	0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f,
 	I2C_CLIENT_END
 };
 I2C_CLIENT_INSMOD;
@@ -325,9 +322,8 @@
 static int tuner_probe(struct i2c_adapter *adap)
 {
 	if (0 != addr) {
-		normal_i2c[0]       = addr;
-		normal_i2c_range[0] = addr;
-		normal_i2c_range[1] = addr;
+		normal_i2c[0] = addr;
+		normal_i2c[1] = I2C_CLIENT_END;
 	}
 	this_adap = 0;
 
Somente em linux-2.6.12-rc6-mm1/drivers/media/video: tuner-core.c~
Somente em linux-2.6.12-rc6-mm1/drivers/media/video: tuner-core.c.orig
Somente em linux-2.6.12-rc6-mm1/drivers/media/video: tuner-core.c.rej
diff -ur linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/tvaudio.c linux-2.6.12-rc6-mm1/drivers/media/video/tvaudio.c
--- linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/tvaudio.c	2005-06-12 12:14:10.000000000 -0300
+++ linux-2.6.12-rc6-mm1/drivers/media/video/tvaudio.c	2005-06-12 23:15:26.000000000 -0300
@@ -148,7 +148,6 @@
 	I2C_TDA9874   >> 1,
 	I2C_PIC16C54  >> 1,
 	I2C_CLIENT_END };
-static unsigned short normal_i2c_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
 I2C_CLIENT_INSMOD;
 
 static struct i2c_driver driver;
diff -ur linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/tveeprom.c linux-2.6.12-rc6-mm1/drivers/media/video/tveeprom.c
--- linux-2.6.12-rc6-mm1-v4l_patch/drivers/media/video/tveeprom.c	2005-06-12 12:14:13.000000000 -0300
+++ linux-2.6.12-rc6-mm1/drivers/media/video/tveeprom.c	2005-06-12 23:15:26.000000000 -0300
@@ -482,7 +482,6 @@
 	0xa0 >> 1,
 	I2C_CLIENT_END,
 };
-static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 I2C_CLIENT_INSMOD;
 
 struct i2c_driver i2c_driver_tveeprom;

--------------040904080604070308040301--
