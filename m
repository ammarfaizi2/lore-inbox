Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144177AbRA1U6o>; Sun, 28 Jan 2001 15:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144180AbRA1U6f>; Sun, 28 Jan 2001 15:58:35 -0500
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:19206 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S144177AbRA1U6X>; Sun, 28 Jan 2001 15:58:23 -0500
To: Martin Mares <mj@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: PCI IRQ routing problem in 2.4.0
From: Robert Siemer <Robert.Siemer@gmx.de>
X-Mailer: Mew version 1.94b25 on Emacs 20.5 / Mule 4.0 (HANANOEN)
Reply-To: Robert Siemer <siemer@panorama.hadiko.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
	boundary="--Next_Part(Sun_Jan_28_21:58:04_2001_809)--"
Content-Transfer-Encoding: 7bit
Message-Id: <20010128215812H.siemer@panorama.hadiko.de>
Date: Sun, 28 Jan 2001 21:58:12 +0100
X-Dispatcher: imput version 990425(IM115)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Next_Part(Sun_Jan_28_21:58:04_2001_809)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Martin!

While moving from 2.4.0-test9 to 2.4.0 I got the following problem:
Linux thinks my usb controller is on IRQ 12 instead of IRQ 9.
The 'BIOS box' (on boot) still states that usb is on IRQ 9.

Under test9 pci-irq-behaviour was okay for me, but with 2.4.0 I cant
load the usb-modules (the kernel panics and reboots).

I attached the kernel output (with #define DEBUG) and 'lspci -vvx'.

I hope you can help me; otherwise I need a good pointer to pci
configuration specs...


Thanks,
	Robert

----Next_Part(Sun_Jan_28_21:58:04_2001_809)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="lspci-vvx.2.4.0"

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 5597 [SiS5582] (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32 set
00: 39 10 97 55 07 00 00 22 02 00 00 06 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set
00: 39 10 08 00 07 00 00 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at d000 [size=16]
00: 39 10 13 55 01 00 00 00 d0 8a 01 01 00 20 80 00
10: 01 e4 00 00 01 e0 00 00 01 d8 00 00 01 d4 00 00
20: 01 d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0c 01 00 00

00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 10) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at e5000000 (32-bit, non-prefetchable) [size=4K]
00: 39 10 01 70 17 00 80 02 10 10 03 0c 08 20 80 00
10: 00 00 00 e5 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00

00:09.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppage computer works Inc.: Unknown device 13eb
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 min, 40 max, 32 set
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e7800000 (32-bit, prefetchable) [size=4K]
00: 9e 10 6e 03 06 00 80 02 02 00 00 04 00 20 80 00
10: 08 00 80 e7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 70 00 eb 13
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 10 28

00:09.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppage computer works Inc.: Unknown device 13eb
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 4 min, 255 max, 32 set
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e7000000 (32-bit, prefetchable) [size=4K]
00: 9e 10 78 08 06 00 80 02 02 00 80 04 00 20 80 00
10: 08 00 00 e7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 70 00 eb 13
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 04 ff

00:0a.0 Ethernet controller: Winbond Electronics Corp W89C940 (rev 0b)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at b800 [size=32]
00: 50 10 40 09 03 00 80 02 0b 00 00 02 00 00 00 00
10: 01 b8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00

00:0b.0 VGA compatible controller: S3 Inc. 86c968 [Vision 968 VRAM] rev 0 (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 14
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
00: 33 53 f0 88 83 00 00 02 00 00 00 03 00 00 00 00
10: 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0e 01 00 00

00:0c.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 03)
	Subsystem: Tekram Technology Co.,Ltd. DC390F Ultra Wide SCSI Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 17 min, 64 max, 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at b400 [size=256]
	Region 1: Memory at e1800000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at e1000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
00: 00 10 0f 00 57 00 00 02 03 00 00 01 08 20 00 00
10: 01 b4 00 00 00 00 80 e1 00 00 00 e1 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 e1 1d 04 39
30: 00 00 00 00 00 00 00 00 00 00 00 00 0c 01 11 40

00:13.0 VGA compatible controller: Silicon Integrated Systems [SiS] 5597/5598 VGA (rev 65) (prog-if 00 [VGA])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at e6000000 (32-bit, prefetchable) [disabled] [size=4M]
	Region 1: Memory at e0800000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Region 2: I/O ports at b000 [disabled] [size=128]
	Expansion ROM at e5ff0000 [disabled] [size=32K]
00: 39 10 00 02 00 00 00 02 65 00 00 03 00 00 00 00
10: 08 00 00 e6 00 00 80 e0 01 b0 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 ff e5 00 00 00 00 00 00 00 00 00 00 00 00


----Next_Part(Sun_Jan_28_21:58:04_2001_809)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="lspci-vvx.2.4.0-test9"

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 5597 [SiS5582] (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32 set
00: 39 10 97 55 07 00 00 22 02 00 00 06 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set
00: 39 10 08 00 07 00 00 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 8f [Master SecP SecO PriP PriO])
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at d000 [size=16]
00: 39 10 13 55 01 00 00 00 d0 8f 01 01 00 20 80 00
10: 01 e4 00 00 01 e0 00 00 01 d8 00 00 01 d4 00 00
20: 01 d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0c 01 00 00

00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 10) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e5000000 (32-bit, non-prefetchable) [size=4K]
00: 39 10 01 70 17 00 80 02 10 10 03 0c 08 20 80 00
10: 00 00 00 e5 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00

