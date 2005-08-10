Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbVHJTDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbVHJTDs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 15:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbVHJTDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 15:03:47 -0400
Received: from dsl3-63-249-67-204.cruzio.com ([63.249.67.204]:2728 "EHLO
	cichlid.com") by vger.kernel.org with ESMTP id S1030205AbVHJTDr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 15:03:47 -0400
Date: Wed, 10 Aug 2005 12:03:24 -0700
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200508101903.j7AJ3Ow6005064@cichlid.com>
To: linux-kernel@vger.kernel.org
Subject: Intermittant hang/reboot at startup: 2.6.13-rc6 SMP (also no mouse and usb error)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.13rc6 SMP (single P4 HT)

messages:

...
Aug 10 11:32:02 cichlid kernel: 3ware Storage Controller device driver for Linux v1.26.02.001.
Aug 10 11:32:02 cichlid kernel: PCI: Found IRQ 10 for device 0000:02:06.0
>>> Hangs here one time, rebooted itself here one time  <<<

The third time it came up but I had no mouse, keyboard was ok (with the newer
RT preempt kernels I sometimes have no keyboard either). I connected a usb
mouse and am using the system now. (Good performance, lots of sched_fifo
threads running well).

I also get a million of these while the IOGEAR USB mouse/keyboard adapter is
connected:

Aug 10 11:50:41 cichlid kernel: drivers/usb/input/hid-core.c: input irq status -71 received

Can I do anything to help debug either of these?

lspci:

00:00.0 Host bridge: Intel Corp. 82875P/E7210 Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2 (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02)
00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #4 (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Interface Bridge (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02)
00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) SATA Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5500] (rev a1)
02:02.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 IEEE-1394a-2000 Controller (PHY/Link)
02:04.0 Unknown mass storage controller: Promise Technology, Inc. PDC20267 (FastTrak100/Ultra100) (rev 02)
02:05.0 Unknown mass storage controller: Promise Technology, Inc. PDC20267 (FastTrak100/Ultra100) (rev 02)
02:06.0 RAID bus controller: 3ware Inc 3ware Inc 3ware 7xxx/8xxx-series PATA/SATA-RAID (rev 01)
02:07.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
02:07.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
02:09.0 Multimedia audio controller: VIA Technologies Inc. ICE1712 [Envy24] PCI Multi-Channel I/O Controller (rev 02)

lsusb:

Bus 001 Device 013: ID 0518:0001 EzKEY Corp. 
Bus 001 Device 012: ID 0403:6001 Future Technology Devices International, Ltd 8-bit FIFO
Bus 001 Device 011: ID 0403:6001 Future Technology Devices International, Ltd 8-bit FIFO
Bus 001 Device 010: ID 0403:6001 Future Technology Devices International, Ltd 8-bit FIFO
Bus 001 Device 009: ID 07b8:420a D-Link Corp. 
Bus 001 Device 008: ID 07e5:05c2 QPS, Inc. 
Bus 001 Device 006: ID 04b4:6560 Cypress Semiconductor Corp. CY7C65640 USB-2.0 "TetraHub"
Bus 001 Device 004: ID 0409:0058 NEC Corp. HighSpeed Hub
Bus 001 Device 001: ID 0000:0000  

