Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUISQIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUISQIe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 12:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269261AbUISQIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 12:08:34 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:52934 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265773AbUISQIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 12:08:21 -0400
Subject: Boot failure with 2.6.9-rc2-bk latest in usb/hid-core.c
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 19 Sep 2004 12:08:04 -0400
Message-Id: <1095610092.10887.16.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this out of the machine (an ia64 zx2000 with connected USB
keyboard and mouse):

Discovering hardware: snd-fm801 aic7xxx mptscsih qla1280 ohci-hcd cmd64x
sym53c8xx tulip e1000
Loading snd-fm801:
Linux video capture interface: v1.00
ACPI: PCI interrupt 0000:a0:04.0[A] -> GSI 41 (level, low) -> IRQ 62
Skipping Module aic7xxx. It's already loaded.
Skipping Module mptscsih. It's already loaded.
Skipping Module qla1280. It's already loaded.
Loading ohci-hcd:
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI interrupt 0000:a0:01.0[A] -> GSI 38 (level, low) -> IRQ 57
ohci_hcd 0000:a0:01.0: NEC Corporation USB
ohci_hcd 0000:a0:01.0: irq 57, pci mem c0000000d0022000
ohci_hcd 0000:a0:01.0: new USB bus registered, assigned bus number 1
usb usb1: Product: NEC Corporation USB
usb usb1: Manufacturer: Linux 2.6.9-rc2 ohci_hcd
usb usb1: SerialNumber: 0000:a0:01.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:a0:01.1[B] -> GSI 39 (level, low) -> IRQ 58
ohci_hcd 0000:a0:01.1: NEC Corporation USB (#2)
ohci_hcd 0000:a0:01.1: irq 58, pci mem c0000000d0021000
ohci_hcd 0000:a0:01.1: new USB bus registered, assigned bus number 2
usb usb2: Product: NEC Corporation USB (#2)
usb usb2: Manufacturer: Linux 2.6.9-rc2 ohci_hcd
usb usb2: SerialNumber: 0000:a0:01.1
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-2: new low speed USB device using address 2
usb 1-2: Product: Standard USB Keyboard 
usb 1-2: Manufacturer: Silitek
usbcore: registered new driver hiddev
input: USB HID v1.00 Keyboard [Silitek Standard USB Keyboard ] on
usb-0000:a0:01.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
usb 2-2: new low speed USB device using address 2
usb 2-2: Product: N48
usb 2-2: Manufacturer: Logitech
input: USB HID v1.00 Mouse [Logitech N48] on usb-0000:a0:01.1-2
Loading cmd64x:
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
CMD649: IDE controller at PCI slot 0000:a0:02.0
ACPI: PCI interrupt 0000:a0:02.0[A] -> GSI 43 (level, low) -> IRQ 60
CMD649: chipset revision 2
CMD649: 100% native mode on irq 60
    ide0: BM-DMA at 0xa0d0-0xa0d7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xa0d8-0xa0df, BIOS settings: hdc:pio, hdd:pio
hdc: HL-DT-ST GCE-8483B, ATAPI CD/DVD-ROM drive
ide1 at 0xa0e0-0xa0e7,0xa0f2 on irq 60
Skipping Module sym53c8xx. It's already loaded.
Loading tulip:
Linux Tulip driver version 1.1.13 (May 11, 2002)
ACPI: PCI interrupt 0000:81:04.0[A] -> GSI 27 (level, low) -> IRQ 55
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1)
block.
tulip0:  MII transceiver #3 config 3100 status 7809 advertising 01e1.
eth0: Digital DS21140 Tulip rev 32 at 0xc0000000a0281000,
00:E0:29:0F:9F:D9, IRQ 55.
ACPI: PCI interrupt 0000:81:05.0[A] -> GSI 28 (level, low) -> IRQ 56
tulip1:  EEPROM default media type Autosense.
tulip1:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1)
block.
tulip1:  MII transceiver #3 config 3100 status 7809 advertising 01e1.
eth1: Digital DS21140 Tulip rev 32 at 0xc0000000a0280000,
00:E0:29:0F:9F:D8, IRQ 56.
Loading e1000:
e1000: Ignoring new-style parameters in presence of obsolete ones
Intel(R) PRO/1000 Network Driver - version 5.3.19-k2
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:a0:03.0[A] -> GSI 42 (level, low) -> IRQ 61
e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
Running 0dns-down to make sure resolv.conf is ok...done.
Cleaning: /etc/network/ifstate.
Starting hotplug subsystem:
   input   
   input    [success]
   isapnp  
   isapnp   [success]
   net     
   net      [success]
   pci     
     ignoring pci display device on 00:00.0
     aic79xx: loaded successfully
     aic7xxx: already loaded
     aic79xx: already loaded
     aic7xxx: already loaded
     mptbase: already loaded
     mptbase: already loaded
     qla1280: already loaded
     tulip: already loaded
     tulip: already loaded
     ohci-hcd: already loaded
     ohci-hcd: already loaded
ACPI: PCI interrupt 0000:a0:01.2[C] -> GSI 40 (level, low) -> IRQ 59
ehci_hcd 0000:a0:01.2: NEC Corporation USB 2.0
ehci_hcd 0000:a0:01.2: irq 59, pci mem c0000000d0020000
ehci_hcd 0000:a0:01.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:a0:01.2: USB 2.0 enabled, EHCI 0.95, driver 2004-May-10
drivers/usb/input/hid-core.c: input irq status -110 received
drivers/usb/input/hid-core.c: input irq status -110 received
[the last message repeats forever]

It boots just fine with 2.6.9-rc2 and the only difference to the usb
input subsystem appears to be your latest merge.

James


