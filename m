Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266494AbTGEVF4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 17:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266495AbTGEVF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 17:05:56 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:39816 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S266494AbTGEVFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 17:05:53 -0400
Date: Sat, 5 Jul 2003 23:20:21 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: usb-storage doesn't recognize a Sony DSC-P92
Message-ID: <20030705212021.GB21621@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

For over a year I've been using a DSC-P9 successfully under Linux.
Now my mother-in-law got a P92, so I thought: "I simply hook it up, it
will work the same way".

Not so.
USB and usb-storage modules are loaded, but where the P9 works, the
P92 is not accessible. I think this may be due to a missing
vendor/product entry.

When I hook it up on the USB port I get:

Jul  5 20:50:25 shawarma kernel: hub.c: port 1, portstatus 103, change 0, 12 Mb/s
Jul  5 20:50:25 shawarma kernel: hub.c: new USB device 00:07.2-1, assigned address 8
Jul  5 20:50:25 shawarma kernel: usb.c: kmalloc IF d4b04bc0, numif 1
Jul  5 20:50:25 shawarma kernel: usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
Jul  5 20:50:25 shawarma kernel: usb.c: USB device number 8 default language ID 0x409
Jul  5 20:50:25 shawarma kernel: Manufacturer: Sony
Jul  5 20:50:25 shawarma kernel: Product: Sony DSC
Jul  5 20:50:25 shawarma kernel: usb.c: unhandled interfaces on device
Jul  5 20:50:25 shawarma kernel: usb.c: USB device 8 (vend/prod 0x54c/0x10) is not claimed by any active driver.
Jul  5 20:50:25 shawarma kernel:   Length              = 18
Jul  5 20:50:25 shawarma kernel:   DescriptorType      = 01
Jul  5 20:50:25 shawarma kernel:   USB version         = 1.10
Jul  5 20:50:25 shawarma kernel:   Vendor:Product      = 054c:0010
Jul  5 20:50:25 shawarma kernel:   MaxPacketSize0      = 8
Jul  5 20:50:25 shawarma kernel:   NumConfigurations   = 1
Jul  5 20:50:25 shawarma kernel:   Device version      = 4.50
Jul  5 20:50:25 shawarma kernel:   Device Class:SubClass:Protocol = 00:00:00
Jul  5 20:50:25 shawarma kernel:     Per-interface classes
Jul  5 20:50:25 shawarma kernel: Configuration:
Jul  5 20:50:25 shawarma kernel:   bLength             =    9
Jul  5 20:50:25 shawarma kernel:   bDescriptorType     =   02
Jul  5 20:50:25 shawarma kernel:   wTotalLength        = 0027
Jul  5 20:50:25 shawarma kernel:   bNumInterfaces      =   01
Jul  5 20:50:25 shawarma kernel:   bConfigurationValue =   01
Jul  5 20:50:25 shawarma kernel:   iConfiguration      =   00
Jul  5 20:50:25 shawarma kernel:   bmAttributes        =   c0
Jul  5 20:50:25 shawarma kernel:   MaxPower            =    2mA
Jul  5 20:50:25 shawarma kernel: 
Jul  5 20:50:25 shawarma kernel:   Interface: 0
Jul  5 20:50:25 shawarma kernel:   Alternate Setting:  0
Jul  5 20:50:26 shawarma kernel:     bLength             =    9
Jul  5 20:50:26 shawarma kernel:     bDescriptorType     =   04
Jul  5 20:50:26 shawarma kernel:     bInterfaceNumber    =   00
Jul  5 20:50:26 shawarma kernel:     bAlternateSetting   =   00
Jul  5 20:50:26 shawarma kernel:     bNumEndpoints       =   03
Jul  5 20:50:26 shawarma kernel:     bInterface Class:SubClass:Protocol =   08:ff:01
Jul  5 20:50:26 shawarma kernel:     iInterface          =   00
Jul  5 20:50:26 shawarma kernel:     Endpoint:
Jul  5 20:50:26 shawarma kernel:       bLength             =    7
Jul  5 20:50:26 shawarma kernel:       bDescriptorType     =   05
Jul  5 20:50:26 shawarma kernel:       bEndpointAddress    =   01 (out)
Jul  5 20:50:26 shawarma kernel:       bmAttributes        =   02 (Bulk)
Jul  5 20:50:26 shawarma kernel:       wMaxPacketSize      = 0040
Jul  5 20:50:26 shawarma kernel:       bInterval           =   00
Jul  5 20:50:26 shawarma kernel:     Endpoint:
Jul  5 20:50:26 shawarma kernel:       bLength             =    7
Jul  5 20:50:26 shawarma kernel:       bDescriptorType     =   05
Jul  5 20:50:26 shawarma kernel:       bEndpointAddress    =   82 (in)
Jul  5 20:50:26 shawarma kernel:       bmAttributes        =   02 (Bulk)
Jul  5 20:50:26 shawarma kernel:       wMaxPacketSize      = 0040
Jul  5 20:50:26 shawarma kernel:       bInterval           =   00
Jul  5 20:50:26 shawarma kernel:     Endpoint:
Jul  5 20:50:26 shawarma kernel:       bLength             =    7
Jul  5 20:50:26 shawarma kernel:       bDescriptorType     =   05
Jul  5 20:50:26 shawarma kernel:       bEndpointAddress    =   83 (in)
Jul  5 20:50:26 shawarma kernel:       bmAttributes        =   03 (Interrupt)
Jul  5 20:50:26 shawarma kernel:       wMaxPacketSize      = 0008
Jul  5 20:50:26 shawarma kernel:       bInterval           =   ff
Jul  5 20:50:26 shawarma kernel: usb.c: kusbd: /sbin/hotplug add 8
Jul  5 20:50:26 shawarma kernel: hub.c: port 2, portstatus 300, change 0, 1.5 Mb/s
Jul  5 20:57:02 shawarma kernel: uhci.c: root-hub INT complete: port1: 48a port2: 580 data: 2
Jul  5 20:57:02 shawarma kernel: uhci.c: d400: suspend_hc
Jul  5 20:57:02 shawarma kernel: hub.c: port 1, portstatus 100, change 3, 12 Mb/s
Jul  5 20:57:02 shawarma kernel: hub.c: port 1 connection change
Jul  5 20:57:02 shawarma kernel: hub.c: port 1, portstatus 100, change 3, 12 Mb/s
Jul  5 20:57:02 shawarma kernel: usb.c: USB disconnect on device 00:07.2-1 address 8
Jul  5 20:57:02 shawarma kernel: usb.c: kusbd: /sbin/hotplug remove 8

and the device cannot be mounted using
mount -t vfat /dev/sda1 /camera

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
