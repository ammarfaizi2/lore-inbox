Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267560AbTBKKxP>; Tue, 11 Feb 2003 05:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267597AbTBKKw4>; Tue, 11 Feb 2003 05:52:56 -0500
Received: from [195.39.17.254] ([195.39.17.254]:12036 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267560AbTBKKwJ>;
	Tue, 11 Feb 2003 05:52:09 -0500
Date: Mon, 10 Feb 2003 17:40:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Coding style in acpi/scan.c
Message-ID: <20030210164033.GA1142@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This should fix whitespace, please apply,
								Pavel

--- clean/drivers/acpi/scan.c	2003-01-17 23:09:34.000000000 +0100
+++ linux-swsusp/drivers/acpi/scan.c	2003-02-03 18:27:40.000000000 +0100
@@ -295,15 +295,15 @@
 	ACPI_FUNCTION_TRACE("acpi_driver_attach");
 
 	spin_lock(&acpi_device_lock);
-	list_for_each_safe(node,next,&acpi_device_list) {
-		struct acpi_device * dev = container_of(node,struct acpi_device,g_list);
+	list_for_each_safe(node, next, &acpi_device_list) {
+		struct acpi_device * dev = container_of(node, struct acpi_device, g_list);
 
 		if (dev->driver || !dev->status.present)
 			continue;
 		spin_unlock(&acpi_device_lock);
 
-		if (!acpi_bus_match(dev,drv)) {
-			if (!acpi_bus_driver_init(dev,drv)) {
+		if (!acpi_bus_match(dev, drv)) {
+			if (!acpi_bus_driver_init(dev, drv)) {
 				atomic_inc(&drv->references);
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found driver [%s] for device [%s]\n",
 						  drv->name, dev->pnp.bus_id));

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
