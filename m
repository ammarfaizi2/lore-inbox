Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWIDLlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWIDLlP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 07:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWIDLlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 07:41:15 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21770 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964782AbWIDLlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 07:41:14 -0400
Date: Mon, 4 Sep 2006 13:41:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeremy Roberson <jroberson@gtcocalcomp.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net
Subject: [2.6 patch] drivers/usb/input/hid-core.c: fix duplicate USB_DEVICE_ID_GTCO_404
Message-ID: <20060904114110.GK4416@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 01:58:18AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc4-mm3:
>...
> +gregkh-usb-hid-core.c-adds-all-gtco-calcomp-digitizers-and-interwrite-school-products-to-blacklist.patch
>...
>  USB tree updates.
>...

The GNU C compiler spotted the following bug:

<--  snip  -->

...
  CC      drivers/usb/input/hid-core.o
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/drivers/usb/input/hid-core.c:1446:1: warning: "USB_DEVICE_ID_GTCO_404" redefined
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/drivers/usb/input/hid-core.c:1445:1: warning: this is the location of the previous definition
...

<--  snip  -->

This patch fixes this cut'n'paste error.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc5-mm1/drivers/usb/input/hid-core.c.old	2006-09-03 21:00:25.000000000 +0200
+++ linux-2.6.18-rc5-mm1/drivers/usb/input/hid-core.c	2006-09-03 21:00:44.000000000 +0200
@@ -1443,7 +1443,7 @@
 #define USB_DEVICE_ID_GTCO_402		0x0402
 #define USB_DEVICE_ID_GTCO_403		0x0403
 #define USB_DEVICE_ID_GTCO_404		0x0404
-#define USB_DEVICE_ID_GTCO_404		0x0405
+#define USB_DEVICE_ID_GTCO_405		0x0405
 #define USB_DEVICE_ID_GTCO_500		0x0500
 #define USB_DEVICE_ID_GTCO_501		0x0501
 #define USB_DEVICE_ID_GTCO_502		0x0502
@@ -1663,7 +1663,7 @@
 	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_402, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_403, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_404, HID_QUIRK_IGNORE },
-	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_404, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_405, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_500, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_501, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_502, HID_QUIRK_IGNORE },


-- 
VGER BF report: U 0.499995
