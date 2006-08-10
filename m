Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161026AbWHJFSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbWHJFSW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 01:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161028AbWHJFSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 01:18:22 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:61494 "EHLO
	asav11.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1161026AbWHJFSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 01:18:21 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AT0KACte2kSBUQ
From: Dmitry Torokhov <dtor@insightbb.com>
To: Greg KH <gregkh@suse.de>
Subject: [PATCH] class_device_create(): make fmt argument 'const char *'
Date: Thu, 10 Aug 2006 01:18:18 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608100118.19140.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/base/class.c   |    3 ++-
 include/linux/device.h |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

Index: work/drivers/base/class.c
===================================================================
--- work.orig/drivers/base/class.c
+++ work/drivers/base/class.c
@@ -679,7 +679,8 @@ int class_device_register(struct class_d
 struct class_device *class_device_create(struct class *cls,
 					 struct class_device *parent,
 					 dev_t devt,
-					 struct device *device, char *fmt, ...)
+					 struct device *device,
+					 const char *fmt, ...)
 {
 	va_list args;
 	struct class_device *class_dev = NULL;
Index: work/include/linux/device.h
===================================================================
--- work.orig/include/linux/device.h
+++ work/include/linux/device.h
@@ -277,7 +277,7 @@ extern struct class_device *class_device
 						struct class_device *parent,
 						dev_t devt,
 						struct device *device,
-						char *fmt, ...)
+						const char *fmt, ...)
 					__attribute__((format(printf,5,6)));
 extern void class_device_destroy(struct class *cls, dev_t devt);
 
