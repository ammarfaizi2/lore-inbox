Return-Path: <linux-kernel-owner+w=401wt.eu-S1755117AbWL2D7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755117AbWL2D7L (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 22:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755135AbWL2D7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 22:59:10 -0500
Received: from [211.144.102.245] ([211.144.102.245]:16584 "EHLO
	Web.hsic.com.cn" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755072AbWL2D7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 22:59:08 -0500
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Dec 2006 22:59:05 EST
Subject: Subject: [PATCH] Input: HID - add CIDC USB device to HID blacklist
From: Zheng XiaoJun <zhengxiaojun@hsic.com.cn>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 29 Dec 2006 11:46:53 +0800
Message-Id: <1167364013.2685.9.camel@zxj.hsic.com.cn>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Dec 2006 03:46:36.0203 (UTC) FILETIME=[F06AAFB0:01C72AFB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng XiaoJun <zhengxiaojun@hsic.com.cn>

Add CIDC USB device to HID blacklist since it is actually a USB token
and has its own driver.

Signed-off-by: Zheng XiaoJun <zhengxiaojun@hsic.com.cn>

---
--- linux-2.6.19.1.orig/drivers/usb/input/hid-core.c	2006-12-09
19:29:47.000000000 +0800
+++ linux-2.6.19.1/drivers/usb/input/hid-core.c	2006-12-25
13:54:24.000000000 +0800
@@ -1643,6 +1643,8 @@ void hid_init_reports(struct hid_device 
 #define USB_VENDOR_ID_AIRCABLE		0x16CA
 #define USB_DEVICE_ID_AIRCABLE1		0x1502
 
+#define USB_VENDOR_ID_CIDC		0x1677
+
 /*
  * Alphabetically sorted blacklist by quirk type.
  */
@@ -1812,6 +1814,8 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_PANJIT, 0x0004, HID_QUIRK_IGNORE },
 
 	{ USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_TURBOX_KEYBOARD,
HID_QUIRK_NOGET },
+
+	{ USB_VENDOR_ID_CIDC, 0x0103, HID_QUIRK_IGNORE },
 	
 	{ 0, 0 }
 };