00:09.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppage computer works Inc.: Unknown device 13eb
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 min, 40 max, 32 set
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e7800000 (32-bit, prefetchable) [size=4K]
00: 9e 10 6e 03 06 00 80 02 02 00 00 04 00 20 80 00
10: 08 00 80 e7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 70 00 eb 13
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 10 28

00:09.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppage computer works Inc.: Unknown device 13eb
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 4 min, 255 max, 32 set
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e7000000 (32-bit, prefetchable) [size=4K]
00: 9e 10 78 08 06 00 80 02 02 00 80 04 00 20 80 00
10: 08 00 00 e7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 70 00 eb 13
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 04 ff

00:0a.0 Ethernet controller: Winbond Electronics Corp W89C940 (rev 0b)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at b800 [size=32]
00: 50 10 40 09 03 00 80 02 0b 00 00 02 00 00 00 00
10: 01 b8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00

00:0b.0 VGA compatible controller: S3 Inc. 86c968 [Vision 968 VRAM] rev 0 (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 14
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
00: 33 53 f0 88 83 00 00 02 00 00 00 03 00 00 00 00
10: 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0e 01 00 00

00:0c.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 03)
	Subsystem: Tekram Technology Co.,Ltd. DC390F Ultra Wide SCSI Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 17 min, 64 max, 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at b400 [size=256]
	Region 1: Memory at e1800000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at e1000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
00: 00 10 0f 00 57 00 00 02 03 00 00 01 08 20 00 00
10: 01 b4 00 00 00 00 80 e1 00 00 00 e1 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 e1 1d 04 39
30: 00 00 00 00 00 00 00 00 00 00 00 00 0c 01 11 40

00:13.0 VGA compatible controller: Silicon Integrated Systems [SiS] 5597/5598 VGA (rev 65) (prog-if 00 [VGA])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at e6000000 (32-bit, prefetchable) [disabled] [size=4M]
	Region 1: Memory at e0800000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Region 2: I/O ports at b000 [disabled] [size=128]
	Expansion ROM at e5ff0000 [disabled] [size=32K]
00: 39 10 00 02 00 00 00 02 65 00 00 03 00 00 00 00
10: 08 00 00 e6 00 00 80 e0 01 b0 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 ff e5 00 00 00 00 00 00 00 00 00 00 00 00


----Next_Part(Sun_Jan_28_21:58:04_2001_809)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg.2.4.0.debug"

