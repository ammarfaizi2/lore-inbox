Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWIVVUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWIVVUG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 17:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWIVVUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 17:20:06 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:2463 "EHLO max.feld.cvut.cz")
	by vger.kernel.org with ESMTP id S932174AbWIVVUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 17:20:04 -0400
From: CIJOML <cijoml@volny.cz>
To: linux-kernel@vger.kernel.org
Subject: Freecom DVB-T tuner firmware load with ohci(ehci) driver
Date: Fri, 22 Sep 2006 23:20:00 +0200
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609222320.00589.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have bought Kouwell Cardbus adapter with 2 USB2.0 and 2 Firewire ports.
In my older laptop with i852 chipset and Pentium4 Celeron card works with all 
the devices

01:04.0 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus Controller 
(rev 01)
01:04.1 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus Controller 
(rev 01)


but with my newer laptop i855 chipset Intel Pentium M everythink works except 
my DVB-T card firmware load fails (my flashdrive, my bluetooth dongle 
works...)

02:0b.0 CardBus bridge: O2 Micro, Inc. OZ711M1/MC1 4-in-1 MemoryCardBus 
Controller (rev 20)
02:0b.1 CardBus bridge: O2 Micro, Inc. OZ711M1/MC1 4-in-1 MemoryCardBus 
Controller (rev 20)


In both cases YENTA module is loaded.

pccard: CardBus card inserted into slot 0
PCI: Enabling device 0000:03:00.3 (0000 -> 0002)
ACPI: PCI Interrupt 0000:03:00.3[A] -> Link [LNKC] -> GSI 11 (level, low) -> 
IRQ 11
ehci_hcd 0000:03:00.3: EHCI Host Controller
ehci_hcd 0000:03:00.3: new USB bus registered, assigned bus number 5
ehci_hcd 0000:03:00.3: debug port 1
ehci_hcd 0000:03:00.3: irq 11, io mem 0x56003800
ehci_hcd 0000:03:00.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 6 ports detected
PCI: Enabling device 0000:03:00.4 (0000 -> 0002)
ACPI: PCI Interrupt 0000:03:00.4[C] -> Link [LNKC] -> GSI 11 (level, low) -> 
IRQ 11
PCI: Setting latency timer of device 0000:03:00.4 to 64
usb 5-2: new high speed USB device using ehci_hcd and address 2
ohci1394: fw-host1: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[56003000-560037ff]  
Max Packet=[2048]  IR/IT contexts=[4/8]
eth1394: eth3: IEEE-1394 IPv4 over 1394 Ethernet (fw-host1)
usb 5-2: configuration #1 chosen from 1 choice
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
PCI: Enabling device 0000:03:00.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:03:00.0[B] -> Link [LNKC] -> GSI 11 (level, low) -> 
IRQ 11
ohci_hcd 0000:03:00.0: OHCI Host Controller
ohci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 6
ohci_hcd 0000:03:00.0: irq 11, io mem 0x56000000
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
PCI: Enabling device 0000:03:00.1 (0000 -> 0002)
ACPI: PCI Interrupt 0000:03:00.1[B] -> Link [LNKC] -> GSI 11 (level, low) -> 
IRQ 11
ohci_hcd 0000:03:00.1: OHCI Host Controller
ohci_hcd 0000:03:00.1: new USB bus registered, assigned bus number 7
ohci_hcd 0000:03:00.1: irq 11, io mem 0x56001000
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
PCI: Enabling device 0000:03:00.2 (0000 -> 0002)
ACPI: PCI Interrupt 0000:03:00.2[B] -> Link [LNKC] -> GSI 11 (level, low) -> 
IRQ 11
ohci_hcd 0000:03:00.2: OHCI Host Controller
ohci_hcd 0000:03:00.2: new USB bus registered, assigned bus number 8
ohci_hcd 0000:03:00.2: irq 11, io mem 0x56002000
usb usb8: configuration #1 chosen from 1 choice
hub 8-0:1.0: USB hub found
hub 8-0:1.0: 2 ports detected
ieee1394: Host added: ID:BUS[1-00:1023]  GUID[0090e600000024f7]
dvb-usb: found a 'WideView WT-220U PenType Receiver (Typhoon/Freecom)' in cold 
state, will try to load a firmware
dvb-usb: downloading firmware from file 'dvb-usb-wt220u-02.fw'
dvb-usb: error while transferring firmware (transferred size: -71, block size: 
16)
dvb-usb: firmware download failed at 2135 with -22
usbcore: registered new driver dvb_usb_dtt200u


Can anybody help??

This is really strange.

Michal
