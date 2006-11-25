Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935141AbWKYEVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935141AbWKYEVL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 23:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935142AbWKYEVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 23:21:10 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:56622 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S935141AbWKYEVJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 23:21:09 -0500
Date: Fri, 24 Nov 2006 23:21:02 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.19-rc5-mm2 : usb keeps resetting usb keyboard.
In-reply-to: <4567BB70.6080907@comcast.net>
To: linux-kernel@vger.kernel.org
Cc: Ed Sweetman <safemode2@comcast.net>, linux-usb-devel@lists.sourceforge.net
Message-id: <200611242321.02776.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 8BIT
Content-disposition: inline
References: <4567BB70.6080907@comcast.net>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 November 2006 22:41, Ed Sweetman wrote:
>I just upgraded from a ps2 keyboard to usb and have been getting these
>messages seemingly randomly, which also corresponds to whatever key i'm
>pressing at the time they occur to act like it's stuck down.
>
>usb 2-2: reset low speed USB device using ohci_hcd and address 3
>usb 2-2: reset low speed USB device using ohci_hcd and address 3
>usb 2-2: reset low speed USB device using ohci_hcd and address 3
>usb 2-2: reset low speed USB device using ohci_hcd and address 3
>usb 2-2: reset low speed USB device using ohci_hcd and address 3
>usb 2-2: reset low speed USB device using ohci_hcd and address 3
>usb 2-2: reset low speed USB device using ohci_hcd and address 3
>
>(repeated a few hundred times )
>
All the data below doesn't point to the culprit.  

I also have this, and I'd bet the common point is going to be an M$ 
wireless mouse like I have.  The mouse works ok as near as I can tell, so 
I'm not sure of the exact cause.

To verify, unplug the receiver for that mouse, wait 5secs, and plug it 
back in, which if thats it should move the mouse, and the log message to 
a higher number on the usb tree.

Also, FWIW dear lkml readers, my logs have been contaminated with this 
since about a year ago, running kernel.org kernels on an FC2 system, but 
using the latest FC6 non-xen kernel.

>From an lsusb -v:
----------
Bus 002 Device 003: ID 045e:008c Microsoft Corp. Wireless Intellimouse 
Explorer 2.0
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x045e Microsoft Corp.
  idProduct          0x008c Wireless Intellimouse Explorer 2.0
  bcdDevice            0.57
  iManufacturer           1 Microsoft
  iProduct                2 Microsoft Wireless Optical Mouse 1.0A
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      Remote Wakeup
    MaxPower               50mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     209
         Report Descriptors:
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              10
-------------------

How close am I in this suposition?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
