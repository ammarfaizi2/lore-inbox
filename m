Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVBGFQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVBGFQB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 00:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVBGFQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 00:16:00 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:9359 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261355AbVBGFP0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 00:15:26 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6: USB disk unusable level of data corruption
Date: Sun, 6 Feb 2005 21:15:07 -0800
User-Agent: KMail/1.7.1
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
References: <1107519382.1703.7.camel@localhost.localdomain> <200502041241.28029.david-b@pacbell.net> <1107744922.8689.6.camel@localhost.localdomain>
In-Reply-To: <1107744922.8689.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502062115.07626.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 February 2005 6:55 pm, Rusty Russell wrote:
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x0dc4 Macpower Peripherals, Ltd
>   idProduct          0x00c4
>   bcdDevice            0.02
>   iManufacturer           1 Macpower
>   iProduct                2 2.5HDD
>   iSerial                 3 8000D1
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           32
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          4 Myson 8818

Not one I'd be familiar with, but that doesn't mean anything.

And I didn't see an "unusual_devs.h" entry for it, but it does
look to need the CONFIG_USB_STORAGE_HP8200e support, which I
see is labeled "experimental".  I don't know how solid the
support for that is.   But I see Greg's checked in a big patch
against the file with that driver, which should make the next
MM patchset against 2.6.11-rc3 ... mostly to support some
new hardware, but with that many changes I suspect there'll
be some bugfixes too.

This would be www.macpower.com.tw/produts/hdd2/daisycutter/dc_usb2
maybe?  The www.qbik.ch/usb/devices database has a report from one
user saying they had problems with a different MacPower adapter until
they fixed its jumpers.  Also worth a check.

- Dave



>     bmAttributes         0xc0
>       Self Powered
>     MaxPower               10mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass         8 Mass Storage
>       bInterfaceSubClass      5 SFF-8070i
>       bInterfaceProtocol     80
>       iInterface              5 USB2.0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x03  EP 3 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval               0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x84  EP 4 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval               0
> Device Qualifier (for other device speed):
>   bLength                10
>   bDescriptorType         6
>   bcdUSB               2.00
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   bNumConfigurations      1
> 
