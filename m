Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVFTXlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVFTXlY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 19:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVFTXi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 19:38:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:64228 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261794AbVFTXAO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:00:14 -0400
Cc: yani.ioannou@gmail.com
Subject: [PATCH] Driver Core: drivers/i2c/chips/adm1031.c - lm75.c: update device attribute callbacks
In-Reply-To: <11193083681775@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:28 -0700
Message-Id: <11193083682037@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver Core: drivers/i2c/chips/adm1031.c - lm75.c: update device attribute callbacks

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 30f74292e50d6c4ae438dbee5cb45d77bf774351
tree 4bfa1b6715ecd597e196a9f448c825ef0c12d8e3
parent 74880c063b06efd103c924abfe19d9d8fa4864c4
author Yani Ioannou <yani.ioannou@gmail.com> Tue, 17 May 2005 06:41:35 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:33 -0700

 drivers/i2c/chips/adm1031.c |   44 +++++++++++++++++++-------------------
 drivers/i2c/chips/asb100.c  |   46 ++++++++++++++++++++--------------------
 drivers/i2c/chips/ds1621.c  |    6 +++--
 drivers/i2c/chips/fscher.c  |    8 +++----
 drivers/i2c/chips/fscpos.c  |   16 +++++++-------
 drivers/i2c/chips/gl518sm.c |   12 +++++-----
 drivers/i2c/chips/gl520sm.c |    8 +++----
 drivers/i2c/chips/it87.c    |   50 ++++++++++++++++++++++---------------------
 drivers/i2c/chips/lm63.c    |   24 ++++++++++-----------
 drivers/i2c/chips/lm75.c    |    4 ++-
 10 files changed, 109 insertions(+), 109 deletions(-)

diff --git a/drivers/i2c/chips/adm1031.c b/drivers/i2c/chips/adm1031.c
--- a/drivers/i2c/chips/adm1031.c
+++ b/drivers/i2c/chips/adm1031.c
@@ -292,11 +292,11 @@ set_fan_auto_channel(struct device *dev,
 }
 
 #define fan_auto_channel_offset(offset)						\
-static ssize_t show_fan_auto_channel_##offset (struct device *dev, char *buf)	\
+static ssize_t show_fan_auto_channel_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
 {										\
 	return show_fan_auto_channel(dev, buf, offset - 1);			\
 }										\
-static ssize_t set_fan_auto_channel_##offset (struct device *dev,		\
+static ssize_t set_fan_auto_channel_##offset (struct device *dev, struct device_attribute *attr,		\
 	const char *buf, size_t count)						\
 {										\
 	return set_fan_auto_channel(dev, buf, count, offset - 1);		\
@@ -357,24 +357,24 @@ set_auto_temp_max(struct device *dev, co
 }
 
 #define auto_temp_reg(offset)							\
-static ssize_t show_auto_temp_##offset##_off (struct device *dev, char *buf)	\
+static ssize_t show_auto_temp_##offset##_off (struct device *dev, struct device_attribute *attr, char *buf)	\
 {										\
 	return show_auto_temp_off(dev, buf, offset - 1);			\
 }										\
-static ssize_t show_auto_temp_##offset##_min (struct device *dev, char *buf)	\
+static ssize_t show_auto_temp_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)	\
 {										\
 	return show_auto_temp_min(dev, buf, offset - 1);			\
 }										\
-static ssize_t show_auto_temp_##offset##_max (struct device *dev, char *buf)	\
+static ssize_t show_auto_temp_##offset##_max (struct device *dev, struct device_attribute *attr, char *buf)	\
 {										\
 	return show_auto_temp_max(dev, buf, offset - 1);			\
 }										\
-static ssize_t set_auto_temp_##offset##_min (struct device *dev,		\
+static ssize_t set_auto_temp_##offset##_min (struct device *dev, struct device_attribute *attr,		\
 					     const char *buf, size_t count)	\
 {										\
 	return set_auto_temp_min(dev, buf, count, offset - 1);		\
 }										\
-static ssize_t set_auto_temp_##offset##_max (struct device *dev,		\
+static ssize_t set_auto_temp_##offset##_max (struct device *dev, struct device_attribute *attr,		\
 					     const char *buf, size_t count)	\
 {										\
 	return set_auto_temp_max(dev, buf, count, offset - 1);		\
@@ -421,11 +421,11 @@ set_pwm(struct device *dev, const char *
 }
 
 #define pwm_reg(offset)							\
-static ssize_t show_pwm_##offset (struct device *dev, char *buf)	\
+static ssize_t show_pwm_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	return show_pwm(dev, buf, offset - 1);			\
 }									\
