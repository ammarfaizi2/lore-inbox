Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269655AbTGJRW6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 13:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269594AbTGJRVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 13:21:36 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:59821 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S269605AbTGJRU4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 13:20:56 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Greg KH <greg@kroah.com>, John Wong <kernel@implode.net>
Subject: Re: USB stops working with any of 2.4.22-pre's after 2.4.21
Date: Thu, 10 Jul 2003 13:35:34 -0400
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <20030710065801.GA351@gambit.implode.net> <20030710170217.GA12098@kroah.com>
In-Reply-To: <20030710170217.GA12098@kroah.com>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307101335.34266.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.62.27] at Thu, 10 Jul 2003 12:35:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 July 2003 13:02, Greg KH wrote:
>On Wed, Jul 09, 2003 at 11:58:01PM -0700, John Wong wrote:
>> Jul  9 23:39:44 gambit kernel: eth0: Resetting the Tx ring
>> pointer. Jul  9 23:39:51 gambit kernel: usb-ohci.c: unlink URB
>> timeout Jul  9 23:39:54 gambit kernel: NETDEV WATCHDOG: eth0:
>> transmit timed out
>
>Hm, looks like bad things are happening with your interrupts.
>
>Do you need acpi to run this box?  What happens if you disable it?
>
>As it looks like networking is also in trouble, I don't think this
> is a USB specific problem for you.
>
>Good luck,
>
>greg k-h
>-

I have a couple of nits with usb here too.

kernel is 2.4.22-pre3

dmesg shows this for a radio shack/Prolific 2303 usb-seriel convertor:
---
usbserial.c: USB Serial support registered for Generic
usbserial.c: USB Serial Driver core v1.4
usbserial.c: USB Serial support registered for PL-2303
pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.9
----
But the output of an lsusb command shows this only:
---
Bus 002 Device 006: ID 1453:4026
  Language IDs: none (invalid length string descriptor 63; len=7)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 Interface
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x1453
  idProduct          0x4026
  bcdDevice            0.00
  iManufacturer           0
  iProduct                0
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize         10
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
  Language IDs: none (invalid length string descriptor 63; len=7)
---
And my ability to use it, while never great due to config problems on 
the other end of the cable, seems now to have gone away.  There has 
also been some pretty heavy lightning activity in the area, during 
which time it may have been hooked up, and something blown from the 
EMP of a nearby strike.  I usually leave it unplugged on the seriel 
side because of that.

Does this look normal?  ISTR it used to ID itself all the time, not 
just in dmesg.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

