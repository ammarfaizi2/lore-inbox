Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWBSBJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWBSBJM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 20:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWBSBJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 20:09:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64742 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964791AbWBSBJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 20:09:11 -0500
Date: Sat, 18 Feb 2006 20:09:10 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: don't bother users with unimportant messages.
Message-ID: <20060219010910.GA18841@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When users see these printed to the console, they think
something is wrong.  As it's just informational and something
that only developers care about, lower the printk level.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.15.noarch/drivers/base/driver.c~	2006-02-18 19:52:36.000000000 -0500
+++ linux-2.6.15.noarch/drivers/base/driver.c	2006-02-18 20:07:51.000000000 -0500
@@ -174,7 +174,7 @@ int driver_register(struct device_driver
 	if ((drv->bus->probe && drv->probe) ||
 	    (drv->bus->remove && drv->remove) ||
 	    (drv->bus->shutdown && drv->shutdown)) {
-		printk(KERN_WARNING "Driver '%s' needs updating - please use bus_type methods\n", drv->name);
+		printk(KERN_DEBUG "Driver '%s' needs updating - please use bus_type methods\n", drv->name);
 	}
 	klist_init(&drv->klist_devices, klist_devices_get, klist_devices_put);
 	init_completion(&drv->unloaded);