-static ssize_t set_pwm_##offset (struct device *dev,			\
+static ssize_t set_pwm_##offset (struct device *dev, struct device_attribute *attr,			\
 				 const char *buf, size_t count)		\
 {									\
 	return set_pwm(dev, buf, count, offset - 1);		\
@@ -557,24 +557,24 @@ set_fan_div(struct device *dev, const ch
 }
 
 #define fan_offset(offset)						\
-static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	return show_fan(dev, buf, offset - 1);			\
 }									\
-static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	return show_fan_min(dev, buf, offset - 1);			\
 }									\
-static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset##_div (struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	return show_fan_div(dev, buf, offset - 1);			\
 }									\
-static ssize_t set_fan_##offset##_min (struct device *dev,		\
+static ssize_t set_fan_##offset##_min (struct device *dev, struct device_attribute *attr,		\
 	const char *buf, size_t count)					\
 {									\
 	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
-static ssize_t set_fan_##offset##_div (struct device *dev,		\
+static ssize_t set_fan_##offset##_div (struct device *dev, struct device_attribute *attr,		\
 	const char *buf, size_t count)					\
 {									\
 	return set_fan_div(dev, buf, count, offset - 1);		\
@@ -667,33 +667,33 @@ set_temp_crit(struct device *dev, const 
 }
 
 #define temp_reg(offset)							\
-static ssize_t show_temp_##offset (struct device *dev, char *buf)		\
+static ssize_t show_temp_##offset (struct device *dev, struct device_attribute *attr, char *buf)		\
 {										\
 	return show_temp(dev, buf, offset - 1);				\
 }										\
-static ssize_t show_temp_##offset##_min (struct device *dev, char *buf)		\
+static ssize_t show_temp_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)		\
 {										\
 	return show_temp_min(dev, buf, offset - 1);				\
 }										\
-static ssize_t show_temp_##offset##_max (struct device *dev, char *buf)		\
+static ssize_t show_temp_##offset##_max (struct device *dev, struct device_attribute *attr, char *buf)		\
 {										\
 	return show_temp_max(dev, buf, offset - 1);				\
 }										\
-static ssize_t show_temp_##offset##_crit (struct device *dev, char *buf)	\
+static ssize_t show_temp_##offset##_crit (struct device *dev, struct device_attribute *attr, char *buf)	\
 {										\
 	return show_temp_crit(dev, buf, offset - 1);			\
 }										\
-static ssize_t set_temp_##offset##_min (struct device *dev,			\
+static ssize_t set_temp_##offset##_min (struct device *dev, struct device_attribute *attr,			\
 					const char *buf, size_t count)		\
 {										\
 	return set_temp_min(dev, buf, count, offset - 1);			\
 }										\
-static ssize_t set_temp_##offset##_max (struct device *dev,			\
+static ssize_t set_temp_##offset##_max (struct device *dev, struct device_attribute *attr,			\
 					const char *buf, size_t count)		\
 {										\
 	return set_temp_max(dev, buf, count, offset - 1);			\
 }										\
-static ssize_t set_temp_##offset##_crit (struct device *dev,			\
+static ssize_t set_temp_##offset##_crit (struct device *dev, struct device_attribute *attr,			\
 					 const char *buf, size_t count)		\
 {										\
 	return set_temp_crit(dev, buf, count, offset - 1);			\
@@ -712,7 +712,7 @@ temp_reg(2);
 temp_reg(3);
 
 /* Alarms */
-static ssize_t show_alarms(struct device *dev, char *buf)
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1031_data *data = adm1031_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarm);
diff --git a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c
+++ b/drivers/i2c/chips/asb100.c
@@ -260,28 +260,28 @@ set_in_reg(MAX, max)
 
 #define sysfs_in(offset) \
 static ssize_t \
-	show_in##offset (struct device *dev, char *buf) \
+	show_in##offset (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_in(dev, buf, offset); \
 } \
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, \
 		show_in##offset, NULL); \
 static ssize_t \
-	show_in##offset##_min (struct device *dev, char *buf) \
+	show_in##offset##_min (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_in_min(dev, buf, offset); \
 } \
 static ssize_t \
-	show_in##offset##_max (struct device *dev, char *buf) \
+	show_in##offset##_max (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_in_max(dev, buf, offset); \
 } \
-static ssize_t set_in##offset##_min (struct device *dev, \
+static ssize_t set_in##offset##_min (struct device *dev, struct device_attribute *attr, \
 		const char *buf, size_t count) \
 { \
 	return set_in_min(dev, buf, count, offset); \
 } \
