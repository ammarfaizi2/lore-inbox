Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbUKIFla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbUKIFla (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbUKIFkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:40:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:56222 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261377AbUKIFY4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:24:56 -0500
Subject: Re: [PATCH] I2C update for 2.6.10-rc1
In-Reply-To: <10999778563931@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 8 Nov 2004 21:24:16 -0800
Message-Id: <10999778563058@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2014.1.16, 2004/11/08 16:35:21-08:00, greg@kroah.com

I2C: remove normal_isa_range from I2C sensor drivers, as it's not used.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/adm1021.c     |    1 -
 drivers/i2c/chips/adm1025.c     |    1 -
 drivers/i2c/chips/adm1031.c     |    1 -
 drivers/i2c/chips/asb100.c      |    1 -
 drivers/i2c/chips/ds1621.c      |    1 -
 drivers/i2c/chips/eeprom.c      |    1 -
 drivers/i2c/chips/fscher.c      |    1 -
 drivers/i2c/chips/gl518sm.c     |    1 -
 drivers/i2c/chips/it87.c        |    1 -
 drivers/i2c/chips/lm63.c        |    1 -
 drivers/i2c/chips/lm75.c        |    1 -
 drivers/i2c/chips/lm77.c        |    1 -
 drivers/i2c/chips/lm78.c        |    1 -
 drivers/i2c/chips/lm80.c        |    1 -
 drivers/i2c/chips/lm83.c        |    1 -
 drivers/i2c/chips/lm85.c        |    1 -
 drivers/i2c/chips/lm87.c        |    1 -
 drivers/i2c/chips/lm90.c        |    1 -
 drivers/i2c/chips/max1619.c     |    1 -
 drivers/i2c/chips/pc87360.c     |    2 --
 drivers/i2c/chips/pcf8574.c     |    1 -
 drivers/i2c/chips/pcf8591.c     |    1 -
 drivers/i2c/chips/smsc47m1.c    |    2 --
 drivers/i2c/chips/via686a.c     |    1 -
 drivers/i2c/chips/w83627hf.c    |    1 -
 drivers/i2c/chips/w83781d.c     |    1 -
 drivers/i2c/chips/w83l785ts.c   |    1 -
 drivers/i2c/i2c-sensor-detect.c |    8 --------
 include/linux/i2c-sensor.h      |    8 --------
 29 files changed, 45 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	2004-11-08 18:55:05 -08:00
+++ b/drivers/i2c/chips/adm1021.c	2004-11-08 18:55:05 -08:00
@@ -45,7 +45,6 @@
 	0x4c, 0x4e, I2C_CLIENT_END
 };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_8(adm1021, adm1023, max1617, max1617a, thmc10, lm84, gl523sm, mc1066);
