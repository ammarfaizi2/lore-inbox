Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270244AbUJTBzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270244AbUJTBzz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUJTAvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:51:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:4276 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266891AbUJTAT3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:29 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <10982315033266@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:24 -0700
Message-Id: <10982315043782@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1832.73.5, 2004/09/08 12:35:33-07:00, khali@linux-fr.org

[PATCH] I2C: Do not init global variables to 0

This trivial patch enforces the rule that global variables should not be
explicitely initialized to 0 for all i2c chip drivers.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/adm1021.c |    2 +-
 drivers/i2c/chips/adm1025.c |    2 +-
 drivers/i2c/chips/ds1621.c  |    2 +-
 drivers/i2c/chips/eeprom.c  |    2 +-
 drivers/i2c/chips/fscher.c  |    2 +-
 drivers/i2c/chips/gl518sm.c |    2 +-
 drivers/i2c/chips/it87.c    |    2 +-
 drivers/i2c/chips/lm75.c    |    2 +-
 drivers/i2c/chips/lm77.c    |    2 +-
 drivers/i2c/chips/lm80.c    |    2 +-
 drivers/i2c/chips/lm83.c    |    2 +-
 drivers/i2c/chips/lm85.c    |    2 +-
 drivers/i2c/chips/lm90.c    |    2 +-
 drivers/i2c/chips/max1619.c |    2 +-
 drivers/i2c/chips/pcf8574.c |    2 +-
 drivers/i2c/chips/pcf8591.c |    2 +-
 16 files changed, 16 insertions(+), 16 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	2004-10-19 16:55:42 -07:00
+++ b/drivers/i2c/chips/adm1021.c	2004-10-19 16:55:42 -07:00
@@ -148,7 +148,7 @@
 	.detach_client	= adm1021_detach_client,
 };
 
-static int adm1021_id = 0;
+static int adm1021_id;
 
 #define show(value)	\
 static ssize_t show_##value(struct device *dev, char *buf)		\
diff -Nru a/drivers/i2c/chips/adm1025.c b/drivers/i2c/chips/adm1025.c
--- a/drivers/i2c/chips/adm1025.c	2004-10-19 16:55:42 -07:00
+++ b/drivers/i2c/chips/adm1025.c	2004-10-19 16:55:42 -07:00
@@ -153,7 +153,7 @@
  * Internal variables
  */
 
-static int adm1025_id = 0;
+static int adm1025_id;
 
 /*
  * Sysfs stuff
diff -Nru a/drivers/i2c/chips/ds1621.c b/drivers/i2c/chips/ds1621.c
--- a/drivers/i2c/chips/ds1621.c	2004-10-19 16:55:42 -07:00
+++ b/drivers/i2c/chips/ds1621.c	2004-10-19 16:55:42 -07:00
@@ -96,7 +96,7 @@
 	.detach_client	= ds1621_detach_client,
 };
 
-static int ds1621_id = 0;
+static int ds1621_id;
 
 /* All registers are word-sized, except for the configuration register.
    DS1621 uses a high-byte first convention, which is exactly opposite to
diff -Nru a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c	2004-10-19 16:55:42 -07:00
+++ b/drivers/i2c/chips/eeprom.c	2004-10-19 16:55:42 -07:00
@@ -86,7 +86,7 @@
 	.detach_client	= eeprom_detach_client,
 };
 
-static int eeprom_id = 0;
+static int eeprom_id;
 
 static void eeprom_update_client(struct i2c_client *client, u8 slice)
 {
diff -Nru a/drivers/i2c/chips/fscher.c b/drivers/i2c/chips/fscher.c
--- a/drivers/i2c/chips/fscher.c	2004-10-19 16:55:42 -07:00
+++ b/drivers/i2c/chips/fscher.c	2004-10-19 16:55:42 -07:00
@@ -156,7 +156,7 @@
  * Internal variables
  */
 
-static int fscher_id = 0;
+static int fscher_id;
 
 /*
  * Sysfs stuff
diff -Nru a/drivers/i2c/chips/gl518sm.c b/drivers/i2c/chips/gl518sm.c
--- a/drivers/i2c/chips/gl518sm.c	2004-10-19 16:55:42 -07:00
+++ b/drivers/i2c/chips/gl518sm.c	2004-10-19 16:55:42 -07:00
@@ -164,7 +164,7 @@
  * Internal variables
  */
 
