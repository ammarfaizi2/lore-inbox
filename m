Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266056AbUFVW4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266056AbUFVW4p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 18:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265101AbUFVR7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:59:50 -0400
Received: from mail.kroah.org ([65.200.24.183]:50101 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265085AbUFVRnh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:37 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <1087926111747@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:51 -0700
Message-Id: <108792611192@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.111.18, 2004/06/09 10:19:23-07:00, greg@kroah.com

merge i2c-2.6 into driver-2.6 trees due to problems people reported.


 MAINTAINERS                  |    6 +-
 drivers/i2c/chips/it87.c     |   22 ++++-----
 drivers/i2c/chips/w83627hf.c |   96 +++++++++++++++++++++----------------------
 drivers/scsi/scsi_debug.c    |   16 +++----
 4 files changed, 70 insertions(+), 70 deletions(-)


diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	Tue Jun 22 09:47:29 2004
+++ b/MAINTAINERS	Tue Jun 22 09:47:29 2004
@@ -950,15 +950,15 @@
 IA64 (Itanium) PLATFORM
 P:	David Mosberger-Tang
 M:	davidm@hpl.hp.com
-L:	linux-ia64@linuxia64.org
-W:	http://www.linuxia64.org/
+L:	linux-ia64@vger.kernel.org
+W:	http://www.ia64-linux.org/
 S:	Maintained
 
 SN-IA64 (Itanium) SUB-PLATFORM
 P:	Jesse Barnes
 M:	jbarnes@sgi.com
 L:	linux-altix@sgi.com
-L:	linux-ia64@linuxia64.org
+L:	linux-ia64@vger.kernel.org
 W:	http://www.sgi.com/altix
 S:	Maintained
 
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Tue Jun 22 09:47:29 2004
+++ b/drivers/i2c/chips/it87.c	Tue Jun 22 09:47:29 2004
@@ -275,7 +275,7 @@
 {								\
 	return show_in(dev, buf, 0x##offset);			\
 }								\
-static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL)
+static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL);
 
 #define limit_in_offset(offset)					\
 static ssize_t							\
@@ -299,9 +299,9 @@
 	return set_in_max(dev, buf, count, 0x##offset);		\
 }								\
 static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, 	\
-		show_in##offset##_min, set_in##offset##_min)	\
+		show_in##offset##_min, set_in##offset##_min);	\
 static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR, 	\
-		show_in##offset##_max, set_in##offset##_max)
+		show_in##offset##_max, set_in##offset##_max);
 
 show_in_offset(0);
 limit_in_offset(0);
@@ -382,11 +382,11 @@
 {									\
 	return set_temp_min(dev, buf, count, 0x##offset - 1);		\
 }									\
-static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL) \
+static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset, NULL); \
 static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, 		\
-		show_temp_##offset##_max, set_temp_##offset##_max) 	\
+		show_temp_##offset##_max, set_temp_##offset##_max); 	\
 static DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR, 		\
-		show_temp_##offset##_min, set_temp_##offset##_min)	
+		show_temp_##offset##_min, set_temp_##offset##_min);	
 
 show_temp_offset(1);
 show_temp_offset(2);
@@ -430,8 +430,8 @@
 {									\
 	return set_sensor(dev, buf, count, 0x##offset - 1);		\
 }									\
-static DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR,	 		\
-		show_sensor_##offset, set_sensor_##offset)
+static DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR, 		\
+		show_sensor_##offset, set_sensor_##offset);
 
 show_sensor_offset(1);
 show_sensor_offset(2);
@@ -525,11 +525,11 @@
 {									\
 	return set_fan_div(dev, buf, count, 0x##offset - 1);		\
 }									\
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL) \
+static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL); \
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
-		show_fan_##offset##_min, set_fan_##offset##_min) 	\
+		show_fan_##offset##_min, set_fan_##offset##_min); 	\
 static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, 		\
