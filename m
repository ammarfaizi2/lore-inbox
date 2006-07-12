Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWGLXal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWGLXal (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWGLXal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:30:41 -0400
Received: from mail.suse.de ([195.135.220.2]:5773 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932258AbWGLXaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:30:39 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@xenotime.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 1/5] [PATCH] Driver core: fix driver-core kernel-doc
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 12 Jul 2006 16:26:50 -0700
Message-Id: <1152746814664-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <20060712232343.GA22672@kroah.com>
References: <20060712232343.GA22672@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Warning(/var/linsrc/linux-2617-g4//drivers/base/core.c:574): No description found for parameter 'class'
Warning(/var/linsrc/linux-2617-g4//drivers/base/core.c:574): No description found for parameter 'devt'
Warning(/var/linsrc/linux-2617-g4//drivers/base/core.c:626): No description found for parameter 'devt'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b21f864..e61ad4e 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -559,9 +559,9 @@ static void device_create_release(struct
 
 /**
  * device_create - creates a device and registers it with sysfs
- * @cs: pointer to the struct class that this device should be registered to.
+ * @class: pointer to the struct class that this device should be registered to.
  * @parent: pointer to the parent struct device of this new device, if any.
- * @dev: the dev_t for the char device to be added.
+ * @devt: the dev_t for the char device to be added.
  * @fmt: string for the class device's name
  *
  * This function can be used by char device classes.  A struct
@@ -621,7 +621,7 @@ EXPORT_SYMBOL_GPL(device_create);
 /**
  * device_destroy - removes a device that was created with device_create()
  * @class: the pointer to the struct class that this device was registered * with.
- * @dev: the dev_t of the device that was previously registered.
+ * @devt: the dev_t of the device that was previously registered.
  *
  * This call unregisters and cleans up a class device that was created with a
  * call to class_device_create()
-- 
1.4.1