Linux version 2.4.0 (root@panorama.hadiko.de) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #4 Sun Jan 28 19:03:05 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000007f00000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=lnx ro root=801
Initializing CPU#0
Detected 334.090 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 666.82 BogoMIPS
Memory: 126884k/131072k available (894k kernel code, 3800k reserved, 332k data, 188k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Before vendor init, caps: 008001bf 808009bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008001bf 808009bf 00000000 00000000
CPU: After generic, caps: 008001bf 808009bf 00000000 00000000
CPU: Common caps: 008001bf 808009bf 00000000 00000000
CPU: AMD-K6(tm) 3D processor stepping 00
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
PCI: BIOS32 Service Directory structure at 0xc00f9a00
PCI: BIOS32 Service Directory entry at 0xf04a0
PCI: BIOS probe returned s=00 hw=11 ver=02.10 l=00
PCI: PCI BIOS revision 2.10 entry at 0xf04d0, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [1039/5597] 000600 00
PCI: Calling quirk c023a2d0 for 00:00.0
PCI: Calling quirk c023a378 for 00:00.0
PCI: Setting max latency to 32
Found 00:08 [1039/0008] 000601 00
PCI: Calling quirk c023a2d0 for 00:01.0
Found 00:09 [1039/5513] 000101 00
PCI: Calling quirk c023a328 for 00:01.1
PCI: IDE base address trash cleared for 00:01.1
PCI: Calling quirk c023a2d0 for 00:01.1
PCI: IDE base address fixup for 00:01.1
Found 00:0a [1039/7001] 000c03 00
PCI: Calling quirk c023a2d0 for 00:01.2
Found 00:48 [109e/036e] 000400 00
PCI: Calling quirk c023a2d0 for 00:09.0
Found 00:49 [109e/0878] 000480 00
PCI: Calling quirk c023a2d0 for 00:09.1
Found 00:50 [1050/0940] 000200 00
PCI: Calling quirk c023a2d0 for 00:0a.0
Found 00:58 [5333/88f0] 000300 00
PCI: Calling quirk c023a2d0 for 00:0b.0
PCI: Calling quirk c0244524 for 00:0b.0
Found 00:60 [1000/000f] 000100 00
PCI: Calling quirk c023a2d0 for 00:0c.0
Found 00:98 [1039/0200] 000300 00
PCI: Calling quirk c023a2d0 for 00:13.0
Fixups for bus 00
PCI: Scanning for ghost devices on bus 0
Bus scan for 00 returning with max=00
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00f0a50
00:0c slot=01 0:01/1eb8 1:02/1eb8 2:03/1eb8 3:04/1eb8
00:0b slot=02 0:02/1eb8 1:03/1eb8 2:04/1eb8 3:01/1eb8
00:0a slot=03 0:03/1eb8 1:04/1eb8 2:01/1eb8 3:02/1eb8
00:09 slot=04 0:04/1eb8 1:01/1eb8 2:02/1eb8 3:03/1eb8
00:01 slot=00 0:01/1eb8 1:02/1eb8 2:03/1eb8 3:04/1eb8
00:13 slot=00 0:01/1eb8 1:02/1eb8 2:03/1eb8 3:04/1eb8
PCI: Using IRQ router SIS [1039/0008] at 00:01.0
PCI: IRQ fixup
PCI: Allocating resources
PCI: Resource e5000000-e5000fff (f=200, d=0, p=0)
PCI: Resource e7800000-e7800fff (f=1208, d=0, p=0)
PCI: Resource e7000000-e7000fff (f=1208, d=0, p=0)
PCI: Resource 0000b800-0000b81f (f=101, d=0, p=0)
PCI: Resource 0000b400-0000b4ff (f=101, d=0, p=0)
PCI: Resource e1800000-e18000ff (f=200, d=0, p=0)
PCI: Resource e1000000-e1000fff (f=200, d=0, p=0)
PCI: Resource 0000d000-0000d00f (f=101, d=1, p=1)
PCI: Resource e6000000-e63fffff (f=1208, d=1, p=1)
PCI: Resource e0800000-e080ffff (f=200, d=1, p=1)
PCI: Resource 0000b000-0000b07f (f=101, d=1, p=1)
  got res[10000000:13ffffff] for resource 0 of S3 Inc. 86c968 [Vision 968 VRAM] rev 0
PCI: Sorting device list...
PCI: Calling quirk c02444a4 for 00:00.0
Disabling direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
DMI 2.0 present.
30 structures occupying 941 bytes.
DMI table at 0x000F51DA.
BIOS Vendor: Award Software, Inc.
BIOS Version: #401A0-0106xv                       
BIOS Release: 01/20/98
System Vendor: System Manufacturer.
Product Name: System Name.
Version System Version.
Serial Number SYS-1234567890.
Board Vendor: ASUSTeK Computer INC..
Board Name: SP97_XV.
Board Version: REV 1.XX.
Asset Tag: Asset-1234567890.
Starting kswapd v1.8
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 16
0x378: readIntrThreshold is 16
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x4b
0x378: ECP settings irq=7 dma=3
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,EPP,ECP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: No more nibble data (0 bytes)
parport1: PC-style at 0x278 [PCSPP]
parport1: cpp_daisy: aa5500ff(38)
parport1: assign_addrs: aa5500ff(38)
parport1: cpp_daisy: aa5500ff(38)
parport1: assign_addrs: aa5500ff(38)
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
lp1: using parport1 (polling).
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 12, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875 detected with Tekram NVRAM
sym53c875-0: rev 0x3 on pci bus 0 device 12 function 0 irq 12
sym53c875-0: Tekram format NVRAM, ID 7, Fast-20, Parity Checking
sym53c875-0: on-chip RAM at 0xe1000000
sym53c875-0: restart (scsi reset).
sym53c875-0: Downloading SCSI SCRIPTS.
scsi0 : sym53c8xx - version 1.6b
  Vendor: IBM       Model: FIREBALL1280S !#  Rev: 630P
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: CONNER    Model: CFP1080S          Rev: 4649
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-ROM PX-40TS    Rev: 1.11
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: COMPAQ    Model: CD-ROM CR-503BCQ  Rev: 1.1c
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST39140W          Rev: 1281
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST39140W          Rev: 1281
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SONY      Model: SDT-10000         Rev: 0101
  Type:   Sequential-Access                  ANSI SCSI revision: 02
sym53c875-0-<1,0>: tagged command queue depth set to 8
sym53c875-0-<8,0>: tagged command queue depth set to 8
sym53c875-0-<9,0>: tagged command queue depth set to 8
Detected scsi tape st0 at scsi0, channel 0, id 10, lun 0
st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
Detected scsi disk sdc at scsi0, channel 0, id 8, lun 0
Detected scsi disk sdd at scsi0, channel 0, id 9, lun 0
sym53c875-0-<0,0>: sync msgout: 1-3-1-c-10.
sym53c875-0-<0,0>: sync msg in: 1-3-1-19-8.
sym53c875-0-<0,0>: sync: per=25 scntl3=0x30 scntl4=0x0 ofs=8 fak=0 chg=0.
sym53c875-0-<0,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 8)
sym53c875-0-<0,0>: sync msgout: 1-3-1-c-10.
sym53c875-0-<0,0>: sync msg in: 1-3-1-19-8.
sym53c875-0-<0,0>: sync: per=25 scntl3=0x30 scntl4=0x0 ofs=8 fak=0 chg=0.
SCSI device sda: 2503872 512-byte hdwr sectors (1282 MB)
Partition check:
 /dev/scsi/host0/bus0/target0/lun0: p1 p2
