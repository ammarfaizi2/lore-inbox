Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbULCULe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbULCULe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 15:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbULCUDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 15:03:50 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:3768 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262494AbULCUBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 15:01:24 -0500
Date: Fri, 3 Dec 2004 12:00:04 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Driver Core: restore comment in kobject_uevent.c
Message-ID: <20041203200003.GB1178@kroah.com>
References: <20041203195908.GA1178@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041203195908.GA1178@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

--- 1.6/drivers/base/class_simple.c	2004-06-10 08:34:24 +02:00
+++ edited/drivers/base/class_simple.c	2004-11-26 20:11:21 +01:00
@@ -122,7 +122,7 @@ EXPORT_SYMBOL(class_simple_destroy);
  * be created, showing the dev_t for the device.  The pointer to the struct
  * class_device will be returned from the call.  Any further sysfs files that
  * might be required can be created using this pointer.
- * Note: the struct class_device passed to this function must have previously been
+ * Note: the struct class_simple passed to this function must have previously been
  * created with a call to class_simple_create().
  */
 struct class_device *class_simple_device_add(struct class_simple *cs, dev_t dev, struct device *device, const char *fmt, ...)
===== lib/kobject_uevent.c 1.16 vs edited =====
--- 1.16/lib/kobject_uevent.c	2004-11-12 12:50:24 +01:00
+++ edited/lib/kobject_uevent.c	2004-11-26 20:19:53 +01:00
@@ -205,6 +205,8 @@ void kobject_hotplug(struct kobject *kob
 	static struct kset_hotplug_ops null_hotplug_ops;
 	struct kset_hotplug_ops *hotplug_ops = &null_hotplug_ops;
 
+	/* If this kobj does not belong to a kset,
+	   try to find a parent that does. */
 	if (!top_kobj->kset && top_kobj->parent) {
 		do {
 			top_kobj = top_kobj->parent;


