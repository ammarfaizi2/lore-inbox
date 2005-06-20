Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVFUDQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVFUDQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 23:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVFUDOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 23:14:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:6884 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261654AbVFTW7f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:35 -0400
Cc: yani.ioannou@gmail.com
Subject: [PATCH] Driver Core: drivers/usb/input/aiptek.c - drivers/zorro/zorro-sysfs.c: update device attribute callbacks
In-Reply-To: <11193083682393@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:28 -0700
Message-Id: <11193083681788@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver Core: drivers/usb/input/aiptek.c - drivers/zorro/zorro-sysfs.c: update device attribute callbacks

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 060b8845e6bea938d65ad6f89e83507e5ff4fec4
tree ba82ce7d7a532b045f02e29788ece53d6be693e6
parent 10523b3b82456e416cbaffcc24ea2246980aa746
author Yani Ioannou <yani.ioannou@gmail.com> Tue, 17 May 2005 06:44:04 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:35 -0700

 drivers/usb/input/aiptek.c      |   78 ++++++++++++++++++++-------------------
 drivers/usb/misc/cytherm.c      |   20 +++++-----
 drivers/usb/misc/phidgetkit.c   |   14 ++++---
 drivers/usb/misc/phidgetservo.c |    4 +-
 drivers/usb/misc/usbled.c       |    4 +-
 drivers/usb/serial/ftdi_sio.c   |    6 ++-
 drivers/usb/storage/scsiglue.c  |    4 +-
 drivers/video/gbefb.c           |    4 +-
 drivers/video/w100fb.c          |   12 +++---
 drivers/w1/w1.c                 |   16 ++++----
 drivers/w1/w1_family.h          |    4 +-
 drivers/w1/w1_smem.c            |    8 ++--
 drivers/w1/w1_therm.c           |    8 ++--
 drivers/zorro/zorro-sysfs.c     |    4 +-
 14 files changed, 93 insertions(+), 93 deletions(-)