sym53c875-0-<1,0>: sync msgout: 1-3-1-c-10.
sym53c875-0-<1,0>: sync msg in: 1-3-1-19-f.
sym53c875-0-<1,0>: sync: per=25 scntl3=0x30 scntl4=0x0 ofs=15 fak=0 chg=0.
sym53c875-0-<1,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 15)
sym53c875-0-<1,0>: sync msgout: 1-3-1-c-10.
sym53c875-0-<1,0>: sync msg in: 1-3-1-19-f.
sym53c875-0-<1,0>: sync: per=25 scntl3=0x30 scntl4=0x0 ofs=15 fak=0 chg=0.
SCSI device sdb: 2110812 512-byte hdwr sectors (1081 MB)
 /dev/scsi/host0/bus0/target1/lun0: p1 p2
sym53c875-0-<8,0>: wide msgout: 1-2-3-1.
sym53c875-0-<8,0>: wide msgin: 1-2-3-1.
sym53c875-0-<8,0>: wide: wide=1 chg=0.
sym53c875-0-<8,0>: wide msgout: 1-2-3-1.
sym53c875-0-<8,0>: wide msgin: 1-2-3-1.
sym53c875-0-<8,0>: wide: wide=1 chg=0.
sym53c875-0-<8,0>: sync msgout: 1-3-1-c-10.
sym53c875-0-<8,0>: sync msg in: 1-3-1-c-f.
sym53c875-0-<8,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0 chg=0.
sym53c875-0-<8,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 15)
SCSI device sdc: 17783240 512-byte hdwr sectors (9105 MB)
 /dev/scsi/host0/bus0/target8/lun0: p1
