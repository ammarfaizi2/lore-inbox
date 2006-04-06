Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWDFUHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWDFUHb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 16:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWDFUHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 16:07:30 -0400
Received: from smtp10k.poczta.onet.pl ([213.180.130.90]:47517 "EHLO
	smtp10k.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S1751267AbWDFUHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 16:07:30 -0400
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Date: Thu, 06 Apr 2006 22:07:12 +0200
From: tomek.fizyk@op.pl
To: greg@kroah.com
Cc: linux-usb-users@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] pl2303: added support for OTi's DKU-5 clone cable
X-Priority: 3
X-Mailer: onet.poczta
Message-Id: <20060406200716Z2608200-18763+115@kps10.test.onet.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Kazmierczak <tomek.fizyk@op.pl>

This patch adds support for a clone of Nokia DKU-5 cable made by
Ours Technology Inc for Nokia phones with PopPort (Nokia 3100 and others).
The cable uses PL2303 USB-to-serial converter from Prolific Technology Inc.
Signed-off-by: Tomasz Kazmierczak <tomek.fizyk@op.pl>
---
kernel version: linux-2.6.17-rc1

diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -78,6 +78,7 @@ static struct usb_device_id id_table [] 
 	{ USB_DEVICE(SAGEM_VENDOR_ID, SAGEM_PRODUCT_ID) },
 	{ USB_DEVICE(LEADTEK_VENDOR_ID, LEADTEK_9531_PRODUCT_ID) },
 	{ USB_DEVICE(SPEEDDRAGON_VENDOR_ID, SPEEDDRAGON_PRODUCT_ID) },
+	{ USB_DEVICE(OTI_VENDOR_ID, OTI_PRODUCT_ID) },
 	{ }					/* Terminating entry */
 };
 
diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -79,3 +79,7 @@
 /* USB GSM cable from Speed Dragon Multimedia, Ltd */
 #define SPEEDDRAGON_VENDOR_ID	0x0e55
 #define SPEEDDRAGON_PRODUCT_ID	0x110b
+
+/* Ours Technology Inc DKU-5 clone, chipset: Prolific Technology Inc */
+#define OTI_VENDOR_ID	0x0ea0
+#define OTI_PRODUCT_ID	0x6858