diff --git a/drivers/usb/input/aiptek.c b/drivers/usb/input/aiptek.c
--- a/drivers/usb/input/aiptek.c
+++ b/drivers/usb/input/aiptek.c
@@ -1025,7 +1025,7 @@ static int aiptek_program_tablet(struct 
 /***********************************************************************
  * support the 'size' file -- display support
  */
-static ssize_t show_tabletSize(struct device *dev, char *buf)
+static ssize_t show_tabletSize(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1048,7 +1048,7 @@ static DEVICE_ATTR(size, S_IRUGO, show_t
 /***********************************************************************
  * support routines for the 'product_id' file
  */
-static ssize_t show_tabletProductId(struct device *dev, char *buf)
+static ssize_t show_tabletProductId(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1064,7 +1064,7 @@ static DEVICE_ATTR(product_id, S_IRUGO, 
 /***********************************************************************
  * support routines for the 'vendor_id' file
  */
-static ssize_t show_tabletVendorId(struct device *dev, char *buf)
+static ssize_t show_tabletVendorId(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1079,7 +1079,7 @@ static DEVICE_ATTR(vendor_id, S_IRUGO, s
 /***********************************************************************
  * support routines for the 'vendor' file
  */
-static ssize_t show_tabletManufacturer(struct device *dev, char *buf)
+static ssize_t show_tabletManufacturer(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	int retval;
@@ -1096,7 +1096,7 @@ static DEVICE_ATTR(vendor, S_IRUGO, show
 /***********************************************************************
  * support routines for the 'product' file
  */
-static ssize_t show_tabletProduct(struct device *dev, char *buf)
+static ssize_t show_tabletProduct(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	int retval;
@@ -1114,7 +1114,7 @@ static DEVICE_ATTR(product, S_IRUGO, sho
  * support routines for the 'pointer_mode' file. Note that this file
  * both displays current setting and allows reprogramming.
  */
-static ssize_t show_tabletPointerMode(struct device *dev, char *buf)
+static ssize_t show_tabletPointerMode(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	char *s;
@@ -1143,7 +1143,7 @@ static ssize_t show_tabletPointerMode(st
 }
 
 static ssize_t
-store_tabletPointerMode(struct device *dev, const char *buf, size_t count)
+store_tabletPointerMode(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	if (aiptek == NULL)
@@ -1168,7 +1168,7 @@ static DEVICE_ATTR(pointer_mode,
  * support routines for the 'coordinate_mode' file. Note that this file
  * both displays current setting and allows reprogramming.
  */
-static ssize_t show_tabletCoordinateMode(struct device *dev, char *buf)
+static ssize_t show_tabletCoordinateMode(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	char *s;
@@ -1193,7 +1193,7 @@ static ssize_t show_tabletCoordinateMode
 }
 
 static ssize_t
-store_tabletCoordinateMode(struct device *dev, const char *buf, size_t count)
+store_tabletCoordinateMode(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	if (aiptek == NULL)
@@ -1217,7 +1217,7 @@ static DEVICE_ATTR(coordinate_mode,
  * support routines for the 'tool_mode' file. Note that this file
  * both displays current setting and allows reprogramming.
  */
-static ssize_t show_tabletToolMode(struct device *dev, char *buf)
+static ssize_t show_tabletToolMode(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	char *s;
@@ -1262,7 +1262,7 @@ static ssize_t show_tabletToolMode(struc
 }
 
 static ssize_t
-store_tabletToolMode(struct device *dev, const char *buf, size_t count)
+store_tabletToolMode(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	if (aiptek == NULL)
@@ -1295,7 +1295,7 @@ static DEVICE_ATTR(tool_mode,
  * support routines for the 'xtilt' file. Note that this file
  * both displays current setting and allows reprogramming.
  */
-static ssize_t show_tabletXtilt(struct device *dev, char *buf)
+static ssize_t show_tabletXtilt(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1311,7 +1311,7 @@ static ssize_t show_tabletXtilt(struct d
 }
 
 static ssize_t
-store_tabletXtilt(struct device *dev, const char *buf, size_t count)
+store_tabletXtilt(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	int x;
@@ -1337,7 +1337,7 @@ static DEVICE_ATTR(xtilt,
  * support routines for the 'ytilt' file. Note that this file
  * both displays current setting and allows reprogramming.
  */
-static ssize_t show_tabletYtilt(struct device *dev, char *buf)
+static ssize_t show_tabletYtilt(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1353,7 +1353,7 @@ static ssize_t show_tabletYtilt(struct d
 }
 
 static ssize_t
-store_tabletYtilt(struct device *dev, const char *buf, size_t count)
+store_tabletYtilt(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	int y;
@@ -1379,7 +1379,7 @@ static DEVICE_ATTR(ytilt,
  * support routines for the 'jitter' file. Note that this file
  * both displays current setting and allows reprogramming.
  */
-static ssize_t show_tabletJitterDelay(struct device *dev, char *buf)
+static ssize_t show_tabletJitterDelay(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1390,7 +1390,7 @@ static ssize_t show_tabletJitterDelay(st
 }
 
 static ssize_t
-store_tabletJitterDelay(struct device *dev, const char *buf, size_t count)
+store_tabletJitterDelay(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1409,7 +1409,7 @@ static DEVICE_ATTR(jitter,
  * support routines for the 'delay' file. Note that this file
  * both displays current setting and allows reprogramming.
  */
-static ssize_t show_tabletProgrammableDelay(struct device *dev, char *buf)
+static ssize_t show_tabletProgrammableDelay(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1421,7 +1421,7 @@ static ssize_t show_tabletProgrammableDe
 }
 
 static ssize_t
-store_tabletProgrammableDelay(struct device *dev, const char *buf, size_t count)
+store_tabletProgrammableDelay(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1440,7 +1440,7 @@ static DEVICE_ATTR(delay,
  * support routines for the 'input_path' file. Note that this file
  * only displays current setting.
  */
-static ssize_t show_tabletInputDevice(struct device *dev, char *buf)
+static ssize_t show_tabletInputDevice(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1457,7 +1457,7 @@ static DEVICE_ATTR(input_path, S_IRUGO, 
  * support routines for the 'event_count' file. Note that this file
  * only displays current setting.
  */
-static ssize_t show_tabletEventsReceived(struct device *dev, char *buf)
+static ssize_t show_tabletEventsReceived(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1473,7 +1473,7 @@ static DEVICE_ATTR(event_count, S_IRUGO,
  * support routines for the 'diagnostic' file. Note that this file
  * only displays current setting.
  */
-static ssize_t show_tabletDiagnosticMessage(struct device *dev, char *buf)
+static ssize_t show_tabletDiagnosticMessage(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	char *retMsg;
@@ -1515,7 +1515,7 @@ static DEVICE_ATTR(diagnostic, S_IRUGO, 
  * support routines for the 'stylus_upper' file. Note that this file
  * both displays current setting and allows for setting changing.
  */
-static ssize_t show_tabletStylusUpper(struct device *dev, char *buf)
+static ssize_t show_tabletStylusUpper(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	char *s;
@@ -1540,7 +1540,7 @@ static ssize_t show_tabletStylusUpper(st
 }
 
 static ssize_t
-store_tabletStylusUpper(struct device *dev, const char *buf, size_t count)
+store_tabletStylusUpper(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1565,7 +1565,7 @@ static DEVICE_ATTR(stylus_upper,
  * support routines for the 'stylus_lower' file. Note that this file
  * both displays current setting and allows for setting changing.
  */
-static ssize_t show_tabletStylusLower(struct device *dev, char *buf)
+static ssize_t show_tabletStylusLower(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	char *s;
@@ -1590,7 +1590,7 @@ static ssize_t show_tabletStylusLower(st
 }
 
 static ssize_t
-store_tabletStylusLower(struct device *dev, const char *buf, size_t count)
+store_tabletStylusLower(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1615,7 +1615,7 @@ static DEVICE_ATTR(stylus_lower,
  * support routines for the 'mouse_left' file. Note that this file
  * both displays current setting and allows for setting changing.
  */
-static ssize_t show_tabletMouseLeft(struct device *dev, char *buf)
+static ssize_t show_tabletMouseLeft(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	char *s;
@@ -1644,7 +1644,7 @@ static ssize_t show_tabletMouseLeft(stru
 }
 
 static ssize_t
-store_tabletMouseLeft(struct device *dev, const char *buf, size_t count)
+store_tabletMouseLeft(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1669,7 +1669,7 @@ static DEVICE_ATTR(mouse_left,
  * support routines for the 'mouse_middle' file. Note that this file
  * both displays current setting and allows for setting changing.
  */
-static ssize_t show_tabletMouseMiddle(struct device *dev, char *buf)
+static ssize_t show_tabletMouseMiddle(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	char *s;
@@ -1698,7 +1698,7 @@ static ssize_t show_tabletMouseMiddle(st
 }
 
 static ssize_t
-store_tabletMouseMiddle(struct device *dev, const char *buf, size_t count)
+store_tabletMouseMiddle(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1725,7 +1725,7 @@ static DEVICE_ATTR(mouse_middle,
  * support routines for the 'mouse_right' file. Note that this file
  * both displays current setting and allows for setting changing.
  */
-static ssize_t show_tabletMouseRight(struct device *dev, char *buf)
+static ssize_t show_tabletMouseRight(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 	char *s;
@@ -1754,7 +1754,7 @@ static ssize_t show_tabletMouseRight(str
 }
 
 static ssize_t
-store_tabletMouseRight(struct device *dev, const char *buf, size_t count)
+store_tabletMouseRight(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1780,7 +1780,7 @@ static DEVICE_ATTR(mouse_right,
  * support routines for the 'wheel' file. Note that this file
  * both displays current setting and allows for setting changing.
  */
-static ssize_t show_tabletWheel(struct device *dev, char *buf)
+static ssize_t show_tabletWheel(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1796,7 +1796,7 @@ static ssize_t show_tabletWheel(struct d
 }
 
 static ssize_t
-store_tabletWheel(struct device *dev, const char *buf, size_t count)
+store_tabletWheel(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1814,7 +1814,7 @@ static DEVICE_ATTR(wheel,
  * support routines for the 'execute' file. Note that this file
  * both displays current setting and allows for setting changing.
  */
-static ssize_t show_tabletExecute(struct device *dev, char *buf)
+static ssize_t show_tabletExecute(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1829,7 +1829,7 @@ static ssize_t show_tabletExecute(struct
 }
 
 static ssize_t
-store_tabletExecute(struct device *dev, const char *buf, size_t count)
+store_tabletExecute(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1855,7 +1855,7 @@ static DEVICE_ATTR(execute,
  * support routines for the 'odm_code' file. Note that this file
  * only displays current setting.
  */
-static ssize_t show_tabletODMCode(struct device *dev, char *buf)
+static ssize_t show_tabletODMCode(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1871,7 +1871,7 @@ static DEVICE_ATTR(odm_code, S_IRUGO, sh
  * support routines for the 'model_code' file. Note that this file
  * only displays current setting.
  */
-static ssize_t show_tabletModelCode(struct device *dev, char *buf)
+static ssize_t show_tabletModelCode(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
@@ -1887,7 +1887,7 @@ static DEVICE_ATTR(model_code, S_IRUGO, 
  * support routines for the 'firmware_code' file. Note that this file
  * only displays current setting.
  */
-static ssize_t show_firmwareCode(struct device *dev, char *buf)
+static ssize_t show_firmwareCode(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct aiptek *aiptek = dev_get_drvdata(dev);
 
diff --git a/drivers/usb/misc/cytherm.c b/drivers/usb/misc/cytherm.c
--- a/drivers/usb/misc/cytherm.c
+++ b/drivers/usb/misc/cytherm.c
@@ -85,7 +85,7 @@ static int vendor_command(struct usb_dev
 #define BRIGHTNESS 0x2c     /* RAM location for brightness value */
 #define BRIGHTNESS_SEM 0x2b /* RAM location for brightness semaphore */
 
-static ssize_t show_brightness(struct device *dev, char *buf)
+static ssize_t show_brightness(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct usb_interface *intf = to_usb_interface(dev);    
 	struct usb_cytherm *cytherm = usb_get_intfdata(intf);     
@@ -93,7 +93,7 @@ static ssize_t show_brightness(struct de
 	return sprintf(buf, "%i", cytherm->brightness);
 }
 
-static ssize_t set_brightness(struct device *dev, const char *buf, 
+static ssize_t set_brightness(struct device *dev, struct device_attribute *attr, const char *buf,
 			      size_t count)
 {
 	struct usb_interface *intf = to_usb_interface(dev);
@@ -138,7 +138,7 @@ static DEVICE_ATTR(brightness, S_IRUGO |
 #define TEMP 0x33 /* RAM location for temperature */
 #define SIGN 0x34 /* RAM location for temperature sign */
 
-static ssize_t show_temp(struct device *dev, char *buf)
+static ssize_t show_temp(struct device *dev, struct device_attribute *attr, char *buf)
 {
 
 	struct usb_interface *intf = to_usb_interface(dev);
@@ -174,7 +174,7 @@ static ssize_t show_temp(struct device *
 }
 
 
-static ssize_t set_temp(struct device *dev, const char *buf, size_t count)
+static ssize_t set_temp(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	return count;
 }
@@ -184,7 +184,7 @@ static DEVICE_ATTR(temp, S_IRUGO, show_t
 
 #define BUTTON 0x7a
 
-static ssize_t show_button(struct device *dev, char *buf)
+static ssize_t show_button(struct device *dev, struct device_attribute *attr, char *buf)
 {
 
 	struct usb_interface *intf = to_usb_interface(dev);
@@ -215,7 +215,7 @@ static ssize_t show_button(struct device
 }
 
 
-static ssize_t set_button(struct device *dev, const char *buf, size_t count)
+static ssize_t set_button(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	return count;
 }
@@ -223,7 +223,7 @@ static ssize_t set_button(struct device 
 static DEVICE_ATTR(button, S_IRUGO, show_button, set_button);
 
 
-static ssize_t show_port0(struct device *dev, char *buf)
+static ssize_t show_port0(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct usb_cytherm *cytherm = usb_get_intfdata(intf);
@@ -249,7 +249,7 @@ static ssize_t show_port0(struct device 
 }
 
 
-static ssize_t set_port0(struct device *dev, const char *buf, size_t count)
+static ssize_t set_port0(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct usb_cytherm *cytherm = usb_get_intfdata(intf);
@@ -283,7 +283,7 @@ static ssize_t set_port0(struct device *
 
 static DEVICE_ATTR(port0, S_IRUGO | S_IWUSR | S_IWGRP, show_port0, set_port0);
 
-static ssize_t show_port1(struct device *dev, char *buf)
+static ssize_t show_port1(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct usb_cytherm *cytherm = usb_get_intfdata(intf);
@@ -309,7 +309,7 @@ static ssize_t show_port1(struct device 
 }
 
 
-static ssize_t set_port1(struct device *dev, const char *buf, size_t count)
+static ssize_t set_port1(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct usb_cytherm *cytherm = usb_get_intfdata(intf);
diff --git a/drivers/usb/misc/phidgetkit.c b/drivers/usb/misc/phidgetkit.c
--- a/drivers/usb/misc/phidgetkit.c
+++ b/drivers/usb/misc/phidgetkit.c
@@ -173,7 +173,7 @@ exit:
 }
 
 #define set_lcd_line(number)	\
-static ssize_t lcd_line_##number(struct device *dev, const char *buf, size_t count)	\
+static ssize_t lcd_line_##number(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)	\
 {											\
 	struct usb_interface *intf = to_usb_interface(dev);				\
 	struct phidget_interfacekit *kit = usb_get_intfdata(intf);			\
@@ -184,7 +184,7 @@ static DEVICE_ATTR(lcd_line_##number, S_
 set_lcd_line(1);
 set_lcd_line(2);
 
-static ssize_t set_backlight(struct device *dev, const char *buf, size_t count)
+static ssize_t set_backlight(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct phidget_interfacekit *kit = usb_get_intfdata(intf);
@@ -232,7 +232,7 @@ static void remove_lcd_files(struct phid
 	}
 }
 
-static ssize_t enable_lcd_files(struct device *dev, const char *buf, size_t count)
+static ssize_t enable_lcd_files(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct phidget_interfacekit *kit = usb_get_intfdata(intf);
@@ -307,7 +307,7 @@ resubmit:
 }
 
 #define show_set_output(value)		\
-static ssize_t set_output##value(struct device *dev, const char *buf, 	\
+static ssize_t set_output##value(struct device *dev, struct device_attribute *attr, const char *buf, 	\
 							size_t count)	\
 {									\
 	struct usb_interface *intf = to_usb_interface(dev);		\
@@ -324,7 +324,7 @@ static ssize_t set_output##value(struct 
 	return retval ? retval : count;					\
 }									\
 									\
-static ssize_t show_output##value(struct device *dev, char *buf)	\
+static ssize_t show_output##value(struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	struct usb_interface *intf = to_usb_interface(dev);		\
 	struct phidget_interfacekit *kit = usb_get_intfdata(intf);	\
@@ -343,7 +343,7 @@ show_set_output(7);
 show_set_output(8);	/* should be MAX_INTERFACES - 1 */
 
 #define show_input(value)	\
-static ssize_t show_input##value(struct device *dev, char *buf)	\
+static ssize_t show_input##value(struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	struct usb_interface *intf = to_usb_interface(dev);		\
 	struct phidget_interfacekit *kit = usb_get_intfdata(intf);	\
@@ -362,7 +362,7 @@ show_input(7);
 show_input(8);		/* should be MAX_INTERFACES - 1 */
 
 #define show_sensor(value)	\
-static ssize_t show_sensor##value(struct device *dev, char *buf)	\
+static ssize_t show_sensor##value(struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	struct usb_interface *intf = to_usb_interface(dev);		\
 	struct phidget_interfacekit *kit = usb_get_intfdata(intf);	\
diff --git a/drivers/usb/misc/phidgetservo.c b/drivers/usb/misc/phidgetservo.c
--- a/drivers/usb/misc/phidgetservo.c
+++ b/drivers/usb/misc/phidgetservo.c
@@ -207,7 +207,7 @@ change_position_v20(struct phidget_servo
 }
 
 #define show_set(value)	\
-static ssize_t set_servo##value (struct device *dev,			\
+static ssize_t set_servo##value (struct device *dev, struct device_attribute *attr,			\
 					const char *buf, size_t count)	\
 {									\
 	int degrees, minutes, retval;					\
@@ -233,7 +233,7 @@ static ssize_t set_servo##value (struct 
 	return retval < 0 ? retval : count;				\
 }									\
 									\
-static ssize_t show_servo##value (struct device *dev, char *buf) 	\
+static ssize_t show_servo##value (struct device *dev, struct device_attribute *attr, char *buf) 	\
 {									\
 	struct usb_interface *intf = to_usb_interface (dev);		\
 	struct phidget_servo *servo = usb_get_intfdata (intf);		\
diff --git a/drivers/usb/misc/usbled.c b/drivers/usb/misc/usbled.c
--- a/drivers/usb/misc/usbled.c
+++ b/drivers/usb/misc/usbled.c
@@ -81,14 +81,14 @@ static void change_color(struct usb_led 
 }
 
 #define show_set(value)	\
-static ssize_t show_##value(struct device *dev, char *buf)		\
+static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	struct usb_interface *intf = to_usb_interface(dev);		\
 	struct usb_led *led = usb_get_intfdata(intf);			\
 									\
 	return sprintf(buf, "%d\n", led->value);			\
 }									\
-static ssize_t set_##value(struct device *dev, const char *buf, size_t count)	\
+static ssize_t set_##value(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)	\
 {									\
 	struct usb_interface *intf = to_usb_interface(dev);		\
 	struct usb_led *led = usb_get_intfdata(intf);			\
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1218,7 +1218,7 @@ check_and_exit:
  * ***************************************************************************
  */
 
-static ssize_t show_latency_timer(struct device *dev, char *buf)
+static ssize_t show_latency_timer(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct usb_serial_port *port = to_usb_serial_port(dev);
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
@@ -1245,7 +1245,7 @@ static ssize_t show_latency_timer(struct
 }
 
 /* Write a new value of the latency timer, in units of milliseconds. */
-static ssize_t store_latency_timer(struct device *dev, const char *valbuf,
+static ssize_t store_latency_timer(struct device *dev, struct device_attribute *attr, const char *valbuf,
 				   size_t count)
 {
 	struct usb_serial_port *port = to_usb_serial_port(dev);
@@ -1276,7 +1276,7 @@ static ssize_t store_latency_timer(struc
 
 /* Write an event character directly to the FTDI register.  The ASCII
    value is in the low 8 bits, with the enable bit in the 9th bit. */
-static ssize_t store_event_char(struct device *dev, const char *valbuf,
+static ssize_t store_event_char(struct device *dev, struct device_attribute *attr, const char *valbuf,
 				size_t count)
 {
 	struct usb_serial_port *port = to_usb_serial_port(dev);
diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -398,7 +398,7 @@ US_DO_ALL_FLAGS
  ***********************************************************************/
 
 /* Output routine for the sysfs max_sectors file */
-static ssize_t show_max_sectors(struct device *dev, char *buf)
+static ssize_t show_max_sectors(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
 
@@ -406,7 +406,7 @@ static ssize_t show_max_sectors(struct d
 }
 
 /* Input routine for the sysfs max_sectors file */
-static ssize_t store_max_sectors(struct device *dev, const char *buf,
+static ssize_t store_max_sectors(struct device *dev, struct device_attribute *attr, const char *buf,
 		size_t count)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
diff --git a/drivers/video/gbefb.c b/drivers/video/gbefb.c
--- a/drivers/video/gbefb.c
+++ b/drivers/video/gbefb.c
@@ -1045,14 +1045,14 @@ static struct fb_ops gbefb_ops = {
  * sysfs
  */
 
-static ssize_t gbefb_show_memsize(struct device *dev, char *buf)
+static ssize_t gbefb_show_memsize(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return snprintf(buf, PAGE_SIZE, "%d\n", gbe_mem_size);
 }
 
 static DEVICE_ATTR(size, S_IRUGO, gbefb_show_memsize, NULL);
 
-static ssize_t gbefb_show_rev(struct device *device, char *buf)
+static ssize_t gbefb_show_rev(struct device *device, struct device_attribute *attr, char *buf)
 {
 	return snprintf(buf, PAGE_SIZE, "%d\n", gbe_revision);
 }
diff --git a/drivers/video/w100fb.c b/drivers/video/w100fb.c
--- a/drivers/video/w100fb.c
+++ b/drivers/video/w100fb.c
@@ -101,7 +101,7 @@ static void(*w100fb_ssp_send)(u8 adrs, u
  * Sysfs functions
  */
 
-static ssize_t rotation_show(struct device *dev, char *buf)
+static ssize_t rotation_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct w100fb_par *par=info->par;
@@ -109,7 +109,7 @@ static ssize_t rotation_show(struct devi
 	return sprintf(buf, "%d\n",par->rotation_flag);
 }
 
-static ssize_t rotation_store(struct device *dev, const char *buf, size_t count)
+static ssize_t rotation_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	unsigned int rotate;
 	struct fb_info *info = dev_get_drvdata(dev);
@@ -134,7 +134,7 @@ static ssize_t rotation_store(struct dev
 
 static DEVICE_ATTR(rotation, 0644, rotation_show, rotation_store);
 
-static ssize_t w100fb_reg_read(struct device *dev, const char *buf, size_t count)
+static ssize_t w100fb_reg_read(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	unsigned long param;
 	unsigned long regs;
@@ -146,7 +146,7 @@ static ssize_t w100fb_reg_read(struct de
 
 static DEVICE_ATTR(reg_read, 0200, NULL, w100fb_reg_read);
 
-static ssize_t w100fb_reg_write(struct device *dev, const char *buf, size_t count)
+static ssize_t w100fb_reg_write(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	unsigned long regs;
 	unsigned long param;
@@ -163,7 +163,7 @@ static ssize_t w100fb_reg_write(struct d
 static DEVICE_ATTR(reg_write, 0200, NULL, w100fb_reg_write);
 
 
-static ssize_t fastsysclk_show(struct device *dev, char *buf)
+static ssize_t fastsysclk_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct w100fb_par *par=info->par;
@@ -171,7 +171,7 @@ static ssize_t fastsysclk_show(struct de
 	return sprintf(buf, "%d\n",par->fastsysclk_mode);
 }
 
-static ssize_t fastsysclk_store(struct device *dev, const char *buf, size_t count)
+static ssize_t fastsysclk_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	int param;
 	struct fb_info *info = dev_get_drvdata(dev);
diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -88,7 +88,7 @@ static void w1_slave_release(struct devi
 	complete(&sl->dev_released);
 }
 
-static ssize_t w1_default_read_name(struct device *dev, char *buf)
+static ssize_t w1_default_read_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "No family registered.\n");
 }
@@ -137,7 +137,7 @@ static struct device_attribute w1_slave_
 	.show = &w1_default_read_name,
 };
 
-static ssize_t w1_master_attribute_show_name(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w1_master *md = container_of (dev, struct w1_master, dev);
 	ssize_t count;
@@ -152,7 +152,7 @@ static ssize_t w1_master_attribute_show_
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_pointer(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_pointer(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
@@ -166,14 +166,14 @@ static ssize_t w1_master_attribute_show_
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_timeout(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_timeout(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	ssize_t count;
 	count = sprintf(buf, "%d\n", w1_timeout);
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_max_slave_count(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_max_slave_count(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
@@ -187,7 +187,7 @@ static ssize_t w1_master_attribute_show_
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_attempts(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_attempts(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
@@ -201,7 +201,7 @@ static ssize_t w1_master_attribute_show_
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_slave_count(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_slave_count(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
@@ -215,7 +215,7 @@ static ssize_t w1_master_attribute_show_
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_slaves(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_slaves(struct device *dev, struct device_attribute *attr, char *buf)
 
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
diff --git a/drivers/w1/w1_family.h b/drivers/w1/w1_family.h
--- a/drivers/w1/w1_family.h
+++ b/drivers/w1/w1_family.h
@@ -34,10 +34,10 @@
 
 struct w1_family_ops
 {
-	ssize_t (* rname)(struct device *, char *);
+	ssize_t (* rname)(struct device *, struct device_attribute *, char *);
 	ssize_t (* rbin)(struct kobject *, char *, loff_t, size_t);
 	
-	ssize_t (* rval)(struct device *, char *);
+	ssize_t (* rval)(struct device *, struct device_attribute *, char *);
 	unsigned char rvalname[MAXNAMELEN];
 };
 
diff --git a/drivers/w1/w1_smem.c b/drivers/w1/w1_smem.c
--- a/drivers/w1/w1_smem.c
+++ b/drivers/w1/w1_smem.c
@@ -36,8 +36,8 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
 MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol, 64bit memory family.");
 
-static ssize_t w1_smem_read_name(struct device *, char *);
-static ssize_t w1_smem_read_val(struct device *, char *);
+static ssize_t w1_smem_read_name(struct device *, struct device_attribute *attr, char *);
+static ssize_t w1_smem_read_val(struct device *, struct device_attribute *attr, char *);
 static ssize_t w1_smem_read_bin(struct kobject *, char *, loff_t, size_t);
 
 static struct w1_family_ops w1_smem_fops = {
@@ -47,14 +47,14 @@ static struct w1_family_ops w1_smem_fops
 	.rvalname = "id",
 };
 
-static ssize_t w1_smem_read_name(struct device *dev, char *buf)
+static ssize_t w1_smem_read_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
 
 	return sprintf(buf, "%s\n", sl->name);
 }
 
-static ssize_t w1_smem_read_val(struct device *dev, char *buf)
+static ssize_t w1_smem_read_val(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
 	int i;
diff --git a/drivers/w1/w1_therm.c b/drivers/w1/w1_therm.c
--- a/drivers/w1/w1_therm.c
+++ b/drivers/w1/w1_therm.c
@@ -42,8 +42,8 @@ static u8 bad_roms[][9] = {
 				{}
 			};
 
-static ssize_t w1_therm_read_name(struct device *, char *);
-static ssize_t w1_therm_read_temp(struct device *, char *);
+static ssize_t w1_therm_read_name(struct device *, struct device_attribute *attr, char *);
+static ssize_t w1_therm_read_temp(struct device *, struct device_attribute *attr, char *);
 static ssize_t w1_therm_read_bin(struct kobject *, char *, loff_t, size_t);
 
 static struct w1_family_ops w1_therm_fops = {
@@ -53,7 +53,7 @@ static struct w1_family_ops w1_therm_fop
 	.rvalname = "temp1_input",
 };
 
-static ssize_t w1_therm_read_name(struct device *dev, char *buf)
+static ssize_t w1_therm_read_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
 
@@ -77,7 +77,7 @@ static inline int w1_convert_temp(u8 rom
 	return t;
 }
 
-static ssize_t w1_therm_read_temp(struct device *dev, char *buf)
+static ssize_t w1_therm_read_temp(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
 
diff --git a/drivers/zorro/zorro-sysfs.c b/drivers/zorro/zorro-sysfs.c
--- a/drivers/zorro/zorro-sysfs.c
+++ b/drivers/zorro/zorro-sysfs.c
@@ -21,7 +21,7 @@
 /* show configuration fields */
 #define zorro_config_attr(name, field, format_string)			\
 static ssize_t								\
-show_##name(struct device *dev, char *buf)				\
+show_##name(struct device *dev, struct device_attribute *attr, char *buf)				\
 {									\
 	struct zorro_dev *z;						\
 									\
@@ -36,7 +36,7 @@ zorro_config_attr(serial, rom.er_SerialN
 zorro_config_attr(slotaddr, slotaddr, "0x%04x\n");
 zorro_config_attr(slotsize, slotsize, "0x%04x\n");
 
-static ssize_t zorro_show_resource(struct device *dev, char *buf)
+static ssize_t zorro_show_resource(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct zorro_dev *z = to_zorro_dev(dev);
 