-static ssize_t set_in##offset##_max (struct device *dev, \
+static ssize_t set_in##offset##_max (struct device *dev, struct device_attribute *attr, \
 		const char *buf, size_t count) \
 { \
 	return set_in_max(dev, buf, count, offset); \
@@ -389,24 +389,24 @@ static ssize_t set_fan_div(struct device
 }
 
 #define sysfs_fan(offset) \
-static ssize_t show_fan##offset(struct device *dev, char *buf) \
+static ssize_t show_fan##offset(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_fan(dev, buf, offset - 1); \
 } \
-static ssize_t show_fan##offset##_min(struct device *dev, char *buf) \
+static ssize_t show_fan##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_fan_min(dev, buf, offset - 1); \
 } \
-static ssize_t show_fan##offset##_div(struct device *dev, char *buf) \
+static ssize_t show_fan##offset##_div(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_fan_div(dev, buf, offset - 1); \
 } \
-static ssize_t set_fan##offset##_min(struct device *dev, const char *buf, \
+static ssize_t set_fan##offset##_min(struct device *dev, struct device_attribute *attr, const char *buf, \
 					size_t count) \
 { \
 	return set_fan_min(dev, buf, count, offset - 1); \
 } \
-static ssize_t set_fan##offset##_div(struct device *dev, const char *buf, \
+static ssize_t set_fan##offset##_div(struct device *dev, struct device_attribute *attr, const char *buf, \
 					size_t count) \
 { \
 	return set_fan_div(dev, buf, count, offset - 1); \
@@ -482,27 +482,27 @@ set_temp_reg(MAX, temp_max);
 set_temp_reg(HYST, temp_hyst);
 
 #define sysfs_temp(num) \
-static ssize_t show_temp##num(struct device *dev, char *buf) \
+static ssize_t show_temp##num(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_temp(dev, buf, num-1); \
 } \
 static DEVICE_ATTR(temp##num##_input, S_IRUGO, show_temp##num, NULL); \
-static ssize_t show_temp_max##num(struct device *dev, char *buf) \
+static ssize_t show_temp_max##num(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_temp_max(dev, buf, num-1); \
 } \
-static ssize_t set_temp_max##num(struct device *dev, const char *buf, \
+static ssize_t set_temp_max##num(struct device *dev, struct device_attribute *attr, const char *buf, \
 					size_t count) \
 { \
 	return set_temp_max(dev, buf, count, num-1); \
 } \
 static DEVICE_ATTR(temp##num##_max, S_IRUGO | S_IWUSR, \
 		show_temp_max##num, set_temp_max##num); \
-static ssize_t show_temp_hyst##num(struct device *dev, char *buf) \
+static ssize_t show_temp_hyst##num(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	return show_temp_hyst(dev, buf, num-1); \
 } \
