Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbTABQZv>; Thu, 2 Jan 2003 11:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbTABQZv>; Thu, 2 Jan 2003 11:25:51 -0500
Received: from nammta01.sugar-land.nam.slb.com ([163.188.150.130]:39356 "EHLO
	mail.slb.com") by vger.kernel.org with ESMTP id <S263291AbTABQZo>;
	Thu, 2 Jan 2003 11:25:44 -0500
Date: Thu, 02 Jan 2003 16:31:35 +0000
From: Loic Jaquemet <jaquemet@fiifo.u-psud.fr>
Subject: PATCH 2.5.54 I2C drivers/media update..
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3E146967.E8DC4941@fiifo.u-psud.fr>
Organization: WesternGeco
MIME-version: 1.0
X-Mailer: Mozilla 4.79 [en] (X11; U; SunOS 5.6 sun4u)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


struct i2c_driver has changed .

## CUT

diff -ruN linux-2.5.54/drivers/media/video/bt819.c
linux-2.5.54.new/drivers/media/video/bt819.c
--- linux-2.5.54/drivers/media/video/bt819.c    2003-01-02
04:21:08.000000000 +0100
+++ linux-2.5.54.new/drivers/media/video/bt819.c        2003-01-02
17:08:28.000000000 +0100
@@ -448,6 +448,7 @@
 /*
-----------------------------------------------------------------------
*/
 
 static struct i2c_driver i2c_driver_bt819 = {
+       THIS_MODULE,
        "bt819",                /* name */
        I2C_DRIVERID_BT819,     /* ID */
        I2C_DF_NOTIFY,
diff -ruN linux-2.5.54/drivers/media/video/bt856.c
linux-2.5.54.new/drivers/media/video/bt856.c
--- linux-2.5.54/drivers/media/video/bt856.c    2003-01-02
04:20:52.000000000 +0100
+++ linux-2.5.54.new/drivers/media/video/bt856.c        2003-01-02
17:07:08.000000000 +0100
@@ -299,6 +299,7 @@
 /*
-----------------------------------------------------------------------
*/
 
 static struct i2c_driver i2c_driver_bt856 = {
+       THIS_MODULE,
        "bt856",                /* name */
        I2C_DRIVERID_BT856,     /* ID */
        I2C_DF_NOTIFY,
diff -ruN linux-2.5.54/drivers/media/video/msp3400.c
linux-2.5.54.new/drivers/media/video/msp3400.c
--- linux-2.5.54/drivers/media/video/msp3400.c  2003-01-02
04:22:21.000000000 +0100
+++ linux-2.5.54.new/drivers/media/video/msp3400.c      2003-01-02
17:14:44.000000000 +0100
@@ -1213,6 +1213,7 @@
 static int msp_command(struct i2c_client *client, unsigned int cmd,
void *arg);
 
 static struct i2c_driver driver = {
+       .owner          = THIS_MODULE,
        .name           = "i2cmsp3400driver",
        .id             = I2C_DRIVERID_MSP3400,
        .flags          = I2C_DF_NOTIFY,
diff -ruN linux-2.5.54/drivers/media/video/saa5249.c
linux-2.5.54.new/drivers/media/video/saa5249.c
--- linux-2.5.54/drivers/media/video/saa5249.c  2003-01-02
04:22:41.000000000 +0100
+++ linux-2.5.54.new/drivers/media/video/saa5249.c      2003-01-02
17:15:20.000000000 +0100
@@ -254,6 +254,7 @@
 
 static struct i2c_driver i2c_driver_videotext = 
 {
+       THIS_MODULE,
        IF_NAME,                /* name */
        I2C_DRIVERID_SAA5249, /* in i2c.h */
        I2C_DF_NOTIFY,
diff -ruN linux-2.5.54/drivers/media/video/saa7110.c
linux-2.5.54.new/drivers/media/video/saa7110.c
--- linux-2.5.54/drivers/media/video/saa7110.c  2003-01-02
04:20:49.000000000 +0100
+++ linux-2.5.54.new/drivers/media/video/saa7110.c      2003-01-02
17:06:16.000000000 +0100
@@ -381,6 +381,7 @@
 
 static struct i2c_driver i2c_driver_saa7110 =
 {
+       THIS_MODULE,
        IF_NAME,                        /* name */
        I2C_DRIVERID_SAA7110,   /* in i2c.h */
        I2C_DF_NOTIFY,  /* Addr range */
diff -ruN linux-2.5.54/drivers/media/video/saa7111.c
linux-2.5.54.new/drivers/media/video/saa7111.c
--- linux-2.5.54/drivers/media/video/saa7111.c  2003-01-02
04:21:50.000000000 +0100
+++ linux-2.5.54.new/drivers/media/video/saa7111.c      2003-01-02
17:13:31.000000000 +0100
@@ -398,6 +398,7 @@
 /*
-----------------------------------------------------------------------
*/
 
 static struct i2c_driver i2c_driver_saa7111 = {
+       .owner          = THIS_MODULE,
        .name           = "saa7111",             /* name */
        .id             = I2C_DRIVERID_SAA7111A, /* ID */
        .flags          = I2C_DF_NOTIFY,
diff -ruN linux-2.5.54/drivers/media/video/saa7185.c
linux-2.5.54.new/drivers/media/video/saa7185.c
--- linux-2.5.54/drivers/media/video/saa7185.c  2003-01-02
04:21:01.000000000 +0100
+++ linux-2.5.54.new/drivers/media/video/saa7185.c      2003-01-02
17:08:00.000000000 +0100
@@ -355,6 +355,7 @@
 /*
-----------------------------------------------------------------------
*/
 
 static struct i2c_driver i2c_driver_saa7185 = {
+       .owner          = THIS_MODULE,
        .name           = "saa7185",             /* name */
        .id             = I2C_DRIVERID_SAA7185B, /* ID */
        .flags          = I2C_DF_NOTIFY,
diff -ruN linux-2.5.54/drivers/media/video/tda7432.c
linux-2.5.54.new/drivers/media/video/tda7432.c
--- linux-2.5.54/drivers/media/video/tda7432.c  2003-01-02
04:22:35.000000000 +0100
+++ linux-2.5.54.new/drivers/media/video/tda7432.c      2003-01-02
17:02:22.000000000 +0100
@@ -500,6 +500,7 @@
 
 
 static struct i2c_driver driver = {
+       THIS_MODULE,
         "i2c tda7432 driver",
        I2C_DRIVERID_TDA7432,
         I2C_DF_NOTIFY,
diff -ruN linux-2.5.54/drivers/media/video/tda9875.c
linux-2.5.54.new/drivers/media/video/tda9875.c
--- linux-2.5.54/drivers/media/video/tda9875.c  2003-01-02
04:21:51.000000000 +0100
+++ linux-2.5.54.new/drivers/media/video/tda9875.c      2003-01-02
17:05:19.000000000 +0100
@@ -397,6 +397,7 @@
 
 
 static struct i2c_driver driver = {
+       THIS_MODULE,
         "i2c tda9875 driver",
         I2C_DRIVERID_TDA9875, /* Get new one for TDA9875 */
         I2C_DF_NOTIFY,
diff -ruN linux-2.5.54/drivers/media/video/tuner-3036.c
linux-2.5.54.new/drivers/media/video/tuner-3036.c
--- linux-2.5.54/drivers/media/video/tuner-3036.c       2003-01-02
04:21:50.000000000 +0100
+++ linux-2.5.54.new/drivers/media/video/tuner-3036.c   2003-01-02
17:14:03.000000000 +0100
@@ -185,6 +185,7 @@
 static struct i2c_driver 
 i2c_driver_tuner = 
 {
+       THIS_MODULE,
        "sab3036",              /* name       */
        I2C_DRIVERID_SAB3036,   /* ID         */
         I2C_DF_NOTIFY,
diff -ruN linux-2.5.54/drivers/media/video/tuner.c
linux-2.5.54.new/drivers/media/video/tuner.c
--- linux-2.5.54/drivers/media/video/tuner.c    2003-01-02
04:22:54.000000000 +0100
+++ linux-2.5.54.new/drivers/media/video/tuner.c        2003-01-02
17:15:54.000000000 +0100
@@ -975,6 +975,7 @@
 /*
-----------------------------------------------------------------------
*/
 
 static struct i2c_driver driver = {
+       .owner          = THIS_MODULE,
        .name           = "i2cTVtunerdriver",
        .id             = I2C_DRIVERID_TUNER,
        .flags          = I2C_DF_NOTIFY,
diff -ruN linux-2.5.54/drivers/media/video/tvaudio.c
linux-2.5.54.new/drivers/media/video/tvaudio.c
--- linux-2.5.54/drivers/media/video/tvaudio.c  2003-01-02
04:21:40.000000000 +0100
+++ linux-2.5.54.new/drivers/media/video/tvaudio.c      2003-01-02
17:12:24.000000000 +0100
@@ -1544,6 +1544,7 @@
 
 
 static struct i2c_driver driver = {
+       .owner          = THIS_MODULE,
        .name           = "generic i2c audio driver",
        .id             = I2C_DRIVERID_TVAUDIO,
        .flags          = I2C_DF_NOTIFY,
diff -ruN linux-2.5.54/drivers/media/video/tvmixer.c
linux-2.5.54.new/drivers/media/video/tvmixer.c
--- linux-2.5.54/drivers/media/video/tvmixer.c  2003-01-02
04:23:04.000000000 +0100
+++ linux-2.5.54.new/drivers/media/video/tvmixer.c      2003-01-02
17:16:18.000000000 +0100
@@ -217,6 +217,7 @@
 
 
 static struct i2c_driver driver = {
+       .owner          = THIS_MODULE,
        .name           = "tv card mixer driver",
        .id             = I2C_DRIVERID_TVMIXER,
        .flags          = I2C_DF_DUMMY,



-- 
+----------------------------------------------+
|Jaquemet Loic                                 |
|Eleve ingenieur en informatique FIIFO, ORSAY  |
+----------------------------------------------+
http://sourceforge.net/projects/ffss/
#wirelessfr @ irc.freenode.net
