Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbTLMOou (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 09:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265095AbTLMOot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 09:44:49 -0500
Received: from pD9E9F733.dip.t-dialin.net ([217.233.247.51]:32518 "EHLO
	icg-pc211.icg-online") by vger.kernel.org with ESMTP
	id S265083AbTLMOon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 09:44:43 -0500
Date: Sat, 13 Dec 2003 15:44:40 +0100
From: Manfred Usselmann <usselmann.m@icg-online.de>
To: linux-kernel@vger.kernel.org
Subject: USB memorystick access problem after kernel upgrade
Message-Id: <20031213154440.218c34e8.usselmann.m@icg-online.de>
Organization: ICG IT Consulting GmbH
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

access to the memorystick in my Sony Handycam PC110E via USB no longer
works with newer kernels.

I had no problems accessing the pictures on the memorystick via USB with
RH 9 and a custom kernel 2.4.20-9. I could mount the memorystick as scsi
disk and it appeared as /mnt/camera (interestingly the mount point even
didn't needed to exist).

After upgrading my system to Fedora Core 1, which includes kernel
2.4.22, this does not work any longer:

kernel: usb_control/bulk_msg: timeout
kernel: usb.c: USB device not accepting new address=2 (error=-110)

The same problem occurs with kernel 2.4.23 which I build myself with
similar settings as the 2.4.20-9.

When I boot my old kernel under Fedora Core 1, mounting of the
memorystick does work as before with RH 9. So it must have something to
do with the kernel version.

Attached are some dmesg messages. Some from 2.4.20-9, where the stick
works and the others from 2.4.23 where it fails.

Thanks,
Manfred


2.4.20-9
=============================================================

kernel: PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
kernel: PCI: Using configuration type 1
kernel: PCI: Probing PCI hardware
kernel: PCI: Using IRQ router VIA [1106/0686] at 00:07.0
kernel: PCI->APIC IRQ transform: (B0,I7,P3) -> 19
kernel: PCI->APIC IRQ transform: (B0,I7,P3) -> 19
kernel: PCI->APIC IRQ transform: (B0,I9,P0) -> 17
kernel: PCI->APIC IRQ transform: (B0,I10,P0) -> 18
kernel: PCI->APIC IRQ transform: (B0,I13,P0) -> 17
kernel: PCI->APIC IRQ transform: (B0,I14,P0) -> 18
kernel: PCI->APIC IRQ transform: (B1,I0,P0) -> 16
kernel: PCI: Enabling Via external APIC routing
kernel: PCI: Via IRQ fixup for 00:07.3, from 5 to 3
kernel: PCI: Via IRQ fixup for 00:07.2, from 5 to 3

kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5

kernel: usb.c: registered new driver usbdevfs
kernel: usb.c: registered new driver hub
kernel: usb-uhci.c: $Revision: 1.275 $ time 23:34:02 Apr 15 2003
kernel: usb-uhci.c: High bandwidth mode enabled
kernel: usb-uhci.c: USB UHCI at I/O 0xc800, IRQ 19
kernel: usb-uhci.c: Detected 2 ports
kernel: usb.c: new USB bus registered, assigned bus number 1
kernel: hub.c: USB hub found
kernel: hub.c: 2 ports detected
kernel: usb-uhci.c: USB UHCI at I/O 0xc400, IRQ 19
kernel: usb-uhci.c: Detected 2 ports
kernel: usb.c: new USB bus registered, assigned bus number 2
kernel: hub.c: USB hub found
kernel: hub.c: 2 ports detected
kernel: usb-uhci.c: v1.275:USB Universal Host Controller Interface
driver
kernel: usb.c: registered new driver hiddev
kernel: usb.c: registered new driver hid
kernel: hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
kernel: hid-core.c: USB HID support drivers


kernel: hub.c: connect-debounce failed, port 1 disabled
kernel: hub.c: new USB device 00:07.2-1, assigned address 2
kernel: usb.c: USB device 2 (vend/prod 0x54c/0x2e) is not claimed by any
active driver.
kernel: Initializing USB Mass Storage driver...
kernel: usb.c: registered new driver usb-storage
kernel: scsi1 : SCSI emulation for USB Mass Storage devices
kernel:   Vendor: Sony      Model: Sony DSC          Rev: 3.00
kernel:   Type:   Direct-Access                      ANSI SCSI revision:
02
kernel: Attached scsi removable disk sde at scsi1, channel 0, id 0, lun
0
kernel: SCSI device sde: 126848 512-byte hdwr sectors (65 MB)
kernel: sde: Write Protect is off
kernel:  sde: sde1
kernel: USB Mass Storage support registered.
kernel: usb-uhci.c: interrupt, status 3, frame# 1114

2.4.23
=============================================================
kernel: PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
kernel: PCI: Using configuration type 1
kernel: PCI: Probing PCI hardware
kernel: PCI: Probing PCI hardware (bus 00)
kernel: PCI: Using IRQ router VIA [1106/0686] at 00:07.0
kernel: PCI->APIC IRQ transform: (B0,I7,P3) -> 19
kernel: PCI->APIC IRQ transform: (B0,I7,P3) -> 19
kernel: PCI->APIC IRQ transform: (B0,I9,P0) -> 17
kernel: PCI->APIC IRQ transform: (B0,I10,P0) -> 18
kernel: PCI->APIC IRQ transform: (B0,I13,P0) -> 17
kernel: PCI->APIC IRQ transform: (B0,I14,P0) -> 18
kernel: PCI->APIC IRQ transform: (B1,I0,P0) -> 16
kernel: PCI: Enabling Via external APIC routing
kernel: PCI: Via IRQ fixup for 00:07.3, from 5 to 3
kernel: PCI: Via IRQ fixup for 00:07.2, from 5 to 3

kernel: usb.c: registered new driver usbdevfs
kernel: usb.c: registered new driver hub
kernel: host/usb-uhci.c: $Revision: 1.275 $ time 01:02:34 Dec  8 2003
kernel: host/usb-uhci.c: High bandwidth mode enabled
kernel: host/usb-uhci.c: USB UHCI at I/O 0xc800, IRQ 19
kernel: host/usb-uhci.c: Detected 2 ports
kernel: usb.c: new USB bus registered, assigned bus number 1
kernel: Product: USB UHCI Root Hub
kernel: SerialNumber: c800
kernel: hub.c: USB hub found
kernel: hub.c: 2 ports detected
kernel: host/usb-uhci.c: USB UHCI at I/O 0xc400, IRQ 19
kernel: host/usb-uhci.c: Detected 2 ports
kernel: usb.c: new USB bus registered, assigned bus number 2
kernel: Product: USB UHCI Root Hub
kernel: SerialNumber: c400
kernel: hub.c: USB hub found
kernel: hub.c: 2 ports detected
kernel: host/usb-uhci.c: v1.275:USB Universal Host Controller Interface
driver
kernel: Initializing USB Mass Storage driver...
kernel: usb.c: registered new driver usb-storage
kernel: USB Mass Storage support registered.

kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5

kernel: hub.c: new USB device 00:07.2-1, assigned address 2
kernel: usb_control/bulk_msg: timeout
kernel: usb.c: USB device not accepting new address=2 (error=-110)
kernel: hub.c: new USB device 00:07.2-1, assigned address 3
kernel: usb_control/bulk_msg: timeout
kernel: usb.c: USB device not accepting new address=3 (error=-110)


-- 
________________________________________________________________________
 Manfred Usselmann                            usselmann.m@icg-online.de

-- 

 Mit freundlichen Gruessen,
________________________________________________________________________

 Manfred Usselmann                            usselmann.m@icg-online.de

 ICG IT Consulting GmbH                       Tel.     +49/0 69 333 623
 Bahnstrasse 7                                Fax      +49/0 69 306 845
 D-65835 Liederbach, Germany                  Mobil +49/0 171 68 23 750
________________________________________________________________________

 Manfred Usselmann                          E-Mail manfred@usselmann.de

 Hundshager Weg 7                           Tel.    +49/0 6192 90 11 97
 D-65719 Hofheim                            Fax     +49/0 6192 90 11 98
 Germany                                    Mobil   +49/0 171 68 23 750
________________________________________________________________________