-static ssize_t set_temp_hyst##num(struct device *dev, const char *buf, \
+static ssize_t set_temp_hyst##num(struct device *dev, struct device_attribute *attr, const char *buf, \
 					size_t count) \
 { \
 	return set_temp_hyst(dev, buf, count, num-1); \
@@ -522,7 +522,7 @@ sysfs_temp(4);
 	device_create_file(&client->dev, &dev_attr_temp##num##_max_hyst); \
 } while (0)
 
-static ssize_t show_vid(struct device *dev, char *buf)
+static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct asb100_data *data = asb100_update_device(dev);
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
@@ -533,13 +533,13 @@ static DEVICE_ATTR(cpu0_vid, S_IRUGO, sh
 device_create_file(&client->dev, &dev_attr_cpu0_vid)
 
 /* VRM */
-static ssize_t show_vrm(struct device *dev, char *buf)
+static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct asb100_data *data = asb100_update_device(dev);
 	return sprintf(buf, "%d\n", data->vrm);
 }
 
-static ssize_t set_vrm(struct device *dev, const char *buf, size_t count)
+static ssize_t set_vrm(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
@@ -553,7 +553,7 @@ static DEVICE_ATTR(vrm, S_IRUGO | S_IWUS
 #define device_create_file_vrm(client) \
 device_create_file(&client->dev, &dev_attr_vrm);
 
-static ssize_t show_alarms(struct device *dev, char *buf)
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct asb100_data *data = asb100_update_device(dev);
 	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->alarms));
@@ -564,13 +564,13 @@ static DEVICE_ATTR(alarms, S_IRUGO, show
 device_create_file(&client->dev, &dev_attr_alarms)
 
 /* 1 PWM */
-static ssize_t show_pwm1(struct device *dev, char *buf)
+static ssize_t show_pwm1(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct asb100_data *data = asb100_update_device(dev);
 	return sprintf(buf, "%d\n", ASB100_PWM_FROM_REG(data->pwm & 0x0f));
 }
 
-static ssize_t set_pwm1(struct device *dev, const char *buf, size_t count)
+static ssize_t set_pwm1(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
@@ -584,13 +584,13 @@ static ssize_t set_pwm1(struct device *d
 	return count;
 }
 
-static ssize_t show_pwm_enable1(struct device *dev, char *buf)
+static ssize_t show_pwm_enable1(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct asb100_data *data = asb100_update_device(dev);
 	return sprintf(buf, "%d\n", (data->pwm & 0x80) ? 1 : 0);
 }
 
-static ssize_t set_pwm_enable1(struct device *dev, const char *buf,
+static ssize_t set_pwm_enable1(struct device *dev, struct device_attribute *attr, const char *buf,
 				size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
diff --git a/drivers/i2c/chips/ds1621.c b/drivers/i2c/chips/ds1621.c
--- a/drivers/i2c/chips/ds1621.c
+++ b/drivers/i2c/chips/ds1621.c
@@ -137,7 +137,7 @@ static void ds1621_init_client(struct i2
 }
 
 #define show(value)							\
-static ssize_t show_##value(struct device *dev, char *buf)		\
+static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	struct ds1621_data *data = ds1621_update_client(dev);		\
 	return sprintf(buf, "%d\n", LM75_TEMP_FROM_REG(data->value));	\
@@ -148,7 +148,7 @@ show(temp_min);
 show(temp_max);
 
 #define set_temp(suffix, value, reg)					\
-static ssize_t set_temp_##suffix(struct device *dev, const char *buf,	\
+static ssize_t set_temp_##suffix(struct device *dev, struct device_attribute *attr, const char *buf,	\
 				 size_t count)				\
 {									\
 	struct i2c_client *client = to_i2c_client(dev);			\
@@ -165,7 +165,7 @@ static ssize_t set_temp_##suffix(struct 
 set_temp(min, temp_min, DS1621_REG_TEMP_MIN);
 set_temp(max, temp_max, DS1621_REG_TEMP_MAX);
 
-static ssize_t show_alarms(struct device *dev, char *buf)
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct ds1621_data *data = ds1621_update_client(dev);
 	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->conf));
diff --git a/drivers/i2c/chips/fscher.c b/drivers/i2c/chips/fscher.c
--- a/drivers/i2c/chips/fscher.c
+++ b/drivers/i2c/chips/fscher.c
@@ -157,8 +157,8 @@ struct fscher_data {
 
 #define sysfs_r(kind, sub, offset, reg) \
 static ssize_t show_##kind##sub (struct fscher_data *, char *, int); \
-static ssize_t show_##kind##offset##sub (struct device *, char *); \
-static ssize_t show_##kind##offset##sub (struct device *dev, char *buf) \
+static ssize_t show_##kind##offset##sub (struct device *, struct device_attribute *attr, char *); \
+static ssize_t show_##kind##offset##sub (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct fscher_data *data = fscher_update_device(dev); \
 	return show_##kind##sub(data, buf, (offset)); \
@@ -166,8 +166,8 @@ static ssize_t show_##kind##offset##sub 
 
 #define sysfs_w(kind, sub, offset, reg) \
 static ssize_t set_##kind##sub (struct i2c_client *, struct fscher_data *, const char *, size_t, int, int); \
-static ssize_t set_##kind##offset##sub (struct device *, const char *, size_t); \
-static ssize_t set_##kind##offset##sub (struct device *dev, const char *buf, size_t count) \
+static ssize_t set_##kind##offset##sub (struct device *, struct device_attribute *attr, const char *, size_t); \
+static ssize_t set_##kind##offset##sub (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct fscher_data *data = i2c_get_clientdata(client); \
diff --git a/drivers/i2c/chips/fscpos.c b/drivers/i2c/chips/fscpos.c
--- a/drivers/i2c/chips/fscpos.c
+++ b/drivers/i2c/chips/fscpos.c
@@ -245,19 +245,19 @@ static void reset_fan_alarm(struct i2c_c
 /* Volts */
 #define VOLT_FROM_REG(val, mult)	((val) * (mult) / 255)
 
-static ssize_t show_volt_12(struct device *dev, char *buf)
+static ssize_t show_volt_12(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct fscpos_data *data = fscpos_update_device(dev);
 	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[0], 14200));
 }
 
-static ssize_t show_volt_5(struct device *dev, char *buf)
+static ssize_t show_volt_5(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct fscpos_data *data = fscpos_update_device(dev);
 	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[1], 6600));
 }
 
-static ssize_t show_volt_batt(struct device *dev, char *buf)
+static ssize_t show_volt_batt(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct fscpos_data *data = fscpos_update_device(dev);
 	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[2], 3300));
