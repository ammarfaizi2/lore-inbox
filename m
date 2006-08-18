Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWHRVpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWHRVpJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 17:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWHRVpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 17:45:08 -0400
Received: from smtp7k.poczta.onet.pl ([213.180.130.85]:37786 "EHLO
	smtp7k.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S1751491AbWHRVpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 17:45:07 -0400
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Date: Fri, 18 Aug 2006 23:43:29 +0200
From: tomek.fizyk@op.pl
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 2.6.17.9] USB: pl2303: removed support for OTi's DKU-5
    clone cable
X-Priority: 3
X-Mailer: onet.poczta
Message-Id: <20060818214343Z1208572-9773+4@kps7.test.onet.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Kazmierczak <tomek.fizyk@op.pl>

This patch removes support for a clone of Nokia DKU-5 cable made by
Ours Technology Inc, as it turned out that the cable does not use the pl2303 chip, but OTI-6858 chip which is not compatible with the pl2303.

Signed-off-by: Tomasz Kazmierczak <tomek.fizyk@op.pl>

---
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
--- a/drivers/usb/serial/pl2303.c	2006-08-18 18:26:24.000000000 +0200
+++ b/drivers/usb/serial/pl2303.c	2006-08-18 22:32:53.000000000 +0200
@@ -79,7 +79,6 @@
 	{ USB_DEVICE(SAGEM_VENDOR_ID, SAGEM_PRODUCT_ID) },
 	{ USB_DEVICE(LEADTEK_VENDOR_ID, LEADTEK_9531_PRODUCT_ID) },
 	{ USB_DEVICE(SPEEDDRAGON_VENDOR_ID, SPEEDDRAGON_PRODUCT_ID) },
-	{ USB_DEVICE(OTI_VENDOR_ID, OTI_PRODUCT_ID) },
 	{ }					/* Terminating entry */
 };
 
diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
--- a/drivers/usb/serial/pl2303.h	2006-08-18 18:26:24.000000000 +0200
+++ b/drivers/usb/serial/pl2303.h	2006-08-18 22:32:38.000000000 +0200
@@ -80,7 +80,3 @@
 /* USB GSM cable from Speed Dragon Multimedia, Ltd */
 #define SPEEDDRAGON_VENDOR_ID	0x0e55
 #define SPEEDDRAGON_PRODUCT_ID	0x110b
-
-/* Ours Technology Inc DKU-5 clone, chipset: Prolific Technology Inc */
-#define OTI_VENDOR_ID	0x0ea0
-#define OTI_PRODUCT_ID	0x6858
