Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWAEAwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWAEAwx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWAEAuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:50:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:58553 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750954AbWAEAtu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:50 -0500
Cc: dtor_core@ameritech.net
Subject: [PATCH] Driver Core: Rearrange exports in platform.c
In-Reply-To: <11364221711332@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jan 2006 16:49:31 -0800
Message-Id: <1136422171546@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver Core: Rearrange exports in platform.c

Driver core: rearrange exports in platform.c

The new way is to specify export right after symbol definition.
Rearrange exports to follow new style to avoid mixing two styles
in one file.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit a96b204208443ab7e23c681f7ddabe807a741d0c
tree 7dacd3fe2790e1c5a922ff30fdab00b689a83998
parent 93ce3061be212f6280e7ccafa9a7f698a95c6d75
author Dmitry Torokhov <dtor_core@ameritech.net> Sat, 10 Dec 2005 01:36:28 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 04 Jan 2006 16:18:09 -0800

 drivers/base/platform.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 95ecfc4..0f81731 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
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