@@ -327,7 +327,7 @@ static ssize_t set_wdog_preset(struct i2
 }
 
 /* Event */
-static ssize_t show_event(struct device *dev, char *buf)
+static ssize_t show_event(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	/* bits 5..7 reserved => mask with 0x1f */
 	struct fscpos_data *data = fscpos_update_device(dev);
@@ -338,14 +338,14 @@ static ssize_t show_event(struct device 
  * Sysfs stuff
  */
 #define create_getter(kind, sub) \
-	static ssize_t sysfs_show_##kind##sub(struct device *dev, char *buf) \
+	static ssize_t sysfs_show_##kind##sub(struct device *dev, struct device_attribute *attr, char *buf) \
 	{ \
 		struct fscpos_data *data = fscpos_update_device(dev); \
 		return show_##kind##sub(data, buf); \
 	}
 
 #define create_getter_n(kind, offset, sub) \
-	static ssize_t sysfs_show_##kind##offset##sub(struct device *dev, char\
+	static ssize_t sysfs_show_##kind##offset##sub(struct device *dev, struct device_attribute *attr, char\
 								 	*buf) \
 	{ \
 		struct fscpos_data *data = fscpos_update_device(dev); \
@@ -353,7 +353,7 @@ static ssize_t show_event(struct device 
 	}
 
 #define create_setter(kind, sub, reg) \
-	static ssize_t sysfs_set_##kind##sub (struct device *dev, const char \
+	static ssize_t sysfs_set_##kind##sub (struct device *dev, struct device_attribute *attr, const char \
 							*buf, size_t count) \
 	{ \
 		struct i2c_client *client = to_i2c_client(dev); \
@@ -362,7 +362,7 @@ static ssize_t show_event(struct device 
 	}
 
 #define create_setter_n(kind, offset, sub, reg) \
-	static ssize_t sysfs_set_##kind##offset##sub (struct device *dev, \
+	static ssize_t sysfs_set_##kind##offset##sub (struct device *dev, struct device_attribute *attr, \
 					const char *buf, size_t count) \
 	{ \
 		struct i2c_client *client = to_i2c_client(dev); \
diff --git a/drivers/i2c/chips/gl518sm.c b/drivers/i2c/chips/gl518sm.c
--- a/drivers/i2c/chips/gl518sm.c
+++ b/drivers/i2c/chips/gl518sm.c
@@ -164,14 +164,14 @@ static struct i2c_driver gl518_driver = 
  */
 
 #define show(type, suffix, value)					\
-static ssize_t show_##suffix(struct device *dev, char *buf)		\
+static ssize_t show_##suffix(struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	struct gl518_data *data = gl518_update_device(dev);		\
 	return sprintf(buf, "%d\n", type##_FROM_REG(data->value));	\
 }
 
 #define show_fan(suffix, value, index)					\
-static ssize_t show_##suffix(struct device *dev, char *buf)		\
+static ssize_t show_##suffix(struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	struct gl518_data *data = gl518_update_device(dev);		\
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->value[index],	\
@@ -205,7 +205,7 @@ show(BOOL, beep_enable, beep_enable);
 show(BEEP_MASK, beep_mask, beep_mask);
 
 #define set(type, suffix, value, reg)					\
-static ssize_t set_##suffix(struct device *dev, const char *buf,	\
+static ssize_t set_##suffix(struct device *dev, struct device_attribute *attr, const char *buf,	\
 	size_t count)							\
 {									\
 	struct i2c_client *client = to_i2c_client(dev);			\
@@ -220,7 +220,7 @@ static ssize_t set_##suffix(struct devic
 }
 
 #define set_bits(type, suffix, value, reg, mask, shift)			\
-static ssize_t set_##suffix(struct device *dev, const char *buf,	\
+static ssize_t set_##suffix(struct device *dev, struct device_attribute *attr, const char *buf,	\
 	size_t count)							\
 {									\
 	struct i2c_client *client = to_i2c_client(dev);			\
@@ -258,7 +258,7 @@ set_high(IN, in_max3, voltage_max[3], GL
 set_bits(BOOL, beep_enable, beep_enable, GL518_REG_CONF, 0x04, 2);
 set(BEEP_MASK, beep_mask, beep_mask, GL518_REG_ALARM);
 
-static ssize_t set_fan_min1(struct device *dev, const char *buf, size_t count)
+static ssize_t set_fan_min1(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct gl518_data *data = i2c_get_clientdata(client);
@@ -284,7 +284,7 @@ static ssize_t set_fan_min1(struct devic
 	return count;
 }
 
-static ssize_t set_fan_min2(struct device *dev, const char *buf, size_t count)
+static ssize_t set_fan_min2(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct gl518_data *data = i2c_get_clientdata(client);
diff --git a/drivers/i2c/chips/gl520sm.c b/drivers/i2c/chips/gl520sm.c
--- a/drivers/i2c/chips/gl520sm.c
+++ b/drivers/i2c/chips/gl520sm.c
@@ -148,8 +148,8 @@ struct gl520_data {
 
 #define sysfs_r(type, n, item, reg) \
 static ssize_t get_##type##item (struct gl520_data *, char *, int); \
-static ssize_t get_##type##n##item (struct device *, char *); \
-static ssize_t get_##type##n##item (struct device *dev, char *buf) \
+static ssize_t get_##type##n##item (struct device *, struct device_attribute *attr, char *); \
+static ssize_t get_##type##n##item (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct gl520_data *data = gl520_update_device(dev); \
 	return get_##type##item(data, buf, (n)); \
@@ -157,8 +157,8 @@ static ssize_t get_##type##n##item (stru
 
 #define sysfs_w(type, n, item, reg) \
 static ssize_t set_##type##item (struct i2c_client *, struct gl520_data *, const char *, size_t, int, int); \
-static ssize_t set_##type##n##item (struct device *, const char *, size_t); \
-static ssize_t set_##type##n##item (struct device *dev, const char *buf, size_t count) \
+static ssize_t set_##type##n##item (struct device *, struct device_attribute *attr, const char *, size_t); \
+static ssize_t set_##type##n##item (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct gl520_data *data = i2c_get_clientdata(client); \
diff --git a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c
+++ b/drivers/i2c/chips/it87.c
@@ -290,7 +290,7 @@ static ssize_t set_in_max(struct device 
 
 #define show_in_offset(offset)					\
 static ssize_t							\
-	show_in##offset (struct device *dev, char *buf)		\
+	show_in##offset (struct device *dev, struct device_attribute *attr, char *buf)		\
 {								\
 	return show_in(dev, buf, offset);			\
 }								\
@@ -298,21 +298,21 @@ static DEVICE_ATTR(in##offset##_input, S
 
 #define limit_in_offset(offset)					\
 static ssize_t							\
-	show_in##offset##_min (struct device *dev, char *buf)	\
+	show_in##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)	\
 {								\
 	return show_in_min(dev, buf, offset);			\
 }								\
 static ssize_t							\
-	show_in##offset##_max (struct device *dev, char *buf)	\
+	show_in##offset##_max (struct device *dev, struct device_attribute *attr, char *buf)	\
 {								\
 	return show_in_max(dev, buf, offset);			\
 }								\
-static ssize_t set_in##offset##_min (struct device *dev, 	\
+static ssize_t set_in##offset##_min (struct device *dev, struct device_attribute *attr, 	\
 		const char *buf, size_t count) 			\
 {								\
 	return set_in_min(dev, buf, count, offset);		\
 }								\
-static ssize_t set_in##offset##_max (struct device *dev,	\
+static ssize_t set_in##offset##_max (struct device *dev, struct device_attribute *attr,	\
 			const char *buf, size_t count)		\
 {								\
 	return set_in_max(dev, buf, count, offset);		\
@@ -383,26 +383,26 @@ static ssize_t set_temp_min(struct devic
 	return count;
 }
 #define show_temp_offset(offset)					\
-static ssize_t show_temp_##offset (struct device *dev, char *buf)	\
+static ssize_t show_temp_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	return show_temp(dev, buf, offset - 1);				\
 }									\
 static ssize_t								\
-show_temp_##offset##_max (struct device *dev, char *buf)		\
+show_temp_##offset##_max (struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	return show_temp_max(dev, buf, offset - 1);			\
 }									\
 static ssize_t								\
-show_temp_##offset##_min (struct device *dev, char *buf)		\
+show_temp_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	return show_temp_min(dev, buf, offset - 1);			\
 }									\
-static ssize_t set_temp_##offset##_max (struct device *dev, 		\
+static ssize_t set_temp_##offset##_max (struct device *dev, struct device_attribute *attr, 		\
 		const char *buf, size_t count) 				\
 {									\
 	return set_temp_max(dev, buf, count, offset - 1);		\
 }									\
-static ssize_t set_temp_##offset##_min (struct device *dev, 		\
+static ssize_t set_temp_##offset##_min (struct device *dev, struct device_attribute *attr, 		\
 		const char *buf, size_t count) 				\
 {									\
 	return set_temp_min(dev, buf, count, offset - 1);		\
@@ -453,11 +453,11 @@ static ssize_t set_sensor(struct device 
 	return count;
 }
 #define show_sensor_offset(offset)					\
-static ssize_t show_sensor_##offset (struct device *dev, char *buf)	\
+static ssize_t show_sensor_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	return show_sensor(dev, buf, offset - 1);			\
 }									\
-static ssize_t set_sensor_##offset (struct device *dev, 		\
+static ssize_t set_sensor_##offset (struct device *dev, struct device_attribute *attr, 		\
 		const char *buf, size_t count) 				\
 {									\
 	return set_sensor(dev, buf, count, offset - 1);			\
@@ -600,24 +600,24 @@ static ssize_t set_pwm(struct device *de
 }
 
 #define show_fan_offset(offset)						\
-static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	return show_fan(dev, buf, offset - 1);				\
 }									\
