Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVDUHh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVDUHh5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 03:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVDUHh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 03:37:57 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:38071 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261432AbVDUHaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:30:10 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: sensors@Stimpy.netroedge.com
Subject: [RFC/PATCH 1/22] W1: whitespace fixes
Date: Thu, 21 Apr 2005 02:08:05 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
References: <200504210207.02421.dtor_core@ameritech.net>
In-Reply-To: <200504210207.02421.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504210208.06123.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W1: whitespace fixes.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 Kconfig        |   14 +++---
 Makefile       |    2 
 ds_w1_bridge.c |   24 +++++-----
 dscore.c       |  126 ++++++++++++++++++++++++++++-----------------------------
 dscore.h       |    6 +-
 matrox_w1.c    |   10 ++--
 w1.c           |   48 ++++++++++-----------
 w1.h           |   36 ++++++++--------
 w1_family.c    |    4 -
 w1_family.h    |   10 ++--
 w1_int.c       |   18 ++++----
 w1_int.h       |    4 -
 w1_io.c        |    4 -
 w1_io.h        |    4 -
 w1_log.h       |    4 -
 w1_netlink.h   |    4 -
 w1_smem.c      |   10 ++--
 w1_therm.c     |   18 ++++----
 18 files changed, 173 insertions(+), 173 deletions(-)

