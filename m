Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266193AbUFJGxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUFJGxl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 02:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266208AbUFJGxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 02:53:40 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:26540 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266193AbUFJGq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 02:46:58 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 3/3] Whitespace fixes
Date: Thu, 10 Jun 2004 01:44:59 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200406090221.24739.dtor_core@ameritech.net> <200406100142.14861.dtor_core@ameritech.net> <200406100143.53381.dtor_core@ameritech.net>
In-Reply-To: <200406100143.53381.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406100145.01599.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1768, 2004-06-10 00:07:32-05:00, dtor_core@ameritech.net
  Whitespace and formatting changes (a,b,c -> a, b, c) in drivers/base
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 base.h           |    5 +-
 bus.c            |  125 +++++++++++++++++++++++++++----------------------------
 class.c          |   38 ++++++++--------
 class_simple.c   |   12 ++---
 core.c           |   46 ++++++++++----------
 driver.c         |   16 +++----
 firmware.c       |    6 +-
 firmware_class.c |   10 ++--
 init.c           |    4 -
 interface.c      |   18 +++----
 node.c           |   14 +++---
 platform.c       |   18 +++----
 power/main.c     |   14 +++---
 power/power.h    |    8 +--
 power/resume.c   |   12 ++---
 power/runtime.c  |    8 +--
 power/shutdown.c |   18 +++----
 power/suspend.c  |   42 +++++++++---------
 power/sysfs.c    |   18 +++----
 sys.c            |  102 ++++++++++++++++++++++----------------------
 20 files changed, 267 insertions(+), 267 deletions(-)


===================================================================



diff -Nru a/drivers/base/base.h b/drivers/base/base.h
--- a/drivers/base/base.h	2004-06-10 01:34:24 -05:00
+++ b/drivers/base/base.h	2004-06-10 01:34:24 -05:00
@@ -6,12 +6,13 @@
 
 static inline struct class_device *to_class_dev(struct kobject *obj)
 {
-	return container_of(obj,struct class_device,kobj);
+	return container_of(obj, struct class_device, kobj);
 }
+
 static inline
 struct class_device_attribute *to_class_dev_attr(struct attribute *_attr)
 {
-	return container_of(_attr,struct class_device_attribute,attr);
+	return container_of(_attr, struct class_device_attribute, attr);
 }
 
 
diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2004-06-10 01:34:24 -05:00
+++ b/drivers/base/bus.c	2004-06-10 01:34:24 -05:00
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2002-3 Patrick Mochel
  * Copyright (c) 2002-3 Open Source Development Labs
- * 
+ *
  * This file is released under the GPLv2
  *
  */
@@ -17,17 +17,17 @@
 #include "base.h"
 #include "power/power.h"
 
-#define to_dev(node) container_of(node,struct device,bus_list)
-#define to_drv(node) container_of(node,struct device_driver,kobj.entry)
+#define to_dev(node) container_of(node, struct device, bus_list)
+#define to_drv(node) container_of(node, struct device_driver, kobj.entry)
 
-#define to_bus_attr(_attr) container_of(_attr,struct bus_attribute,attr)
-#define to_bus(obj) container_of(obj,struct bus_type,subsys.kset.kobj)
+#define to_bus_attr(_attr) container_of(_attr, struct bus_attribute, attr)
+#define to_bus(obj) container_of(obj, struct bus_type, subsys.kset.kobj)
 
 /*
  * sysfs bindings for drivers
  */
 
-#define to_drv_attr(_attr) container_of(_attr,struct driver_attribute,attr)
+#define to_drv_attr(_attr) container_of(_attr, struct driver_attribute, attr)
 #define to_driver(obj) container_of(obj, struct device_driver, kobj)
 
 
@@ -39,12 +39,12 @@
 	ssize_t ret = 0;
 
 	if (drv_attr->show)
-		ret = drv_attr->show(drv,buf);
+		ret = drv_attr->show(drv, buf);
 	return ret;
 }
 
 static ssize_t
-drv_attr_store(struct kobject * kobj, struct attribute * attr, 
+drv_attr_store(struct kobject * kobj, struct attribute * attr,
 	       const char * buf, size_t count)
 {
 	struct driver_attribute * drv_attr = to_drv_attr(attr);
@@ -52,7 +52,7 @@
 	ssize_t ret = 0;
 
 	if (drv_attr->store)
-		ret = drv_attr->store(drv,buf,count);
+		ret = drv_attr->store(drv, buf, count);
 	return ret;
 }
 
@@ -87,12 +87,12 @@
 	ssize_t ret = 0;
 
 	if (bus_attr->show)
-		ret = bus_attr->show(bus,buf);
+		ret = bus_attr->show(bus, buf);
 	return ret;
 }
 
 static ssize_t