-		show_fan_##offset##_div, set_fan_##offset##_div)
+		show_fan_##offset##_div, set_fan_##offset##_div);
 
 show_fan_offset(1);
 show_fan_offset(2);
diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	Tue Jun 22 09:47:29 2004
+++ b/drivers/i2c/chips/w83627hf.c	Tue Jun 22 09:47:29 2004
@@ -371,7 +371,7 @@
 { \
         return show_in(dev, buf, 0x##offset); \
 } \
-static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL)
+static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL);
 
 #define sysfs_in_reg_offset(reg, offset) \
 static ssize_t show_regs_in_##reg##offset (struct device *dev, char *buf) \
@@ -385,21 +385,21 @@
 	return store_in_##reg (dev, buf, count, 0x##offset); \
 } \
 static DEVICE_ATTR(in##offset##_##reg, S_IRUGO| S_IWUSR, \
-		  show_regs_in_##reg##offset, store_regs_in_##reg##offset)
+		  show_regs_in_##reg##offset, store_regs_in_##reg##offset);
 
 #define sysfs_in_offsets(offset) \
 sysfs_in_offset(offset) \
 sysfs_in_reg_offset(min, offset) \
 sysfs_in_reg_offset(max, offset)
 
-sysfs_in_offsets(1)
-sysfs_in_offsets(2)
-sysfs_in_offsets(3)
-sysfs_in_offsets(4)
-sysfs_in_offsets(5)
-sysfs_in_offsets(6)
-sysfs_in_offsets(7)
-sysfs_in_offsets(8)
+sysfs_in_offsets(1);
+sysfs_in_offsets(2);
+sysfs_in_offsets(3);
+sysfs_in_offsets(4);
+sysfs_in_offsets(5);
+sysfs_in_offsets(6);
+sysfs_in_offsets(7);
+sysfs_in_offsets(8);
 
 /* use a different set of functions for in0 */
 static ssize_t show_in_0(struct w83627hf_data *data, char *buf, u8 reg)
@@ -499,8 +499,8 @@
 		FAN_FROM_REG(data->reg[nr-1], \
 			    (long)DIV_FROM_REG(data->fan_div[nr-1]))); \
 }
-show_fan_reg(fan)
-show_fan_reg(fan_min)
+show_fan_reg(fan);
+show_fan_reg(fan_min);
 
 static ssize_t
 store_fan_min(struct device *dev, const char *buf, size_t count, int nr)
@@ -523,7 +523,7 @@
 { \
 	return show_fan(dev, buf, 0x##offset); \
 } \
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_regs_fan_##offset, NULL)
+static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_regs_fan_##offset, NULL);
 
 #define sysfs_fan_min_offset(offset) \
 static ssize_t show_regs_fan_min##offset (struct device *dev, char *buf) \
@@ -536,14 +536,14 @@
 	return store_fan_min(dev, buf, count, 0x##offset); \
 } \
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, \
-		  show_regs_fan_min##offset, store_regs_fan_min##offset)
+		  show_regs_fan_min##offset, store_regs_fan_min##offset);
 
-sysfs_fan_offset(1)
-sysfs_fan_min_offset(1)
-sysfs_fan_offset(2)
-sysfs_fan_min_offset(2)
-sysfs_fan_offset(3)
-sysfs_fan_min_offset(3)
+sysfs_fan_offset(1);
+sysfs_fan_min_offset(1);
+sysfs_fan_offset(2);
+sysfs_fan_min_offset(2);
+sysfs_fan_offset(3);
+sysfs_fan_min_offset(3);
 
 #define device_create_file_fan(client, offset) \
 do { \
@@ -562,9 +562,9 @@
 		return sprintf(buf,"%ld\n", (long)TEMP_FROM_REG(data->reg)); \
 	} \
 }
-show_temp_reg(temp)
-show_temp_reg(temp_max)
-show_temp_reg(temp_max_hyst)
+show_temp_reg(temp);
+show_temp_reg(temp_max);
+show_temp_reg(temp_max_hyst);
 
 #define store_temp_reg(REG, reg) \
 static ssize_t \
