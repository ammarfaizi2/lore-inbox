Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbUDAWN0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 17:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbUDAWMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 17:12:52 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:15847 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S263176AbUDAWK1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 17:10:27 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-rc3-mm4 usb partially broken, works at 2.6.5-rc3-mm3
Date: Thu, 1 Apr 2004 17:10:25 -0500
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404011710.26126.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.9.48] at Thu, 1 Apr 2004 16:10:25 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greets all;

The missus just asked me to scan something, but xsane locks up on the 
opening device scan.  I was booted to 2.6.5-rc3-mm4 at that time.

An lsusb went past the scanner, but hung at the end of the group of 
data from the mouse, a logitek optical wheel model thats working ok 
except for an occasional spastic jump halfway across the screen.
I am now rebooted to 2.6.5-rc3-mm3, and it appears everything is 
working ok, scanner included.

Here is where the lsusb died:
---
Bus 001 Device 002: ID 046d:c00e Logitech Inc.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 Interface
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x046d Logitech Inc.
  idProduct          0xc00e
  bcdDevice           11.00
  iManufacturer           1 Logitech
  iProduct                2 USB-PS/2 Optical Mouse
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
    MaxPower               98mA
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
          bcdHID               1.10
          bCountryCode            0
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      52
cannot get report descriptor <<<<---2.6.5-rc3-mm4 did not print this 
line, it hung instead.
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          4
        bInterval              10
  Language IDs: (length=4)
     0409 English(US)
--------------------

I hope this is helpfull & sorry for the noise.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
