Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbVIEMzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbVIEMzB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 08:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVIEMzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 08:55:01 -0400
Received: from lucidpixels.com ([66.45.37.187]:8084 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751158AbVIEMzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 08:55:00 -0400
Date: Mon, 5 Sep 2005 08:54:59 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.13 repeated ACPI events?
Message-ID: <Pine.LNX.4.63.0509050853310.3389@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a box where I keep getting this in dmesg:

ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level, low) 
-> IRQ 5
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level, low) 
-> IRQ 5
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level, low) 
-> IRQ 5
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level, low) 
-> IRQ 5
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level, low) 
-> IRQ 5
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level, low) 
-> IRQ 5
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level, low) 
-> IRQ 5
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level, low) 
-> IRQ 5

# cat /proc/interrupts
            CPU0
   0:    2691916          XT-PIC  timer
   1:        392          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   5:    1120689          XT-PIC  eth1, eth0
   9:          1          XT-PIC  acpi
  14:       3938          XT-PIC  ide0
  15:         45          XT-PIC  ide1
NMI:          0
LOC:          0
ERR:          0
MIS:          0

Anyone have any idea what could cause this?

# lspci
00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory 
Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corp. 82815 815 Chipset AGP Bridge (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02)
00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02)
00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02)
00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 02)
01:00.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
01:04.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] 
(rev 78)
02:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2 
Model 64/Model 64 Pro] (rev 15)