@@ -588,8 +588,8 @@
 	 \
 	return count; \
 }
-store_temp_reg(OVER, max)
-store_temp_reg(HYST, max_hyst)
+store_temp_reg(OVER, max);
+store_temp_reg(HYST, max_hyst);
 
 #define sysfs_temp_offset(offset) \
 static ssize_t \
@@ -597,7 +597,7 @@
 { \
 	return show_temp(dev, buf, 0x##offset); \
 } \
-static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_regs_temp_##offset, NULL)
+static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_regs_temp_##offset, NULL);
 
 #define sysfs_temp_reg_offset(reg, offset) \
 static ssize_t show_regs_temp_##reg##offset (struct device *dev, char *buf) \
@@ -611,16 +611,16 @@
 	return store_temp_##reg (dev, buf, count, 0x##offset); \
 } \
 static DEVICE_ATTR(temp##offset##_##reg, S_IRUGO| S_IWUSR, \
-		  show_regs_temp_##reg##offset, store_regs_temp_##reg##offset)
+		  show_regs_temp_##reg##offset, store_regs_temp_##reg##offset);
 
 #define sysfs_temp_offsets(offset) \
 sysfs_temp_offset(offset) \
 sysfs_temp_reg_offset(max, offset) \
 sysfs_temp_reg_offset(max_hyst, offset)
 
-sysfs_temp_offsets(1)
-sysfs_temp_offsets(2)
-sysfs_temp_offsets(3)
+sysfs_temp_offsets(1);
+sysfs_temp_offsets(2);
+sysfs_temp_offsets(3);
 
 #define device_create_file_temp(client, offset) \
 do { \
@@ -635,7 +635,7 @@
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
 }
-static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid_reg, NULL)
+static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid_reg, NULL);
 #define device_create_file_vid(client) \
 device_create_file(&client->dev, &dev_attr_in0_ref)
 
@@ -657,7 +657,7 @@
 
 	return count;
 }
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg)
+static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
 #define device_create_file_vrm(client) \
 device_create_file(&client->dev, &dev_attr_vrm)
 
@@ -667,7 +667,7 @@
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) data->alarms);
 }
-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL)
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
 #define device_create_file_alarms(client) \
 device_create_file(&client->dev, &dev_attr_alarms)
 
