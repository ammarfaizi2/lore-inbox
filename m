Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262657AbTCTWnB>; Thu, 20 Mar 2003 17:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262713AbTCTWXQ>; Thu, 20 Mar 2003 17:23:16 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:35589 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262690AbTCTWVg>;
	Thu, 20 Mar 2003 17:21:36 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.65
In-reply-to: <1048199566294@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Thu, 20 Mar 2003 14:32 -0800
Message-id: <10481995712956@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1143.1.8, 2003/03/19 11:29:45-08:00, elenstev@mesatop.com

[PATCH] i2c: spelling corrections for drivers/i2c

Here are some spelling and typo fixes for drivers/i2c.


 drivers/i2c/chips/adm1021.c |    4 ++--
 drivers/i2c/chips/lm75.c    |    2 +-
 drivers/i2c/i2c-algo-pcf.c  |    6 +++---
 drivers/i2c/i2c-proc.c      |    2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Thu Mar 20 12:55:46 2003
+++ b/drivers/i2c/chips/adm1021.c	Thu Mar 20 12:55:46 2003
@@ -93,9 +93,9 @@
 
 /* Initial values */
 
-/* Note: Eventhough I left the low and high limits named os and hyst, 
+/* Note: Even though I left the low and high limits named os and hyst, 
 they don't quite work like a thermostat the way the LM75 does.  I.e., 
-a lower temp than THYST actuall triggers an alarm instead of 
+a lower temp than THYST actually triggers an alarm instead of 
 clearing it.  Weird, ey?   --Phil  */
 #define adm1021_INIT_TOS 60
 #define adm1021_INIT_THYST 20
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Thu Mar 20 12:55:46 2003
+++ b/drivers/i2c/chips/lm75.c	Thu Mar 20 12:55:46 2003
@@ -25,7 +25,7 @@
 #include <linux/i2c-proc.h>
 
 
-#define LM75_SYSCTL_TEMP 1200	/* Degrees Celcius * 10 */
+#define LM75_SYSCTL_TEMP 1200	/* Degrees Celsius * 10 */
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { SENSORS_I2C_END };
diff -Nru a/drivers/i2c/i2c-algo-pcf.c b/drivers/i2c/i2c-algo-pcf.c
--- a/drivers/i2c/i2c-algo-pcf.c	Thu Mar 20 12:55:46 2003
+++ b/drivers/i2c/i2c-algo-pcf.c	Thu Mar 20 12:55:46 2003
@@ -152,7 +152,7 @@
 
 	/* load own address in S0, effective address is (own << 1)	*/
 	i2c_outb(adap, get_own(adap));
-	/* check it's realy writen */
+	/* check it's really written */
 	if ((temp = i2c_inb(adap)) != get_own(adap)) {
 		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't set S0 (0x%02x).\n", temp));
 		return -ENXIO;
@@ -168,7 +168,7 @@
 
 	/* load clock register S2					*/
 	i2c_outb(adap, get_clock(adap));
-	/* check it's realy writen, the only 5 lowest bits does matter */
+	/* check it's really written, the only 5 lowest bits does matter */
 	if (((temp = i2c_inb(adap)) & 0x1f) != get_clock(adap)) {
 		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't set S2 (0x%02x).\n", temp));
 		return -ENXIO;
@@ -177,7 +177,7 @@
 	/* Enable serial interface, idle, S0 selected			*/
 	set_pcf(adap, 1, I2C_PCF_IDLE);
 
-	/* check to see PCF is realy idled and we can access status register */
+	/* check to see PCF is really idled and we can access status register */
 	if ((temp = get_pcf(adap, 1)) != (I2C_PCF_PIN | I2C_PCF_BB)) {
 		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't select S1` (0x%02x).\n", temp));
 		return -ENXIO;
diff -Nru a/drivers/i2c/i2c-proc.c b/drivers/i2c/i2c-proc.c
--- a/drivers/i2c/i2c-proc.c	Thu Mar 20 12:55:46 2003
+++ b/drivers/i2c/i2c-proc.c	Thu Mar 20 12:55:46 2003
@@ -270,7 +270,7 @@
 }
 
 
-/* This funcion reads or writes a 'real' value (encoded by the combination
+/* This function reads or writes a 'real' value (encoded by the combination
    of an integer and a magnitude, the last is the power of ten the value
    should be divided with) to a /proc/sys directory. To use this function,
    you must (before registering the ctl_table) set the extra2 field to the

