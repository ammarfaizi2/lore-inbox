Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVCRQxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVCRQxS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 11:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVCRQxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 11:53:12 -0500
Received: from metis.extern.pengutronix.de ([83.236.181.26]:64687 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S261680AbVCRQup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 11:50:45 -0500
Date: Fri, 18 Mar 2005 17:50:44 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] export platform_add_devices
Message-ID: <20050318165044.GQ11709@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

platform_add_devices can be used from within modules, so it should be
exported. This can for example happen if you have hotpluggable firmware
in an FPGA on a system on chip processor; in our case the FPGA is probed
for devices and the FPGA base code registers the devices it has found
with the kernel. 

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

Robert

--- linux-2.6.11/drivers/base/platform.c	2005-03-02 08:37:48.000000000 +0100
+++ linux-2.6.11-trunk/drivers/base/platform.c	2005-03-14 22:01:46.000000000 +0100
@@ -341,6 +341,7 @@
 
 EXPORT_SYMBOL_GPL(platform_bus);
 EXPORT_SYMBOL_GPL(platform_bus_type);
+EXPORT_SYMBOL_GPL(platform_add_devices);
 EXPORT_SYMBOL_GPL(platform_device_register);
 EXPORT_SYMBOL_GPL(platform_device_register_simple);
 EXPORT_SYMBOL_GPL(platform_device_unregister);