@@ -724,10 +724,10 @@
 	return store_beep_reg(dev, buf, count, BEEP_##REG); \
 } \
 static DEVICE_ATTR(beep_##reg, S_IRUGO | S_IWUSR, \
-		  show_regs_beep_##reg, store_regs_beep_##reg)
+		  show_regs_beep_##reg, store_regs_beep_##reg);
 
-sysfs_beep(ENABLE, enable)
-sysfs_beep(MASK, mask)
+sysfs_beep(ENABLE, enable);
+sysfs_beep(MASK, mask);
 
 #define device_create_file_beep(client) \
 do { \
@@ -790,11 +790,11 @@
 	return store_fan_div_reg(dev, buf, count, offset - 1); \
 } \
 static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, \
-		  show_regs_fan_div_##offset, store_regs_fan_div_##offset)
+		  show_regs_fan_div_##offset, store_regs_fan_div_##offset);
 
-sysfs_fan_div(1)
-sysfs_fan_div(2)
-sysfs_fan_div(3)
+sysfs_fan_div(1);
+sysfs_fan_div(2);
+sysfs_fan_div(3);
 
 #define device_create_file_fan_div(client, offset) \
 do { \
@@ -846,11 +846,11 @@
 	return store_pwm_reg(dev, buf, count, offset); \
 } \
 static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR, \
-		  show_regs_pwm_##offset, store_regs_pwm_##offset)
+		  show_regs_pwm_##offset, store_regs_pwm_##offset);
 
-sysfs_pwm(1)
-sysfs_pwm(2)
-sysfs_pwm(3)
+sysfs_pwm(1);
+sysfs_pwm(2);
+sysfs_pwm(3);
 
 #define device_create_file_pwm(client, offset) \
 do { \
@@ -919,11 +919,11 @@
     return store_sensor_reg(dev, buf, count, offset); \
 } \
 static DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR, \
-		  show_regs_sensor_##offset, store_regs_sensor_##offset)
+		  show_regs_sensor_##offset, store_regs_sensor_##offset);
 
-sysfs_sensor(1)
-sysfs_sensor(2)
-sysfs_sensor(3)
+sysfs_sensor(1);
+sysfs_sensor(2);
+sysfs_sensor(3);
 
 #define device_create_file_sensor(client, offset) \
 do { \
diff -Nru a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
--- a/drivers/scsi/scsi_debug.c	Tue Jun 22 09:47:29 2004
+++ b/drivers/scsi/scsi_debug.c	Tue Jun 22 09:47:29 2004
@@ -1326,7 +1326,7 @@
 	return -EINVAL;
 }
 DRIVER_ATTR(delay, S_IRUGO | S_IWUSR, sdebug_delay_show, 
-	    sdebug_delay_store)
+	    sdebug_delay_store);
 
 static ssize_t sdebug_opts_show(struct device_driver * ddp, char * buf) 
 {
@@ -1355,7 +1355,7 @@
 	return count;
 }
 DRIVER_ATTR(opts, S_IRUGO | S_IWUSR, sdebug_opts_show, 
-	    sdebug_opts_store)
+	    sdebug_opts_store);
 
 static ssize_t sdebug_num_tgts_show(struct device_driver * ddp, char * buf) 
 {
@@ -1373,13 +1373,13 @@
 	return -EINVAL;
 }
 DRIVER_ATTR(num_tgts, S_IRUGO | S_IWUSR, sdebug_num_tgts_show, 
-	    sdebug_num_tgts_store) 
+	    sdebug_num_tgts_store);
 
 static ssize_t sdebug_dev_size_mb_show(struct device_driver * ddp, char * buf) 
 {
         return scnprintf(buf, PAGE_SIZE, "%d\n", scsi_debug_dev_size_mb);
 }
-DRIVER_ATTR(dev_size_mb, S_IRUGO, sdebug_dev_size_mb_show, NULL) 
+DRIVER_ATTR(dev_size_mb, S_IRUGO, sdebug_dev_size_mb_show, NULL);
 
 static ssize_t sdebug_every_nth_show(struct device_driver * ddp, char * buf) 
 {
@@ -1398,7 +1398,7 @@
 	return -EINVAL;
 }
 DRIVER_ATTR(every_nth, S_IRUGO | S_IWUSR, sdebug_every_nth_show,
-	    sdebug_every_nth_store) 
+	    sdebug_every_nth_store);
 
 static ssize_t sdebug_max_luns_show(struct device_driver * ddp, char * buf) 
 {
@@ -1416,13 +1416,13 @@
 	return -EINVAL;
 }
 DRIVER_ATTR(max_luns, S_IRUGO | S_IWUSR, sdebug_max_luns_show, 
-	    sdebug_max_luns_store) 
+	    sdebug_max_luns_store);
 
 static ssize_t sdebug_scsi_level_show(struct device_driver * ddp, char * buf) 
 {
         return scnprintf(buf, PAGE_SIZE, "%d\n", scsi_debug_scsi_level);
 }
-DRIVER_ATTR(scsi_level, S_IRUGO, sdebug_scsi_level_show, NULL) 
+DRIVER_ATTR(scsi_level, S_IRUGO, sdebug_scsi_level_show, NULL);
 
 static ssize_t sdebug_add_host_show(struct device_driver * ddp, char * buf) 
 {
@@ -1459,7 +1459,7 @@
 	return count;
 }
 DRIVER_ATTR(add_host, S_IRUGO | S_IWUSR, sdebug_add_host_show, 
-	    sdebug_add_host_store)
+	    sdebug_add_host_store);
 
 static void do_create_driverfs_files(void)
 {

