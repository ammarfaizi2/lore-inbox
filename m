Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292333AbSBUK7k>; Thu, 21 Feb 2002 05:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292335AbSBUK7b>; Thu, 21 Feb 2002 05:59:31 -0500
Received: from portal.west.saic.com ([198.151.12.15]:14212 "HELO
	portal.west.saic.com") by vger.kernel.org with SMTP
	id <S292333AbSBUK7P>; Thu, 21 Feb 2002 05:59:15 -0500
Subject: 2.4.17: fails to detect PCI bus
From: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 21 Feb 2002 10:57:56 +0000
Message-Id: <1014289078.15561.26.camel@ukabzc383.uk.saic.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I've just tried updating a friends machine from 2.4.9 to 2.4.17. 2.4.17
fails to detect the PCI bus in his system. I saw some discussion about
this kind of problem back in the 2.4.10 period, but I though it was
fixed?

Anybody got any ideas?

Cheers,
Eamonn

 

Failed boot from 2.4.17: 

Feb 19 15:34:57 estelwyn kernel: POSIX conformance testing by UNIFIX
Feb 19 15:34:57 estelwyn kernel: PCI: PCI BIOS revision 2.10 entry at
0xfdb31, last bus=0
Feb 19 15:34:57 estelwyn kernel: PCI: System does not support PCI
Feb 19 15:34:57 estelwyn kernel: Linux NET4.0 for Linux 2.4



2.4.9 works just fine, reporting

Feb 19 18:16:46 estelwyn kernel: PCI: PCI BIOS revision 2.10 entry at
0xfdb31, last bus=0
Feb 19 18:16:46 estelwyn kernel: PCI: Probing PCI hardware
Feb 19 18:16:46 estelwyn kernel: isapnp: Scanning for PnP cards...



lspci -v reports 

00:05.0 Host bridge: Hint Corp VXPro II Chipset
	Subsystem: Hint Corp VXPro II Chipset CPU to PCI Bridge
	Flags: bus master, 66Mhz, slow devsel, latency 64

00:05.1 ISA bridge: Hint Corp VXPro II Chipset
	Subsystem: Hint Corp VXPro II Chipset PCI to ISA Bridge
	Flags: bus master, 66Mhz, slow devsel, latency 64

00:05.2 IDE interface: Hint Corp VXPro II Chipset (prog-if 00 [])
	Subsystem: Hint Corp VXPro II Chipset EIDE Controller
	Flags: medium devsel

00:08.0 USB Controller: Lucent Microelectronics: Unknown device 5802
(rev 10) (prog-if 10 [OHCI])
	Subsystem: Lucent Microelectronics: Unknown device 5802
	Flags: bus master, medium devsel, latency 64, IRQ 9
	Memory at ffade000 (32-bit, non-prefetchable) [size=4K]

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 64, IRQ 10
	I/O ports at e800 [size=256]
	Memory at ffadfe00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

00:0a.0 VGA compatible controller: Trident Microsystems TGUI 9440 (rev
e3) (prog-if 00 [VGA])
	Flags: medium devsel
	Memory at ff800000 (32-bit, non-prefetchable) [size=2M]
	Memory at ffaf0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at ffae0000 [disabled] [size=64K]

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at ec00 [size=256]
	Memory at ffadff00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2


