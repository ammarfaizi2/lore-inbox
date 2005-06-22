Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262891AbVFVHhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262891AbVFVHhP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbVFVHfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:35:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:55707 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262767AbVFVFVt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:21:49 -0400
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: rename i2c-sysfs.h to hwmon-sysfs.h
In-Reply-To: <11194174671555@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:47 -0700
Message-Id: <1119417467761@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: rename i2c-sysfs.h to hwmon-sysfs.h

This patch renames the new linux/i2c-sysfs.h header file to
linux/hwmon-sysfs.h. This names seems to be more appropriate since this
file defines macros and structures not related to i2c but to hardware
monitoring drivers. The patch also updates the five hardware monitoring
driver which include that header file already.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 10c08f8100ee2c4d27b862635574cdf4ef439e67
tree 7055414032c3fd5fa066c6574804011132b69cb5
parent c3bc4caedd84ad03360cb9ec04b6c44ab314588b
author Jean Delvare <khali@linux-fr.org> Mon, 06 Jun 2005 19:34:45 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:52:05 -0700

 drivers/i2c/chips/adm1026.c |    2 +-
 drivers/i2c/chips/it87.c    |    2 +-
 drivers/i2c/chips/lm63.c    |    2 +-
 drivers/i2c/chips/lm83.c    |    2 +-
 drivers/i2c/chips/lm90.c    |    2 +-
 include/linux/hwmon-sysfs.h |   36 ++++++++++++++++++++++++++++++++++++
 include/linux/i2c-sysfs.h   |   36 ------------------------------------
 7 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/i2c/chips/adm1026.c b/drivers/i2c/chips/adm1026.c
--- a/drivers/i2c/chips/adm1026.c
+++ b/drivers/i2c/chips/adm1026.c
@@ -29,8 +29,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
-#include <linux/i2c-sysfs.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon-sysfs.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
diff --git a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c
+++ b/drivers/i2c/chips/it87.c
@@ -37,8 +37,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
-#include <linux/i2c-sysfs.h>
 #include <linux/i2c-vid.h>
+#include <linux/hwmon-sysfs.h>
 #include <asm/io.h>
 
 
diff --git a/drivers/i2c/chips/lm63.c b/drivers/i2c/chips/lm63.c
--- a/drivers/i2c/chips/lm63.c
+++ b/drivers/i2c/chips/lm63.c
@@ -43,7 +43,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
-#include <linux/i2c-sysfs.h>
+#include <linux/hwmon-sysfs.h>
 
 /*
  * Addresses to scan
diff --git a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c
+++ b/drivers/i2c/chips/lm83.c
@@ -33,7 +33,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
-#include <linux/i2c-sysfs.h>
+#include <linux/hwmon-sysfs.h>
 
 /*
  * Addresses to scan
diff --git a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c
+++ b/drivers/i2c/chips/lm90.c
@@ -76,7 +76,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
-#include <linux/i2c-sysfs.h>
+#include <linux/hwmon-sysfs.h>
 
 /*
  * Addresses to scan
diff --git a/include/linux/hwmon-sysfs.h b/include/linux/hwmon-sysfs.h
new file mode 100644
--- /dev/null
+++ b/include/linux/hwmon-sysfs.h
@@ -0,0 +1,36 @@
+/*
+ *  hwmon-sysfs.h - hardware monitoring chip driver sysfs defines
+ *
+ *  Copyright (C) 2005 Yani Ioannou <yani.ioannou@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#ifndef _LINUX_HWMON_SYSFS_H
+#define _LINUX_HWMON_SYSFS_H
+
+struct sensor_device_attribute{
+	struct device_attribute dev_attr;
+	int index;
+};
+#define to_sensor_dev_attr(_dev_attr) \
+	container_of(_dev_attr, struct sensor_device_attribute, dev_attr)
+
+#define SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)	\
+struct sensor_device_attribute sensor_dev_attr_##_name = {	\
+	.dev_attr =	__ATTR(_name,_mode,_show,_store),	\
+	.index =	_index,					\
+}
+
+#endif /* _LINUX_HWMON_SYSFS_H */
diff --git a/include/linux/i2c-sysfs.h b/include/linux/i2c-sysfs.h
deleted file mode 100644
--- a/include/linux/i2c-sysfs.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- *  i2c-sysfs.h - i2c chip driver sysfs defines
- *
- *  Copyright (C) 2005 Yani Ioannou <yani.ioannou@gmail.com>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#ifndef _LINUX_I2C_SYSFS_H
-#define _LINUX_I2C_SYSFS_H
-
-struct sensor_device_attribute{
-	struct device_attribute dev_attr;
-	int index;
-};
-#define to_sensor_dev_attr(_dev_attr) \
-	container_of(_dev_attr, struct sensor_device_attribute, dev_attr)
-
-#define SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)	\
-struct sensor_device_attribute sensor_dev_attr_##_name = {	\
-	.dev_attr =	__ATTR(_name,_mode,_show,_store),	\
-	.index =	_index,					\
-}
-
-#endif /* _LINUX_I2C_SYSFS_H */