Index: dtor/drivers/w1/ds_w1_bridge.c
===================================================================
--- dtor.orig/drivers/w1/ds_w1_bridge.c
+++ dtor/drivers/w1/ds_w1_bridge.c
@@ -1,8 +1,8 @@
 /*
- * 	ds_w1_bridge.c
+ *	ds_w1_bridge.c
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -25,7 +25,7 @@
 #include "../w1/w1.h"
 #include "../w1/w1_int.h"
 #include "dscore.h"
-	
+
 static struct ds_device *ds_dev;
 static struct w1_bus_master *ds_bus_master;
 
@@ -120,7 +120,7 @@ static u8 ds9490r_reset(unsigned long da
 static int __devinit ds_w1_init(void)
 {
 	int err;
-	
+
 	ds_bus_master = kmalloc(sizeof(*ds_bus_master), GFP_KERNEL);
 	if (!ds_bus_master) {
 		printk(KERN_ERR "Failed to allocate DS9490R USB<->W1 bus_master structure.\n");
@@ -136,14 +136,14 @@ static int __devinit ds_w1_init(void)
 
 	memset(ds_bus_master, 0, sizeof(*ds_bus_master));
 
-	ds_bus_master->data 		= (unsigned long)ds_dev;
-	ds_bus_master->touch_bit 	= &ds9490r_touch_bit;
-	ds_bus_master->read_bit 	= &ds9490r_read_bit;
-	ds_bus_master->write_bit 	= &ds9490r_write_bit;
-	ds_bus_master->read_byte 	= &ds9490r_read_byte;
-	ds_bus_master->write_byte 	= &ds9490r_write_byte;
-	ds_bus_master->read_block 	= &ds9490r_read_block;
-	ds_bus_master->write_block 	= &ds9490r_write_block;
+	ds_bus_master->data		= (unsigned long)ds_dev;
+	ds_bus_master->touch_bit	= &ds9490r_touch_bit;
+	ds_bus_master->read_bit		= &ds9490r_read_bit;
+	ds_bus_master->write_bit	= &ds9490r_write_bit;
+	ds_bus_master->read_byte	= &ds9490r_read_byte;
+	ds_bus_master->write_byte	= &ds9490r_write_byte;
+	ds_bus_master->read_block	= &ds9490r_read_block;
+	ds_bus_master->write_block	= &ds9490r_write_block;
 	ds_bus_master->reset_bus	= &ds9490r_reset;
 
 	err = w1_add_master_device(ds_bus_master);
Index: dtor/drivers/w1/w1_io.h
===================================================================
--- dtor.orig/drivers/w1/w1_io.h
+++ dtor/drivers/w1/w1_io.h
@@ -1,8 +1,8 @@
 /*
- * 	w1_io.h
+ *	w1_io.h
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
Index: dtor/drivers/w1/w1_therm.c
===================================================================
--- dtor.orig/drivers/w1/w1_therm.c
+++ dtor/drivers/w1/w1_therm.c
@@ -1,8 +1,8 @@
 /*
- * 	w1_therm.c
+ *	w1_therm.c
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the therms of the GNU General Public License as published by
@@ -38,7 +38,7 @@ MODULE_AUTHOR("Evgeniy Polyakov <johnpol
 MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol, temperature family.");
 
 static u8 bad_roms[][9] = {
-				{0xaa, 0x00, 0x4b, 0x46, 0xff, 0xff, 0x0c, 0x10, 0x87}, 
+				{0xaa, 0x00, 0x4b, 0x46, 0xff, 0xff, 0x0c, 0x10, 0x87},
 				{}
 			};
 
@@ -63,12 +63,12 @@ static ssize_t w1_therm_read_name(struct
 static inline int w1_convert_temp(u8 rom[9])
 {
 	int t, h;
-	
+
 	if (rom[1] == 0)
 		t = ((s32)rom[0] >> 1)*1000;
 	else
 		t = 1000*(-1*(s32)(0x100-rom[0]) >> 1);
-	
+
 	t -= 250;
 	h = 1000*((s32)rom[7] - (s32)rom[6]);
 	h /= (s32)rom[7];
@@ -98,7 +98,7 @@ static int w1_therm_check_rom(u8 rom[9])
 static ssize_t w1_therm_read_bin(struct kobject *kobj, char *buf, loff_t off, size_t count)
 {
 	struct w1_slave *sl = container_of(container_of(kobj, struct device, kobj),
-			      			struct w1_slave, dev);
+					   struct w1_slave, dev);
 	struct w1_master *dev = sl->master;
 	u8 rom[9], crc, verdict;
 	int i, max_trying = 10;
@@ -133,7 +133,7 @@ static ssize_t w1_therm_read_bin(struct 
 			unsigned int tm = 750;
 
 			memcpy(&match[1], (u64 *) & sl->reg_num, 8);
-			
+
 			w1_write_block(dev, match, 9);
 
 			w1_write_8(dev, W1_CONVERT_TEMP);
@@ -146,7 +146,7 @@ static ssize_t w1_therm_read_bin(struct 
 
 			if (!w1_reset_bus (dev)) {
 				w1_write_block(dev, match, 9);
-				
+
 				w1_write_8(dev, W1_READ_SCRATCHPAD);
 				if ((count = w1_read_block(dev, rom, 9)) != 9) {
 					dev_warn(&dev->dev, "w1_read_block() returned %d instead of 9.\n", count);
@@ -175,7 +175,7 @@ static ssize_t w1_therm_read_bin(struct 
 
 	for (i = 0; i < 9; ++i)
 		count += sprintf(buf + count, "%02x ", sl->rom[i]);
-	
+
 	count += sprintf(buf + count, "t=%d\n", w1_convert_temp(rom));
 out:
 	up(&dev->mutex);
Index: dtor/drivers/w1/w1_netlink.h
===================================================================
--- dtor.orig/drivers/w1/w1_netlink.h
+++ dtor/drivers/w1/w1_netlink.h
@@ -33,13 +33,13 @@ enum w1_netlink_message_types {
 	W1_MASTER_REMOVE,
 };
 
-struct w1_netlink_msg 
+struct w1_netlink_msg
 {
 	__u8				type;
 	__u8				reserved[3];
 	union
 	{
-		struct w1_reg_num 	id;
+		struct w1_reg_num	id;
 		__u64			w1_id;
 		struct
 		{
Index: dtor/drivers/w1/dscore.h
===================================================================
--- dtor.orig/drivers/w1/dscore.h
+++ dtor/drivers/w1/dscore.h
@@ -1,8 +1,8 @@
 /*
- * 	dscore.h
+ *	dscore.h
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -122,7 +122,7 @@
 
 struct ds_device
 {
-	struct usb_device 	*udev;
+	struct usb_device	*udev;
 	struct usb_interface	*intf;
 
 	int			ep[NUM_EP];
Index: dtor/drivers/w1/w1_int.c
===================================================================
--- dtor.orig/drivers/w1/w1_int.c
+++ dtor/drivers/w1/w1_int.c
@@ -1,8 +1,8 @@
 /*
- * 	w1_int.c
+ *	w1_int.c
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -60,13 +60,13 @@ struct w1_master * w1_alloc_dev(u32 id, 
 
 	dev->bus_master = (struct w1_bus_master *)(dev + 1);
 
-	dev->owner 		= THIS_MODULE;
-	dev->max_slave_count 	= slave_count;
-	dev->slave_count 	= 0;
-	dev->attempts 		= 0;
-	dev->kpid 		= -1;
-	dev->initialized 	= 0;
-	dev->id 		= id;
+	dev->owner		= THIS_MODULE;
+	dev->max_slave_count	= slave_count;
+	dev->slave_count	= 0;
+	dev->attempts		= 0;
+	dev->kpid		= -1;
+	dev->initialized	= 0;
+	dev->id			= id;
 	dev->slave_ttl		= slave_ttl;
 
 	atomic_set(&dev->refcnt, 2);
Index: dtor/drivers/w1/Makefile
===================================================================
--- dtor.orig/drivers/w1/Makefile
+++ dtor/drivers/w1/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_W1_MATROX)		+= matrox_w1.o
 obj-$(CONFIG_W1_THERM)		+= w1_therm.o
 obj-$(CONFIG_W1_SMEM)		+= w1_smem.o
 
-obj-$(CONFIG_W1_DS9490)		+= ds9490r.o 
+obj-$(CONFIG_W1_DS9490)		+= ds9490r.o
 ds9490r-objs    := dscore.o
 
 obj-$(CONFIG_W1_DS9490_BRIDGE)	+= ds_w1_bridge.o
Index: dtor/drivers/w1/matrox_w1.c
===================================================================
--- dtor.orig/drivers/w1/matrox_w1.c
+++ dtor/drivers/w1/matrox_w1.c
@@ -1,8 +1,8 @@
 /*
- * 	matrox_w1.c
+ *	matrox_w1.c
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -59,7 +59,7 @@ static struct pci_driver matrox_w1_pci_d
 	.remove = __devexit_p(matrox_w1_remove),
 };
 
-/* 
+/*
  * Matrox G400 DDC registers.
  */
 
