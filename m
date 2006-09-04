Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbWIDQaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbWIDQaj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 12:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWIDQaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 12:30:39 -0400
Received: from sccrmhc13.comcast.net ([204.127.200.83]:56477 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S964933AbWIDQai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 12:30:38 -0400
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, Gene Heskett <gene.heskett@verizon.net>,
       jroberson@gtcocalcomp.com, linux-usb-users@lists.sourceforge.net
Subject: [PATCH] [USB] hid-core.c: Fix apparent typo in GTCO blacklist
 entries
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@digitalvampire.org>
Date: Mon, 04 Sep 2006 09:30:36 -0700
Message-ID: <87pseb61cj.fsf@digitalvampire.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6f8d9e26e7deecb1296c221aa979542bc5d63f20 added blacklist
entries for GTCO products, but it included an apparent cut-and-paste
typo (the device ID entry for GTCO_404 is duplicated with two
different values, and used twice in the blacklist).  This leads to the
warning:

    drivers/usb/input/hid-core.c:1447:1: warning: "USB_DEVICE_ID_GTCO_404" redefined

Fix this by correcting the second device ID name to GTCO_405, and
using it in the blacklist.

Signed-off-by: Roland Dreier <roland@digitalvampire.org>

---

diff --git a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
index acb24c6..a2c56b2 100644
--- a/drivers/usb/input/hid-core.c
+++ b/drivers/usb/input/hid-core.c
@@ -1444,7 +1444,7 @@ #define USB_DEVICE_ID_GTCO_401		0x0401
 #define USB_DEVICE_ID_GTCO_402		0x0402
 #define USB_DEVICE_ID_GTCO_403		0x0403
 #define USB_DEVICE_ID_GTCO_404		0x0404
-#define USB_DEVICE_ID_GTCO_404		0x0405
+#define USB_DEVICE_ID_GTCO_405		0x0405
 #define USB_DEVICE_ID_GTCO_500		0x0500
 #define USB_DEVICE_ID_GTCO_501		0x0501
 #define USB_DEVICE_ID_GTCO_502		0x0502
@@ -1657,7 +1657,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_402, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_403, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_404, HID_QUIRK_IGNORE },
-	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_404, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_405, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_500, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_501, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_502, HID_QUIRK_IGNORE },
