Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030583AbVKDCIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030583AbVKDCIg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 21:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030587AbVKDCIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 21:08:36 -0500
Received: from pop-knobcone.atl.sa.earthlink.net ([207.69.195.64]:4339 "EHLO
	pop-knobcone.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1030583AbVKDCIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 21:08:36 -0500
From: John Mock <kd6pag@qsl.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14: advansys & zd1201 on PowerMac 8500/G3
Message-Id: <E1EXr0G-00045u-98@penngrove.fdns.net>
Date: Thu, 03 Nov 2005 18:08:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    PowerMac 8500 is an old fragile beast. Especially with a G3 processor
    hooked on it. The venerable Apple Bandit PCI bridge can have some
    "issues" every now and then with trivial things like ... cache coherency
    (ugh !). It tends to hit things like USB pretty badly. I can't guarantee
    for sure that's the cause of your problem, but it's possible...
					       -- benh@kernel.crashing.org

The ZD1201 driver has been stable on 2.6.11.7 and i think also 2.6.13-rc6,
but 2.6.14/ppc seems to have problems with that driver.  I suppose i could
try building up an 2.6.14/i386 and test it there if that might help...  

Attached are some USB kernel messages and extracts from `lsusb -v`.  Thank
you for your comments and assistance.

				  -- JM

-------------------------------------------------------------------------------
	...
usbcore: registered new driver usbfs
usbcore: registered new driver hub
usbcore: registered new driver usbmouse
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
	...
USB Universal Host Controller Interface driver v2.3
PCI: Enabling device 0000:00:0f.0 (0014 -> 0015)
PCI: Via IRQ fixup for 0000:00:0f.0, from 25 to 9
uhci_hcd 0000:00:0f.0: UHCI Host Controller
uhci_hcd 0000:00:0f.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:0f.0: irq 25, io base 0x00000860
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Enabling device 0000:00:0f.1 (0014 -> 0015)
PCI: Via IRQ fixup for 0000:00:0f.1, from 25 to 9
uhci_hcd 0000:00:0f.1: UHCI Host Controller
usb 1-1: new low speed USB device using uhci_hcd and address 2
uhci_hcd 0000:00:0f.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:0f.1: irq 25, io base 0x00000840
input: Logitech N48 on usb-0000:00:0f.0-1
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 2-1: new full speed USB device using uhci_hcd and address 2
usb 2-1: wlan0: ZD1201 USB Wireless interface
usbcore: registered new driver zd1201
PCI: Enabling device 0000:00:0f.2 (0014 -> 0016)
PCI: Via IRQ fixup for 0000:00:0f.2, from 25 to 9
ehci_hcd 0000:00:0f.2: EHCI Host Controller
ehci_hcd 0000:00:0f.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:0f.2: irq 25, io mem 0x80800000
ehci_hcd 0000:00:0f.2: USB 2.0 initialized, EHCI 0.95, driver 10 Dec 2004
usb 2-1: wlan0: rx urb failed: -84
usb 2-1: USB disconnect, address 2
usb 1-1: USB disconnect, address 2
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
usb 1-1: new low speed USB device using uhci_hcd and address 3
input: Logitech N48 on usb-0000:00:0f.0-1
usb 2-1: new full speed USB device using uhci_hcd and address 3
usb 2-1: wlan0: ZD1201 USB Wireless interface
	...
-------------------------------------------------------------------------------
Bus 003 Device 001: ID 0000:0000  
	...
  iManufacturer           3 Linux 2.6.11.7 ehci_hcd
  iProduct                2 VIA Technologies, Inc. USB 2.0
	...
Bus 002 Device 003: ID 0ace:1201  
	...
  iManufacturer           0 
  iProduct                2 USB WLAN
	...
Bus 002 Device 001: ID 0000:0000  
	...
  iManufacturer           3 Linux 2.6.11.7 uhci_hcd
  iProduct                2 VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
	...
Bus 001 Device 003: ID 046d:c001 Logitech, Inc. N48/M-BB48 [FirstMouse Plus]
	...
  idVendor           0x046d Logitech, Inc.
  idProduct          0xc001 N48/M-BB48 [FirstMouse Plus]
	...
Bus 001 Device 001: ID 0000:0000  
	...
  iManufacturer           3 Linux 2.6.11.7 uhci_hcd
  iProduct                2 VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
	...
===============================================================================
