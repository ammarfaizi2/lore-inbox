Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422935AbWAMUCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422935AbWAMUCQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422929AbWAMUCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 15:02:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:43412 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422869AbWAMTua convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:30 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add superhyway_bus_type probe and remove methods
In-Reply-To: <11371818111724@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:12 -0800
Message-Id: <11371818112032@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add superhyway_bus_type probe and remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ff2dae79773658eaaab731663ddca9f7975430eb
tree c27859a56e87dbddd041a787dfad0e6d4507680e
parent f9ccf4569ac4597e9e09d301ca362d90b4a1046d
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:42:40 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:09 -0800

 drivers/sh/superhyway/superhyway.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/sh/superhyway/superhyway.c b/drivers/sh/superhyway/superhyway.c
index 7bdab2a..94b2290 100644
--- a/drivers/sh/superhyway/superhyway.c
+++ b/drivers/sh/superhyway/superhyway.c
@@ -175,8 +175,6 @@ int superhyway_register_driver(struct su
 {
 	drv->drv.name	= drv->name;
 	drv->drv.bus	= &superhyway_bus_type;
-	drv->drv.probe	= superhyway_device_probe;
-	drv->drv.remove	= superhyway_device_remove;
 
 	return driver_register(&drv->drv);
 }
@@ -213,6 +211,8 @@ struct bus_type superhyway_bus_type = {
 #ifdef CONFIG_SYSFS
 	.dev_attrs	= superhyway_dev_attrs,
 #endif
+	.probe		= superhyway_device_probe,
+	.remove		= superhyway_device_remove,
 };
 
 static int __init superhyway_bus_init(void)

