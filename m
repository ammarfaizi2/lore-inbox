Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbUCYR15 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 12:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263507AbUCYR14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 12:27:56 -0500
Received: from colino.net ([62.212.100.143]:752 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S263513AbUCYR0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 12:26:36 -0500
Date: Thu, 25 Mar 2004 18:26:04 +0100
From: Colin Leroy <colin@colino.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, <linux-usb-devel@lists.sf.net>
Subject: Re: [linux-usb-devel] Re: [OOPS] reproducible oops with
 2.6.5-rc2-bk3
Message-Id: <20040325182604.2db9666c@jack.colino.net>
In-Reply-To: <Pine.LNX.4.44L0.0403251153110.1083-100000@ida.rowland.org>
References: <13c901c41287$d29bb040$3cc8a8c0@epro.dom>
	<Pine.LNX.4.44L0.0403251153110.1083-100000@ida.rowland.org>
Organization: 
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 2.2.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Mar 2004 at 11h03, Alan Stern wrote:

> It's not as bad as it looks. 

Ok, thanks for the clarification. In the mean time here's the lsusb -v output for my phone. I'll try to find out why we have a null pointer.


Bus 003 Device 003: ID 22b8:3802
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB              10.01
  bDeviceClass            2 Communications
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x22b8
  idProduct          0x3802
  bcdDevice            1.00
  iManufacturer           1 Motorola Inc.
  iProduct                2 Motorola Phone (C350)
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           67
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          4
    bmAttributes         0xc0
      Self Powered
    MaxPower               20mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         2 Communications
      bInterfaceSubClass      2 Abstract (modem)
      bInterfaceProtocol      1 AT-commands (v.25ter)
      iInterface              5 Motorola Communication Interface
  unknown descriptor type: 05 24 00 01 01
  unknown descriptor type: 05 24 01 03 01
  unknown descriptor type: 05 24 06 00 01
  unknown descriptor type: 04 24 02 02
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x89  EP 9 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize         16
        bInterval              10
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass        10 Data
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0
      iInterface             16 Motorola Data Interface
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         16
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         16
        bInterval               0
  Language IDs: (length=4)
     0409 English(US)

Thanks!
-- 
Colin
