Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbTJIGg7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 02:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTJIGg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 02:36:59 -0400
Received: from [66.62.77.7] ([66.62.77.7]:31389 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S261899AbTJIGg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 02:36:58 -0400
Subject: [PATCH] Add Handspring Treo 600 ids
From: Dax Kelson <dax@gurulabs.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Content-Type: text/plain
Message-Id: <1065681411.12124.23.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2) 
Date: Thu, 09 Oct 2003 00:36:52 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tested this with my new Treo 600 and it works. Please apply.


diff -urNp linux-treo600/drivers/usb/serial/visor.c linux/drivers/usb/serial/visor.c
--- linux-treo600/drivers/usb/serial/visor.c	2003-10-09 00:25:07.000000000 -0600
+++ linux/drivers/usb/serial/visor.c	2003-10-09 00:25:23.000000000 -0600
@@ -195,6 +195,7 @@ static int param_register;
 static struct usb_device_id id_table [] = {
 	{ USB_DEVICE(HANDSPRING_VENDOR_ID, HANDSPRING_VISOR_ID) },
 	{ USB_DEVICE(HANDSPRING_VENDOR_ID, HANDSPRING_TREO_ID) },
+	{ USB_DEVICE(HANDSPRING_VENDOR_ID, HANDSPRING_TREO600_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M500_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M505_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M515_ID) },
@@ -222,6 +223,7 @@ static struct usb_device_id clie_id_3_5_
 static __devinitdata struct usb_device_id id_table_combined [] = {
 	{ USB_DEVICE(HANDSPRING_VENDOR_ID, HANDSPRING_VISOR_ID) },
 	{ USB_DEVICE(HANDSPRING_VENDOR_ID, HANDSPRING_TREO_ID) },
+	{ USB_DEVICE(HANDSPRING_VENDOR_ID, HANDSPRING_TREO600_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M500_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M505_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M515_ID) },
diff -urNp linux-treo600/drivers/usb/serial/visor.h linux/drivers/usb/serial/visor.h
--- linux-treo600/drivers/usb/serial/visor.h	2003-10-09 00:25:07.000000000 -0600
+++ linux/drivers/usb/serial/visor.h	2003-10-09 00:25:23.000000000 -0600
@@ -20,6 +20,7 @@
 #define HANDSPRING_VENDOR_ID		0x082d
 #define HANDSPRING_VISOR_ID		0x0100
 #define HANDSPRING_TREO_ID		0x0200
+#define HANDSPRING_TREO600_ID		0x0300
 
 #define PALM_VENDOR_ID			0x0830
 #define PALM_M500_ID			0x0001