-static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	return show_fan_min(dev, buf, offset - 1);			\
 }									\
-static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)	\
+static ssize_t show_fan_##offset##_div (struct device *dev, struct device_attribute *attr, char *buf)	\
 {									\
 	return show_fan_div(dev, buf, offset - 1);			\
 }									\
-static ssize_t set_fan_##offset##_min (struct device *dev, 		\
+static ssize_t set_fan_##offset##_min (struct device *dev, struct device_attribute *attr, 		\
 	const char *buf, size_t count) 					\
 {									\
 	return set_fan_min(dev, buf, count, offset - 1);		\
 }									\
-static ssize_t set_fan_##offset##_div (struct device *dev, 		\
+static ssize_t set_fan_##offset##_div (struct device *dev, struct device_attribute *attr, 		\
 		const char *buf, size_t count) 				\
 {									\
 	return set_fan_div(dev, buf, count, offset - 1);		\
@@ -633,21 +633,21 @@ show_fan_offset(2);
 show_fan_offset(3);
 
 #define show_pwm_offset(offset)						\
-static ssize_t show_pwm##offset##_enable (struct device *dev,		\
+static ssize_t show_pwm##offset##_enable (struct device *dev, struct device_attribute *attr,		\
 	char *buf)							\
 {									\
 	return show_pwm_enable(dev, buf, offset - 1);			\
 }									\
