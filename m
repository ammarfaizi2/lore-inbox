Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129404AbQKSVuQ>; Sun, 19 Nov 2000 16:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129913AbQKSVuG>; Sun, 19 Nov 2000 16:50:06 -0500
Received: from pm3-0-8.apex.net ([209.250.40.23]:22532 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S129404AbQKSVt6>; Sun, 19 Nov 2000 16:49:58 -0500
Date: Sun, 19 Nov 2000 15:18:38 -0600
From: Steven Walter <srwalter@hapablap.dyn.dhs.org>
To: Martin Mares <mj@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "No IRQ known for interrupt pin A..." error message
Message-ID: <20001119151838.A2104@hapablap.dyn.dhs.org>
In-Reply-To: <20001118181110.A424@hapablap.dyn.dhs.org> <20001119202033.A272@albireo.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001119202033.A272@albireo.ucw.cz>; from mj@suse.cz on Sun, Nov 19, 2000 at 08:20:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2000 at 08:20:33PM +0100, Martin Mares wrote:
> > During boot, I get the message:
> > 
> > PCI: No IRQ known for interrupt pin A of device 00:00.1. Please try
> > using pci=biosirq.
> 
> Can you send me 'lspci -vvx' output, please?
> 

Here you go:

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 530 Host (rev 03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32 set
        Region 0: Memory at ec000000 (32-bit, non-prefetchable)
        Capabilities: [c0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=21
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=
00: 39 10 30 05 07 00 10 22 03 00 00 06 00 20 80 00
10: 00 00 00 ec 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
        Subsystem: Silicon Integrated Systems [SiS]: Unknown device 5513
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 set
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at 01f0
        Region 1: I/O ports at 03f4
        Region 2: I/O ports at 0170
        Region 3: I/O ports at 0374
        Region 4: I/O ports at ffa0
00: 39 10 13 55 05 00 00 00 d0 80 01 01 00 80 80 00
10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
20: a1 ff 00 00 00 00 00 00 00 00 00 00 39 10 13 55
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev b1)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
00: 39 10 08 00 0f 00 00 02 b1 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.1 Class ff00: Silicon Integrated Systems [SiS] ACPI
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 39 10 09 00 00 00 00 02 00 00 00 ff 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 11) (prog-if 10 [OHCI])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 80 max, 32 set
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at efffe000 (32-bit, non-prefetchable)
00: 39 10 01 70 17 01 80 02 11 10 03 0c 00 20 80 00
10: 00 e0 ff ef 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 50

00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: ebe00000-ebefffff
        Prefetchable memory behind bridge: fec00000-ffcfffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: 39 10 01 00 07 00 00 00 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 c0 c0 00 00
20: e0 eb e0 eb c0 fe c0 ff 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00

00:0b.0 Ethernet controller: Davicom Semiconductor, Inc. Ethernet 100/10 MBit (rev 10)
        Subsystem: Unknown device 0291:8212
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 20 min, 40 max, 32 set
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at da00
        Region 1: Memory at efffff80 (32-bit, non-prefetchable)
        Expansion ROM at eff80000 [disabled]
        Capabilities: [50] Power Management version 1
                Flags: PMEClk- AuxPwr+ DSI+ D1- D2- PME-
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME+
00: 82 12 02 91 07 01 90 02 10 00 00 02 00 20 00 00
10: 01 da 00 00 80 ff ff ef 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 91 02 12 82
30: 00 00 f8 ef 50 00 00 00 00 00 00 00 0a 01 14 28

00:0c.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: C-Media Electronics Inc: Unknown device 0111
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 2 min, 24 max, 32 set
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at dc00
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: f6 13 11 01 05 01 10 02 10 00 01 04 00 20 80 00
10: 01 dc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 f6 13 11 01
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0b 01 02 18

00:0c.1 Communication controller: C-Media Electronics Inc: Unknown device 0211 (rev 10)
        Subsystem: C-Media Electronics Inc: Unknown device 0211
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at de00
        Capabilities: [40] Power Management version 2
                Flags: PMEClk+ AuxPwr- DSI- D1- D2+ PME+
                Status: D3 PME-Enable+ DSel=0 DScale=0 PME+
00: f6 13 11 02 01 00 10 02 10 00 80 07 00 00 00 00
10: 01 de 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 f6 13 11 02
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 02 00 00

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 6306 3D-AGP (rev a3) (prog-if 00 [VGA])
        Subsystem: Silicon Integrated Systems [SiS]: Unknown device 6306
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 2 min, 32 set
        Region 0: Memory at ff000000 (32-bit, prefetchable)
        Region 1: Memory at ebef0000 (32-bit, non-prefetchable)
        Region 2: I/O ports at cc00
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2+ PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] AGP version 1.0
                Status: RQ=1 SBA- 64bit- FW- Rate=21
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=
00: 39 10 06 63 07 00 30 02 a3 00 00 03 00 20 00 00
10: 08 00 00 ff 00 00 ef eb 01 cc 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 39 10 06 63
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 02 00


Hope its useful to you. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
