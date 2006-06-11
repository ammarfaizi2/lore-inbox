Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751553AbWFKCGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbWFKCGk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 22:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbWFKCGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 22:06:40 -0400
Received: from munin.agotnes.com ([202.173.149.60]:58550 "EHLO
	mail.agotnes.com") by vger.kernel.org with ESMTP id S1751202AbWFKCGj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 22:06:39 -0400
Message-ID: <448B7A88.5070009@agotnes.com>
Date: Sun, 11 Jun 2006 12:06:00 +1000
From: =?ISO-8859-1?Q?Johny_=C5gotnes?= <johny@agotnes.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.17-rc5-mm3 - USB issues
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

My USB hub isn't recognised with the latest -mm series, whereas with 
2.6.16 vanilla it is picked up & used immediately.

The error I get in dmesg is;

hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-4: new high speed USB device using ehci_hcd and address 3
ehci_hcd 0000:00:10.3: Unlink after no-IRQ?  Controller is probably 
using the wrong IRQ.
usb 1-4: device not accepting address 3, error -110
usb 1-4: new high speed USB device using ehci_hcd and address 4
usb 1-4: device not accepting address 4, error -110
usb 1-4: new high speed USB device using ehci_hcd and address 5
usb 1-4: device not accepting address 5, error -110
usb 1-4: new high speed USB device using ehci_hcd and address 6
usb 1-4: device not accepting address 6, error -110
usb 2-2: new full speed USB device using uhci_hcd and address 2

Which seems to be related to my Belkin hub. The full USB related dmesg 
information can be found below, I'm happy to provide further debugging 
information as required :)

ACPI (acpi_bus-0192): Device `USB9]is not power manageable [20060310]
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:10.3[D] -> Link [LNKD] -> GSI 10 (level, 
low) -> IRQ 10
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.3: irq 10, io mem 0xea022000
ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.17-rc5-mm3 ehci_hcd
usb usb1: SerialNumber: 0000:00:10.3
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI (acpi_bus-0192): Device `USB6]is not power manageable [20060310]
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 11, io base 0x0000d000
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.17-rc5-mm3 uhci_hcd
usb usb2: SerialNumber: 0000:00:10.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI (acpi_bus-0192): Device `USB7]is not power manageable [20060310]
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [LNKB] -> GSI 11 (level, 
low) -> IRQ 11
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 11, io base 0x0000d400
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.17-rc5-mm3 uhci_hcd
usb usb3: SerialNumber: 0000:00:10.1
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI (acpi_bus-0192): Device `USB8]is not power manageable [20060310]
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:10.2[C] -> Link [LNKC] -> GSI 10 (level, 
low) -> IRQ 10
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 10, io base 0x0000d800
usb usb4: new device found, idVendor=0000, idProduct=0000
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.17-rc5-mm3 uhci_hcd
usb usb4: SerialNumber: 0000:00:10.2
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-4: new high speed USB device using ehci_hcd and address 3
ehci_hcd 0000:00:10.3: Unlink after no-IRQ?  Controller is probably 
using the wrong IRQ.
usb 1-4: device not accepting address 3, error -110
usb 1-4: new high speed USB device using ehci_hcd and address 4
usb 1-4: device not accepting address 4, error -110
usb 1-4: new high speed USB device using ehci_hcd and address 5
usb 1-4: device not accepting address 5, error -110
usb 1-4: new high speed USB device using ehci_hcd and address 6
usb 1-4: device not accepting address 6, error -110
usb 2-2: new full speed USB device using uhci_hcd and address 2
usb 2-2: new device found, idVendor=0731, idProduct=0528
usb 2-2: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-2: configuration #1 chosen from 1 choice
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