-static ssize_t show_pwm##offset (struct device *dev, char *buf)		\
+static ssize_t show_pwm##offset (struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	return show_pwm(dev, buf, offset - 1);				\
 }									\
-static ssize_t set_pwm##offset##_enable (struct device *dev,		\
+static ssize_t set_pwm##offset##_enable (struct device *dev, struct device_attribute *attr,		\
 		const char *buf, size_t count)				\
 {									\
 	return set_pwm_enable(dev, buf, count, offset - 1);		\
 }									\
-static ssize_t set_pwm##offset (struct device *dev,			\
+static ssize_t set_pwm##offset (struct device *dev, struct device_attribute *attr,			\
 		const char *buf, size_t count)				\
 {									\
 	return set_pwm(dev, buf, count, offset - 1);			\
@@ -663,7 +663,7 @@ show_pwm_offset(2);
 show_pwm_offset(3);
 
 /* Alarms */
-static ssize_t show_alarms(struct device *dev, char *buf)
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf,"%d\n", ALARMS_FROM_REG(data->alarms));
@@ -671,13 +671,13 @@ static ssize_t show_alarms(struct device
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 static ssize_t
-show_vrm_reg(struct device *dev, char *buf)
+show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) data->vrm);
 }
 static ssize_t
-store_vrm_reg(struct device *dev, const char *buf, size_t count)
+store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
@@ -693,7 +693,7 @@ static DEVICE_ATTR(vrm, S_IRUGO | S_IWUS
 device_create_file(&client->dev, &dev_attr_vrm)
 
 static ssize_t
-show_vid_reg(struct device *dev, char *buf)
+show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
diff --git a/drivers/i2c/chips/lm63.c b/drivers/i2c/chips/lm63.c
--- a/drivers/i2c/chips/lm63.c
+++ b/drivers/i2c/chips/lm63.c
@@ -177,7 +177,7 @@ struct lm63_data {
  */
 
 #define show_fan(value) \
-static ssize_t show_##value(struct device *dev, char *buf) \
+static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct lm63_data *data = lm63_update_device(dev); \
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->value)); \
@@ -185,7 +185,7 @@ static ssize_t show_##value(struct devic
 show_fan(fan1_input);
 show_fan(fan1_low);
 
