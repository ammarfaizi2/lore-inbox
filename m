Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbVJMCM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbVJMCM5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 22:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbVJMCMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 22:12:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:44942 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964858AbVJMCMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 22:12:06 -0400
Date: Wed, 12 Oct 2005 19:10:37 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Cc: linux-kernel@vger.kernel.org
Subject: [patch 3/8] Driver Core: document struct class_device properly
Message-ID: <20051013021037.GD31732@kroah.com>
References: <20051013014147.235668000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="class-device.h-documentation.patch"
In-Reply-To: <20051013020844.GA31732@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 include/linux/device.h |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- gregkh-2.6.orig/include/linux/device.h
+++ gregkh-2.6/include/linux/device.h
@@ -203,6 +203,30 @@ struct class_device_attribute class_devi
 extern int class_device_create_file(struct class_device *,
 				    const struct class_device_attribute *);
 
+/**
+ * struct class_device - class devices
+ * @class: pointer to the parent class for this class device.  This is required.
+ * @devt: for internal use by the driver core only.
+ * @node: for internal use by the driver core only.
+ * @kobj: for internal use by the driver core only.
+ * @devt_attr: for internal use by the driver core only.
+ * @dev: if set, a symlink to the struct device is created in the sysfs
+ * directory for this struct class device.
+ * @class_data: pointer to whatever you want to store here for this struct
+ * class_device.  Use class_get_devdata() and class_set_devdata() to get and
+ * set this pointer.
+ * @parent: pointer to a struct class_device that is the parent of this struct
+ * class_device.  If NULL, this class_device will show up at the root of the
+ * struct class in sysfs (which is probably what you want to have happen.)
+ * @release: pointer to a release function for this struct class_device.  If
+ * set, this will be called instead of the class specific release function.
+ * Only use this if you want to override the default release function, like
+ * when you are nesting class_device structures.
+ * @hotplug: pointer to a hotplug function for this struct class_device.  If
+ * set, this will be called instead of the class specific hotplug function.
+ * Only use this if you want to override the default hotplug function, like
+ * when you are nesting class_device structures.
+ */
 struct class_device {
 	struct list_head	node;
 

--
