Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030425AbWFVWWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030425AbWFVWWU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 18:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030426AbWFVWWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 18:22:20 -0400
Received: from xenotime.net ([66.160.160.81]:50397 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030425AbWFVWWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 18:22:19 -0400
Date: Thu, 22 Jun 2006 15:14:07 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: gregkh <greg@kroah.com>
Subject: [PATCH] fix driver-core kernel-doc
Message-Id: <20060622151407.9d7d7664.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Warning(/var/linsrc/linux-2617-g4//drivers/base/core.c:574): No description found for parameter 'class'
Warning(/var/linsrc/linux-2617-g4//drivers/base/core.c:574): No description found for parameter 'devt'
Warning(/var/linsrc/linux-2617-g4//drivers/base/core.c:626): No description found for parameter 'devt'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/base/core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2617-g4.orig/drivers/base/core.c
+++ linux-2617-g4/drivers/base/core.c
@@ -550,9 +550,9 @@ static void device_create_release(struct
 
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
@@ -617,7 +617,7 @@ EXPORT_SYMBOL_GPL(device_create);
 /**
  * device_destroy - removes a device that was created with device_create()
  * @class: the pointer to the struct class that this device was registered * with.
- * @dev: the dev_t of the device that was previously registered.
+ * @devt: the dev_t of the device that was previously registered.
  *
  * This call unregisters and cleans up a class device that was created with a
  * call to class_device_create()


---