-static ssize_t set_fan1_low(struct device *dev, const char *buf,
+static ssize_t set_fan1_low(struct device *dev, struct device_attribute *attr, const char *buf,
 	size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -202,7 +202,7 @@ static ssize_t set_fan1_low(struct devic
 	return count;
 }
 
-static ssize_t show_pwm1(struct device *dev, char *buf)
+static ssize_t show_pwm1(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct lm63_data *data = lm63_update_device(dev);
 	return sprintf(buf, "%d\n", data->pwm1_value >= 2 * data->pwm1_freq ?
@@ -210,7 +210,7 @@ static ssize_t show_pwm1(struct device *
 		       (2 * data->pwm1_freq));
 }
 
-static ssize_t set_pwm1(struct device *dev, const char *buf, size_t count)
+static ssize_t set_pwm1(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm63_data *data = i2c_get_clientdata(client);
@@ -229,20 +229,20 @@ static ssize_t set_pwm1(struct device *d
 	return count;
 }
 
-static ssize_t show_pwm1_enable(struct device *dev, char *buf)
+static ssize_t show_pwm1_enable(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct lm63_data *data = lm63_update_device(dev);
 	return sprintf(buf, "%d\n", data->config_fan & 0x20 ? 1 : 2);
 }
 
 #define show_temp8(value) \
-static ssize_t show_##value(struct device *dev, char *buf) \
+static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct lm63_data *data = lm63_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP8_FROM_REG(data->value)); \
 }
 #define show_temp11(value) \
-static ssize_t show_##value(struct device *dev, char *buf) \
+static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
 	struct lm63_data *data = lm63_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP11_FROM_REG(data->value)); \
@@ -255,7 +255,7 @@ show_temp11(temp2_low);
 show_temp8(temp2_crit);
 
 #define set_temp8(value, reg) \
-static ssize_t set_##value(struct device *dev, const char *buf, \
+static ssize_t set_##value(struct device *dev, struct device_attribute *attr, const char *buf, \
 	size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
@@ -269,7 +269,7 @@ static ssize_t set_##value(struct device
 	return count; \
 }
 #define set_temp11(value, reg_msb, reg_lsb) \
-static ssize_t set_##value(struct device *dev, const char *buf, \
+static ssize_t set_##value(struct device *dev, struct device_attribute *attr, const char *buf, \
 	size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
@@ -289,7 +289,7 @@ set_temp11(temp2_low, LM63_REG_REMOTE_LO
 
 /* Hysteresis register holds a relative value, while we want to present
    an absolute to user-space */
-static ssize_t show_temp2_crit_hyst(struct device *dev, char *buf)
+static ssize_t show_temp2_crit_hyst(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct lm63_data *data = lm63_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP8_FROM_REG(data->temp2_crit)
@@ -298,7 +298,7 @@ static ssize_t show_temp2_crit_hyst(stru
 
 /* And now the other way around, user-space provides an absolute
    hysteresis value and we have to store a relative one */
-static ssize_t set_temp2_crit_hyst(struct device *dev, const char *buf,
+static ssize_t set_temp2_crit_hyst(struct device *dev, struct device_attribute *attr, const char *buf,
 	size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -314,7 +314,7 @@ static ssize_t set_temp2_crit_hyst(struc
 	return count;
 }
 
-static ssize_t show_alarms(struct device *dev, char *buf)
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct lm63_data *data = lm63_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
diff --git a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c
+++ b/drivers/i2c/chips/lm75.c
@@ -75,7 +75,7 @@ static struct i2c_driver lm75_driver = {
 };
 
 #define show(value)	\
-static ssize_t show_##value(struct device *dev, char *buf)		\
+static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf)		\
 {									\
 	struct lm75_data *data = lm75_update_device(dev);		\
 	return sprintf(buf, "%d\n", LM75_TEMP_FROM_REG(data->value));	\
@@ -85,7 +85,7 @@ show(temp_hyst);
 show(temp_input);
 
 #define set(value, reg)	\
-static ssize_t set_##value(struct device *dev, const char *buf, size_t count)	\
+static ssize_t set_##value(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)	\
 {								\
 	struct i2c_client *client = to_i2c_client(dev);		\
 	struct lm75_data *data = i2c_get_clientdata(client);	\

