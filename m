Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWGLXao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWGLXao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWGLXao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:30:44 -0400
Received: from ns2.suse.de ([195.135.220.15]:6885 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932213AbWGLXan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:30:43 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Henrik Kretzschmar <henne@nachtwindheim.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 2/5] [PATCH] Driver core: kernel-doc in drivers/base/core.c corrections
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 12 Jul 2006 16:26:51 -0700
Message-Id: <11527468173384-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <1152746814664-git-send-email-greg@kroah.com>
References: <20060712232343.GA22672@kroah.com> <1152746814664-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Corrects the kerneldocs for device_create() and device_destroy()
with an eye on coding style, grammar and readability.

Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/core.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index e61ad4e..be6b5bc 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -559,20 +559,20 @@ static void device_create_release(struct
 
 /**
  * device_create - creates a device and registers it with sysfs
- * @class: pointer to the struct class that this device should be registered to.
- * @parent: pointer to the parent struct device of this new device, if any.
- * @devt: the dev_t for the char device to be added.
- * @fmt: string for the class device's name
+ * @class: pointer to the struct class that this device should be registered to
+ * @parent: pointer to the parent struct device of this new device, if any
+ * @devt: the dev_t for the char device to be added
+ * @fmt: string for the device's name
+ *
+ * This function can be used by char device classes.  A struct device
+ * will be created in sysfs, registered to the specified class.
  *
- * This function can be used by char device classes.  A struct
- * device will be created in sysfs, registered to the specified
- * class.
  * A "dev" file will be created, showing the dev_t for the device, if
  * the dev_t is not 0,0.
- * If a pointer to a parent struct device is passed in, the newly
- * created struct device will be a child of that device in sysfs.  The
- * pointer to the struct device will be returned from the call.  Any
- * further sysfs files that might be required can be created using this
+ * If a pointer to a parent struct device is passed in, the newly created
+ * struct device will be a child of that device in sysfs.
+ * The pointer to the struct device will be returned from the call.
+ * Any further sysfs files that might be required can be created using this
  * pointer.
  *
  * Note: the struct class passed to this function must have previously
@@ -620,11 +620,11 @@ EXPORT_SYMBOL_GPL(device_create);
 
 /**
  * device_destroy - removes a device that was created with device_create()
- * @class: the pointer to the struct class that this device was registered * with.
- * @devt: the dev_t of the device that was previously registered.
+ * @class: pointer to the struct class that this device was registered with
+ * @devt: the dev_t of the device that was previously registered
  *
- * This call unregisters and cleans up a class device that was created with a
- * call to class_device_create()
+ * This call unregisters and cleans up a device that was created with a
+ * call to device_create().
  */
 void device_destroy(struct class *class, dev_t devt)
 {
-- 
1.4.1

