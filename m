Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbUCCEWY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 23:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbUCCEWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 23:22:24 -0500
Received: from mail.kroah.org ([65.200.24.183]:34178 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262355AbUCCEVx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 23:21:53 -0500
Subject: Re: [PATCH] PCI Hotplug fixes for 2.6.4-rc1
In-Reply-To: <1078287705197@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 2 Mar 2004 20:21:46 -0800
Message-Id: <10782877062961@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1623, 2004/03/02 13:11:26-08:00, greg@kroah.com

PCI Hotplug: fix up the permission settings on a few of the sysfs files.

Thanks to Linda Xie for pointing this out.


 drivers/pci/hotplug/pci_hotplug_core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
--- a/drivers/pci/hotplug/pci_hotplug_core.c	Tue Mar  2 19:42:22 2004
+++ b/drivers/pci/hotplug/pci_hotplug_core.c	Tue Mar  2 19:42:22 2004
@@ -292,7 +292,7 @@
 }
 
 static struct hotplug_slot_attribute hotplug_slot_attr_latch = {
-	.attr = {.name = "latch", .mode = S_IFREG | S_IRUGO | S_IWUSR},
+	.attr = {.name = "latch", .mode = S_IFREG | S_IRUGO},
 	.show = latch_read_file,
 };
 
@@ -311,7 +311,7 @@
 }
 
 static struct hotplug_slot_attribute hotplug_slot_attr_presence = {
-	.attr = {.name = "adapter", .mode = S_IFREG | S_IRUGO | S_IWUSR},
+	.attr = {.name = "adapter", .mode = S_IFREG | S_IRUGO},
 	.show = presence_read_file,
 };
 
@@ -361,7 +361,7 @@
 }
 
 static struct hotplug_slot_attribute hotplug_slot_attr_max_bus_speed = {
-	.attr = {.name = "max_bus_speed", .mode = S_IFREG | S_IRUGO | S_IWUSR},
+	.attr = {.name = "max_bus_speed", .mode = S_IFREG | S_IRUGO},
 	.show = max_bus_speed_read_file,
 };
 
@@ -387,7 +387,7 @@
 }
 
 static struct hotplug_slot_attribute hotplug_slot_attr_cur_bus_speed = {
-	.attr = {.name = "cur_bus_speed", .mode = S_IFREG | S_IRUGO | S_IWUSR},
+	.attr = {.name = "cur_bus_speed", .mode = S_IFREG | S_IRUGO},
 	.show = cur_bus_speed_read_file,
 };
 

