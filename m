Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbVIVHuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVIVHuo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbVIVHuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:50:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:17587 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932172AbVIVHtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:49:43 -0400
Date: Thu, 22 Sep 2005 00:48:40 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       smurf@smurf.noris.de
Subject: [patch 10/18] USB: more device IDs for Option card driver
Message-ID: <20050922074839.GK15053@kroah.com>
References: <20050922003901.814147000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-option-new-ids.patch"
In-Reply-To: <20050922074643.GA15053@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Urlichs <smurf@smurf.noris.de>

Added support for HUAWEI E600 and Audiovox AirCard

User reports say that these devices work without driver modification.

Signed-off-by: Matthias Urlichs <smurf@smurf.noris.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/usb/serial/option.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- scsi-2.6.orig/drivers/usb/serial/option.c	2005-09-20 06:00:04.000000000 -0700
+++ scsi-2.6/drivers/usb/serial/option.c	2005-09-21 17:29:39.000000000 -0700
@@ -25,6 +25,7 @@
   2005-06-20  v0.4.1 add missing braces :-/
                      killed end-of-line whitespace
   2005-07-15  v0.4.2 rename WLAN product to FUSION, add FUSION2
+  2005-09-10  v0.4.3 added HUAWEI E600 card and Audiovox AirCard
 
   Work sponsored by: Sigos GmbH, Germany <info@sigos.de>
 
@@ -71,15 +72,21 @@
 
 /* Vendor and product IDs */
 #define OPTION_VENDOR_ID			0x0AF0
+#define HUAWEI_VENDOR_ID			0x12D1
+#define AUDIOVOX_VENDOR_ID			0x0F3D
 
 #define OPTION_PRODUCT_OLD		0x5000
 #define OPTION_PRODUCT_FUSION	0x6000
 #define OPTION_PRODUCT_FUSION2	0x6300
+#define HUAWEI_PRODUCT_E600     0x1001
+#define AUDIOVOX_PRODUCT_AIRCARD 0x0112
 
 static struct usb_device_id option_ids[] = {
 	{ USB_DEVICE(OPTION_VENDOR_ID, OPTION_PRODUCT_OLD) },
 	{ USB_DEVICE(OPTION_VENDOR_ID, OPTION_PRODUCT_FUSION) },
 	{ USB_DEVICE(OPTION_VENDOR_ID, OPTION_PRODUCT_FUSION2) },
+	{ USB_DEVICE(HUAWEI_VENDOR_ID, HUAWEI_PRODUCT_E600) },
+	{ USB_DEVICE(AUDIOVOX_VENDOR_ID, AUDIOVOX_PRODUCT_AIRCARD) },
 	{ } /* Terminating entry */
 };
 

--
