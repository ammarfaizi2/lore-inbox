Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbVLGRnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbVLGRnV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 12:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbVLGRnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 12:43:21 -0500
Received: from orion2.pixelized.ch ([195.190.190.13]:1165 "EHLO
	mail.pixelized.ch") by vger.kernel.org with ESMTP id S1751380AbVLGRnU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 12:43:20 -0500
Message-ID: <43971EE8.1080204@cateee.net>
Date: Wed, 07 Dec 2005 18:42:00 +0100
From: Giacomo Catenazzi <cate@cateee.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051018)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ppc kernel bugs in2.6.15-rc5: kobject_register failed for usbcore
 (-17)
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have some call trace in 2.6.15-rc5 (I don't know if
it happens also on old kernel, new machine, my first non x86 kernel)

Uniform CD-ROM driver Revision: 3.20
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected Apple UniNorth 2 chipset
agpgart: configuring for size idx: 4
agpgart: AGP aperture is 16M @ 0x0
kobject_register failed for usbcore (-17)
Call trace:
 [c01023ac] kobject_register+0x6c/0x90
 [c0047d9c] sys_init_module+0x13bc/0x1530
 [c00047fc] ret_from_syscall+0x0/0x44
kobject_register failed for usbcore (-17)
Call trace:
 [c01023ac] kobject_register+0x6c/0x90
 [c0047d9c] sys_init_module+0x13bc/0x1530
 [c00047fc] ret_from_syscall+0x0/0x44
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
kobject_register failed for ohci_hcd (-17)
Call trace:
 [c01023ac] kobject_register+0x6c/0x90
 [c016eb50] bus_add_driver+0x80/0x180
 [c016f978] driver_register+0x48/0x60
 [c010cda4] __pci_register_driver+0x84/0xe0
 [e1026044] ohci_hcd_pci_init+0x44/0xd0 [ohci_hcd]
 [c0046b38] sys_init_module+0x158/0x1530
 [c00047fc] ret_from_syscall+0x0/0x44
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
PCI: Enabling device 0002:20:0e.0 (0000 -> 0002)
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[40]
MMIO=[f5000000-f50007ff]  Max Packet=[2048]
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
kobject_register failed for ohci_hcd (-17)
Call trace:
 [c01023ac] kobject_register+0x6c/0x90
 [c016eb50] bus_add_driver+0x80/0x180
 [c016f978] driver_register+0x48/0x60
 [c010cda4] __pci_register_driver+0x84/0xe0
 [e1026044] ohci_hcd_pci_init+0x44/0xd0 [ohci_hcd]
 [c0046b38] sys_init_module+0x158/0x1530
 [c00047fc] ret_from_syscall+0x0/0x44
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[001124fffed13718]
eth1394: $Rev: 1312 $ Ben Collins <bcollins@debian.org>
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
Adding 1269520k swap on /dev/hda3.  Priority:-1 extents:1 across:1269520k
EXT3 FS on hda4, internal journal
SCSI subsystem initialized
kobject_register failed for usbcore (-17)
Call trace:
 [c01023ac] kobject_register+0x6c/0x90
 [c0047d9c] sys_init_module+0x13bc/0x1530
 [c00047fc] ret_from_syscall+0x0/0x44
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
kobject_register failed for ohci_hcd (-17)
Call trace:
 [c01023ac] kobject_register+0x6c/0x90
 [c016eb50] bus_add_driver+0x80/0x180
 [c016f978] driver_register+0x48/0x60
 [c010cda4] __pci_register_driver+0x84/0xe0
 [e20dd044] ohci_hcd_pci_init+0x44/0xd0 [ohci_hcd]
 [c0046b38] sys_init_module+0x158/0x1530
 [c00047fc] ret_from_syscall+0x0/0x44
kobject_register failed for usbcore (-17)
Call trace:
 [c01023ac] kobject_register+0x6c/0x90
 [c0047d9c] sys_init_module+0x13bc/0x1530
 [c00047fc] ret_from_syscall+0x0/0x44
kobject_register failed for ehci_hcd (-17)
Call trace:
 [c01023ac] kobject_register+0x6c/0x90
 [c0047d9c] sys_init_module+0x13bc/0x1530
 [c00047fc] ret_from_syscall+0x0/0x44
eth0: Link is up at 100 Mbps, full-duplex.
eth0: Pause is disabled
hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=0x04 { AbortedCommand }
ide: failed opcode was: 0xec
hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=0x04 { AbortedCommand }
ide: failed opcode was: 0xec

[The hdc error was reported also on the original debian kernel, I should
still check]

ciao
    cate