sym53c875-0-<9,0>: wide msgout: 1-2-3-1.
sym53c875-0-<9,0>: wide msgin: 1-2-3-1.
sym53c875-0-<9,0>: wide: wide=1 chg=0.
sym53c875-0-<9,0>: wide msgout: 1-2-3-1.
sym53c875-0-<9,0>: wide msgin: 1-2-3-1.
sym53c875-0-<9,0>: wide: wide=1 chg=0.
sym53c875-0-<9,0>: sync msgout: 1-3-1-c-10.
sym53c875-0-<9,0>: sync msg in: 1-3-1-c-f.
sym53c875-0-<9,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0 chg=0.
sym53c875-0-<9,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 15)
SCSI device sdd: 17783240 512-byte hdwr sectors (9105 MB)
 /dev/scsi/host0/bus0/target9/lun0: p1
<ACI 0x07, id 6d/43 "m/C", (PCM20 radio)> at 0x344
aci: READYFLAG needed 785911 polls.
aci: READYFLAG needed 835044 polls.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 188k freed
Adding Swap: 132072k swap-space (priority -1)
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Linux video capture interface: v1.00
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
bttv: driver version 0.7.50 loaded
bttv: using 2 buffers with 2080k (4160k total) for capture
BT848 and your chipset may not work together.
bttv: Bt8xx card found (0).
IRQ for 00:09.0:0 -> PIRQ 04, mask 1eb8, excl 0000 -> newirq=11 -> got IRQ 7
IRQ routing conflict in pirq table! Try 'pci=autoirq'
bttv0: Bt878 (rev 2) at 00:09.0, irq: 11, latency: 32, memory: 0xe7800000
bttv0: subsystem: 0070:13eb  =>  Hauppauge WinTV  =>  card=10
bttv0: model: BT878(Hauppauge new (bt878)) [autodetected]
bttv0: Hauppauge msp34xx: reset line init
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: Hauppauge eeprom: model=37284, tuner=Philips FM1216 (5)
bttv0: i2c: checking for MSP34xx @ 0x80... found
i2c-core.o: driver i2c msp3400 driver registered.
msp34xx: init: chip=MSP3410D-B4, has NICAM support
msp3410: daemon started
bttv0: i2c attach [MSP3410D-B4]
i2c-core.o: client [MSP3410D-B4] registered to adapter [bt848 #0](pos. 0).
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951)
i2c-core.o: driver generic i2c audio driver registered.
bttv0: i2c attach [tda9840]
i2c-core.o: client [tda9840] registered to adapter [bt848 #0](pos. 1).
i2c-core.o: driver i2c TV tuner driver registered.
tuner: chip found @ 0x61
bttv0: i2c attach [Philips PAL]
i2c-core.o: client [Philips PAL] registered to adapter [bt848 #0](pos. 2).
inserting floppy driver for 2.4.0
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
Detected scsi CD-ROM sr1 at scsi0, channel 0, id 5, lun 0
sym53c875-0-<4,0>: sync msgout: 1-3-1-c-10.
sym53c875-0-<4,0>: sync msg in: 1-3-1-c-f.
sym53c875-0-<4,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0 chg=0.
sym53c875-0-<4,*>: FAST-20 SCSI 20.0 MB/s (50 ns, offset 15)
sym53c875-0-<4,0>: sync msgout: 1-3-1-c-10.
sym53c875-0-<4,0>: sync msg in: 1-3-1-c-f.
sym53c875-0-<4,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0 chg=0.
sym53c875-0-<4,0>: sync msgout: 1-3-1-c-10.
sym53c875-0-<4,0>: sync msg in: 1-3-1-c-f.
sym53c875-0-<4,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0 chg=0.
Uniform CD-ROM driver Revision: 3.12
sym53c875-0-<5,*>: target did not report SYNC.
sym53c875-0-<5,*>: target did not report SYNC.
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller on PCI bus 00 dev 09
PCI: Enabling device 00:01.1 (0000 -> 0001)
IRQ for 00:01.1:0 -> PIRQ 01, mask 1eb8, excl 0000 -> newirq=12 -> assigning IRQ 12 ... OK
PCI: Assigned IRQ 12 for device 00:01.1
PCI: The same IRQ used for device 00:01.2
PCI: The same IRQ used for device 00:0c.0
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: neither IDE port enabled (BIOS)

----Next_Part(Sun_Jan_28_21:58:04_2001_809)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg.2.4.0-test9"

Linux version 2.4.0-test9 (root@panorama.hadiko.de) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Mon Oct 16 16:28:46 CEST 2000
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000007f00000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01223000)
Kernel command line: BOOT_IMAGE=old ro root=801
Initializing CPU#0
Detected 334.089 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 666.83 BogoMIPS
Memory: 126952k/131072k available (1093k kernel code, 3732k reserved, 64k data, 188k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: L1 I Cache: 32K  L1 D Cache: 32K (32 bytes/line)
CPU: AMD-K6(tm) 3D processor stepping 00
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xf04d0, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [1039/0008] at 00:01.0
Disabling direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
Linux IP multicast router 0.06 plus PIM-SM
Initializing RT netlink socket
Starting kswapd v1.8
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 16
0x378: readIntrThreshold is 16
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x4b
0x378: ECP settings irq=7 dma=3
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,EPP,ECP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: No more nibble data (0 bytes)
parport1: PC-style at 0x278 [PCSPP]
parport1: cpp_daisy: aa5500ff(38)
parport1: assign_addrs: aa5500ff(38)
parport1: cpp_daisy: aa5500ff(38)
parport1: assign_addrs: aa5500ff(38)
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
lp1: using parport1 (polling).
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 12, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875 detected with Tekram NVRAM
sym53c875-0: rev 0x3 on pci bus 0 device 12 function 0 irq 12
sym53c875-0: Tekram format NVRAM, ID 7, Fast-20, Parity Checking
sym53c875-0: on-chip RAM at 0xe1000000
sym53c875-0: restart (scsi reset).
sym53c875-0: Downloading SCSI SCRIPTS.
scsi0 : sym53c8xx - version 1.6b
  Vendor: IBM       Model: FIREBALL1280S !#  Rev: 630P
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: CONNER    Model: CFP1080S          Rev: 4649
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-ROM PX-40TS    Rev: 1.11
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: COMPAQ    Model: CD-ROM CR-503BCQ  Rev: 1.1c
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST39140W          Rev: 1281
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST39140W          Rev: 1281
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SONY      Model: SDT-10000         Rev: 0101
  Type:   Sequential-Access                  ANSI SCSI revision: 02
sym53c875-0-<1,0>: tagged command queue depth set to 8
sym53c875-0-<8,0>: tagged command queue depth set to 8
sym53c875-0-<9,0>: tagged command queue depth set to 8
Detected scsi tape st0 at scsi0, channel 0, id 10, lun 0
st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
Detected scsi disk sdc at scsi0, channel 0, id 8, lun 0
Detected scsi disk sdd at scsi0, channel 0, id 9, lun 0
sym53c875-0-<0,0>: sync msgout: 1-3-1-c-10.
sym53c875-0-<0,0>: sync msg in: 1-3-1-19-8.
sym53c875-0-<0,0>: sync: per=25 scntl3=0x30 scntl4=0x0 ofs=8 fak=0 chg=0.
sym53c875-0-<0,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 8)
sym53c875-0-<0,0>: sync msgout: 1-3-1-c-10.
sym53c875-0-<0,0>: sync msg in: 1-3-1-19-8.
sym53c875-0-<0,0>: sync: per=25 scntl3=0x30 scntl4=0x0 ofs=8 fak=0 chg=0.
SCSI device sda: 2503872 512-byte hdwr sectors (1282 MB)
Partition check:
 /dev/scsi/host0/bus0/target0/lun0: p1 p2
sym53c875-0-<1,0>: sync msgout: 1-3-1-c-10.
sym53c875-0-<1,0>: sync msg in: 1-3-1-19-f.
sym53c875-0-<1,0>: sync: per=25 scntl3=0x30 scntl4=0x0 ofs=15 fak=0 chg=0.
sym53c875-0-<1,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 15)
sym53c875-0-<1,0>: sync msgout: 1-3-1-c-10.
sym53c875-0-<1,0>: sync msg in: 1-3-1-19-f.
sym53c875-0-<1,0>: sync: per=25 scntl3=0x30 scntl4=0x0 ofs=15 fak=0 chg=0.
SCSI device sdb: 2110812 512-byte hdwr sectors (1081 MB)
 /dev/scsi/host0/bus0/target1/lun0: p1 p2
