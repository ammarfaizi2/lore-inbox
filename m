Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129819AbQKUPi5>; Tue, 21 Nov 2000 10:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130319AbQKUPir>; Tue, 21 Nov 2000 10:38:47 -0500
Received: from pc-62-31-77-22-tw.blueyonder.co.uk ([62.31.77.22]:3598 "EHLO
	linux.scot-mur.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129819AbQKUPil>; Tue, 21 Nov 2000 10:38:41 -0500
Date: Tue, 21 Nov 2000 15:09:56 +0000
From: rob@mur.org.uk
To: linux-kernel@vger.kernel.org
Subject: Re: "No IRQ known for interrupt pin A..." error message
Message-ID: <20001121150956.B14040@scot-mur.demon.co.uk>
Mail-Followup-To: rob@mur.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20001118181110.A424@hapablap.dyn.dhs.org> <20001119202033.A272@albireo.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001119202033.A272@albireo.ucw.cz>; from mj@suse.cz on Sun, Nov 19, 2000 at 08:20:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the same message with 2.4.0-test10 on a sis chipset. There
doesn't seam to be any other problems, and ide0 appears in
/proc/interrupts. 


# dmesg |grep ^PCI
PCI: PCI BIOS revision 2.10 entry at 0xfdb91, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 00:14.0
PCI: Cannot allocate resource region 1 of device 00:14.0
PCI: Cannot allocate resource region 2 of device 00:14.0
PCI: No IRQ known for interrupt pin A of device 00:01.1. Please try using pci=biosirq.
PCI: Setting latency timer of device 00:0b.0 to 32
PCI: Setting latency timer of device 00:09.0 to 32
# lspci
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 5597 [SiS5582] (rev 10)
00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 01)
00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:09.0 Multimedia audio controller: Trident Microsystems 4DWave NX (rev 02)
00:0b.0 Ethernet controller: D-Link System Inc: Unknown device 1002
00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
00:0d.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
00:0f.0 VGA compatible controller: Cirrus Logic GD 5430/40 [Alpine] (rev 22)
00:14.0 VGA compatible controller: Silicon Integrated Systems [SiS] 5597/5598 VGA (rev 68)
#  lspci -vvx
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 5597 [SiS5582] (rev 10)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
00: 39 10 97 55 07 00 00 22 10 00 00 06 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 39 10 08 00 07 00 00 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 8a [Master SecP PriP])
	Subsystem: Unknown device 0149:0100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at 4000 [size=16]
00: 39 10 13 55 07 00 00 00 d0 8a 01 01 00 80 80 00
10: 01 00 2c 13 21 84 00 00 a1 c2 00 03 19 02 84 08
20: 01 40 00 00 00 00 00 00 00 00 00 00 49 01 00 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00

00:09.0 Multimedia audio controller: Trident Microsystems 4DWave NX (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at f400 [size=256]
	Region 1: Memory at ffadf000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [48] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 23 10 01 20 07 01 10 02 02 00 01 04 00 20 00 00
10: 01 f4 00 00 00 f0 ad ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 48 00 00 00 00 00 00 00 0b 01 02 05

00:0b.0 Ethernet controller: D-Link System Inc: Unknown device 1002
	Subsystem: D-Link System Inc: Unknown device 1002
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 04
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at f080 [size=128]
	Region 1: Memory at ffafff80 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at ffae0000 [disabled] [size=64K]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
00: 86 11 02 10 17 01 10 02 00 00 00 02 04 20 00 00
10: 81 f0 00 00 80 ff af ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 11 02 10
30: 00 00 ae ff 50 00 00 00 00 00 00 00 0a 01 0a 0a

00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at fd9fe000 (32-bit, prefetchable) [size=4K]
00: 9e 10 6e 03 06 01 80 02 02 00 00 04 00 40 80 00
10: 08 e0 9f fd 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 70 00 eb 13
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 10 28

00:0d.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at fd9ff000 (32-bit, prefetchable) [size=4K]
00: 9e 10 78 08 06 01 80 02 02 00 80 04 00 40 80 00
10: 08 f0 9f fd 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 70 00 eb 13
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 04 ff

00:0f.0 VGA compatible controller: Cirrus Logic GD 5430/40 [Alpine] (rev 22) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at fc000000 (32-bit, prefetchable) [size=16M]
	Expansion ROM at fe000000 [disabled] [size=16M]
00: 13 10 a0 00 23 00 00 02 22 00 00 03 00 00 00 00
10: 08 00 00 fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 fe 00 00 00 00 00 00 00 00 ff 00 00 00

00:14.0 VGA compatible controller: Silicon Integrated Systems [SiS] 5597/5598 VGA (rev 68) (prog-if 00 [VGA])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at 10000000 (32-bit, prefetchable) [disabled] [size=4M]
	Region 1: Memory at 10400000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Region 2: I/O ports at <ignored> [disabled] [size=128]
	Expansion ROM at ffff8000 [disabled] [size=32K]
00: 39 10 00 02 00 00 00 02 68 00 00 03 00 00 00 00
10: 08 00 00 10 00 00 40 10 81 ff ff ff 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 80 ff ff 00 00 00 00 00 00 00 00 00 01 00 00

portable:~# 
Script done on Tue Nov 21 15:02:15 2000

-- 
Rob Murray
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