@@ -177,8 +177,8 @@ static int __devinit matrox_w1_probe(str
 
 	dev->bus_master = (struct w1_bus_master *)(dev + 1);
 
-	/* 
-	 * True for G400, for some other we need resource 0, see drivers/video/matrox/matroxfb_base.c 
+	/*
+	 * True for G400, for some other we need resource 0, see drivers/video/matrox/matroxfb_base.c
 	 */
 
 	dev->phys_addr = pci_resource_start(pdev, 1);
Index: dtor/drivers/w1/w1_smem.c
===================================================================
--- dtor.orig/drivers/w1/w1_smem.c
+++ dtor/drivers/w1/w1_smem.c
@@ -1,8 +1,8 @@
 /*
- * 	w1_smem.c
+ *	w1_smem.c
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the smems of the GNU General Public License as published by
@@ -59,7 +59,7 @@ static ssize_t w1_smem_read_val(struct d
 	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
 	int i;
 	ssize_t count = 0;
-	
+
 	for (i = 0; i < 9; ++i)
 		count += sprintf(buf + count, "%02x ", ((u8 *)&sl->reg_num)[i]);
 	count += sprintf(buf + count, "\n");
@@ -70,7 +70,7 @@ static ssize_t w1_smem_read_val(struct d
 static ssize_t w1_smem_read_bin(struct kobject *kobj, char *buf, loff_t off, size_t count)
 {
 	struct w1_slave *sl = container_of(container_of(kobj, struct device, kobj),
-			      			struct w1_slave, dev);
+					   struct w1_slave, dev);
 	int i;
 
 	atomic_inc(&sl->refcnt);
@@ -90,7 +90,7 @@ static ssize_t w1_smem_read_bin(struct k
 	for (i = 0; i < 9; ++i)
 		count += sprintf(buf + count, "%02x ", ((u8 *)&sl->reg_num)[i]);
 	count += sprintf(buf + count, "\n");
-	
+
 out:
 	up(&sl->master->mutex);
 out_dec:
Index: dtor/drivers/w1/w1_family.c
===================================================================
--- dtor.orig/drivers/w1/w1_family.c
+++ dtor/drivers/w1/w1_family.c
@@ -1,8 +1,8 @@
 /*
- * 	w1_family.c
+ *	w1_family.c
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
Index: dtor/drivers/w1/w1.c
===================================================================
--- dtor.orig/drivers/w1/w1.c
+++ dtor/drivers/w1/w1.c
@@ -1,8 +1,8 @@
 /*
- * 	w1.c
+ *	w1.c
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -141,12 +141,12 @@ static ssize_t w1_master_attribute_show_
 {
 	struct w1_master *md = container_of (dev, struct w1_master, dev);
 	ssize_t count;
-	
+
 	if (down_interruptible (&md->mutex))
 		return -EBUSY;
 
 	count = sprintf(buf, "%s\n", md->name);
-	
+
 	up(&md->mutex);
 
 	return count;
@@ -156,12 +156,12 @@ static ssize_t w1_master_attribute_show_
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
-	
+
 	if (down_interruptible(&md->mutex))
 		return -EBUSY;
 
 	count = sprintf(buf, "0x%p\n", md->bus_master);
-	
+
 	up(&md->mutex);
 	return count;
 }
@@ -177,12 +177,12 @@ static ssize_t w1_master_attribute_show_
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
-	
+
 	if (down_interruptible(&md->mutex))
 		return -EBUSY;
 
 	count = sprintf(buf, "%d\n", md->max_slave_count);
-	
+
 	up(&md->mutex);
 	return count;
 }
@@ -191,12 +191,12 @@ static ssize_t w1_master_attribute_show_
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
-	
+
 	if (down_interruptible(&md->mutex))
 		return -EBUSY;
 
 	count = sprintf(buf, "%lu\n", md->attempts);
-	
+
 	up(&md->mutex);
 	return count;
 }
@@ -205,12 +205,12 @@ static ssize_t w1_master_attribute_show_
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
-	
+
 	if (down_interruptible(&md->mutex))
 		return -EBUSY;
 
 	count = sprintf(buf, "%d\n", md->slave_count);
-	
+
 	up(&md->mutex);
 	return count;
 }
@@ -233,7 +233,7 @@ static ssize_t w1_master_attribute_show_
 		list_for_each_safe(ent, n, &md->slist) {
 			sl = list_entry(ent, struct w1_slave, w1_slave_entry);
 
- 			c -= snprintf(buf + PAGE_SIZE - c, c, "%s\n", sl->name);
+			c -= snprintf(buf + PAGE_SIZE - c, c, "%s\n", sl->name);
 		}
 	}
 
@@ -244,11 +244,11 @@ static ssize_t w1_master_attribute_show_
 
 static struct device_attribute w1_master_attribute_slaves = {
 	.attr = {
- 			.name = "w1_master_slaves",
+			.name = "w1_master_slaves",
 			.mode = S_IRUGO,
 			.owner = THIS_MODULE,
 	},
- 	.show = &w1_master_attribute_show_slaves,
+	.show = &w1_master_attribute_show_slaves,
 };
 static struct device_attribute w1_master_attribute_slave_count = {
 	.attr = {
@@ -301,8 +301,8 @@ static struct device_attribute w1_master
 
 static struct bin_attribute w1_slave_bin_attribute = {
 	.attr = {
-		 	.name = "w1_slave",
-		 	.mode = S_IRUGO,
+			.name = "w1_slave",
+			.mode = S_IRUGO,
 			.owner = THIS_MODULE,
 	},
 	.size = W1_SLAVE_DATA_SIZE,
@@ -341,7 +341,7 @@ static int __w1_attach_slave_device(stru
 	memcpy(&sl->attr_bin, &w1_slave_bin_attribute, sizeof(sl->attr_bin));
 	memcpy(&sl->attr_name, &w1_slave_attribute, sizeof(sl->attr_name));
 	memcpy(&sl->attr_val, &w1_slave_attribute_val, sizeof(sl->attr_val));
-	
+
 	sl->attr_bin.read = sl->family->fops->rbin;
 	sl->attr_name.show = sl->family->fops->rname;
 	sl->attr_val.show = sl->family->fops->rval;
@@ -445,7 +445,7 @@ static int w1_attach_slave_device(struct
 static void w1_slave_detach(struct w1_slave *sl)
 {
 	struct w1_netlink_msg msg;
-	
+
 	dev_info(&sl->dev, "%s: detaching %s.\n", __func__, sl->name);
 
 	while (atomic_read(&sl->refcnt)) {
@@ -471,7 +471,7 @@ static struct w1_master *w1_search_maste
 {
 	struct w1_master *dev;
 	int found = 0;
-	
+
 	spin_lock_irq(&w1_mlock);
 	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
 		if (dev->bus_master->data == data) {
@@ -500,7 +500,7 @@ void w1_slave_found(unsigned long data, 
 				data);
 		return;
 	}
-	
+
 	tmp = (struct w1_reg_num *) &rn;
 
 	slave_count = 0;
@@ -527,7 +527,7 @@ void w1_slave_found(unsigned long data, 
 			if(((rn >> 56) & 0xff) == w1_calc_crc8((u8 *)&tmp, 7))
 				w1_attach_slave_device(dev, (struct w1_reg_num *) &rn);
 	}
-			
+
 	atomic_dec(&dev->refcnt);
 }
 
@@ -614,7 +614,7 @@ void w1_search(struct w1_master *dev)
 			last_device = 1;
 
 		desc_bit = last_zero;
-	
+
 		w1_slave_found(dev->bus_master->data, rn);
 	}
 }
@@ -747,7 +747,7 @@ int w1_process(void *data)
 			if (sl)
 				clear_bit(W1_SLAVE_ACTIVE, (long *)&sl->flags);
 		}
-		
+
 		w1_search_devices(dev, w1_slave_found);
 
 		list_for_each_safe(ent, n, &dev->slist) {
Index: dtor/drivers/w1/w1_log.h
===================================================================
--- dtor.orig/drivers/w1/w1_log.h
+++ dtor/drivers/w1/w1_log.h
@@ -1,8 +1,8 @@
 /*
- * 	w1_log.h
+ *	w1_log.h
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
Index: dtor/drivers/w1/w1_io.c
===================================================================
--- dtor.orig/drivers/w1/w1_io.c
+++ dtor/drivers/w1/w1_io.c
@@ -1,8 +1,8 @@
 /*
- * 	w1_io.c
+ *	w1_io.c
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
Index: dtor/drivers/w1/w1_int.h
===================================================================
--- dtor.orig/drivers/w1/w1_int.h
+++ dtor/drivers/w1/w1_int.h
@@ -1,8 +1,8 @@
 /*
- * 	w1_int.h
+ *	w1_int.h
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
Index: dtor/drivers/w1/w1_family.h
===================================================================
--- dtor.orig/drivers/w1/w1_family.h
+++ dtor/drivers/w1/w1_family.h
@@ -1,8 +1,8 @@
 /*
- * 	w1_family.h
+ *	w1_family.h
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -36,7 +36,7 @@ struct w1_family_ops
 {
 	ssize_t (* rname)(struct device *, char *);
 	ssize_t (* rbin)(struct kobject *, char *, loff_t, size_t);
-	
+
 	ssize_t (* rval)(struct device *, char *);
 	unsigned char rvalname[MAXNAMELEN];
 };
@@ -45,9 +45,9 @@ struct w1_family
 {
 	struct list_head	family_entry;
 	u8			fid;
-	
+
 	struct w1_family_ops	*fops;
-	
+
 	atomic_t		refcnt;
 	u8			need_exit;
 };
Index: dtor/drivers/w1/dscore.c
===================================================================
--- dtor.orig/drivers/w1/dscore.c
+++ dtor/drivers/w1/dscore.c
@@ -1,8 +1,8 @@
 /*
- * 	dscore.c
+ *	dscore.c
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -79,11 +79,11 @@ void ds_put_device(struct ds_device *dev
 static int ds_send_control_cmd(struct ds_device *dev, u16 value, u16 index)
 {
 	int err;
-	
-	err = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_CONTROL]), 
+
+	err = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_CONTROL]),
 			CONTROL_CMD, 0x40, value, index, NULL, 0, 1000);
 	if (err < 0) {
-		printk(KERN_ERR "Failed to send command control message %x.%x: err=%d.\n", 
+		printk(KERN_ERR "Failed to send command control message %x.%x: err=%d.\n",
 				value, index, err);
 		return err;
 	}
@@ -94,11 +94,11 @@ static int ds_send_control_cmd(struct ds
 static int ds_send_control_mode(struct ds_device *dev, u16 value, u16 index)
 {
 	int err;
-	
-	err = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_CONTROL]), 
+
+	err = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_CONTROL]),
 			MODE_CMD, 0x40, value, index, NULL, 0, 1000);
 	if (err < 0) {
-		printk(KERN_ERR "Failed to send mode control message %x.%x: err=%d.\n", 
+		printk(KERN_ERR "Failed to send mode control message %x.%x: err=%d.\n",
 				value, index, err);
 		return err;
 	}
@@ -109,11 +109,11 @@ static int ds_send_control_mode(struct d
 static int ds_send_control(struct ds_device *dev, u16 value, u16 index)
 {
 	int err;
-	
-	err = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_CONTROL]), 
+
+	err = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, dev->ep[EP_CONTROL]),
 			COMM_CMD, 0x40, value, index, NULL, 0, 1000);
 	if (err < 0) {
-		printk(KERN_ERR "Failed to send control message %x.%x: err=%d.\n", 
+		printk(KERN_ERR "Failed to send control message %x.%x: err=%d.\n",
 				value, index, err);
 		return err;
 	}
@@ -129,16 +129,16 @@ static inline void ds_dump_status(unsign
 int ds_recv_status_nodump(struct ds_device *dev, struct ds_status *st, unsigned char *buf, int size)
 {
 	int count, err;
-		
+
 	memset(st, 0, sizeof(st));
-	
+
 	count = 0;
 	err = usb_bulk_msg(dev->udev, usb_rcvbulkpipe(dev->udev, dev->ep[EP_STATUS]), buf, size, &count, 100);
 	if (err < 0) {
 		printk(KERN_ERR "Failed to read 1-wire data from 0x%x: err=%d.\n", dev->ep[EP_STATUS], err);
 		return err;
 	}
-	
+
 	if (count >= sizeof(*st))
 		memcpy(st, buf, sizeof(*st));
 
@@ -149,13 +149,13 @@ static int ds_recv_status(struct ds_devi
 {
 	unsigned char buf[64];
 	int count, err = 0, i;
-	
+
 	memcpy(st, buf, sizeof(*st));
-		
+
 	count = ds_recv_status_nodump(dev, st, buf, sizeof(buf));
 	if (count < 0)
 		return err;
-	
+
 	printk("0x%x: count=%d, status: ", dev->ep[EP_STATUS], count);
 	for (i=0; i<count; ++i)
 		printk("%02x ", buf[i]);
@@ -199,7 +199,7 @@ static int ds_recv_status(struct ds_devi
 			return err;
 	}
 #endif
-	
+
 	return err;
 }
 
@@ -207,9 +207,9 @@ static int ds_recv_data(struct ds_device
 {
 	int count, err;
 	struct ds_status st;
-	
+
 	count = 0;
-	err = usb_bulk_msg(dev->udev, usb_rcvbulkpipe(dev->udev, dev->ep[EP_DATA_IN]), 
+	err = usb_bulk_msg(dev->udev, usb_rcvbulkpipe(dev->udev, dev->ep[EP_DATA_IN]),
 				buf, size, &count, 1000);
 	if (err < 0) {
 		printk(KERN_INFO "Clearing ep0x%x.\n", dev->ep[EP_DATA_IN]);
@@ -234,7 +234,7 @@ static int ds_recv_data(struct ds_device
 static int ds_send_data(struct ds_device *dev, unsigned char *buf, int len)
 {
 	int count, err;
-	
+
 	count = 0;
 	err = usb_bulk_msg(dev->udev, usb_sndbulkpipe(dev->udev, dev->ep[EP_DATA_OUT]), buf, len, &count, 1000);
 	if (err < 0) {
@@ -250,7 +250,7 @@ int ds_stop_pulse(struct ds_device *dev,
 	struct ds_status st;
 	int count = 0, err = 0;
 	u8 buf[0x20];
-	
+
 	do {
 		err = ds_send_control(dev, CTL_HALT_EXE_IDLE, 0);
 		if (err)
@@ -275,7 +275,7 @@ int ds_stop_pulse(struct ds_device *dev,
 int ds_detect(struct ds_device *dev, struct ds_status *st)
 {
 	int err;
-	
+
 	err = ds_send_control_cmd(dev, CTL_RESET_DEVICE, 0);
 	if (err)
 		return err;
@@ -283,11 +283,11 @@ int ds_detect(struct ds_device *dev, str
 	err = ds_send_control(dev, COMM_SET_DURATION | COMM_IM, 0);
 	if (err)
 		return err;
-	
+
 	err = ds_send_control(dev, COMM_SET_DURATION | COMM_IM | COMM_TYPE, 0x40);
 	if (err)
 		return err;
-	
+
 	err = ds_send_control_mode(dev, MOD_PULSE_EN, PULSE_PROG);
 	if (err)
 		return err;
@@ -305,7 +305,7 @@ int ds_wait_status(struct ds_device *dev
 	do {
 		err = ds_recv_status_nodump(dev, st, buf, sizeof(buf));
 #if 0
-		if (err >= 0) {	
+		if (err >= 0) {
 			int i;
 			printk("0x%x: count=%d, status: ", dev->ep[EP_STATUS], err);
 			for (i=0; i<err; ++i)
@@ -341,14 +341,14 @@ int ds_reset(struct ds_device *dev, stru
 		return -EIO;
 	}
 #endif
-	
+
 	return 0;
 }
 
 int ds_set_speed(struct ds_device *dev, int speed)
 {
 	int err;
-	
+
 	if (speed != SPEED_NORMAL && speed != SPEED_FLEXIBLE && speed != SPEED_OVERDRIVE)
 		return -EINVAL;
 
@@ -356,7 +356,7 @@ int ds_set_speed(struct ds_device *dev, 
 		speed = SPEED_FLEXIBLE;
 
 	speed &= 0xff;
-	
+
 	err = ds_send_control_mode(dev, MOD_1WIRE_SPEED, speed);
 	if (err)
 		return err;
@@ -369,7 +369,7 @@ int ds_start_pulse(struct ds_device *dev
 	int err;
 	u8 del = 1 + (u8)(delay >> 4);
 	struct ds_status st;
-	
+
 #if 0
 	err = ds_stop_pulse(dev, 10);
 	if (err)
@@ -390,7 +390,7 @@ int ds_start_pulse(struct ds_device *dev
 	mdelay(delay);
 
 	ds_wait_status(dev, &st);
-	
+
 	return err;
 }
 
@@ -400,7 +400,7 @@ int ds_touch_bit(struct ds_device *dev, 
 	struct ds_status st;
 	u16 value = (COMM_BIT_IO | COMM_IM) | ((bit) ? COMM_D : 0);
 	u16 cmd;
-	
+
 	err = ds_send_control(dev, value, 0);
 	if (err)
 		return err;
@@ -430,7 +430,7 @@ int ds_write_bit(struct ds_device *dev, 
 {
 	int err;
 	struct ds_status st;
-	
+
 	err = ds_send_control(dev, COMM_BIT_IO | COMM_IM | (bit) ? COMM_D : 0, 0);
 	if (err)
 		return err;
@@ -445,7 +445,7 @@ int ds_write_byte(struct ds_device *dev,
 	int err;
 	struct ds_status st;
 	u8 rbyte;
-	
+
 	err = ds_send_control(dev, COMM_BYTE_IO | COMM_IM | COMM_SPU, byte);
 	if (err)
 		return err;
@@ -453,11 +453,11 @@ int ds_write_byte(struct ds_device *dev,
 	err = ds_wait_status(dev, &st);
 	if (err)
 		return err;
-		
+
 	err = ds_recv_data(dev, &rbyte, sizeof(rbyte));
 	if (err < 0)
 		return err;
-	
+
 	ds_start_pulse(dev, PULLUP_PULSE_DURATION);
 
 	return !(byte == rbyte);
@@ -470,11 +470,11 @@ int ds_read_bit(struct ds_device *dev, u
 	err = ds_send_control_mode(dev, MOD_PULSE_EN, PULSE_SPUE);
 	if (err)
 		return err;
-	
+
 	err = ds_send_control(dev, COMM_BIT_IO | COMM_IM | COMM_SPU | COMM_D, 0);
 	if (err)
 		return err;
-	
+
 	err = ds_recv_data(dev, bit, sizeof(*bit));
 	if (err < 0)
 		return err;
@@ -492,7 +492,7 @@ int ds_read_byte(struct ds_device *dev, 
 		return err;
 
 	ds_wait_status(dev, &st);
-	
+
 	err = ds_recv_data(dev, byte, sizeof(*byte));
 	if (err < 0)
 		return err;
@@ -509,17 +509,17 @@ int ds_read_block(struct ds_device *dev,
 		return -E2BIG;
 
 	memset(buf, 0xFF, len);
-	
+
 	err = ds_send_data(dev, buf, len);
 	if (err < 0)
 		return err;
-	
+
 	err = ds_send_control(dev, COMM_BLOCK_IO | COMM_IM | COMM_SPU, len);
 	if (err)
 		return err;
 
 	ds_wait_status(dev, &st);
-	
+
 	memset(buf, 0x00, len);
 	err = ds_recv_data(dev, buf, len);
 
@@ -530,11 +530,11 @@ int ds_write_block(struct ds_device *dev
 {
 	int err;
 	struct ds_status st;
-	
+
 	err = ds_send_data(dev, buf, len);
 	if (err < 0)
 		return err;
-	
+
 	ds_wait_status(dev, &st);
 
 	err = ds_send_control(dev, COMM_BLOCK_IO | COMM_IM | COMM_SPU, len);
@@ -548,7 +548,7 @@ int ds_write_block(struct ds_device *dev
 		return err;
 
 	ds_start_pulse(dev, PULLUP_PULSE_DURATION);
-	
+
 	return !(err == len);
 }
 
@@ -559,11 +559,11 @@ int ds_search(struct ds_device *dev, u64
 	struct ds_status st;
 
 	memset(buf, 0, sizeof(buf));
-	
+
 	err = ds_send_data(ds_dev, (unsigned char *)&init, 8);
 	if (err)
 		return err;
-	
+
 	ds_wait_status(ds_dev, &st);
 
 	value = COMM_SEARCH_ACCESS | COMM_IM | COMM_SM | COMM_F | COMM_RTS;
@@ -589,7 +589,7 @@ int ds_match_access(struct ds_device *de
 	err = ds_send_data(dev, (unsigned char *)&init, sizeof(init));
 	if (err)
 		return err;
-	
+
 	ds_wait_status(dev, &st);
 
 	err = ds_send_control(dev, COMM_MATCH_ACCESS | COMM_IM | COMM_RST, 0x0055);
@@ -609,11 +609,11 @@ int ds_set_path(struct ds_device *dev, u
 
 	memcpy(buf, &init, 8);
 	buf[8] = BRANCH_MAIN;
-	
+
 	err = ds_send_data(dev, buf, sizeof(buf));
 	if (err)
 		return err;
-	
+
 	ds_wait_status(dev, &st);
 
 	err = ds_send_control(dev, COMM_SET_PATH | COMM_IM | COMM_RST, 0);
@@ -653,7 +653,7 @@ int ds_probe(struct usb_interface *intf,
 		printk(KERN_ERR "Failed to reset configuration: err=%d.\n", err);
 		return err;
 	}
-	
+
 	iface_desc = &intf->altsetting[0];
 	if (iface_desc->desc.bNumEndpoints != NUM_EP-1) {
 		printk(KERN_INFO "Num endpoints=%d. It is not DS9490R.\n", iface_desc->desc.bNumEndpoints);
@@ -662,37 +662,37 @@ int ds_probe(struct usb_interface *intf,
 
 	atomic_set(&ds_dev->refcnt, 0);
 	memset(ds_dev->ep, 0, sizeof(ds_dev->ep));
-	
+
 	/*
-	 * This loop doesn'd show control 0 endpoint, 
+	 * This loop doesn'd show control 0 endpoint,
 	 * so we will fill only 1-3 endpoints entry.
 	 */
 	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
 		endpoint = &iface_desc->endpoint[i].desc;
 
 		ds_dev->ep[i+1] = endpoint->bEndpointAddress;
-		
+
 		printk("%d: addr=%x, size=%d, dir=%s, type=%x\n",
 			i, endpoint->bEndpointAddress, le16_to_cpu(endpoint->wMaxPacketSize),
 			(endpoint->bEndpointAddress & USB_DIR_IN)?"IN":"OUT",
 			endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK);
 	}