sym53c875-0-<8,0>: wide msgout: 1-2-3-1.
sym53c875-0-<8,0>: wide msgin: 1-2-3-1.
sym53c875-0-<8,0>: wide: wide=1 chg=0.
sym53c875-0-<8,0>: wide msgout: 1-2-3-1.
sym53c875-0-<8,0>: wide msgin: 1-2-3-1.
sym53c875-0-<8,0>: wide: wide=1 chg=0.
sym53c875-0-<8,0>: sync msgout: 1-3-1-c-10.
sym53c875-0-<8,0>: sync msg in: 1-3-1-c-f.
sym53c875-0-<8,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0 chg=0.
sym53c875-0-<8,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 15)
SCSI device sdc: 17783240 512-byte hdwr sectors (9105 MB)
 /dev/scsi/host0/bus0/target8/lun0: p1
sym53c875-0-<9,0>: wide msgout: 1-2-3-1.
sym53c875-0-<9,0>: wide msgin: 1-2-3-1.
sym53c875-0-<9,0>: wide: wide=1 chg=0.
sym53c875-0-<9,0>: wide msgout: 1-2-3-1.
sym53c875-0-<9,0>: wide msgin: 1-2-3-1.
sym53c875-0-<9,0>: wide: wide=1 chg=0.
sym53c875-0-<9,0>: sync msgout: 1-3-1-c-10.
sym53c875-0-<9,0>: sync msg in: 1-3-1-c-f.
sym53c875-0-<9,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0 chg=0.
sym53c875-0-<9,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 15)
SCSI device sdd: 17783240 512-byte hdwr sectors (9105 MB)
 /dev/scsi/host0/bus0/target9/lun0: p1
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 188k freed
Adding Swap: 132072k swap-space (priority -1)
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Linux video capture interface: v1.00
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
bttv: driver version 0.7.38 loaded
bttv: using 2 buffers with 2080k (4160k total) for capture
bttv: Bt8xx card found (0).
bttv0: Brooktree Bt878 (rev 2) bus: 0, devfn: 72, irq: 11, memory: 0xe7800000.
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: i2c: checking for eeprom @ 0xa0... found
bttv0: card id: Hauppauge WinTV (0x13eb0070) => card=10
bttv0: model: BT878(Hauppauge new (bt878)) [autodetected]
bttv0: Hauppauge eeprom: tuner=Philips FM1216 (5)
bttv0: Hauppauge msp34xx: reset line init
bttv0: i2c: checking for MSP34xx @ 0x80... found
i2c-core.o: adapter unregistered: bt848 #0
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: i2c: checking for MSP34xx @ 0x80... found
i2c-core.o: driver i2c msp3400 driver registered.
msp3400: init: chip=MSP3410D-B4, has NICAM support
msp3410: daemon started
bttv0: i2c attach [MSP3410D-B4]
i2c-core.o: client [MSP3410D-B4] registered to adapter [bt848 #0](pos. 0).
bttv0: i2c: checking for TDA8425 @ 0x82... not found
bttv0: i2c: checking for TDA985x @ 0xb6... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
i2c-core.o: driver i2c TV tuner driver registered.
tuner: chip found @ 0x61
bttv0: i2c attach [Philips PAL]
i2c-core.o: client [Philips PAL] registered to adapter [bt848 #0](pos. 1).
inserting floppy driver for 2.4.0-test9
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
Detected scsi CD-ROM sr1 at scsi0, channel 0, id 5, lun 0
sym53c875-0-<4,0>: sync msgout: 1-3-1-c-10.
sym53c875-0-<4,0>: sync msg in: 1-3-1-c-f.
sym53c875-0-<4,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0 chg=0.
sym53c875-0-<4,*>: FAST-20 SCSI 20.0 MB/s (50 ns, offset 15)
sym53c875-0-<4,0>: sync msgout: 1-3-1-c-10.
sym53c875-0-<4,0>: sync msg in: 1-3-1-c-f.
sym53c875-0-<4,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0 chg=0.
sym53c875-0-<4,0>: sync msgout: 1-3-1-c-10.
sym53c875-0-<4,0>: sync msg in: 1-3-1-c-f.
sym53c875-0-<4,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0 chg=0.
Uniform CD-ROM driver Revision: 3.11
sym53c875-0-<5,*>: target did not report SYNC.
sym53c875-0-<5,*>: target did not report SYNC.
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller on PCI bus 00 dev 09
SIS5513: placing both ports into native PCI mode
SIS5513: device enabled (Linux)
SIS5513: chipset revision 208
SIS5513: will probe irqs later
SIS5513: neither IDE port enabled (BIOS)

----Next_Part(Sun_Jan_28_21:58:04_2001_809)----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