diff -Nru a/drivers/i2c/chips/adm1025.c b/drivers/i2c/chips/adm1025.c
--- a/drivers/i2c/chips/adm1025.c	2004-11-08 18:55:05 -08:00
+++ b/drivers/i2c/chips/adm1025.c	2004-11-08 18:55:05 -08:00
@@ -62,7 +62,6 @@
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { 0x2c, 0x2e, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /*
  * Insmod parameters
diff -Nru a/drivers/i2c/chips/adm1031.c b/drivers/i2c/chips/adm1031.c
--- a/drivers/i2c/chips/adm1031.c	2004-11-08 18:55:05 -08:00
+++ b/drivers/i2c/chips/adm1031.c	2004-11-08 18:55:05 -08:00
@@ -60,7 +60,6 @@
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { 0x2c, 0x2e, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_2(adm1030, adm1031);
diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	2004-11-08 18:55:06 -08:00
+++ b/drivers/i2c/chips/asb100.c	2004-11-08 18:55:06 -08:00
@@ -61,7 +61,6 @@
 
 /* ISA addresses to scan (none) */
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(asb100);
diff -Nru a/drivers/i2c/chips/ds1621.c b/drivers/i2c/chips/ds1621.c
--- a/drivers/i2c/chips/ds1621.c	2004-11-08 18:55:06 -08:00
+++ b/drivers/i2c/chips/ds1621.c	2004-11-08 18:55:06 -08:00
@@ -32,7 +32,6 @@
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { 0x48, 0x4f, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(ds1621);
diff -Nru a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c	2004-11-08 18:55:05 -08:00
+++ b/drivers/i2c/chips/eeprom.c	2004-11-08 18:55:05 -08:00
@@ -39,7 +39,6 @@
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { 0x50, 0x57, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(eeprom);
diff -Nru a/drivers/i2c/chips/fscher.c b/drivers/i2c/chips/fscher.c
--- a/drivers/i2c/chips/fscher.c	2004-11-08 18:55:05 -08:00
+++ b/drivers/i2c/chips/fscher.c	2004-11-08 18:55:05 -08:00
@@ -40,7 +40,6 @@
 static unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /*
  * Insmod parameters
diff -Nru a/drivers/i2c/chips/gl518sm.c b/drivers/i2c/chips/gl518sm.c
--- a/drivers/i2c/chips/gl518sm.c	2004-11-08 18:55:06 -08:00
+++ b/drivers/i2c/chips/gl518sm.c	2004-11-08 18:55:06 -08:00
@@ -47,7 +47,6 @@
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_2(gl518sm_r00, gl518sm_r80);
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2004-11-08 18:55:06 -08:00
+++ b/drivers/i2c/chips/it87.c	2004-11-08 18:55:06 -08:00
@@ -45,7 +45,6 @@
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { 0x20, 0x2f, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { 0x0290, I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_2(it87, it8712);
diff -Nru a/drivers/i2c/chips/lm63.c b/drivers/i2c/chips/lm63.c
--- a/drivers/i2c/chips/lm63.c	2004-11-08 18:55:06 -08:00
+++ b/drivers/i2c/chips/lm63.c	2004-11-08 18:55:06 -08:00
@@ -52,7 +52,6 @@
 static unsigned short normal_i2c[] = { 0x4c, I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /*
  * Insmod parameters
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	2004-11-08 18:55:05 -08:00
+++ b/drivers/i2c/chips/lm75.c	2004-11-08 18:55:05 -08:00
@@ -31,7 +31,6 @@
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { 0x48, 0x4f, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(lm75);
diff -Nru a/drivers/i2c/chips/lm77.c b/drivers/i2c/chips/lm77.c
--- a/drivers/i2c/chips/lm77.c	2004-11-08 18:55:06 -08:00
+++ b/drivers/i2c/chips/lm77.c	2004-11-08 18:55:06 -08:00
@@ -37,7 +37,6 @@
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { 0x48, 0x4b, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(lm77);
diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	2004-11-08 18:55:06 -08:00
+++ b/drivers/i2c/chips/lm78.c	2004-11-08 18:55:06 -08:00
@@ -30,7 +30,6 @@
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { 0x20, 0x2f, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { 0x0290, I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_3(lm78, lm78j, lm79);
diff -Nru a/drivers/i2c/chips/lm80.c b/drivers/i2c/chips/lm80.c
--- a/drivers/i2c/chips/lm80.c	2004-11-08 18:55:05 -08:00
+++ b/drivers/i2c/chips/lm80.c	2004-11-08 18:55:05 -08:00
@@ -32,7 +32,6 @@
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { 0x28, 0x2f, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(lm80);
diff -Nru a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c	2004-11-08 18:55:05 -08:00
+++ b/drivers/i2c/chips/lm83.c	2004-11-08 18:55:05 -08:00
@@ -44,7 +44,6 @@
 static unsigned short normal_i2c_range[] = { 0x18, 0x1a, 0x29, 0x2b,
 	0x4c, 0x4e, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /*
  * Insmod parameters
diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	2004-11-08 18:55:05 -08:00
+++ b/drivers/i2c/chips/lm85.c	2004-11-08 18:55:05 -08:00
@@ -35,7 +35,6 @@
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_4(lm85b, lm85c, adm1027, adt7463);
diff -Nru a/drivers/i2c/chips/lm87.c b/drivers/i2c/chips/lm87.c
--- a/drivers/i2c/chips/lm87.c	2004-11-08 18:55:06 -08:00
+++ b/drivers/i2c/chips/lm87.c	2004-11-08 18:55:06 -08:00
@@ -68,7 +68,6 @@
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { 0x2c, 0x2e, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /*
  * Insmod parameters
diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	2004-11-08 18:55:05 -08:00
+++ b/drivers/i2c/chips/lm90.c	2004-11-08 18:55:05 -08:00
@@ -78,7 +78,6 @@
 static unsigned short normal_i2c[] = { 0x4c, 0x4d, I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /*
  * Insmod parameters
diff -Nru a/drivers/i2c/chips/max1619.c b/drivers/i2c/chips/max1619.c
--- a/drivers/i2c/chips/max1619.c	2004-11-08 18:55:06 -08:00
+++ b/drivers/i2c/chips/max1619.c	2004-11-08 18:55:06 -08:00
@@ -38,7 +38,6 @@
 static unsigned short normal_i2c_range[] = { 0x18, 0x1a, 0x29, 0x2b,
 						0x4c, 0x4e, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /*
  * Insmod parameters
diff -Nru a/drivers/i2c/chips/pc87360.c b/drivers/i2c/chips/pc87360.c
--- a/drivers/i2c/chips/pc87360.c	2004-11-08 18:55:05 -08:00
+++ b/drivers/i2c/chips/pc87360.c	2004-11-08 18:55:05 -08:00
@@ -45,7 +45,6 @@
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 static unsigned int normal_isa[] = { 0, I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 static struct i2c_force_data forces[] = {{ NULL }};
 static u8 devid;
 static unsigned int extra_isa[3];
@@ -56,7 +55,6 @@
 	.normal_i2c		= normal_i2c,
 	.normal_i2c_range	= normal_i2c_range,
 	.normal_isa		= normal_isa,
-	.normal_isa_range	= normal_isa_range,
 	.forces			= forces,
 };
 
diff -Nru a/drivers/i2c/chips/pcf8574.c b/drivers/i2c/chips/pcf8574.c
--- a/drivers/i2c/chips/pcf8574.c	2004-11-08 18:55:05 -08:00
+++ b/drivers/i2c/chips/pcf8574.c	2004-11-08 18:55:05 -08:00
@@ -45,7 +45,6 @@
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { 0x20, 0x27, 0x38, 0x3f, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_2(pcf8574, pcf8574a);
diff -Nru a/drivers/i2c/chips/pcf8591.c b/drivers/i2c/chips/pcf8591.c
--- a/drivers/i2c/chips/pcf8591.c	2004-11-08 18:55:06 -08:00
+++ b/drivers/i2c/chips/pcf8591.c	2004-11-08 18:55:06 -08:00
@@ -30,7 +30,6 @@
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { 0x48, 0x4f, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(pcf8591);
diff -Nru a/drivers/i2c/chips/smsc47m1.c b/drivers/i2c/chips/smsc47m1.c
--- a/drivers/i2c/chips/smsc47m1.c	2004-11-08 18:55:05 -08:00
+++ b/drivers/i2c/chips/smsc47m1.c	2004-11-08 18:55:05 -08:00
@@ -37,7 +37,6 @@
 static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 /* Address is autodetected, there is no default value */
 static unsigned int normal_isa[] = { 0x0000, I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 static struct i2c_force_data forces[] = {{NULL}};
 
 enum chips { any_chip, smsc47m1 };
@@ -45,7 +44,6 @@
 	.normal_i2c		= normal_i2c,
 	.normal_i2c_range	= normal_i2c_range,
 	.normal_isa		= normal_isa,
-	.normal_isa_range	= normal_isa_range,
 	.forces			= forces,
 };
 
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	2004-11-08 18:55:05 -08:00
+++ b/drivers/i2c/chips/via686a.c	2004-11-08 18:55:05 -08:00
@@ -54,7 +54,6 @@
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 static unsigned int normal_isa[] = { 0x0000, I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(via686a);
diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	2004-11-08 18:55:06 -08:00
+++ b/drivers/i2c/chips/w83627hf.c	2004-11-08 18:55:06 -08:00
@@ -59,7 +59,6 @@
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 static unsigned int normal_isa[] = { 0, I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_4(w83627hf, w83627thf, w83697hf, w83637hf);
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	2004-11-08 18:55:05 -08:00
+++ b/drivers/i2c/chips/w83781d.c	2004-11-08 18:55:05 -08:00
@@ -52,7 +52,6 @@
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { 0x20, 0x2f, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { 0x0290, I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_6(w83781d, w83782d, w83783s, w83627hf, as99127f, w83697hf);
diff -Nru a/drivers/i2c/chips/w83l785ts.c b/drivers/i2c/chips/w83l785ts.c
--- a/drivers/i2c/chips/w83l785ts.c	2004-11-08 18:55:05 -08:00
+++ b/drivers/i2c/chips/w83l785ts.c	2004-11-08 18:55:05 -08:00
@@ -49,7 +49,6 @@
 static unsigned short normal_i2c[] = { 0x2e, I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
-static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /*
  * Insmod parameters
diff -Nru a/drivers/i2c/i2c-sensor-detect.c b/drivers/i2c/i2c-sensor-detect.c
--- a/drivers/i2c/i2c-sensor-detect.c	2004-11-08 18:55:05 -08:00
+++ b/drivers/i2c/i2c-sensor-detect.c	2004-11-08 18:55:06 -08:00
@@ -93,14 +93,6 @@
 					found = 1;
 				}
 			}
-			for (i = 0; !found && (address_data->normal_isa_range[i] != I2C_CLIENT_ISA_END); i += 3) {
-				if ((addr >= address_data->normal_isa_range[i]) &&
-				    (addr <= address_data->normal_isa_range[i + 1]) &&
-				    ((addr - address_data->normal_isa_range[i]) % address_data->normal_isa_range[i + 2] == 0)) {
-					dev_dbg(&adapter->dev, "found normal isa_range entry for adapter %d, addr %04x", adapter_id, addr);
-					found = 1;
-				}
-			}
 		} else {
 			for (i = 0; !found && (address_data->normal_i2c[i] != I2C_CLIENT_END); i += 1) {
 				if (addr == address_data->normal_i2c[i]) {
diff -Nru a/include/linux/i2c-sensor.h b/include/linux/i2c-sensor.h
--- a/include/linux/i2c-sensor.h	2004-11-08 18:55:06 -08:00
+++ b/include/linux/i2c-sensor.h	2004-11-08 18:55:06 -08:00
@@ -48,12 +48,6 @@
      addresses which should normally be examined.
    normal_isa: filled in by the module writer. Terminated by SENSORS_ISA_END.
      A list of ISA addresses which should normally be examined.
-   normal_isa_range: filled in by the module writer. Terminated by 
-     SENSORS_ISA_END
-     A list of triples. The first two elements are ISA addresses, being an
-     range of addresses which should normally be examined. The third is the
-     modulo parameter: only addresses which are 0 module this value relative
-     to the first address of the range are actually considered.
    probe: insmod parameter. Initialize this list with I2C_CLIENT_ISA_END values.
      A list of pairs. The first value is a bus number (ANY_I2C_ISA_BUS for
      the ISA bus, -1 for any I2C bus), the second is the address. These
@@ -70,7 +64,6 @@
 	unsigned short *normal_i2c;
 	unsigned short *normal_i2c_range;
 	unsigned int *normal_isa;
-	unsigned int *normal_isa_range;
 	unsigned short *probe;
 	unsigned short *ignore;
 	struct i2c_force_data *forces;
@@ -92,7 +85,6 @@
 			.normal_i2c =		normal_i2c,		\
 			.normal_i2c_range =	normal_i2c_range,	\
 			.normal_isa =		normal_isa,		\
-			.normal_isa_range =	normal_isa_range,	\
 			.probe =		probe,			\
 			.ignore =		ignore,			\
 			.forces =		forces,			\