-	
+
 #if 0
 	{
 		int err, i;
 		u64 buf[3];
 		u64 init=0xb30000002078ee81ull;
 		struct ds_status st;
-		
+
 		ds_reset(ds_dev, &st);
 		err = ds_search(ds_dev, init, buf, 3, 0);
 		if (err < 0)
 			return err;
 		for (i=0; i<err; ++i)
 			printk("%d: %llx\n", i, buf[i]);
-		
-		printk("Resetting...\n");	
+
+		printk("Resetting...\n");
 		ds_reset(ds_dev, &st);
 		printk("Setting path for %llx.\n", init);
 		err = ds_set_path(ds_dev, init);
@@ -707,12 +707,12 @@ int ds_probe(struct usb_interface *intf,
 		err = ds_search(ds_dev, init, buf, 3, 0);
 
 		printk("ds_search() returned %d\n", err);
-		
+
 		if (err < 0)
 			return err;
 		for (i=0; i<err; ++i)
 			printk("%d: %llx\n", i, buf[i]);
-		
+
 		return 0;
 	}
 #endif
@@ -723,7 +723,7 @@ int ds_probe(struct usb_interface *intf,
 void ds_disconnect(struct usb_interface *intf)
 {
 	struct ds_device *dev;
-	
+
 	dev = usb_get_intfdata(intf);
 	usb_set_intfdata(intf, NULL);
 
@@ -776,8 +776,8 @@ EXPORT_SYMBOL(ds_get_device);
 EXPORT_SYMBOL(ds_put_device);
 
 /*
- * This functions can be used for EEPROM programming, 
- * when driver will be included into mainline this will 
+ * This functions can be used for EEPROM programming,
+ * when driver will be included into mainline this will
  * require uncommenting.
  */
 #if 0
Index: dtor/drivers/w1/w1.h
===================================================================
--- dtor.orig/drivers/w1/w1.h
+++ dtor/drivers/w1/w1.h
@@ -1,8 +1,8 @@
 /*
- * 	w1.h
+ *	w1.h
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * 
+ *
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -74,11 +74,11 @@ struct w1_slave
 	int			ttl;
 
 	struct w1_master	*master;
-	struct w1_family 	*family;
-	struct device 		dev;
-	struct completion 	dev_released;
+	struct w1_family	*family;
+	struct device		dev;
+	struct completion	dev_released;
 
-	struct bin_attribute 	attr_bin;
+	struct bin_attribute	attr_bin;
 	struct device_attribute	attr_name, attr_val;
 };
 
@@ -90,16 +90,16 @@ struct w1_bus_master
 
 	u8			(*read_bit)(unsigned long);
 	void			(*write_bit)(unsigned long, u8);
-  	
+
 	u8			(*read_byte)(unsigned long);
-  	void			(*write_byte)(unsigned long, u8);
-  	
+	void			(*write_byte)(unsigned long, u8);
+
 	u8			(*read_block)(unsigned long, u8 *, int);
 	void			(*write_block)(unsigned long, u8 *, int);
-	
-  	u8			(*touch_bit)(unsigned long, u8);
-  
-  	u8			(*reset_bus)(unsigned long);
+
+	u8			(*touch_bit)(unsigned long, u8);
+
+	u8			(*reset_bus)(unsigned long);
 
 	void			(*search)(unsigned long, w1_slave_found_callback);
 };
@@ -123,17 +123,17 @@ struct w1_master
 
 	int			need_exit;
 	pid_t			kpid;
-	struct semaphore 	mutex;
+	struct semaphore	mutex;
 
 	struct device_driver	*driver;
-	struct device 		dev;
-	struct completion 	dev_released;
-	struct completion 	dev_exited;
+	struct device		dev;
+	struct completion	dev_released;
+	struct completion	dev_exited;
 
 	struct w1_bus_master	*bus_master;
 
 	u32			seq, groups;
-	struct sock 		*nls;
+	struct sock		*nls;
 };
 
 int w1_create_master_attributes(struct w1_master *);
Index: dtor/drivers/w1/Kconfig
===================================================================
--- dtor.orig/drivers/w1/Kconfig
+++ dtor/drivers/w1/Kconfig
@@ -3,9 +3,9 @@ menu "Dallas's 1-wire bus"
 config W1
 	tristate "Dallas's 1-wire support"
 	---help---
-	  Dallas's 1-wire bus is usefull to connect slow 1-pin devices 
+	  Dallas's 1-wire bus is usefull to connect slow 1-pin devices
 	  such as iButtons and thermal sensors.
-	  
+
 	  If you want W1 support, you should say Y here.
 
 	  This W1 support can also be built as a module.  If so, the module
@@ -17,8 +17,8 @@ config W1_MATROX
 	help
 	  Say Y here if you want to communicate with your 1-wire devices
 	  using Matrox's G400 GPIO pins.
-	  
-	  This support is also available as a module.  If so, the module 
+
+	  This support is also available as a module.  If so, the module
 	  will be called matrox_w1.ko.
 
 config W1_DS9490
@@ -27,7 +27,7 @@ config W1_DS9490
 	help
 	  Say Y here if you want to have a driver for DS9490R UWB <-> W1 bridge.
 
-	  This support is also available as a module.  If so, the module 
+	  This support is also available as a module.  If so, the module
 	  will be called ds9490r.ko.
 
 config W1_DS9490_BRIDGE
@@ -37,7 +37,7 @@ config W1_DS9490_BRIDGE
 	  Say Y here if you want to communicate with your 1-wire devices
 	  using DS9490R USB bridge.
 
-	  This support is also available as a module.  If so, the module 
+	  This support is also available as a module.  If so, the module
 	  will be called ds_w1_bridge.ko.
 
 config W1_THERM
@@ -51,7 +51,7 @@ config W1_SMEM
 	tristate "Simple 64bit memory family implementation"
 	depends on W1
 	help
-	  Say Y here if you want to connect 1-wire 
+	  Say Y here if you want to connect 1-wire
 	  simple 64bit memory rom(ds2401/ds2411/ds1990*) to you wire.
 
 endmenu
