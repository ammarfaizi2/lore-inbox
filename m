Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbTIWQmA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 12:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbTIWQmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 12:42:00 -0400
Received: from filesrv1.system-techniques.com ([199.33.245.55]:42125 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id S261449AbTIWQl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 12:41:56 -0400
Date: Tue, 23 Sep 2003 12:41:52 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: cs: warning: no high memory space available
Message-ID: <Pine.LNX.4.58.0309231238580.15947@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello All ,
	Any device I put into any pcmcia/cardbus slot on my Dell C810
	laptop gives me "cs: unable to map card memory!" .  I have
	tried a IBM Data/Fax Modem pcmcia mdl: XJ 1560 ,  fru: 04K0054
	& 3Com 11mbps wireless LAN OfficeConnect PC Card
	mdl: 3CRSHPW196 or SL-1110 ,  Ver. 1.0 .  Any pointers welcome .
	I have already looked at & checked the faqs at
	http://www.whacked.net/ldl-faq/faq/  &
	http://people.mech.kuleuven.ac.be/~kgadeyne/linux/dell.html#pcmcia
		Tia ,  JimL

  # dmesg | tail -18
Adding Swap: 530136k swap-space (priority -1)
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
eth0: no IPv6 routers present
cs: warning: no high memory space available!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!
cs: unable to map card memory!

  # sh /usr/src/linux/scripts/ver_linux
Linux jimlabs 2.4.22 #6 Sun Sep 7 20:44:47 EDT 2003 i686 unknown
Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.22
e2fsprogs              1.32
jfsutils               1.1.1
reiserfsprogs          3.6.4
pcmcia-cs              3.2.4
quota-tools            3.08.
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Linux C++ Library      5.0.2
Procps                 3.1.6
Net-tools              1.60
Kbd                    1.08
Sh-utils               2.0
Modules Loaded

  # lspci -v
00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 04)
	Flags: bus master, fast devsel, latency 0
	Memory at e8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [88] #09 [e104]
	Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corp. 82815 815 Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fc000000-fdffffff
	Prefetchable memory behind bridge: e0000000-e7ffffff

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=10, sec-latency=32
	I/O behind bridge: 0000e000-0000ffff
	Memory behind bridge: f4000000-fbffffff

00:1f.0 ISA bridge: Intel Corp. 82801BAM ISA Bridge (LPC) (rev 03)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801BAM IDE U100 (rev 03) (prog-if 80 [Master])
	Subsystem: Intel Corp.: Unknown device 4541
	Flags: bus master, medium devsel, latency 0
	I/O ports at bfa0 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 4541
	Flags: bus master, medium devsel, latency 0, IRQ 10
	I/O ports at dce0 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 Go] (rev b2) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 00e5
	Flags: bus master, VGA palette snoop, 66Mhz, medium devsel, latency 32, IRQ 11
	Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
	Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
	Capabilities: [44] AGP version 2.0

02:03.0 Multimedia audio controller: ESS Technology ES1983S Maestro-3i PCI Audio Accelerator (rev 10)
	Subsystem: Dell Computer Corporation: Unknown device 00e5
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at ec00 [size=256]
	Memory at f8ffe000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [c0] Power Management version 2

02:06.0 Ethernet controller: 3Com Corporation 3c556 Hurricane CardBus (rev 10)
	Subsystem: 3Com Corporation: Unknown device 6456
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at e800 [size=256]
	Memory at f8ffdc00 (32-bit, non-prefetchable) [size=128]
	Memory at f8ffd800 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at f9000000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2

02:06.1 Communication controller: 3Com Corporation Mini PCI 56k Winmodem (rev 10)
	Subsystem: 3Com Corporation: Unknown device 615b
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at e400 [size=256]
	Memory at f8ffd400 (32-bit, non-prefetchable) [size=256]
	Memory at f8ffd000 (32-bit, non-prefetchable) [size=128]
	Capabilities: [50] Power Management version 2

02:0f.0 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus Controller
	Subsystem: Dell Computer Corporation: Unknown device 00e5
	Flags: bus master, medium devsel, latency 168, IRQ 10
	Memory at 20000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 20400000-207ff000 (prefetchable)
	Memory window 1: 20800000-20bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

02:0f.1 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus Controller
	Subsystem: Dell Computer Corporation: Unknown device 00e5
	Flags: bus master, medium devsel, latency 168, IRQ 10
	Memory at 20001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 20c00000-20fff000 (prefetchable)
	Memory window 1: 21000000-213ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	16-bit legacy interface ports at 0001

02:0f.2 FireWire (IEEE 1394): Texas Instruments PCI4451 IEEE-1394 Controller (prog-if 10 [OHCI])
	Subsystem: Dell Computer Corporation: Unknown device 00e5
	Flags: bus master, medium devsel, latency 32, IRQ 10
	Memory at f8ffc800 (32-bit, non-prefetchable) [size=2K]
	Memory at f8ff8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
