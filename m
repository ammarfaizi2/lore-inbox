Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751647AbWIZFvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbWIZFvM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWIZFit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:38:49 -0400
Received: from ns.suse.de ([195.135.220.2]:43489 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751294AbWIZFiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:38:11 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dtor@insightbb.com>, Dmitry Torokhov <dtor@mail.ru>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 3/47] class_device_create(): make fmt argument 'const char *'
Date: Mon, 25 Sep 2006 22:37:23 -0700
Message-Id: <11592490933346-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592490903867-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dtor@insightbb.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/class.c   |    3 ++-
 include/linux/device.h |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 46336f1..75057aa 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
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
diff --git a/include/linux/device.h b/include/linux/device.h
index 1e5f30d..1fec285 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -277,7 +277,7 @@ extern struct class_device *class_device
 						struct class_device *parent,
 						dev_t devt,
 						struct device *device,
-						char *fmt, ...)
+						const char *fmt, ...)
 					__attribute__((format(printf,5,6)));
 extern void class_device_destroy(struct class *cls, dev_t devt);
 
-- 
1.4.2.1

