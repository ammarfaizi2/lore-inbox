Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbTEEUQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 16:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbTEEUQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 16:16:28 -0400
Received: from nycsmtp4out-eri0.rdc-nyc.rr.com ([24.29.99.227]:34705 "EHLO
	nycsmtp4out-eri0.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S261256AbTEEUQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 16:16:27 -0400
Date: Mon, 5 May 2003 16:47:11 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.69 : drivers/bluetooth/hci_usb.c
Message-ID: <Pine.LNX.4.44.0305051642060.18736-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following patch addresses the compile error below (I haven't seent 
this previously reported.). I suspect there's a cleaner patch. Please review. Thanks.

Regards,
Frank

drivers/bluetooth/hci_usb.c: In function `hci_usb_send_bulk':
drivers/bluetooth/hci_usb.c:461: `USB_ZERO_PACKET' undeclared (first use in this function)
drivers/bluetooth/hci_usb.c:461: (Each undeclared identifier is reported only once
drivers/bluetooth/hci_usb.c:461: for each function it appears in.)
make[2]: *** [drivers/bluetooth/hci_usb.o] Error 1
make[1]: *** [drivers/bluetooth] Error 2
make: *** [drivers] Error 2

--- linux/drivers/bluetooth/hci_usb.c.old	2003-05-05 16:38:58.000000000 -0400
+++ linux/drivers/bluetooth/hci_usb.c	2003-05-05 16:40:35.000000000 -0400
@@ -68,6 +68,8 @@
 #define USB_ZERO_PACKET 0
 #endif
 
+#define USB_ZERO_PACKET 0
+
 static struct usb_driver hci_usb_driver; 
 
 static struct usb_device_id bluetooth_ids[] = {