-static int gl518_id = 0;
+static int gl518_id;
 
 /*
  * Sysfs stuff
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2004-10-19 16:55:42 -07:00
+++ b/drivers/i2c/chips/it87.c	2004-10-19 16:55:42 -07:00
@@ -226,7 +226,7 @@
 	.detach_client	= it87_detach_client,
 };
 
-static int it87_id = 0;
+static int it87_id;
 
 static ssize_t show_in(struct device *dev, char *buf, int nr)
 {
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	2004-10-19 16:55:42 -07:00
+++ b/drivers/i2c/chips/lm75.c	2004-10-19 16:55:42 -07:00
@@ -74,7 +74,7 @@
 	.detach_client	= lm75_detach_client,
 };
 
-static int lm75_id = 0;
+static int lm75_id;
 
 #define show(value)	\
 static ssize_t show_##value(struct device *dev, char *buf)		\
diff -Nru a/drivers/i2c/chips/lm77.c b/drivers/i2c/chips/lm77.c
--- a/drivers/i2c/chips/lm77.c	2004-10-19 16:55:42 -07:00
+++ b/drivers/i2c/chips/lm77.c	2004-10-19 16:55:42 -07:00
@@ -83,7 +83,7 @@
 	.detach_client	= lm77_detach_client,
 };
 
-static int lm77_id = 0;
+static int lm77_id;
 
 /* straight from the datasheet */
 #define LM77_TEMP_MIN (-55000)
diff -Nru a/drivers/i2c/chips/lm80.c b/drivers/i2c/chips/lm80.c
--- a/drivers/i2c/chips/lm80.c	2004-10-19 16:55:42 -07:00
+++ b/drivers/i2c/chips/lm80.c	2004-10-19 16:55:42 -07:00
@@ -145,7 +145,7 @@
  * Internal variables
  */
 
-static int lm80_id = 0;
+static int lm80_id;
 
 /*
  * Driver data (common to all clients)
diff -Nru a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c	2004-10-19 16:55:42 -07:00
+++ b/drivers/i2c/chips/lm83.c	2004-10-19 16:55:42 -07:00
@@ -152,7 +152,7 @@
  * Internal variables
  */
 
-static int lm83_id = 0;
+static int lm83_id;
 
 /*
  * Sysfs stuff
diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	2004-10-19 16:55:42 -07:00
+++ b/drivers/i2c/chips/lm85.c	2004-10-19 16:55:42 -07:00
@@ -405,7 +405,7 @@
 };
 
 /* Unique ID assigned to each LM85 detected */
-static int lm85_id = 0;
+static int lm85_id;
 
 
 /* 4 Fans */
diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	2004-10-19 16:55:42 -07:00
+++ b/drivers/i2c/chips/lm90.c	2004-10-19 16:55:42 -07:00
@@ -187,7 +187,7 @@
  * Internal variables
  */
 
-static int lm90_id = 0;
+static int lm90_id;
 
 /*
  * Sysfs stuff
diff -Nru a/drivers/i2c/chips/max1619.c b/drivers/i2c/chips/max1619.c
--- a/drivers/i2c/chips/max1619.c	2004-10-19 16:55:42 -07:00
+++ b/drivers/i2c/chips/max1619.c	2004-10-19 16:55:42 -07:00
@@ -120,7 +120,7 @@
  * Internal variables
  */
 
-static int max1619_id = 0;
+static int max1619_id;
 
 /*
  * Sysfs stuff
diff -Nru a/drivers/i2c/chips/pcf8574.c b/drivers/i2c/chips/pcf8574.c
--- a/drivers/i2c/chips/pcf8574.c	2004-10-19 16:55:42 -07:00
+++ b/drivers/i2c/chips/pcf8574.c	2004-10-19 16:55:42 -07:00
@@ -77,7 +77,7 @@
 	.detach_client	= pcf8574_detach_client,
 };
 
-static int pcf8574_id = 0;
+static int pcf8574_id;
 
 /* following are the sysfs callback functions */
 static ssize_t show_read(struct device *dev, char *buf)
diff -Nru a/drivers/i2c/chips/pcf8591.c b/drivers/i2c/chips/pcf8591.c
--- a/drivers/i2c/chips/pcf8591.c	2004-10-19 16:55:42 -07:00
+++ b/drivers/i2c/chips/pcf8591.c	2004-10-19 16:55:42 -07:00
@@ -99,7 +99,7 @@
 	.detach_client	= pcf8591_detach_client,
 };
 
-static int pcf8591_id = 0;
+static int pcf8591_id;
 
 /* following are the sysfs callback functions */
 #define show_in_channel(channel)					\

