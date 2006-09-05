Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWIEIMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWIEIMk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 04:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWIEIMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 04:12:40 -0400
Received: from webmail.gtco.com ([209.36.34.20]:51272 "EHLO
	mdmailserv.gtcocalcomp.local") by vger.kernel.org with ESMTP
	id S932168AbWIEIMj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 04:12:39 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [PATCH] [USB] hid-core.c: Fix apparent typo in GTCO blacklist entries
Date: Tue, 5 Sep 2006 01:15:20 -0700
Message-ID: <8EE501DE48611042A700AED41225B6B94E3DE7@azmailserv.gtcocalcomp.local>
In-Reply-To: <87pseb61cj.fsf@digitalvampire.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [USB] hid-core.c: Fix apparent typo in GTCO blacklist entries
Thread-Index: AcbQP9XNE1VrNAHISMG1Ouf4P7WoUgAg1nMQ
From: "Roberson, Jeremy" <jroberson@gtcocalcomp.com>
To: "Roland Dreier" <roland@digitalvampire.org>, <gregkh@suse.de>
Cc: <linux-kernel@vger.kernel.org>, "Gene Heskett" <gene.heskett@verizon.net>,
       <linux-usb-users@lists.sourceforge.net>
X-OriginalArrivalTime: 05 Sep 2006 08:15:21.0929 (UTC) FILETIME=[6E97F390:01C6D0C3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry all, that was indeed a typo. 

-----Original Message-----
From: Roland Dreier [mailto:roland@digitalvampire.org]
Sent: Monday, September 04, 2006 9:31 AM
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org; Gene Heskett; Roberson, Jeremy;
linux-usb-users@lists.sourceforge.net
Subject: [PATCH] [USB] hid-core.c: Fix apparent typo in GTCO blacklist
entries
Importance: High


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
