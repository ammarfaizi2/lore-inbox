Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVGaLMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVGaLMr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 07:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVGaLMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 07:12:43 -0400
Received: from coderock.org ([193.77.147.115]:62660 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261832AbVGaLM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 07:12:28 -0400
Message-Id: <20050731111216.428775000@homer>
Date: Sun, 31 Jul 2005 13:12:09 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Jan Veldeman <Jan.Veldeman@advalvas.be>,
       domen@coderock.org
Subject: [patch 4/5] Driver core: Documentation: fix whitespace between parameters
Content-Disposition: inline; filename=fixup2-Documentation_filesystems_sysfs.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Veldeman <jan@mind.be>


Fix whitespace after comma between parameters.


Signed-off-by: Jan Veldeman <Jan.Veldeman@advalvas.be>
Signed-off-by: Domen Puncer <domen@coderock.org>


---
 sysfs.txt |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

Index: quilt/Documentation/filesystems/sysfs.txt
===================================================================
--- quilt.orig/Documentation/filesystems/sysfs.txt
+++ quilt/Documentation/filesystems/sysfs.txt
@@ -90,7 +90,7 @@ void device_remove_file(struct device *,
 
 It also defines this helper for defining device attributes: 
 
-#define DEVICE_ATTR(_name,_mode,_show,_store)      \
+#define DEVICE_ATTR(_name, _mode, _show, _store)      \
 struct device_attribute dev_attr_##_name = {            \
         .attr = {.name  = __stringify(_name) , .mode   = _mode },      \
         .show   = _show,                                \
@@ -99,7 +99,7 @@ struct device_attribute dev_attr_##_name
 
 For example, declaring
 
-static DEVICE_ATTR(foo,0644,show_foo,store_foo);
+static DEVICE_ATTR(foo, 0644, show_foo, store_foo);
 
 is equivalent to doing:
 
@@ -121,8 +121,8 @@ set of sysfs operations for forwarding r
 show and store methods of the attribute owners. 
 
 struct sysfs_ops {
-        ssize_t (*show)(struct kobject *, struct attribute *,char *);
-        ssize_t (*store)(struct kobject *,struct attribute *,const char *);
+        ssize_t (*show)(struct kobject *, struct attribute *, char *);
+        ssize_t (*store)(struct kobject *, struct attribute *, const char *);
 };
 
 [ Subsystems should have already defined a struct kobj_type as a
@@ -137,7 +137,7 @@ calls the associated methods. 
 
 To illustrate:
 
-#define to_dev_attr(_attr) container_of(_attr,struct device_attribute,attr)
+#define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
 #define to_dev(d) container_of(d, struct device, kobj)
 
 static ssize_t
@@ -148,7 +148,7 @@ dev_attr_show(struct kobject * kobj, str
         ssize_t ret = 0;
 
         if (dev_attr->show)
-                ret = dev_attr->show(dev,buf);
+                ret = dev_attr->show(dev, buf);
         return ret;
 }
 
@@ -216,16 +216,16 @@ A very simple (and naive) implementation
 
 static ssize_t show_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
-        return snprintf(buf,PAGE_SIZE,"%s\n",dev->name);
+        return snprintf(buf, PAGE_SIZE, "%s\n", dev->name);
 }
 
 static ssize_t store_name(struct device * dev, const char * buf)
 {
-	sscanf(buf,"%20s",dev->name);
-	return strnlen(buf,PAGE_SIZE);
+	sscanf(buf, "%20s", dev->name);
+	return strnlen(buf, PAGE_SIZE);
 }
 
-static DEVICE_ATTR(name,S_IRUGO,show_name,store_name);
+static DEVICE_ATTR(name, S_IRUGO, show_name, store_name);
 
 
 (Note that the real implementation doesn't allow userspace to set the 
@@ -290,7 +290,7 @@ struct device_attribute {
 
 Declaring:
 
-DEVICE_ATTR(_name,_str,_mode,_show,_store);
+DEVICE_ATTR(_name, _str, _mode, _show, _store);
 
 Creation/Removal:
 
@@ -310,7 +310,7 @@ struct bus_attribute {
 
 Declaring:
 
-BUS_ATTR(_name,_mode,_show,_store)
+BUS_ATTR(_name, _mode, _show, _store)
 
 Creation/Removal:
 
@@ -331,7 +331,7 @@ struct driver_attribute {
 
 Declaring:
 
-DRIVER_ATTR(_name,_mode,_show,_store)
+DRIVER_ATTR(_name, _mode, _show, _store)
 
 Creation/Removal:
 

--
