Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263292AbTJKMsr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 08:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263297AbTJKMsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 08:48:47 -0400
Received: from ulysses.news.tiscali.de ([195.185.185.36]:27140 "EHLO
	ulysses.news.tiscali.de") by vger.kernel.org with ESMTP
	id S263292AbTJKMsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 08:48:43 -0400
To: linux-kernel@vger.kernel.org
Path: 127.0.0.1!nobody
From: Peter Matthias <espi@epost.de>
Newsgroups: linux.kernel
Subject: ACM USB modem on Kernel 2.6.0-test
Date: Sat, 11 Oct 2003 14:38:00 +0200
Organization: Tiscali Germany
Message-ID: <8jt8mb.5a.ln@127.0.0.1>
NNTP-Posting-Host: p62.246.122.217.tisdip.tiscali.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: ulysses.news.tiscali.de 1065876416 52379 62.246.122.217 (11 Oct 2003 12:46:56 GMT)
X-Complaints-To: abuse@tiscali.de
NNTP-Posting-Date: Sat, 11 Oct 2003 12:46:56 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a problem running my Elsa Microlink USB modem with latest 2.6.0-test7
kernel. On startup I get:

usb 3-3: configuration #1 chosen from 2 choices
drivers/usb/class/cdc-acm.c: need inactive config #2
drivers/usb/class/cdc-acm.c: need inactive config #2

and the driver is not being loaded. I have no problems with 2.4 kernels.

Thank you,
        Peter


lsusb says:

Bus 003 Device 002: ID 05cc:2267 ELSA AG
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            2 Communications
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x05cc ELSA AG
  idProduct          0x2267
  bcdDevice            1.00
  iManufacturer           1 Lucent Technologies, Inc.
  iProduct                2 ELSA Modem Board
  iSerial                 0
  bNumConfigurations      2
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           41
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          3
    bmAttributes         0xa0
      Remote Wakeup
    MaxPower              400mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              4 Lucent Win95 Modem USB
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              5 Control Interface
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         16
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize         63
        bInterval               2
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           67
    bNumInterfaces          2
    bConfigurationValue     2
    iConfiguration          6
    bmAttributes         0xa0
      Remote Wakeup
    MaxPower              400mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         2 Communications
      bInterfaceSubClass      2 Abstract (modem)
      bInterfaceProtocol      1 AT-commands
      iInterface              4 Lucent Win95 Modem USB
  unknown descriptor type: 05 24 00 00 01
  unknown descriptor type: 05 24 01 03 01
  unknown descriptor type: 04 24 02 07
  unknown descriptor type: 05 24 06 00 01
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize         32
        bInterval             128
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass        10
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              5 Control Interface
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
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
  Language IDs: (length=6)
     0009 English(English)
     0409 English(US)

