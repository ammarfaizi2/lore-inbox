Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263858AbTEOHoC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 03:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTEOHoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 03:44:02 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:2822 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263858AbTEOHnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 03:43:50 -0400
Message-ID: <3EC3481A.2000309@yahoo.com>
Date: Thu, 15 May 2003 00:56:10 -0700
From: Lars <lhofhansl@yahoo.com>
Organization: What? Organized??
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: HD DMA disabled in 2.4.21-rc2, works fine in 2.4.20
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ever since I upgraded my kernel to 2.4.21-rc{1|2} from 2.4.20
I can't enable DMA on my harddisk anymore.

hdparm -d1 returns
HDIO_SET_DMA failed: Operation not permitted

What am I missing? I looked through the archive, and couldn't
find any discussion on this (I apologize if this has been discusses
before).

Please 'CC me on replies as I'm not subscribed to the list.

Thanks.

-- Lars


I attached some info on my system:

hdparm -i /dev/hda
------------------

/dev/hda:

  Model=HITACHI_DK23CA-30, FwRev=00H0A0G3, SerialNo=119T7D
  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
  RawCHS=16383/16/63, TrkSize=36477, SectSize=579, ECCbytes=4
  BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
  CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=58605120
  IORDY=yes, tPIO={min:400,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes: pio0 pio1 pio2 pio3 pio4
  DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 
udma4 *udma5
  AdvancedPM=yes: mode=0x80 (128)
  Drive Supports : ATA/ATAPI-5 T13 1321D revision 3 : ATA-1 ATA-2 ATA-3 
ATA-4 ATA-5



lspci -v
--------
00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and 
Memory Controller Hub (rev 04)
	Flags: bus master, fast devsel, latency 0
	Memory at e8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [88] #09 [e104]
	Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corporation: Unknown device 1131 (rev 04) 
(prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fc000000-fdffffff
	Prefetchable memory behind bridge: e0000000-e7ffffff

00:1e.0 PCI bridge: Intel Corporation 82801BA PCI (rev 03) (prog-if 00 
[Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=10, sec-latency=32
	I/O behind bridge: 0000d000-0000ffff
	Memory behind bridge: f2000000-fbffffff

00:1f.0 ISA bridge: Intel Corporation 82801BAM ISA Bridge (ICH2) (rev 03)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation 82801BAM IDE U100 (rev 03) 
(prog-if 80 [Master])
	Subsystem: Intel Corporation: Unknown device 4541
	Flags: bus master, medium devsel, latency 0
	I/O ports at bfa0 [size=16]

00:1f.2 USB Controller: Intel Corporation 82801BA(M) USB (Hub A) (rev 
03) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 4541
	Flags: bus master, medium devsel, latency 0, IRQ 10
	I/O ports at bce0 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 
0112 (rev b2) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 00e6
	Flags: bus master, VGA palette snoop, 66Mhz, medium devsel, latency 
248, IRQ 11
	Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
	Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
	Capabilities: [44] AGP version 2.0

02:03.0 Multimedia audio controller: ESS Technology ES1983S Maestro-3i 
PCI Audio Accelerator (rev 10)
	Subsystem: Dell Computer Corporation: Unknown device 00e6
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at dc00 [size=256]
	Memory at f6ffe000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [c0] Power Management version 2

02:06.0 PCI bridge: Action Tec Electronics Inc: Unknown device 0100 (rev 
11) (prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 32
	Bus: primary=02, secondary=08, subordinate=08, sec-latency=32
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: f8000000-f9ffffff
	Capabilities: [80] Power Management version 2
	Capabilities: [90] #06 [0000]

02:0f.0 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus Controller
	Subsystem: Dell Computer Corporation: Unknown device 00e6
	Flags: bus master, medium devsel, latency 168, IRQ 10
	Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=09, subordinate=0c, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

02:0f.1 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus Controller
	Subsystem: Dell Computer Corporation: Unknown device 00e6
	Flags: bus master, medium devsel, latency 168, IRQ 10
	Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=0d, subordinate=10, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	16-bit legacy interface ports at 0001

02:0f.2 FireWire (IEEE 1394): Texas Instruments: Unknown device 8027 
(prog-if 10 [OHCI])
	Subsystem: Dell Computer Corporation: Unknown device 00e6
	Flags: bus master, medium devsel, latency 32, IRQ 10
	Memory at f6ffd800 (32-bit, non-prefetchable) [size=2K]
	Memory at f6ff8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2

08:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] 
(rev 08)
	Subsystem: Action Tec Electronics Inc: Unknown device 1100
	Flags: bus master, medium devsel, latency 32, IRQ 10
	Memory at f8fff000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at ecc0 [size=64]
	Memory at f8e00000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at f9000000 [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2

08:08.0 Communication controller: Lucent Microelectronics WinModem 56k 
(rev 01)
	Subsystem: Action Tec Electronics Inc: Unknown device 2400
	Flags: bus master, medium devsel, latency 0, IRQ 10
	Memory at f8ffec00 (32-bit, non-prefetchable) [size=256]
	I/O ports at ecb8 [size=8]
	I/O ports at e800 [size=256]
	Capabilities: [f8] Power Management version 2


