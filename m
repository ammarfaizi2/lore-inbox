Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbTJITgq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 15:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbTJITgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 15:36:17 -0400
Received: from [66.62.77.7] ([66.62.77.7]:50603 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S262070AbTJITev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 15:34:51 -0400
Subject: [2.6.0-test7 PATCH] Handspring Treo 600 id
From: Dax Kelson <Dax@GuruLabs.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1065728090.2843.19.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 09 Oct 2003 13:34:50 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a new toy. This obviously correct 4 liner patches
the two files:

drivers/usb/serial/visor.c
drivers/usb/serial/visor.h

Works like a champ here. Linus, please apply.


diff -ur linux-2.6.0-test7-treo600/drivers/usb/serial/visor.c linux-2.6.0-test7/drivers/usb/serial/visor.c
--- linux-2.6.0-test7-treo600/drivers/usb/serial/visor.c	2003-10-09 13:26:41.000000000 -0600
+++ linux-2.6.0-test7/drivers/usb/serial/visor.c	2003-10-09 13:26:18.000000000 -0600
@@ -201,6 +201,8 @@
 		.driver_info = (kernel_ulong_t)&palm_os_3_probe },
 	{ USB_DEVICE(HANDSPRING_VENDOR_ID, HANDSPRING_TREO_ID),
 		.driver_info = (kernel_ulong_t)&palm_os_4_probe },
+	{ USB_DEVICE(HANDSPRING_VENDOR_ID, HANDSPRING_TREO600_ID),
+		.driver_info = (kernel_ulong_t)&palm_os_4_probe },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M500_ID),
 		.driver_info = (kernel_ulong_t)&palm_os_4_probe },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M505_ID),
@@ -247,6 +249,7 @@
 static struct usb_device_id id_table_combined [] = {
 	{ USB_DEVICE(HANDSPRING_VENDOR_ID, HANDSPRING_VISOR_ID) },
 	{ USB_DEVICE(HANDSPRING_VENDOR_ID, HANDSPRING_TREO_ID) },
+	{ USB_DEVICE(HANDSPRING_VENDOR_ID, HANDSPRING_TREO600_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M500_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M505_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M515_ID) },
diff -ur linux-2.6.0-test7-treo600/drivers/usb/serial/visor.h linux-2.6.0-test7/drivers/usb/serial/visor.h
--- linux-2.6.0-test7-treo600/drivers/usb/serial/visor.h	2003-10-09 13:26:50.000000000 -0600
+++ linux-2.6.0-test7/drivers/usb/serial/visor.h	2003-10-09 13:26:22.000000000 -0600
@@ -20,6 +20,7 @@
 #define HANDSPRING_VENDOR_ID		0x082d
 #define HANDSPRING_VISOR_ID		0x0100
 #define HANDSPRING_TREO_ID		0x0200
+#define HANDSPRING_TREO600_ID		0x0300
 
 #define PALM_VENDOR_ID			0x0830
 #define PALM_M500_ID			0x0001


