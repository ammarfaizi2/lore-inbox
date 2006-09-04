Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWIDOaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWIDOaI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 10:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWIDOaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 10:30:08 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:13461 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751396AbWIDOaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 10:30:06 -0400
Date: Mon, 04 Sep 2006 10:29:56 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [2.6 patch] drivers/usb/input/hid-core.c: fix duplicate
 USB_DEVICE_ID_GTCO_404
In-reply-to: <20060904114110.GK4416@stusta.de>
To: linux-kernel@vger.kernel.org
Message-id: <200609041029.56764.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20060904114110.GK4416@stusta.de>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 September 2006 07:41, Adrian Bunk wrote:
>On Fri, Sep 01, 2006 at 01:58:18AM -0700, Andrew Morton wrote:
>>...
>> Changes since 2.6.18-rc4-mm3:
>>...
>> +gregkh-usb-hid-core.c-adds-all-gtco-calcomp-digitizers-and-interwrite-
>>school-products-to-blacklist.patch ...
>>  USB tree updates.
>>...
>
>The GNU C compiler spotted the following bug:
>
><--  snip  -->
>
>...
>  CC      drivers/usb/input/hid-core.o
>/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/drivers/usb/input/hid-co
>re.c:1446:1: warning: "USB_DEVICE_ID_GTCO_404" redefined
> /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/drivers/usb/input/hid-c
>ore.c:1445:1: warning: this is the location of the previous definition
> ...
>
><--  snip  -->
>
>This patch fixes this cut'n'paste error.
>
>Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
>--- linux-2.6.18-rc5-mm1/drivers/usb/input/hid-core.c.old 2006-09-03
> 21:00:25.000000000 +0200 +++
> linux-2.6.18-rc5-mm1/drivers/usb/input/hid-core.c 2006-09-03
> 21:00:44.000000000 +0200 @@ -1443,7 +1443,7 @@
> #define USB_DEVICE_ID_GTCO_402  0x0402
> #define USB_DEVICE_ID_GTCO_403  0x0403
> #define USB_DEVICE_ID_GTCO_404  0x0404
>-#define USB_DEVICE_ID_GTCO_404  0x0405
>+#define USB_DEVICE_ID_GTCO_405  0x0405
> #define USB_DEVICE_ID_GTCO_500  0x0500
> #define USB_DEVICE_ID_GTCO_501  0x0501
> #define USB_DEVICE_ID_GTCO_502  0x0502
>@@ -1663,7 +1663,7 @@
>  { USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_402, HID_QUIRK_IGNORE },
>  { USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_403, HID_QUIRK_IGNORE },
>  { USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_404, HID_QUIRK_IGNORE },
>- { USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_404, HID_QUIRK_IGNORE },
>+ { USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_405, HID_QUIRK_IGNORE },
>  { USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_500, HID_QUIRK_IGNORE },
>  { USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_501, HID_QUIRK_IGNORE },
>  { USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_502, HID_QUIRK_IGNORE },

Thanks, applied, Just Works(TM).

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