-bus_attr_store(struct kobject * kobj, struct attribute * attr, 
+bus_attr_store(struct kobject * kobj, struct attribute * attr,
 	       const char * buf, size_t count)
 {
 	struct bus_attribute * bus_attr = to_bus_attr(attr);
@@ -100,7 +100,7 @@
 	ssize_t ret = 0;
 
 	if (bus_attr->store)
-		ret = bus_attr->store(bus,buf,count);
+		ret = bus_attr->store(bus, buf, count);
 	return ret;
 }
 
@@ -113,7 +113,7 @@
 {
 	int error;
 	if (get_bus(bus)) {
-		error = sysfs_create_file(&bus->subsys.kset.kobj,&attr->attr);
+		error = sysfs_create_file(&bus->subsys.kset.kobj, &attr->attr);
 		put_bus(bus);
 	} else
 		error = -EINVAL;
@@ -123,7 +123,7 @@
 void bus_remove_file(struct bus_type * bus, struct bus_attribute * attr)
 {
 	if (get_bus(bus)) {
-		sysfs_remove_file(&bus->subsys.kset.kobj,&attr->attr);
+		sysfs_remove_file(&bus->subsys.kset.kobj, &attr->attr);
 		put_bus(bus);
 	}
 }
@@ -133,7 +133,7 @@
 
 };
 
-decl_subsys(bus,&ktype_bus,NULL);
+decl_subsys(bus, &ktype_bus, NULL);
 
 /**
  *	bus_for_each_dev - device iterator.
@@ -151,10 +151,10 @@
  *
  *	NOTE: The device that returns a non-zero value is not retained
  *	in any way, nor is its refcount incremented. If the caller needs
- *	to retain this data, it should do, and increment the reference 
+ *	to retain this data, it should do, and increment the reference
  *	count in the supplied callback.
  */
-int bus_for_each_dev(struct bus_type * bus, struct device * start, 
+int bus_for_each_dev(struct bus_type * bus, struct device * start,
 		     void * data, int (*fn)(struct device *, void *))
 {
 	struct device *dev;
@@ -170,7 +170,7 @@
 	down_read(&bus->subsys.rwsem);
 	list_for_each_entry_continue(dev, head, bus_list) {
 		get_device(dev);
-		error = fn(dev,data);
+		error = fn(dev, data);
 		put_device(dev);
 		if (error)
 			break;
@@ -193,7 +193,7 @@
  *	and return it. If @start is not NULL, we use it as the head
  *	of the list.
  *
- *	NOTE: we don't return the driver that returns a non-zero 
+ *	NOTE: we don't return the driver that returns a non-zero
  *	value, nor do we leave the reference count incremented for that
  *	driver. If the caller needs to know that info, it must set it
  *	in the callback. It must also be sure to increment the refcount
@@ -216,7 +216,7 @@
 	down_read(&bus->subsys.rwsem);
 	list_for_each_entry_continue(drv, head, kobj.entry) {
 		get_driver(drv);
-		error = fn(drv,data);
+		error = fn(drv, data);
 		put_driver(drv);
 		if(error)
 			break;
@@ -233,8 +233,8 @@
  *	Allow manual attachment of a driver to a deivce.
  *	Caller must have already set @dev->driver.
  *
- *	Note that this does not modify the bus reference count 
- *	nor take the bus's rwsem. Please verify those are accounted 
+ *	Note that this does not modify the bus reference count
+ *	nor take the bus's rwsem. Please verify those are accounted
  *	for before calling this. (It is ok to call with no other effort
  *	from a driver's probe() method.)
  */
@@ -242,9 +242,9 @@
 void device_bind_driver(struct device * dev)
 {
 	pr_debug("bound device '%s' to driver '%s'\n",
-		 dev->bus_id,dev->driver->name);
-	list_add_tail(&dev->driver_list,&dev->driver->devices);
-	sysfs_create_link(&dev->driver->kobj,&dev->kobj,
+		 dev->bus_id, dev->driver->name);
+	list_add_tail(&dev->driver_list, &dev->driver->devices);
+	sysfs_create_link(&dev->driver->kobj, &dev->kobj,
 			  kobject_name(&dev->kobj));
 }
 
@@ -255,18 +255,18 @@
  *	@drv:	driver.
  *
  *	First, we call the bus's match function, which should compare
- *	the device IDs the driver supports with the device IDs of the 
- *	device. Note we don't do this ourselves because we don't know 
+ *	the device IDs the driver supports with the device IDs of the
+ *	device. Note we don't do this ourselves because we don't know
  *	the format of the ID structures, nor what is to be considered
  *	a match and what is not.
- *	
- *	If we find a match, we call @drv->probe(@dev) if it exists, and 
+ *
+ *	If we find a match, we call @drv->probe(@dev) if it exists, and
  *	call attach() above.
  */
 static int bus_match(struct device * dev, struct device_driver * drv)
 {
 	int error = -ENODEV;
-	if (dev->bus->match(dev,drv)) {
+	if (dev->bus->match(dev, drv)) {
 		dev->driver = drv;
 		if (drv->probe) {
 			if ((error = drv->probe(dev))) {
@@ -285,7 +285,7 @@
  *	device_attach - try to attach device to a driver.
  *	@dev:	device.
  *
- *	Walk the list of drivers that the bus has and call bus_match() 
+ *	Walk the list of drivers that the bus has and call bus_match()
  *	for each pair. If a compatible pair is found, break out and return.
  */
 static int device_attach(struct device * dev)
@@ -300,15 +300,15 @@
 	}
 
 	if (bus->match) {
-		list_for_each(entry,&bus->drivers.list) {
+		list_for_each(entry, &bus->drivers.list) {
 			struct device_driver * drv = to_drv(entry);
-			error = bus_match(dev,drv);
-			if (!error )  
+			error = bus_match(dev, drv);
+			if (!error)
 				/* success, driver matched */
-				return 1; 
-			if (error != -ENODEV) 
+				return 1;
+			if (error != -ENODEV)
 				/* driver matched but the probe failed */
-				printk(KERN_WARNING 
+				printk(KERN_WARNING
 				    "%s: probe of %s failed with error %d\n",
 				    drv->name, dev->bus_id, error);
 		}
@@ -327,7 +327,7 @@
  *	If bus_match() returns 0 and the @dev->driver is set, we've found
  *	a compatible pair.
  *
- *	Note that we ignore the -ENODEV error from bus_match(), since it's 
+ *	Note that we ignore the -ENODEV error from bus_match(), since it's
  *	perfectly valid for a driver not to bind to any devices.
  */
 void driver_attach(struct device_driver * drv)
@@ -339,13 +339,13 @@
 	if (!bus->match)
 		return;
 
-	list_for_each(entry,&bus->devices.list) {
-		struct device * dev = container_of(entry,struct device,bus_list);
+	list_for_each(entry, &bus->devices.list) {
+		struct device * dev = container_of(entry, struct device, bus_list);
 		if (!dev->driver) {
-			error = bus_match(dev,drv);
+			error = bus_match(dev, drv);
 			if (error && (error != -ENODEV))
 				/* driver matched but the probe failed */
-				printk(KERN_WARNING 
+				printk(KERN_WARNING
 				    "%s: probe of %s failed with error %d\n",
 				    drv->name, dev->bus_id, error);
 		}
@@ -367,7 +367,7 @@
 {
 	struct device_driver * drv = dev->driver;
 	if (drv) {
-		sysfs_remove_link(&drv->kobj,kobject_name(&dev->kobj));
+		sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
 		list_del_init(&dev->driver_list);
 		device_detach_shutdown(dev);
 		if (drv->remove)
@@ -385,11 +385,10 @@
 static void driver_detach(struct device_driver * drv)
 {
 	struct list_head * entry, * next;
-	list_for_each_safe(entry,next,&drv->devices) {
-		struct device * dev = container_of(entry,struct device,driver_list);
+	list_for_each_safe(entry, next, &drv->devices) {
+		struct device * dev = container_of(entry, struct device, driver_list);
 		device_release_driver(dev);
 	}
-	
 }
 
 /**
@@ -407,11 +406,11 @@
 
 	if (bus) {
 		down_write(&dev->bus->subsys.rwsem);
-		pr_debug("bus %s: add device %s\n",bus->name,dev->bus_id);
-		list_add_tail(&dev->bus_list,&dev->bus->devices.list);
+		pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
+		list_add_tail(&dev->bus_list, &dev->bus->devices.list);
 		device_attach(dev);
 		up_write(&dev->bus->subsys.rwsem);
-		sysfs_create_link(&bus->devices.kobj,&dev->kobj,dev->bus_id);
+		sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
 	}
 	return error;
 }
@@ -428,9 +427,9 @@
 void bus_remove_device(struct device * dev)
 {
 	if (dev->bus) {
-		sysfs_remove_link(&dev->bus->devices.kobj,dev->bus_id);
+		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
 		down_write(&dev->bus->subsys.rwsem);
-		pr_debug("bus %s: remove device %s\n",dev->bus->name,dev->bus_id);
+		pr_debug("bus %s: remove device %s\n", dev->bus->name, dev->bus_id);
 		device_release_driver(dev);
 		list_del_init(&dev->bus_list);
 		up_write(&dev->bus->subsys.rwsem);
@@ -450,8 +449,8 @@
 	int error = 0;
 
 	if (bus) {
-		pr_debug("bus %s: add driver %s\n",bus->name,drv->name);
-		error = kobject_set_name(&drv->kobj,drv->name);
+		pr_debug("bus %s: add driver %s\n", bus->name, drv->name);
+		error = kobject_set_name(&drv->kobj, drv->name);
 		if (error) {
 			put_bus(bus);
 			return error;
@@ -484,7 +483,7 @@
 {
 	if (drv->bus) {
 		down_write(&drv->bus->subsys.rwsem);
-		pr_debug("bus %s: remove driver %s\n",drv->bus->name,drv->name);
+		pr_debug("bus %s: remove driver %s\n", drv->bus->name, drv->name);
 		driver_detach(drv);
 		up_write(&drv->bus->subsys.rwsem);
 		kobject_unregister(&drv->kobj);
@@ -526,7 +525,7 @@
 
 struct bus_type * get_bus(struct bus_type * bus)
 {
-	return bus ? container_of(subsys_get(&bus->subsys),struct bus_type,subsys) : NULL;
+	return bus ? container_of(subsys_get(&bus->subsys), struct bus_type, subsys) : NULL;
 }
 
 void put_bus(struct bus_type * bus)
@@ -545,7 +544,7 @@
 
 struct bus_type * find_bus(char * name)
 {
-	struct kobject * k = kset_find_obj(&bus_subsys.kset,name);
+	struct kobject * k = kset_find_obj(&bus_subsys.kset, name);
 	return k ? to_bus(k) : NULL;
 }
 
@@ -555,19 +554,19 @@
  *
  *	Once we have that, we registered the bus with the kobject
  *	infrastructure, then register the children subsystems it has:
- *	the devices and drivers that belong to the bus. 
+ *	the devices and drivers that belong to the bus.
  */
 int bus_register(struct bus_type * bus)
 {
 	int retval;
 
-	retval = kobject_set_name(&bus->subsys.kset.kobj,bus->name);
+	retval = kobject_set_name(&bus->subsys.kset.kobj, bus->name);
 	if (retval)
 		goto out;
 
-	subsys_set_kset(bus,bus_subsys);
+	subsys_set_kset(bus, bus_subsys);
 	retval = subsystem_register(&bus->subsys);
-	if (retval) 
+	if (retval)
 		goto out;
 
 	kobject_set_name(&bus->devices.kobj, "devices");
@@ -583,7 +582,7 @@
 	if (retval)
 		goto bus_drivers_fail;
 
-	pr_debug("bus type '%s' registered\n",bus->name);
+	pr_debug("bus type '%s' registered\n", bus->name);
 	return 0;
 
 bus_drivers_fail:
@@ -596,7 +595,7 @@
 
 
 /**
- *	bus_unregister - remove a bus from the system 
+ *	bus_unregister - remove a bus from the system
  *	@bus:	bus.
  *
  *	Unregister the child subsystems and the bus itself.
@@ -604,7 +603,7 @@
  */
 void bus_unregister(struct bus_type * bus)
 {
-	pr_debug("bus %s: unregistering\n",bus->name);
+	pr_debug("bus %s: unregistering\n", bus->name);
 	kset_unregister(&bus->drivers);
 	kset_unregister(&bus->devices);
 	subsystem_unregister(&bus->subsys);
diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	2004-06-10 01:34:24 -05:00
+++ b/drivers/base/class.c	2004-06-10 01:34:24 -05:00
@@ -5,7 +5,7 @@
  * Copyright (c) 2002-3 Open Source Development Labs
  * Copyright (c) 2003-2004 Greg Kroah-Hartman
  * Copyright (c) 2003-2004 IBM Corp.
- * 
+ *
  * This file is released under the GPLv2
  *
  */
@@ -17,8 +17,8 @@
 #include <linux/string.h>
 #include "base.h"
 
-#define to_class_attr(_attr) container_of(_attr,struct class_attribute,attr)
-#define to_class(obj) container_of(obj,struct class,subsys.kset.kobj)
+#define to_class_attr(_attr) container_of(_attr, struct class_attribute, attr)
+#define to_class(obj) container_of(obj, struct class, subsys.kset.kobj)
 
 static ssize_t
 class_attr_show(struct kobject * kobj, struct attribute * attr, char * buf)
@@ -28,12 +28,12 @@
 	ssize_t ret = 0;
 
 	if (class_attr->show)
-		ret = class_attr->show(dc,buf);
+		ret = class_attr->show(dc, buf);
 	return ret;
 }
 
 static ssize_t
-class_attr_store(struct kobject * kobj, struct attribute * attr, 
+class_attr_store(struct kobject * kobj, struct attribute * attr,
 		 const char * buf, size_t count)
 {
 	struct class_attribute * class_attr = to_class_attr(attr);
@@ -41,7 +41,7 @@
 	ssize_t ret = 0;
 
 	if (class_attr->store)
-		ret = class_attr->store(dc,buf,count);
+		ret = class_attr->store(dc, buf, count);
 	return ret;
 }
 
@@ -69,14 +69,14 @@
 };
 
 /* Hotplug events for classes go to the class_obj subsys */
-static decl_subsys(class,&ktype_class,NULL);
+static decl_subsys(class, &ktype_class, NULL);
 
 
 int class_create_file(struct class * cls, const struct class_attribute * attr)
 {
 	int error;
 	if (cls) {
-		error = sysfs_create_file(&cls->subsys.kset.kobj,&attr->attr);
+		error = sysfs_create_file(&cls->subsys.kset.kobj, &attr->attr);
 	} else
 		error = -EINVAL;
 	return error;
@@ -85,13 +85,13 @@
 void class_remove_file(struct class * cls, const struct class_attribute * attr)
 {
 	if (cls)
-		sysfs_remove_file(&cls->subsys.kset.kobj,&attr->attr);
+		sysfs_remove_file(&cls->subsys.kset.kobj, &attr->attr);
 }
 
 struct class * class_get(struct class * cls)
 {
 	if (cls)
-		return container_of(subsys_get(&cls->subsys),struct class,subsys);
+		return container_of(subsys_get(&cls->subsys), struct class, subsys);
 	return NULL;
 }
 
@@ -104,15 +104,15 @@
 {
 	int error;
 
-	pr_debug("device class '%s': registering\n",cls->name);
+	pr_debug("device class '%s': registering\n", cls->name);
 
 	INIT_LIST_HEAD(&cls->children);
 	INIT_LIST_HEAD(&cls->interfaces);
-	error = kobject_set_name(&cls->subsys.kset.kobj,cls->name);
+	error = kobject_set_name(&cls->subsys.kset.kobj, cls->name);
 	if (error)
 		return error;
 
-	subsys_set_kset(cls,class_subsys);
+	subsys_set_kset(cls, class_subsys);
 
 	error = subsystem_register(&cls->subsys);
 	if (error)
@@ -123,7 +123,7 @@
 
 void class_unregister(struct class * cls)
 {
-	pr_debug("device class '%s': unregistering\n",cls->name);
+	pr_debug("device class '%s': unregistering\n", cls->name);
 	subsystem_unregister(&cls->subsys);
 }
 
@@ -181,12 +181,12 @@
 	ssize_t ret = 0;
 
 	if (class_dev_attr->show)
-		ret = class_dev_attr->show(cd,buf);
+		ret = class_dev_attr->show(cd, buf);
 	return ret;
 }
 
 static ssize_t
-class_device_attr_store(struct kobject * kobj, struct attribute * attr, 
+class_device_attr_store(struct kobject * kobj, struct attribute * attr,
 			const char * buf, size_t count)
 {
 	struct class_device_attribute * class_dev_attr = to_class_dev_attr(attr);
@@ -194,7 +194,7 @@
 	ssize_t ret = 0;
 
 	if (class_dev_attr->store)
-		ret = class_dev_attr->store(cd,buf,count);
+		ret = class_dev_attr->store(cd, buf, count);
 	return ret;
 }
 
@@ -208,7 +208,7 @@
 	struct class_device *cd = to_class_dev(kobj);
 	struct class * cls = cd->class;
 
-	pr_debug("device class '%s': release.\n",cd->class_id);
+	pr_debug("device class '%s': release.\n", cd->class_id);
 
 	if (cls->release)
 		cls->release(cd);
@@ -344,7 +344,7 @@
 
 	class_device_dev_unlink(class_dev);
 	class_device_driver_unlink(class_dev);
-	
+
 	kobject_del(&class_dev->kobj);
 
 	if (parent)
diff -Nru a/drivers/base/class_simple.c b/drivers/base/class_simple.c
--- a/drivers/base/class_simple.c	2004-06-10 01:34:24 -05:00
+++ b/drivers/base/class_simple.c	2004-06-10 01:34:24 -05:00
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2003-2004 Greg Kroah-Hartman <greg@kroah.com>
  * Copyright (c) 2003-2004 IBM Corp.
- * 
+ *
  * This file is released under the GPLv2
  *
  */
@@ -111,7 +111,7 @@
 
 /**
  * class_simple_device_add - adds a class device to sysfs for a character driver
- * @cs: pointer to the struct class_simple that this device should be registered to.  
+ * @cs: pointer to the struct class_simple that this device should be registered to.
  * @dev: the dev_t for the device to be added.
  * @device: a pointer to a struct device that is assiociated with this class device.
  * @fmt: string for the class device's name
@@ -146,8 +146,8 @@
 	s_dev->dev = dev;
 	s_dev->class_dev.dev = device;
 	s_dev->class_dev.class = &cs->class;
-	
-	va_start(args,fmt);
+
+	va_start(args, fmt);
 	vsnprintf(s_dev->class_dev.class_id, BUS_ID_SIZE, fmt, args);
 	va_end(args);
 	retval = class_device_register(&s_dev->class_dev);
@@ -173,10 +173,10 @@
  * @cs: pointer to the struct class_simple to hold the pointer
  * @hotplug: function pointer to the hotplug function
  *
- * Implement and set a hotplug function to add environment variables specific to this 
+ * Implement and set a hotplug function to add environment variables specific to this
  * class on the hotplug event.
  */
-int class_simple_set_hotplug(struct class_simple *cs, 
+int class_simple_set_hotplug(struct class_simple *cs,
 	int (*hotplug)(struct class_device *dev, char **envp, int num_envp, char *buffer, int buffer_size))
 {
 	if ((cs == NULL) || (IS_ERR(cs)))
diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	2004-06-10 01:34:24 -05:00
+++ b/drivers/base/core.c	2004-06-10 01:34:24 -05:00
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2002-3 Patrick Mochel
  * Copyright (c) 2002-3 Open Source Development Labs
- * 
+ *
  * This file is released under the GPLv2
  *
  */
@@ -28,8 +28,8 @@
  * sysfs bindings for devices.
  */
 
-#define to_dev(obj) container_of(obj,struct device,kobj)
-#define to_dev_attr(_attr) container_of(_attr,struct device_attribute,attr)
+#define to_dev(obj) container_of(obj, struct device, kobj)
+#define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
 
 extern struct attribute * dev_default_attrs[];
 
@@ -41,12 +41,12 @@
 	ssize_t ret = 0;
 
 	if (dev_attr->show)
-		ret = dev_attr->show(dev,buf);
+		ret = dev_attr->show(dev, buf);
 	return ret;
 }
 
 static ssize_t
-dev_attr_store(struct kobject * kobj, struct attribute * attr, 
+dev_attr_store(struct kobject * kobj, struct attribute * attr,
 	       const char * buf, size_t count)
 {
 	struct device_attribute * dev_attr = to_dev_attr(attr);
@@ -54,7 +54,7 @@
 	ssize_t ret = 0;
 
 	if (dev_attr->store)
-		ret = dev_attr->store(dev,buf,count);
+		ret = dev_attr->store(dev, buf, count);
 	return ret;
 }
 
@@ -153,7 +153,7 @@
 {
 	int error = 0;
 	if (get_device(dev)) {
-		error = sysfs_create_file(&dev->kobj,&attr->attr);
+		error = sysfs_create_file(&dev->kobj, &attr->attr);
 		put_device(dev);
 	}
 	return error;
@@ -168,7 +168,7 @@
 void device_remove_file(struct device * dev, struct device_attribute * attr)
 {
 	if (get_device(dev)) {
-		sysfs_remove_file(&dev->kobj,&attr->attr);
+		sysfs_remove_file(&dev->kobj, &attr->attr);
 		put_device(dev);
 	}
 }
@@ -179,7 +179,7 @@
  *	@dev:	device.
  *
  *	This prepares the device for use by other layers,
- *	including adding it to the device hierarchy. 
+ *	including adding it to the device hierarchy.
  *	It is the first half of device_register(), if called by
  *	that, though it can also be called separately, so one
  *	may use @dev's fields (e.g. the refcount).
@@ -187,7 +187,7 @@
 
 void device_initialize(struct device *dev)
 {
-	kobj_set_kset_s(dev,devices_subsys);
+	kobj_set_kset_s(dev, devices_subsys);
 	kobject_init(&dev->kobj);
 	INIT_LIST_HEAD(&dev->node);
 	INIT_LIST_HEAD(&dev->children);
@@ -200,7 +200,7 @@
  *	device_add - add device to device hierarchy.
  *	@dev:	device.
  *
- *	This is part 2 of device_register(), though may be called 
+ *	This is part 2 of device_register(), though may be called
  *	separately _iff_ device_initialize() has been called separately.
  *
  *	This adds it to the kobject hierarchy via kobject_add(), adds it
@@ -221,7 +221,7 @@
 	pr_debug("DEV: registering device: ID = '%s'\n", dev->bus_id);
 
 	/* first, register with generic layer. */
-	kobject_set_name(&dev->kobj,dev->bus_id);
+	kobject_set_name(&dev->kobj, dev->bus_id);
 	if (parent)
 		dev->kobj.parent = &parent->kobj;
 
@@ -233,7 +233,7 @@
 		goto BusError;
 	down_write(&devices_subsys.rwsem);
 	if (parent)
-		list_add_tail(&dev->node,&parent->children);
+		list_add_tail(&dev->node, &parent->children);
 	up_write(&devices_subsys.rwsem);
 
 	/* notify platform of device entry */
@@ -258,9 +258,9 @@
  *	@dev:	pointer to the device structure
  *
  *	This happens in two clean steps - initialize the device
- *	and add it to the system. The two steps can be called 
- *	separately, but this is the easiest and most common. 
- *	I.e. you should only call the two helpers separately if 
+ *	and add it to the system. The two steps can be called
+ *	separately, but this is the easiest and most common.
+ *	I.e. you should only call the two helpers separately if
  *	have a clearly defined need to use and refcount the device
  *	before it is added to the hierarchy.
  */
@@ -301,13 +301,13 @@
  *	device_del - delete device from system.
  *	@dev:	device.
  *
- *	This is the first part of the device unregistration 
+ *	This is the first part of the device unregistration
  *	sequence. This removes the device from the lists we control
- *	from here, has it removed from the other driver model 
+ *	from here, has it removed from the other driver model
  *	subsystems it was added to in device_add(), and removes it
  *	from the kobject hierarchy.
  *
- *	NOTE: this should be called manually _iff_ device_add() was 
+ *	NOTE: this should be called manually _iff_ device_add() was
  *	also called manually.
  */
 
@@ -340,7 +340,7 @@
  *	we remove it from all the subsystems with device_del(), then
  *	we decrement the reference count via put_device(). If that
  *	is the final reference count, the device will be cleaned up
- *	via device_release() above. Otherwise, the structure will 
+ *	via device_release() above. Otherwise, the structure will
  *	stick around until the final reference to the device is dropped.
  */
 void device_unregister(struct device * dev)
@@ -358,7 +358,7 @@
  *	@fn:	function to be called for each device.
  *
  *	Iterate over @dev's child devices, and call @fn for each,
- *	passing it @data. 
+ *	passing it @data.
  *
  *	We check the return of @fn each time. If it returns anything
  *	other than 0, we break out and return that value.
@@ -370,8 +370,8 @@
 	int error = 0;
 
 	down_read(&devices_subsys.rwsem);
-	list_for_each_entry(child,&dev->children,node) {
-		if((error = fn(child,data)))
+	list_for_each_entry(child, &dev->children, node) {
+		if((error = fn(child, data)))
 			break;
 	}
 	up_read(&devices_subsys.rwsem);
diff -Nru a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c	2004-06-10 01:34:24 -05:00
+++ b/drivers/base/driver.c	2004-06-10 01:34:24 -05:00
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2002-3 Patrick Mochel
  * Copyright (c) 2002-3 Open Source Development Labs
- * 
+ *
  * This file is released under the GPLv2
  *
  */
@@ -15,8 +15,8 @@
 #include <linux/string.h>
 #include "base.h"
 
-#define to_dev(node) container_of(node,struct device,driver_list)
-#define to_drv(obj) container_of(obj,struct device_driver,kobj)
+#define to_dev(node) container_of(node, struct device, driver_list)
+#define to_drv(obj) container_of(obj, struct device_driver, kobj)
 
 /**
  *	driver_create_file - create sysfs file for driver.
@@ -28,7 +28,7 @@
 {
 	int error;
 	if (get_driver(drv)) {
-		error = sysfs_create_file(&drv->kobj,&attr->attr);
+		error = sysfs_create_file(&drv->kobj, &attr->attr);
 		put_driver(drv);
 	} else
 		error = -EINVAL;
@@ -45,7 +45,7 @@
 void driver_remove_file(struct device_driver * drv, struct driver_attribute * attr)
 {
 	if (get_driver(drv)) {
-		sysfs_remove_file(&drv->kobj,&attr->attr);
+		sysfs_remove_file(&drv->kobj, &attr->attr);
 		put_driver(drv);
 	}
 }
@@ -76,7 +76,7 @@
  *	@drv:	driver to register
  *
  *	We pass off most of the work to the bus_add_driver() call,
- *	since most of the things we have to do deal with the bus 
+ *	since most of the things we have to do deal with the bus
  *	structures.
  *
  *	The one interesting aspect is that we initialize @drv->unload_sem
@@ -99,8 +99,8 @@
  *
  *	Though, once that is done, we attempt to take @drv->unload_sem.
  *	This will block until the driver refcount reaches 0, and it is
- *	released. Only modular drivers will call this function, and we 
- *	have to guarantee that it won't complete, letting the driver 
+ *	released. Only modular drivers will call this function, and we
+ *	have to guarantee that it won't complete, letting the driver
  *	unload until all references are gone.
  */
 
diff -Nru a/drivers/base/firmware.c b/drivers/base/firmware.c
--- a/drivers/base/firmware.c	2004-06-10 01:34:24 -05:00
+++ b/drivers/base/firmware.c	2004-06-10 01:34:24 -05:00
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2002-3 Patrick Mochel
  * Copyright (c) 2002-3 Open Source Development Labs
- * 
+ *
  * This file is released under the GPLv2
  *
  */
@@ -12,11 +12,11 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
-static decl_subsys(firmware,NULL,NULL);
+static decl_subsys(firmware, NULL, NULL);
 
 int firmware_register(struct subsystem * s)
 {
-	kset_set_kset_s(s,firmware_subsys);
+	kset_set_kset_s(s, firmware_subsys);
 	return subsystem_register(s);
 }
 
diff -Nru a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
--- a/drivers/base/firmware_class.c	2004-06-10 01:34:24 -05:00
+++ b/drivers/base/firmware_class.c	2004-06-10 01:34:24 -05:00
@@ -68,7 +68,7 @@
  *	firmware will be provided.
  *
  *	Note: zero means 'wait for ever'
- *  
+ *
  **/
 static ssize_t
 firmware_timeout_store(struct class *class, const char *buf, size_t count)
@@ -121,7 +121,7 @@
 /**
  * firmware_loading_store: - loading control file
  * Description:
- *	The relevant values are: 
+ *	The relevant values are:
  *
  *	 1: Start a load, discarding any previous partial load.
  *	 0: Conclude the load and handle the data to the driver code.
@@ -376,7 +376,7 @@
 	return retval;
 }
 
-/** 
+/**
  * request_firmware: - request firmware to hotplug and wait for it
  * Description:
  *	@firmware will be used to return a firmware image by the name
@@ -457,7 +457,7 @@
 
 /**
  * register_firmware: - provide a firmware image for later usage
- * 
+ *
  * Description:
  *	Make sure that @data will be available by requesting firmware @name.
  *
@@ -541,7 +541,7 @@
 
 	ret = kernel_thread(request_firmware_work_func, fw_work,
 			    CLONE_FS | CLONE_FILES);
-	
+
 	if (ret < 0) {
 		fw_work->cont(NULL, fw_work->context);
 		return ret;
diff -Nru a/drivers/base/init.c b/drivers/base/init.c
--- a/drivers/base/init.c	2004-06-10 01:34:24 -05:00
+++ b/drivers/base/init.c	2004-06-10 01:34:24 -05:00
@@ -2,7 +2,7 @@
  *
  * Copyright (c) 2002-3 Patrick Mochel
  * Copyright (c) 2002-3 Open Source Development Labs
- * 
+ *
  * This file is released under the GPLv2
  *
  */
@@ -33,7 +33,7 @@
 	classes_init();
 	firmware_init();
 
-	/* These are also core pieces, but must come after the 
+	/* These are also core pieces, but must come after the
 	 * core core pieces.
 	 */
 	platform_bus_init();
diff -Nru a/drivers/base/interface.c b/drivers/base/interface.c
--- a/drivers/base/interface.c	2004-06-10 01:34:24 -05:00
+++ b/drivers/base/interface.c	2004-06-10 01:34:24 -05:00
@@ -1,10 +1,10 @@
 /*
- * drivers/base/interface.c - common driverfs interface that's exported to 
+ * drivers/base/interface.c - common driverfs interface that's exported to
  * 	the world for all devices.
  *
  * Copyright (c) 2002-3 Patrick Mochel
  * Copyright (c) 2002-3 Open Source Development Labs
- * 
+ *
  * This file is released under the GPLv2
  *
  */
@@ -16,33 +16,33 @@
 
 /**
  *	detach_state - control the default power state for the device.
- *	
- *	This is the state the device enters when it's driver module is 
+ *
+ *	This is the state the device enters when it's driver module is
  *	unloaded. The value is an unsigned integer, in the range of 0-4.
  *	'0' indicates 'On', so no action will be taken when the driver is
  *	unloaded. This is the default behavior.
  *	'4' indicates 'Off', meaning the driver core will call the driver's
  *	shutdown method to quiesce the device.
- *	1-3 indicate a low-power state for the device to enter via the 
- *	driver's suspend method. 
+ *	1-3 indicate a low-power state for the device to enter via the
+ *	driver's suspend method.
  */
 
 static ssize_t detach_show(struct device * dev, char * buf)
 {
-	return sprintf(buf,"%u\n",dev->detach_state);
+	return sprintf(buf, "%u\n", dev->detach_state);
 }
 
 static ssize_t detach_store(struct device * dev, const char * buf, size_t n)
 {
 	u32 state;
-	state = simple_strtoul(buf,NULL,10);
+	state = simple_strtoul(buf, NULL, 10);
 	if (state > 4)
 		return -EINVAL;
 	dev->detach_state = state;
 	return n;
 }
 
-static DEVICE_ATTR(detach_state,0644,detach_show,detach_store);
+static DEVICE_ATTR(detach_state, 0644, detach_show, detach_store);
 
 
 struct attribute * dev_default_attrs[] = {
diff -Nru a/drivers/base/node.c b/drivers/base/node.c
--- a/drivers/base/node.c	2004-06-10 01:34:24 -05:00
+++ b/drivers/base/node.c	2004-06-10 01:34:24 -05:00
@@ -29,7 +29,7 @@
 	return len;
 }
 
-static SYSDEV_ATTR(cpumap,S_IRUGO,node_read_cpumap,NULL);
+static SYSDEV_ATTR(cpumap, S_IRUGO, node_read_cpumap, NULL);
 
 /* Can be overwritten by architecture specific code. */
 int __attribute__((weak)) hugetlb_report_node_meminfo(int node, char *buf)
@@ -54,17 +54,17 @@
 		       "Node %d LowFree:      %8lu kB\n",
 		       nid, K(i.totalram),
 		       nid, K(i.freeram),
-		       nid, K(i.totalram-i.freeram),
+		       nid, K(i.totalram - i.freeram),
 		       nid, K(i.totalhigh),
 		       nid, K(i.freehigh),
-		       nid, K(i.totalram-i.totalhigh),
-		       nid, K(i.freeram-i.freehigh));
+		       nid, K(i.totalram - i.totalhigh),
+		       nid, K(i.freeram - i.freehigh));
 	n += hugetlb_report_node_meminfo(nid, buf + n);
 	return n;
 }
 
-#undef K 
-static SYSDEV_ATTR(meminfo,S_IRUGO,node_read_meminfo,NULL);
+#undef K
+static SYSDEV_ATTR(meminfo, S_IRUGO, node_read_meminfo, NULL);
 
 static ssize_t node_read_numastat(struct sys_device * dev, char * buf)
 {
@@ -104,7 +104,7 @@
 		       local_node,
 		       other_node);
 }
-static SYSDEV_ATTR(numastat,S_IRUGO,node_read_numastat,NULL);
+static SYSDEV_ATTR(numastat, S_IRUGO, node_read_numastat, NULL);
 
 /*
  * register_node - Setup a driverfs device for a node.
diff -Nru a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c	2004-06-10 01:34:24 -05:00
+++ b/drivers/base/platform.c	2004-06-10 01:34:24 -05:00
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2002-3 Patrick Mochel
  * Copyright (c) 2002-3 Open Source Development Labs
- * 
+ *
  * This file is released under the GPLv2
  *
  * Please see Documentation/driver-model/platform.txt for more
@@ -33,14 +33,14 @@
 		pdev->dev.parent = &platform_bus;
 
 	pdev->dev.bus = &platform_bus_type;
-	
+
 	if (pdev->id != -1)
 		snprintf(pdev->dev.bus_id, BUS_ID_SIZE, "%s%u", pdev->name, pdev->id);
 	else
 		strlcpy(pdev->dev.bus_id, pdev->name, BUS_ID_SIZE);
 
 	pr_debug("Registering platform device '%s'. Parent at %s\n",
-		 pdev->dev.bus_id,pdev->dev.parent->bus_id);
+		 pdev->dev.bus_id, pdev->dev.parent->bus_id);
 	return device_register(&pdev->dev);
 }
 
@@ -106,13 +106,13 @@
  *	@dev:	device.
  *	@drv:	driver.
  *
- *	Platform device IDs are assumed to be encoded like this: 
- *	"<name><instance>", where <name> is a short description of the 
- *	type of device, like "pci" or "floppy", and <instance> is the 
+ *	Platform device IDs are assumed to be encoded like this:
+ *	"<name><instance>", where <name> is a short description of the
+ *	type of device, like "pci" or "floppy", and <instance> is the
  *	enumerated instance of the device, like '0' or '42'.
- *	Driver IDs are simply "<name>". 
- *	So, extract the <name> from the platform_device structure, 
- *	and compare it against the name of the driver. Return whether 
+ *	Driver IDs are simply "<name>".
+ *	So, extract the <name> from the platform_device structure,
+ *	and compare it against the name of the driver. Return whether
  *	they match or not.
  */
 
diff -Nru a/drivers/base/power/main.c b/drivers/base/power/main.c
--- a/drivers/base/power/main.c	2004-06-10 01:34:24 -05:00
+++ b/drivers/base/power/main.c	2004-06-10 01:34:24 -05:00
@@ -12,10 +12,10 @@
  * and add it to the list of power-controlled devices. sysfs entries for
  * controlling device power management will also be added.
  *
- * A different set of lists than the global subsystem list are used to 
- * keep track of power info because we use different lists to hold 
- * devices based on what stage of the power management process they 
- * are in. The power domain dependencies may also differ from the 
+ * A different set of lists than the global subsystem list are used to
+ * keep track of power info because we use different lists to hold
+ * devices based on what stage of the power management process they
+ * are in. The power domain dependencies may also differ from the
  * ancestral dependencies that the subsystem list maintains.
  */
 
@@ -74,10 +74,10 @@
 
 	pr_debug("PM: Adding info for %s:%s\n",
 		 dev->bus ? dev->bus->name : "No Bus", dev->kobj.name);
-	atomic_set(&dev->power.pm_users,0);
+	atomic_set(&dev->power.pm_users, 0);
 	down(&dpm_sem);
-	list_add_tail(&dev->power.entry,&dpm_active);
-	device_pm_set_parent(dev,dev->parent);
+	list_add_tail(&dev->power.entry, &dpm_active);
+	device_pm_set_parent(dev, dev->parent);
 	if ((error = dpm_sysfs_add(dev)))
 		list_del(&dev->power.entry);
 	up(&dpm_sem);
diff -Nru a/drivers/base/power/power.h b/drivers/base/power/power.h
--- a/drivers/base/power/power.h	2004-06-10 01:34:24 -05:00
+++ b/drivers/base/power/power.h	2004-06-10 01:34:24 -05:00
@@ -27,7 +27,7 @@
  */
 extern struct semaphore dpm_sem;
 
-/* 
+/*
  * The PM lists.
  */
 extern struct list_head dpm_active;
@@ -37,12 +37,12 @@
 
 static inline struct dev_pm_info * to_pm_info(struct list_head * entry)
 {
-	return container_of(entry,struct dev_pm_info,entry);
+	return container_of(entry, struct dev_pm_info, entry);
 }
 
 static inline struct device * to_device(struct list_head * entry)
 {
-	return container_of(to_pm_info(entry),struct device,power);
+	return container_of(to_pm_info(entry), struct device, power);
 }
 
 extern int device_pm_add(struct device *);
@@ -56,7 +56,7 @@
 extern void dpm_sysfs_remove(struct device *);
 
 /*
- * resume.c 
+ * resume.c
  */
 
 extern void dpm_resume(void);
diff -Nru a/drivers/base/power/resume.c b/drivers/base/power/resume.c
--- a/drivers/base/power/resume.c	2004-06-10 01:34:24 -05:00
+++ b/drivers/base/power/resume.c	2004-06-10 01:34:24 -05:00
@@ -39,7 +39,7 @@
 		if (!dev->power.prev_state)
 			resume_device(dev);
 
-		list_add_tail(entry,&dpm_active);
+		list_add_tail(entry, &dpm_active);
 	}
 }
 
@@ -48,7 +48,7 @@
  *	device_resume - Restore state of each device in system.
  *
  *	Walk the dpm_off list, remove each entry, resume the device,
- *	then add it to the dpm_active list. 
+ *	then add it to the dpm_active list.
  */
 
 void device_resume(void)
@@ -62,14 +62,14 @@
 
 
 /**
- *	device_power_up_irq - Power on some devices. 
+ *	device_power_up_irq - Power on some devices.
  *
- *	Walk the dpm_off_irq list and power each device up. This 
+ *	Walk the dpm_off_irq list and power each device up. This
  *	is used for devices that required they be powered down with
  *	interrupts disabled. As devices are powered on, they are moved to
  *	the dpm_suspended list.
  *
- *	Interrupts must be disabled when calling this. 
+ *	Interrupts must be disabled when calling this.
  */
 
 void dpm_power_up(void)
@@ -78,7 +78,7 @@
 		struct list_head * entry = dpm_off_irq.next;
 		list_del_init(entry);
 		resume_device(to_device(entry));
-		list_add_tail(entry,&dpm_active);
+		list_add_tail(entry, &dpm_active);
 	}
 }
 
diff -Nru a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
--- a/drivers/base/power/runtime.c	2004-06-10 01:34:24 -05:00
+++ b/drivers/base/power/runtime.c	2004-06-10 01:34:24 -05:00
@@ -24,9 +24,9 @@
  *	dpm_runtime_resume - Power one device back on.
  *	@dev:	Device.
  *
- *	Bring one device back to the on state by first powering it 
+ *	Bring one device back to the on state by first powering it
  *	on, then restoring state. We only operate on devices that aren't
- *	already on. 
+ *	already on.
  *	FIXME: We need to handle devices that are in an unknown state.
  */
 
@@ -55,7 +55,7 @@
 	if (dev->power.power_state)
 		runtime_resume(dev);
 
-	if (!(error = suspend_device(dev,state)))
+	if (!(error = suspend_device(dev, state)))
 		dev->power.power_state = state;
  Done:
 	up(&dpm_sem);
@@ -70,7 +70,7 @@
  *
  *	This is an update mechanism for drivers to notify the core
  *	what power state a device is in. Device probing code may not
- *	always be able to tell, but we need accurate information to 
+ *	always be able to tell, but we need accurate information to
  *	work reliably.
  */
 void dpm_set_power_state(struct device * dev, u32 state)
diff -Nru a/drivers/base/power/shutdown.c b/drivers/base/power/shutdown.c
--- a/drivers/base/power/shutdown.c	2004-06-10 01:34:24 -05:00
+++ b/drivers/base/power/shutdown.c	2004-06-10 01:34:24 -05:00
@@ -1,9 +1,9 @@
 /*
  * shutdown.c - power management functions for the device tree.
- * 
+ *
  * Copyright (c) 2002-3 Patrick Mochel
  *		 2002-3 Open Source Development Lab
- * 
+ *
  * This file is released under the GPLv2
  *
  */
@@ -14,7 +14,7 @@
 
 #include "power.h"
 
-#define to_dev(node) container_of(node,struct device,kobj.entry)
+#define to_dev(node) container_of(node, struct device, kobj.entry)
 
 extern struct subsystem devices_subsys;
 
@@ -29,7 +29,7 @@
 			dev->driver->shutdown(dev);
 		return 0;
 	}
-	return dpm_runtime_suspend(dev,dev->detach_state);
+	return dpm_runtime_suspend(dev, dev->detach_state);
 }
 
 
@@ -38,8 +38,8 @@
  * down last and resume them first. That way, we don't do anything stupid like
  * shutting down the interrupt controller before any devices..
  *
- * Note that there are not different stages for power management calls - 
- * they only get one called once when interrupts are disabled. 
+ * Note that there are not different stages for power management calls -
+ * they only get one called once when interrupts are disabled.
  */
 
 extern int sysdev_shutdown(void);
@@ -50,10 +50,10 @@
 void device_shutdown(void)
 {
 	struct device * dev;
-	
+
 	down_write(&devices_subsys.rwsem);
-	list_for_each_entry_reverse(dev,&devices_subsys.kset.list,kobj.entry) {
-		pr_debug("shutting down %s: ",dev->bus_id);
+	list_for_each_entry_reverse(dev, &devices_subsys.kset.list, kobj.entry) {
+		pr_debug("shutting down %s: ", dev->bus_id);
 		if (dev->driver && dev->driver->shutdown) {
 			pr_debug("Ok\n");
 			dev->driver->shutdown(dev);
diff -Nru a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
--- a/drivers/base/power/suspend.c	2004-06-10 01:34:24 -05:00
+++ b/drivers/base/power/suspend.c	2004-06-10 01:34:24 -05:00
@@ -1,5 +1,5 @@
 /*
- * suspend.c - Functions for putting devices to sleep. 
+ * suspend.c - Functions for putting devices to sleep.
  *
  * Copyright (c) 2003 Patrick Mochel
  * Copyright (c) 2003 Open Source Development Labs
@@ -10,18 +10,18 @@
 
 #include <linux/device.h>
 #include "power.h"
- 
+
 extern int sysdev_suspend(u32 state);
 
 /*
  * The entries in the dpm_active list are in a depth first order, simply
- * because children are guaranteed to be discovered after parents, and 
- * are inserted at the back of the list on discovery. 
- * 
+ * because children are guaranteed to be discovered after parents, and
+ * are inserted at the back of the list on discovery.
+ *
  * All list on the suspend path are done in reverse order, so we operate
  * on the leaves of the device tree (or forests, depending on how you want
- * to look at it ;) first. As nodes are removed from the back of the list, 
- * they are inserted into the front of their destintation lists. 
+ * to look at it ;) first. As nodes are removed from the back of the list,
+ * they are inserted into the front of their destintation lists.
  *
  * Things are the reverse on the resume path - iterations are done in
  * forward order, and nodes are inserted at the back of their destination
@@ -44,7 +44,7 @@
 	dev->power.prev_state = dev->power.power_state;
 
 	if (dev->bus && dev->bus->suspend && !dev->power.power_state)
-		error = dev->bus->suspend(dev,state);
+		error = dev->bus->suspend(dev, state);
 
 	return error;
 }
@@ -52,16 +52,16 @@
 
 /**
  *	device_suspend - Save state and stop all devices in system.
- *	@state:		Power state to put each device in. 
+ *	@state:		Power state to put each device in.
  *
  *	Walk the dpm_active list, call ->suspend() for each device, and move
- *	it to dpm_off. 
+ *	it to dpm_off.
  *	Check the return value for each. If it returns 0, then we move the
- *	the device to the dpm_off list. If it returns -EAGAIN, we move it to 
- *	the dpm_off_irq list. If we get a different error, try and back out. 
+ *	the device to the dpm_off list. If it returns -EAGAIN, we move it to
+ *	the dpm_off_irq list. If we get a different error, try and back out.
  *
  *	If we hit a failure with any of the devices, call device_resume()
- *	above to bring the suspended devices back to life. 
+ *	above to bring the suspended devices back to life.
  *
  *	Note this function leaves dpm_sem held to
  *	a) block other devices from registering.
@@ -78,14 +78,14 @@
 	while(!list_empty(&dpm_active)) {
 		struct list_head * entry = dpm_active.prev;
 		struct device * dev = to_device(entry);
-		error = suspend_device(dev,state);
+		error = suspend_device(dev, state);
 
 		if (!error) {
 			list_del(&dev->power.entry);
-			list_add(&dev->power.entry,&dpm_off);
+			list_add(&dev->power.entry, &dpm_off);
 		} else if (error == -EAGAIN) {
 			list_del(&dev->power.entry);
-			list_add(&dev->power.entry,&dpm_off_irq);
+			list_add(&dev->power.entry, &dpm_off_irq);
 		} else {
 			printk(KERN_ERR "Could not suspend device %s: "
 				"error %d\n", kobject_name(&dev->kobj), error);
@@ -108,8 +108,8 @@
  *	@state:		Power state to enter.
  *
  *	Walk the dpm_off_irq list, calling ->power_down() for each device that
- *	couldn't power down the device with interrupts enabled. When we're 
- *	done, power down system devices. 
+ *	couldn't power down the device with interrupts enabled. When we're
+ *	done, power down system devices.
  */
 
 int device_power_down(u32 state)
@@ -117,10 +117,10 @@
 	int error = 0;
 	struct device * dev;
 
-	list_for_each_entry_reverse(dev,&dpm_off_irq,power.entry) {
-		if ((error = suspend_device(dev,state)))
+	list_for_each_entry_reverse(dev, &dpm_off_irq, power.entry) {
+		if ((error = suspend_device(dev, state)))
 			break;
-	} 
+	}
 	if (error)
 		goto Error;
 	if ((error = sysdev_suspend(state)))
diff -Nru a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
--- a/drivers/base/power/sysfs.c	2004-06-10 01:34:24 -05:00
+++ b/drivers/base/power/sysfs.c	2004-06-10 01:34:24 -05:00
@@ -11,10 +11,10 @@
  *
  *	show() returns the current power state of the device. '0' indicates
  *	the device is on. Other values (1-3) indicate the device is in a low
- *	power state. 
+ *	power state.
  *
- *	store() sets the current power state, which is an integer value 
- *	between 0-3. If the device is on ('0'), and the value written is 
+ *	store() sets the current power state, which is an integer value
+ *	between 0-3. If the device is on ('0'), and the value written is
  *	greater than 0, then the device is placed directly into the low-power
  *	state (via its driver's ->suspend() method).
  *	If the device is currently in a low-power state, and the value is 0,
@@ -26,7 +26,7 @@
 
 static ssize_t state_show(struct device * dev, char * buf)
 {
-	return sprintf(buf,"%u\n",dev->power.power_state);
+	return sprintf(buf, "%u\n", dev->power.power_state);
 }
 
 static ssize_t state_store(struct device * dev, const char * buf, size_t n)
@@ -35,17 +35,17 @@
 	char * rest;
 	int error = 0;
 
-	state = simple_strtoul(buf,&rest,10);
+	state = simple_strtoul(buf, &rest, 10);
 	if (*rest)
 		return -EINVAL;
 	if (state)
-		error = dpm_runtime_suspend(dev,state);
+		error = dpm_runtime_suspend(dev, state);
 	else
 		dpm_runtime_resume(dev);
 	return error ? error : n;
 }
 
-static DEVICE_ATTR(state,0644,state_show,state_store);
+static DEVICE_ATTR(state, 0644, state_show, state_store);
 
 
 static struct attribute * power_attrs[] = {
@@ -59,10 +59,10 @@
 
 int dpm_sysfs_add(struct device * dev)
 {
-	return sysfs_create_group(&dev->kobj,&pm_attr_group);
+	return sysfs_create_group(&dev->kobj, &pm_attr_group);
 }
 
 void dpm_sysfs_remove(struct device * dev)
 {
-	sysfs_remove_group(&dev->kobj,&pm_attr_group);
+	sysfs_remove_group(&dev->kobj, &pm_attr_group);
 }
diff -Nru a/drivers/base/sys.c b/drivers/base/sys.c
--- a/drivers/base/sys.c	2004-06-10 01:34:24 -05:00
+++ b/drivers/base/sys.c	2004-06-10 01:34:24 -05:00
@@ -5,8 +5,8 @@
  *               2002-3 Open Source Development Lab
  *
  * This file is released under the GPLv2
- * 
- * This exports a 'system' bus type. 
+ *
+ * This exports a 'system' bus type.
  * By default, a 'sys' bus gets added to the root of the system. There will
  * always be core system devices. Devices can use sysdev_register() to
  * add themselves as children of the system bus.
@@ -24,31 +24,31 @@
 
 extern struct subsystem devices_subsys;
 
-#define to_sysdev(k) container_of(k,struct sys_device,kobj)
-#define to_sysdev_attr(a) container_of(a,struct sysdev_attribute,attr)
+#define to_sysdev(k) container_of(k, struct sys_device, kobj)
+#define to_sysdev_attr(a) container_of(a, struct sysdev_attribute, attr)
 
 
-static ssize_t 
+static ssize_t
 sysdev_show(struct kobject * kobj, struct attribute * attr, char * buffer)
 {
 	struct sys_device * sysdev = to_sysdev(kobj);
 	struct sysdev_attribute * sysdev_attr = to_sysdev_attr(attr);
 
 	if (sysdev_attr->show)
-		return sysdev_attr->show(sysdev,buffer);
+		return sysdev_attr->show(sysdev, buffer);
 	return 0;
 }
 
 
 static ssize_t
-sysdev_store(struct kobject * kobj, struct attribute * attr, 
+sysdev_store(struct kobject * kobj, struct attribute * attr,
 	     const char * buffer, size_t count)
 {
 	struct sys_device * sysdev = to_sysdev(kobj);
 	struct sysdev_attribute * sysdev_attr = to_sysdev_attr(attr);
 
 	if (sysdev_attr->store)
-		return sysdev_attr->store(sysdev,buffer,count);
+		return sysdev_attr->store(sysdev, buffer, count);
 	return 0;
 }
 
@@ -64,22 +64,22 @@
 
 int sysdev_create_file(struct sys_device * s, struct sysdev_attribute * a)
 {
-	return sysfs_create_file(&s->kobj,&a->attr);
+	return sysfs_create_file(&s->kobj, &a->attr);
 }
 
 
 void sysdev_remove_file(struct sys_device * s, struct sysdev_attribute * a)
 {
-	sysfs_remove_file(&s->kobj,&a->attr);
+	sysfs_remove_file(&s->kobj, &a->attr);
 }
 
 EXPORT_SYMBOL(sysdev_create_file);
 EXPORT_SYMBOL(sysdev_remove_file);
 
-/* 
- * declare system_subsys 
+/*
+ * declare system_subsys
  */
-decl_subsys(system,&ktype_sysdev,NULL);
+decl_subsys(system, &ktype_sysdev, NULL);
 
 int sysdev_class_register(struct sysdev_class * cls)
 {
@@ -87,7 +87,7 @@
 		 kobject_name(&cls->kset.kobj));
 	INIT_LIST_HEAD(&cls->drivers);
 	cls->kset.subsys = &system_subsys;
-	kset_set_kset_s(cls,system_subsys);
+	kset_set_kset_s(cls, system_subsys);
 	return kset_register(&cls->kset);
 }
 
@@ -109,19 +109,19 @@
  * 	@cls:	Device class driver belongs to.
  *	@drv:	Driver.
  *
- *	If @cls is valid, then @drv is inserted into @cls->drivers to be 
+ *	If @cls is valid, then @drv is inserted into @cls->drivers to be
  *	called on each operation on devices of that class. The refcount
- *	of @cls is incremented. 
- *	Otherwise, @drv is inserted into global_drivers, and called for 
+ *	of @cls is incremented.
+ *	Otherwise, @drv is inserted into global_drivers, and called for
  *	each device.
  */
 
-int sysdev_driver_register(struct sysdev_class * cls, 
+int sysdev_driver_register(struct sysdev_class * cls,
 			   struct sysdev_driver * drv)
 {
 	down_write(&system_subsys.rwsem);
 	if (cls && kset_get(&cls->kset)) {
-		list_add_tail(&drv->entry,&cls->drivers);
+		list_add_tail(&drv->entry, &cls->drivers);
 
 		/* If devices of this class already exist, tell the driver */
 		if (drv->add) {
@@ -130,7 +130,7 @@
 				drv->add(dev);
 		}
 	} else
-		list_add_tail(&drv->entry,&global_drivers);
+		list_add_tail(&drv->entry, &global_drivers);
 	up_write(&system_subsys.rwsem);
 	return 0;
 }
@@ -180,12 +180,12 @@
 
 	/* But make sure we point to the right type for sysfs translation */
 	sysdev->kobj.ktype = &ktype_sysdev;
-	error = kobject_set_name(&sysdev->kobj,"%s%d",
-			 kobject_name(&cls->kset.kobj),sysdev->id);
+	error = kobject_set_name(&sysdev->kobj, "%s%d",
+			 kobject_name(&cls->kset.kobj), sysdev->id);
 	if (error)
 		return error;
 
-	pr_debug("Registering sys device '%s'\n",kobject_name(&sysdev->kobj));
+	pr_debug("Registering sys device '%s'\n", kobject_name(&sysdev->kobj));
 
 	/* Register the object */
 	error = kobject_register(&sysdev->kobj);
@@ -194,18 +194,18 @@
 		struct sysdev_driver * drv;
 
 		down_write(&system_subsys.rwsem);
-		/* Generic notification is implicit, because it's that 
-		 * code that should have called us. 
+		/* Generic notification is implicit, because it's that
+		 * code that should have called us.
 		 */
 
 		/* Notify global drivers */
-		list_for_each_entry(drv,&global_drivers,entry) {
+		list_for_each_entry(drv, &global_drivers, entry) {
 			if (drv->add)
 				drv->add(sysdev);
 		}
 
 		/* Notify class auxillary drivers */
-		list_for_each_entry(drv,&cls->drivers,entry) {
+		list_for_each_entry(drv, &cls->drivers, entry) {
 			if (drv->add)
 				drv->add(sysdev);
 		}
@@ -219,12 +219,12 @@
 	struct sysdev_driver * drv;
 
 	down_write(&system_subsys.rwsem);
-	list_for_each_entry(drv,&global_drivers,entry) {
+	list_for_each_entry(drv, &global_drivers, entry) {
 		if (drv->remove)
 			drv->remove(sysdev);
 	}
 
-	list_for_each_entry(drv,&sysdev->cls->drivers,entry) {
+	list_for_each_entry(drv, &sysdev->cls->drivers, entry) {
 		if (drv->remove)
 			drv->remove(sysdev);
 	}
@@ -241,12 +241,12 @@
  *	Loop over each class of system devices, and the devices in each
  *	of those classes. For each device, we call the shutdown method for
  *	each driver registered for the device - the globals, the auxillaries,
- *	and the class driver. 
+ *	and the class driver.
  *
  *	Note: The list is iterated in reverse order, so that we shut down
  *	child devices before we shut down thier parents. The list ordering
  *	is guaranteed by virtue of the fact that child devices are registered
- *	after their parents. 
+ *	after their parents.
  */
 
 void sysdev_shutdown(void)
@@ -256,25 +256,25 @@
 	pr_debug("Shutting Down System Devices\n");
 
 	down_write(&system_subsys.rwsem);
-	list_for_each_entry_reverse(cls,&system_subsys.kset.list,
+	list_for_each_entry_reverse(cls, &system_subsys.kset.list,
 				    kset.kobj.entry) {
 		struct sys_device * sysdev;
 
 		pr_debug("Shutting down type '%s':\n",
 			 kobject_name(&cls->kset.kobj));
 
-		list_for_each_entry(sysdev,&cls->kset.list,kobj.entry) {
+		list_for_each_entry(sysdev, &cls->kset.list, kobj.entry) {
 			struct sysdev_driver * drv;
-			pr_debug(" %s\n",kobject_name(&sysdev->kobj));
+			pr_debug(" %s\n", kobject_name(&sysdev->kobj));
 
 			/* Call global drivers first. */
-			list_for_each_entry(drv,&global_drivers,entry) {
+			list_for_each_entry(drv, &global_drivers, entry) {
 				if (drv->shutdown)
 					drv->shutdown(sysdev);
 			}
 
 			/* Call auxillary drivers next. */
-			list_for_each_entry(drv,&cls->drivers,entry) {
+			list_for_each_entry(drv, &cls->drivers, entry) {
 				if (drv->shutdown)
 					drv->shutdown(sysdev);
 			}
@@ -295,7 +295,7 @@
  *	We perform an almost identical operation as sys_device_shutdown()
  *	above, though calling ->suspend() instead. Interrupts are disabled
  *	when this called. Devices are responsible for both saving state and
- *	quiescing or powering down the device. 
+ *	quiescing or powering down the device.
  *
  *	This is only called by the device PM core, so we let them handle
  *	all synchronization.
@@ -307,32 +307,32 @@
 
 	pr_debug("Suspending System Devices\n");
 
-	list_for_each_entry_reverse(cls,&system_subsys.kset.list,
+	list_for_each_entry_reverse(cls, &system_subsys.kset.list,
 				    kset.kobj.entry) {
 		struct sys_device * sysdev;
 
 		pr_debug("Suspending type '%s':\n",
 			 kobject_name(&cls->kset.kobj));
 
-		list_for_each_entry(sysdev,&cls->kset.list,kobj.entry) {
+		list_for_each_entry(sysdev, &cls->kset.list, kobj.entry) {
 			struct sysdev_driver * drv;
-			pr_debug(" %s\n",kobject_name(&sysdev->kobj));
+			pr_debug(" %s\n", kobject_name(&sysdev->kobj));
 
 			/* Call global drivers first. */
-			list_for_each_entry(drv,&global_drivers,entry) {
+			list_for_each_entry(drv, &global_drivers, entry) {
 				if (drv->suspend)
-					drv->suspend(sysdev,state);
+					drv->suspend(sysdev, state);
 			}
 
 			/* Call auxillary drivers next. */
-			list_for_each_entry(drv,&cls->drivers,entry) {
+			list_for_each_entry(drv, &cls->drivers, entry) {
 				if (drv->suspend)
-					drv->suspend(sysdev,state);
+					drv->suspend(sysdev, state);
 			}
 
 			/* Now call the generic one */
 			if (cls->suspend)
-				cls->suspend(sysdev,state);
+				cls->suspend(sysdev, state);
 		}
 	}
 	return 0;
@@ -345,7 +345,7 @@
  *	Similar to sys_device_suspend(), but we iterate the list forwards
  *	to guarantee that parent devices are resumed before their children.
  *
- *	Note: Interrupts are disabled when called. 
+ *	Note: Interrupts are disabled when called.
  */
 
 int sysdev_resume(void)
@@ -354,28 +354,28 @@
 
 	pr_debug("Resuming System Devices\n");
 
-	list_for_each_entry(cls,&system_subsys.kset.list,kset.kobj.entry) {
+	list_for_each_entry(cls, &system_subsys.kset.list, kset.kobj.entry) {
 		struct sys_device * sysdev;
 
 		pr_debug("Resuming type '%s':\n",
 			 kobject_name(&cls->kset.kobj));
 
-		list_for_each_entry(sysdev,&cls->kset.list,kobj.entry) {
+		list_for_each_entry(sysdev, &cls->kset.list, kobj.entry) {
 			struct sysdev_driver * drv;
-			pr_debug(" %s\n",kobject_name(&sysdev->kobj));
+			pr_debug(" %s\n", kobject_name(&sysdev->kobj));
 
 			/* First, call the class-specific one */
 			if (cls->resume)
 				cls->resume(sysdev);
 
 			/* Call auxillary drivers next. */
-			list_for_each_entry(drv,&cls->drivers,entry) {
+			list_for_each_entry(drv, &cls->drivers, entry) {
 				if (drv->resume)
 					drv->resume(sysdev);
 			}
 
 			/* Call global drivers. */
-			list_for_each_entry(drv,&global_drivers,entry) {
+			list_for_each_entry(drv, &global_drivers, entry) {
 				if (drv->resume)
 					drv->resume(sysdev);
 			}
