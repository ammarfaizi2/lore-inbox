Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVHASds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVHASds (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 14:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVHASdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 14:33:44 -0400
Received: from 69.36.162.216.west-datacenter.net ([69.36.162.216]:62879 "EHLO
	schau.com") by vger.kernel.org with ESMTP id S261172AbVHASdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 14:33:16 -0400
Message-ID: <42EE6B11.7000609@schau.com>
Date: Mon, 01 Aug 2005 20:33:53 +0200
From: Brian Schau <brian@schau.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vojtech@suse.cz
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13-rc4] Patch to hid-core.c
Content-Type: multipart/mixed;
 boundary="------------000509020806090203000604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000509020806090203000604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

(Retrying ..)

Hi Vojtech,


Please apply the following patch to hid-core.c.   It adds a device to the
exception-/blacklist.
The device is a Wireless Security Lock (WSL).   The device identifies itself
as a Cypress Ultra Mouse.   It is, however, not a mouse at all and as such,
shouldn't be handled as one, which is why I want to put it on the blacklist.
The patch is also attached as a gzipped archive - it seems that my mailer
screws up from time to time.

--- linux-1.6.13-rc4/drivers/usb/input/hid-core.c.orig	2005-08-01 20:15:05.000000000 +0200
+++ linux-2.6.13-rc4/drivers/usb/input/hid-core.c	2005-07-31 17:06:36.000000000 +0200
@@ -1375,6 +1375,7 @@ void hid_init_reports(struct hid_device
  #define USB_VENDOR_ID_CYPRESS		0x04b4
  #define USB_DEVICE_ID_CYPRESS_MOUSE	0x0001
  #define USB_DEVICE_ID_CYPRESS_HIDCOM	0x5500
+#define USB_DEVICE_ID_CYPRES_ULTRAMOUSE	0x7417

  #define USB_VENDOR_ID_BERKSHIRE		0x0c98
  #define USB_DEVICE_ID_BERKSHIRE_PCWD	0x1140
@@ -1465,6 +1466,7 @@ static struct hid_blacklist {
  	{ USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW48, HID_QUIRK_IGNORE },
  	{ USB_VENDOR_ID_CODEMERCS, USB_DEVICE_ID_CODEMERCS_IOW28, HID_QUIRK_IGNORE },
  	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_HIDCOM, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRES_ULTRAMOUSE, HID_QUIRK_IGNORE },
  	{ USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EARTHMATE, HID_QUIRK_IGNORE },
  	{ USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20, HID_QUIRK_IGNORE },
  	{ USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5, HID_QUIRK_IGNORE },

Signed-off-by:	Brian Schau <brian@schau.com>


/brian

--------------000509020806090203000604
Content-Type: application/x-gzip;
 name="hid-core-2.6.13-rc4.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="hid-core-2.6.13-rc4.patch.gz"

H4sICPNp7kIAA2hpZC1jb3JlLTIuNi4xMy1yYzQucGF0Y2gArZFda8IwFIav9VcEdjOoqUnt
h/PK2oYZbK1Lq+JV0LbbwkSlrSLI/vvq1/Bz07HcBM55eDjnPRBCMBaT+RIqsi7jCkxCtRwl
YhEnaXmejspiMptn5XcRwXCaxHIoTxPxVlAQ0iCqQoSBgmpYqyFNRvsHJJT3i5Ik3afeWQ1Y
wQAbNaTXKvqZtV4HEFcMraQDafMbIC8tpiICuYmLich4Es+mSZY+plkyD7NNPYoXIoxBETxE
8auYxKDrN3iPtG2PcWpza9BhxPcLBbRE6kg9xmzSoxY5wLjrdX2yZhHCv7FNaluem8Oatg7l
J5h3nYCZe7mhYqN4deIGYS2/SRnZzBw+Va/N8Q3yjtW3cxhjdRejqm9jVHV9G2OaDTMRgoPc
RuNh+DEWaQZWRVBYncbm2cQlzPJLp/vsG5x6fbVaAnkK/KVLWYvT57bHCPgs/dmn3O7b3uDM
dnSayzLpPtnB6W4dziaOx1xy6tuVOTFZ0HTN4N98LncCBd1qyzcl7YCaDmfEdGgwOPWeAbyj
XZZ/AbCBPixkBAAA
--------------000509020806090203000604--
