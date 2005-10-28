Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965115AbVJ1Gjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbVJ1Gjv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbVJ1Gii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:38:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:35050 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965130AbVJ1GbS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:18 -0400
Cc: gregkh@suse.de
Subject: [PATCH] Driver Core: document struct class_device properly
In-Reply-To: <11304810232167@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:24 -0700
Message-Id: <11304810242041@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver Core: document struct class_device properly

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit e9a873633c67dd048c9d53f3e934e83df10312d1
tree 9152a484f16797773dce293c205e5e71b1260322
parent c5d4abda2b87357d5ba32b0c8babb532eb75d9c7
author Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:25:43 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:03 -0700

 include/linux/device.h |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 226e550..10ab780 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
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
 

