Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbVLJGsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbVLJGsl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 01:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbVLJGsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 01:48:41 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:48575 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964939AbVLJGsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 01:48:40 -0500
Message-Id: <20051210064750.889604000.dtor_core@ameritech.net>
References: <20051210063626.817047000.dtor_core@ameritech.net>
Date: Sat, 10 Dec 2005 01:36:28 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Jean Delvare <khali@linux-fr.org>
Subject: [patch 2/2] Rearrange exports in platform.c
Content-Disposition: inline; filename=platform-rearange-exports.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Driver core: rearrange exports in platform.c

The new way is to specify export right after symbol definition.
Rearrange exports to follow new style to avoid mixing two styles
in one file.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/base/platform.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

Index: work/drivers/base/platform.c
===================================================================
--- work.orig/drivers/base/platform.c
+++ work/drivers/base/platform.c
@@ -25,6 +25,7 @@
 struct device platform_bus = {
 	.bus_id		= "platform",
 };
+EXPORT_SYMBOL_GPL(platform_bus);
 
 /**
  *	platform_get_resource - get a resource for a device
@@ -49,6 +50,7 @@ platform_get_resource(struct platform_de
 	}
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(platform_get_resource);
 
 /**
  *	platform_get_irq - get an IRQ for a device
@@ -61,6 +63,7 @@ int platform_get_irq(struct platform_dev
 
 	return r ? r->start : 0;
 }
+EXPORT_SYMBOL_GPL(platform_get_irq);
 
 /**
  *	platform_get_resource_byname - get a resource for a device by name
@@ -84,6 +87,7 @@ platform_get_resource_byname(struct plat
 	}
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(platform_get_resource_byname);
 
 /**
  *	platform_get_irq - get an IRQ for a device
@@ -96,6 +100,7 @@ int platform_get_irq_byname(struct platf
 
 	return r ? r->start : 0;
 }
+EXPORT_SYMBOL_GPL(platform_get_irq_byname);
 
 /**
  *	platform_add_devices - add a numbers of platform devices
@@ -117,6 +122,7 @@ int platform_add_devices(struct platform
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(platform_add_devices);
 
 struct platform_object {
 	struct platform_device pdev;
@@ -314,6 +320,7 @@ int platform_device_register(struct plat
 	device_initialize(&pdev->dev);
 	return platform_device_add(pdev);
 }
+EXPORT_SYMBOL_GPL(platform_device_register);
 
 /**
  *	platform_device_unregister - unregister a platform-level device
@@ -328,6 +335,7 @@ void platform_device_unregister(struct p
 	platform_device_del(pdev);
 	platform_device_put(pdev);
 }
+EXPORT_SYMBOL_GPL(platform_device_unregister);
 
 /**
  *	platform_device_register_simple
@@ -370,6 +378,7 @@ error:
 	platform_device_put(pdev);
 	return ERR_PTR(retval);
 }
+EXPORT_SYMBOL_GPL(platform_device_register_simple);
 
 static int platform_drv_probe(struct device *_dev)
 {
@@ -491,6 +500,7 @@ struct bus_type platform_bus_type = {
 	.suspend	= platform_suspend,
 	.resume		= platform_resume,
 };
+EXPORT_SYMBOL_GPL(platform_bus_type);
 
 int __init platform_bus_init(void)
 {
@@ -519,14 +529,3 @@ u64 dma_get_required_mask(struct device 
 }
 EXPORT_SYMBOL_GPL(dma_get_required_mask);
 #endif
-
-EXPORT_SYMBOL_GPL(platform_bus);
-EXPORT_SYMBOL_GPL(platform_bus_type);
-EXPORT_SYMBOL_GPL(platform_add_devices);
-EXPORT_SYMBOL_GPL(platform_device_register);
-EXPORT_SYMBOL_GPL(platform_device_register_simple);
-EXPORT_SYMBOL_GPL(platform_device_unregister);
-EXPORT_SYMBOL_GPL(platform_get_irq);
-EXPORT_SYMBOL_GPL(platform_get_resource);
-EXPORT_SYMBOL_GPL(platform_get_irq_byname);
-EXPORT_SYMBOL_GPL(platform_get_resource_byname);

