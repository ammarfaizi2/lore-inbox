Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266164AbUFYCH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266164AbUFYCH4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 22:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266159AbUFYCH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 22:07:56 -0400
Received: from ms-1.rz.RWTH-Aachen.DE ([134.130.3.130]:2786 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S266167AbUFYCFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 22:05:17 -0400
Date: Fri, 25 Jun 2004 04:06:45 +0200
From: Alexander Gran <alex@zodiac.dnsalias.org>
Subject: Re: Linux 2.6.7-mm1, IBM T40p, ACPI C3 finally working.
In-reply-to: <200406211951.03333@zodiac.zodiac.dnsalias.org>
To: linux-kernel@vger.kernel.org
Cc: linux-thinkpad@linux-thinkpad.org
Message-id: <200406250406.45408@zodiac.zodiac.dnsalias.org>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_xqtFj7LrLlCkVSc9H7x5lw)"
User-Agent: KMail/1.6.2
X-Ignorant-User: yes
References: <200406211951.03333@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_xqtFj7LrLlCkVSc9H7x5lw)
Content-type: text/plain; charset=iso-8859-15
Content-transfer-encoding: 7BIT
Content-disposition: inline

Ok guys, now this is strange.

since 2.6.7-mm2 C3 does not work any longer. No idea why.
Same config, same system:
IBM t40p, 2373-g1g.
lspci -vvv:
root@t40:~# lspci -vvv
0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 
03)
        Subsystem: IBM: Unknown device 0529
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d0000000 (32-bit, prefetchable)
        Capabilities: [e4] #09 [f104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- 
Rate=x2

0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 
03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 96
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: c0100000-c01fffff
        Prefetchable memory behind bridge: e0000000-e7ffffff
        Expansion ROM at 00003000 [disabled] [size=4K]
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

0000:00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 01) 
(prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 052d
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 9
        Region 4: I/O ports at 1800 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 01) 
(prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 052d
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at 1820 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 01) 
(prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 052d
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 11
        Region 4: I/O ports at 1840 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller 
(rev 01) (prog-if 20 [EHCI])
        Subsystem: IBM: Unknown device 052e
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 10
        Region 0: Memory at c0000000 (32-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [2080]

0000:00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81) (prog-if 
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=08, sec-latency=168
        I/O behind bridge: 00004000-00008fff
        Memory behind bridge: c0200000-cfffffff
        Prefetchable memory behind bridge: e8000000-efffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 
01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage 
Controller (rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: IBM: Unknown device 052d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 1860 [size=16]
        Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (rev 01)
        Subsystem: IBM: Unknown device 052d
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at 1880 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97 
Audio Controller (rev 01)
        Subsystem: IBM: Unknown device 0537
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at 1c00
        Region 1: I/O ports at 18c0 [size=64]
        Region 2: Memory at c0000c00 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at c0000800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 01) 
(prog-if 00 [Generic])
        Subsystem: IBM: Unknown device 0525
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at 2400
        Region 1: I/O ports at 2000 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf 
[Radeon Mobility 9000 M9] (rev 02) (prog-if 00 [VGA])
        Subsystem: IBM: Unknown device 054d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR+ FastB2B+
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at e0000000 (32-bit, prefetchable)
        Region 1: I/O ports at 3000 [size=256]
        Region 2: Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- 
Rate=x2
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:00.0 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus 
Controller (rev 01)
        Subsystem: IBM ThinkPad T30/T40
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, Cache Line Size: 0x20 (128 bytes)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at b0000000 (32-bit, non-prefetchable)
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 20400000-207ff000 (prefetchable)
        Memory window 1: 20800000-20bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

0000:02:00.1 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus 
Controller (rev 01)
        Subsystem: IBM ThinkPad T30/T40
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, Cache Line Size: 0x20 (128 bytes)
        Interrupt: pin B routed to IRQ 10
        Region 0: Memory at b1000000 (32-bit, non-prefetchable)
        Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
        Memory window 0: 20c00000-20fff000 (prefetchable)
        Memory window 1: 21000000-213ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

0000:02:01.0 Ethernet controller: Intel Corp. 82540EP Gigabit Ethernet 
Controller (Mobile) (rev 03)
        Subsystem: IBM PRO/1000 MT Mobile Connection
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (63750ns min), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at c0220000 (32-bit, non-prefetchable)
        Region 1: Memory at c0200000 (32-bit, non-prefetchable) [size=64K]
        Region 2: I/O ports at 8000 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 
Enable-
                Address: 0000000000000000  Data: 0000

0000:02:02.0 Ethernet controller: Atheros Communications, Inc. AR5211 802.11ab 
NIC (rev 01)
        Subsystem: Unknown device 17ab:8310
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 80 (2500ns min, 7000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at c0210000 (32-bit, non-prefetchable)
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

dmesges attached.

regards
Alex


Am Montag, 21. Juni 2004 19:50 schrieb Alexander Gran:
> Hi,
>
> just a quick note:
> Since 2.6.7-mm1 acpi C3 works even with usb and radeon loaded.
> Great work!
>
> regards
> Alex

-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

--Boundary_(ID_xqtFj7LrLlCkVSc9H7x5lw)
Content-type: text/plain; charset=iso-8859-15; name=dmesg-2.6.7-mm1
Content-transfer-encoding: 8BIT
Content-disposition: inline; filename=dmesg-2.6.7-mm1

Linux version 2.6.7-mm1 (root@t40) (gcc version 3.3.4 (Debian)) #1 Mon Jun 21 03:57:38 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff60000 (usable)
 BIOS-e820: 000000001ff60000 - 000000001ff77000 (ACPI data)
 BIOS-e820: 000000001ff77000 - 000000001ff79000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130912
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126816 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
ACPI: RSDP (v002 IBM                                       ) @ 0x000f6e00
ACPI: XSDT (v001 IBM    TP-1R    0x00003051  LTP 0x00000000) @ 0x1ff6af83
ACPI: FADT (v003 IBM    TP-1R    0x00003051 IBM  0x00000001) @ 0x1ff6b000
ACPI: SSDT (v001 IBM    TP-1R    0x00003051 MSFT 0x0100000e) @ 0x1ff6b1b4
ACPI: ECDT (v001 IBM    TP-1R    0x00003051 IBM  0x00000001) @ 0x1ff76e06
ACPI: TCPA (v001 IBM    TP-1R    0x00003051 PTL  0x00000001) @ 0x1ff76e58
ACPI: BOOT (v001 IBM    TP-1R    0x00003051  LTP 0x00000001) @ 0x1ff76fd8
ACPI: DSDT (v001 IBM    TP-1R    0x00003051 MSFT 0x0100000e) @ 0x00000000
Built 1 zonelists
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Kernel command line: BOOT_IMAGE=Linux2.6.7-mm1 ro root=306 quiet
CPU 0 irqstacks, hard=c050a000 soft=c0509000
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1595.001 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 512528k/523648k available (2721k kernel code, 10352k reserved, 1221k data, 176k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3153.92 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU:     After vendor identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU:     After all inits, caps: a7e9fbbf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1600MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1594.0574 MHz.
..... host bus clock speed is 99.0660 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=8
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
    ACPI-0291: *** Info: Table [DSDT] replaced by host OS
ACPI: IRQ9 SCI: Level Trigger.
ACPI: Found ECDT
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 28)
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f6e30
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xb699, dseg 0x400
pnp: 00:0b: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0b: ioport range 0x1000-0x105f has been reserved
pnp: 00:0b: ioport range 0x1060-0x107f has been reserved
pnp: 00:0b: ioport range 0x1180-0x11bf has been reserved
PnPBIOS: 19 nodes reported by PnP BIOS; 19 recorded by driver
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:02:00.1[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
NET: Registered protocol family 23
Bluetooth: Core ver 2.5
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 9 (level, low) -> IRQ 9
radeonfb: Invalid ROM signature 0 should be 0xaa55
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=252.00 Mhz, System=200.00 MHz
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: SXGA+ Single (85MHz)    
radeonfb: detected LVDS panel size from BIOS: 1400x1050
radeondb: BIOS provided dividers will be used
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB
Simple Boot Flag at 0x35 set to 0x1
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
udf: registering filesystem
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 175x65
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xd0000000
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9]
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
pnp: Device 00:12 activated.
ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x3bc (0x7bc), irq 7, dma 1 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
lp0: using parport0 (interrupt-driven).
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
NET: Registered protocol family 24
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATCS05-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: UJDA745 DVD/CDRW, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/7898KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 > hda4
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 9 (level, low) -> IRQ 9
Yenta: CardBus bridge found at 0000:02:00.0 [1014:0512]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:00.0, mfunc 0x01d21022, devctl 0x64
Yenta: ISA IRQ mask 0x0078, PCI irq 9
Socket status: 30000006
ACPI: PCI interrupt 0000:02:00.1[B] -> GSI 10 (level, low) -> IRQ 10
Yenta: CardBus bridge found at 0000:02:00.1 [1014:0512]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:00.1, mfunc 0x01d21022, devctl 0x64
Yenta: ISA IRQ mask 0x0078, PCI irq 10
Socket status: 30000006
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 44
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
 -> pass-through port
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: Synaptics pass-through port at isa0060/serio1/input0
input: PS/2 Generic Mouse on synaptics-pt/serio0
input: PC Speaker
Advanced Linux Sound Architecture Driver Version 1.0.5 (Sun May 30 10:49:40 2004 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
IrCOMM protocol (Dag Brattli)
Bluetooth: L2CAP ver 2.2
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.3
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM ver 1.3
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.0
Bluetooth: BNEP filters: protocol multicast
speedstep-centrino: found "Intel(R) Pentium(R) M processor 1600MHz": max frequency: 1600000kHz
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 176k freed
Adding 498920k swap on /dev/hda5.  Priority:-1 extents:1
EXT3 FS on hda6, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 600 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 600 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB (ICH4) USB UHCI #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 9, io base 00001800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: detected 2 ports
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: Intel Corp. 82801DB (ICH4) USB UHCI #1
usb usb1: Manufacturer: Linux 2.6.7-mm1 uhci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB (ICH4) USB UHCI #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 10, io base 00001820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: detected 2 ports
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: default language 0x0409
usb usb2: Product: Intel Corp. 82801DB (ICH4) USB UHCI #2
usb usb2: Manufacturer: Linux 2.6.7-mm1 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.1
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB (ICH4) USB UHCI #3
uhci_hcd 0000:00:1d.1: port 1 portsc 0093
hub 2-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 11, io base 00001840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: detected 2 ports
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: default language 0x0409
usb usb3: Product: Intel Corp. 82801DB (ICH4) USB UHCI #3
usb usb3: Manufacturer: Linux 2.6.7-mm1 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.2
usb usb3: hotplug
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: individual port over-current protection
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: local power source is good
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
usb 2-1: new full speed USB device using address 2
usb 2-1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1: hotplug
usb 2-1: adding 2-1:1.0 (config #1, interface 0)
usb 2-1:1.0: hotplug
hub 2-1:1.0: usb_probe_interface
hub 2-1:1.0: usb_probe_interface - got id
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 4 ports detected
hub 2-1:1.0: standalone hub
hub 2-1:1.0: individual port power switching
hub 2-1:1.0: individual port over-current protection
hub 2-1:1.0: Port indicators are supported
hub 2-1:1.0: power on to power good time: 100ms
hub 2-1:1.0: local power source is good
hub 2-1:1.0: enabling power on all ports
hub 2-1:1.0: port 3, status 0301, change 0001, 1.5 Mb/s
hub 2-1:1.0: debounce: port 3: total 100ms stable 100ms status 0x301
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: reset hcs_params 0x103206 dbg=1 cc=3 pcc=2 ordered !ppc ports=6
ehci_hcd 0000:00:1d.7: reset hcc_params 6871 thresh 7 uframes 1024 64 bit addr
ehci_hcd 0000:00:1d.7: capability 0001 at 68
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 10, pci mem e18c6000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:1d.7: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: init command 010001 (park)=0 ithresh=1 period=1024 RUN
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
ehci_hcd 0000:00:1d.7: supports USB remote wakeup
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: default language 0x0409
usb usb4: Product: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
usb usb4: Manufacturer: Linux 2.6.7-mm1 ehci_hcd
usb usb4: SerialNumber: 0000:00:1d.7
usb usb4: hotplug
usb usb4: adding 4-0:1.0 (config #1, interface 0)
usb 4-0:1.0: hotplug
hub 4-0:1.0: usb_probe_interface
hub 4-0:1.0: usb_probe_interface - got id
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
hub 4-0:1.0: standalone hub
hub 4-0:1.0: ganged power switching
hub 4-0:1.0: individual port over-current protection
hub 4-0:1.0: Single TT
hub 4-0:1.0: TT requires at most 8 FS bit times
hub 4-0:1.0: power on to power good time: 20ms
hub 4-0:1.0: local power source is good
hub 4-0:1.0: enabling power on all ports
uhci_hcd 0000:00:1d.0: suspend_hc
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
[df057270] link (1f0571e2) element (1f38b080)
  0: [df38b080] link (1f38b0c0) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=1f3315c0)
  1: [df38b0c0] link (1f38b100) e3 SPD Active Length=0 MaxLen=3 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=1f3311a0)
  2: [df38b100] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)

hub 2-1:1.0: hub_port_status failed (err = -71)
hub 2-1:1.0: port 3 not enabled, trying reset again...
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
[df057270] link (1f0571e2) element (1f38b080)
  0: [df38b080] link (1f38b0c0) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=1f3315c0)
  1: [df38b0c0] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=69(IN) (buf=00000000)

hub 2-1:1.0: cannot reset port 3 (err = -71)
hub 2-1:1.0: port 3 not enabled, trying reset again...
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
[df0572a0] link (1f0571e2) element (1f38b100)
  0: [df38b100] link (1f38b140) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=1f3315c0)
  1: [df38b140] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=69(IN) (buf=00000000)

hub 2-1:1.0: cannot reset port 3 (err = -71)
hub 2-1:1.0: port 3 not enabled, trying reset again...
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
[df057270] link (1f0571e2) element (1f38b080)
  0: [df38b080] link (1f38b0c0) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=1f3315c0)
  1: [df38b0c0] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=69(IN) (buf=00000000)

hub 2-1:1.0: cannot reset port 3 (err = -71)
hub 2-1:1.0: port 3 not enabled, trying reset again...
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
[df0572a0] link (1f0571e2) element (1f38b100)
  0: [df38b100] link (1f38b140) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=1f3315c0)
  1: [df38b140] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=69(IN) (buf=00000000)

hub 2-1:1.0: cannot reset port 3 (err = -71)
hub 2-1:1.0: port 3 not enabled, trying reset again...
hub 2-1:1.0: Cannot enable port 3.  Maybe the USB cable is bad?
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
[df057270] link (1f0571e2) element (1f38b080)
  0: [df38b080] link (1f38b0c0) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=1f3315c0)
  1: [df38b0c0] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=69(IN) (buf=00000000)

hub 2-1:1.0: cannot disable port 3 (err = -71)
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
[df0572a0] link (1f0571e2) element (1f38b100)
  0: [df38b100] link (1f38b140) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=1f3315c0)
  1: [df38b140] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=69(IN) (buf=00000000)

hub 2-1:1.0: cannot reset port 3 (err = -71)
hub 2-1:1.0: port 3 not enabled, trying reset again...
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
[df057270] link (1f0571e2) element (1f38b080)
  0: [df38b080] link (1f38b0c0) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=1f3315c0)
  1: [df38b0c0] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=69(IN) (buf=00000000)

hub 2-1:1.0: cannot reset port 3 (err = -71)
hub 2-1:1.0: port 3 not enabled, trying reset again...
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
[df0572a0] link (1f0571e2) element (1f38b100)
  0: [df38b100] link (1f38b140) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=1f3315c0)
  1: [df38b140] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=69(IN) (buf=00000000)

hub 2-1:1.0: cannot reset port 3 (err = -71)
hub 2-1:1.0: port 3 not enabled, trying reset again...
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
[df057270] link (1f0571e2) element (1f38b080)
  0: [df38b080] link (1f38b0c0) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=1f3315c0)
  1: [df38b0c0] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=69(IN) (buf=00000000)

hub 2-1:1.0: cannot reset port 3 (err = -71)
hub 2-1:1.0: port 3 not enabled, trying reset again...
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
[df0572a0] link (1f0571e2) element (1f38b100)
  0: [df38b100] link (1f38b140) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=1f3315c0)
  1: [df38b140] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=69(IN) (buf=00000000)

hub 2-1:1.0: cannot reset port 3 (err = -71)
hub 2-1:1.0: port 3 not enabled, trying reset again...
hub 2-1:1.0: Cannot enable port 3.  Maybe the USB cable is bad?
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
[df057270] link (1f0571e2) element (1f38b080)
  0: [df38b080] link (1f38b0c0) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=1f3315c0)
  1: [df38b0c0] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=69(IN) (buf=00000000)

hub 2-1:1.0: cannot disable port 3 (err = -71)
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
[df0572a0] link (1f0571e2) element (1f38b100)
  0: [df38b100] link (1f38b140) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=1f3315c0)
  1: [df38b140] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=69(IN) (buf=00000000)

hub 2-1:1.0: cannot disable port 3 (err = -71)
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
[df057270] link (1f0571e2) element (1f38b080)
  0: [df38b080] link (1f38b0c0) e0 Stalled CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=2, PID=2d(SETUP) (buf=1f3315c0)
  1: [df38b0c0] link (1f38b180) e3 SPD Active Length=0 MaxLen=3 DT1 EndPt=0 Dev=2, PID=69(IN) (buf=1f3311a0)
  2: [df38b180] link (00000001) e3 IOC Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=2, PID=e1(OUT) (buf=00000000)

hub 2-1:1.0: hub_port_status failed (err = -71)
uhci_hcd 0000:00:1d.1: port 1 portsc 008a
hub 2-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
usb 2-1: USB disconnect, address 2
usb 2-1: usb_disable_device nuking all URBs
uhci_hcd 0000:00:1d.1: shutdown urb dfd43b80 pipe 40408280 ep1in-intr
usb 2-1: unregistering interface 2-1:1.0
usb 2-1:1.0: hotplug
usb 2-1: unregistering device
usb 2-1: hotplug
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001803 POWER sig=j  CSC CONNECT
hub 4-0:1.0: port 3, status 0501, change 0001, 480 Mb/s
uhci_hcd 0000:00:1d.2: suspend_hc
hub 4-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x501
hub 4-0:1.0: port 3 not reset yet, waiting 50ms
ehci_hcd 0000:00:1d.7: port 3 high speed
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001005 POWER sig=se0  PE CONNECT
usb 4-3: new high speed USB device using address 2
usb 4-3: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 4-3: hotplug
usb 4-3: adding 4-3:1.0 (config #1, interface 0)
usb 4-3:1.0: hotplug
hub 4-3:1.0: usb_probe_interface
hub 4-3:1.0: usb_probe_interface - got id
hub 4-3:1.0: USB hub found
hub 4-3:1.0: 4 ports detected
hub 4-3:1.0: standalone hub
hub 4-3:1.0: individual port power switching
hub 4-3:1.0: individual port over-current protection
hub 4-3:1.0: TT per port
hub 4-3:1.0: TT requires at most 8 FS bit times
hub 4-3:1.0: Port indicators are supported
hub 4-3:1.0: power on to power good time: 100ms
hub 4-3:1.0: local power source is good
drivers/usb/host/ehci-sched.c: scheduled qh df517100 usecs 7/0 period 256.0 starting 255.0 (gap 0)
hub 4-3:1.0: enabling power on all ports
hub 4-3:1.0: port 3, status 0301, change 0001, 1.5 Mb/s
uhci_hcd 0000:00:1d.1: suspend_hc
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
hub 4-3:1.0: debounce: port 3: total 100ms stable 100ms status 0x301
usb 4-3.3: new low speed USB device using address 3
usb 4-3.3: skipped 1 descriptor after interface
usb 4-3.3: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 4-3.3: default language 0x0409
usb 4-3.3: Product: Microsoft IntelliMouse® Explorer
usb 4-3.3: Manufacturer: Microsoft
usb 4-3.3: hotplug
usb 4-3.3: adding 4-3.3:1.0 (config #1, interface 0)
usb 4-3.3:1.0: hotplug
usbcore: registered new driver hiddev
usbhid 4-3.3:1.0: usb_probe_interface
usbhid 4-3.3:1.0: usb_probe_interface - got id
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Explorer] on usb-0000:00:1d.7-3.3
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
intel8x0_measure_ac97_clock: measured 98438 usecs
intel8x0: measured clock 24208 rejected
intel8x0: clocking to 48000
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.6 to 64
e1000: Ignoring new-style parameters in presence of obsolete ones
Intel(R) PRO/1000 Network Driver - version 5.2.52-k4
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 9 (level, low) -> IRQ 9
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ath_hal: module license 'Proprietary' taints kernel.
ath_hal: 0.9.9.3
wlan: 0.7.3.2 BETA
ath_pci: no version for "ieee80211_encap" found: kernel tainted.
ath_pci: 0.8.6.1 BETA
ath_pci: 0.8.6.1 BETA
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
ath%d: HAL ABI msmatch; driver expects 0x4050400, HAL reports 0x4030601
ACPI: Battery Slot [BAT0] (battery present)
ACPI: AC Adapter [AC] (on-line)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THM0] (49 C)
cs: IO port probe 0x0100-0x04ff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
[drm] Loading R200 Microcode
drivers/usb/host/ehci-sched.c: scheduled qh df517200 usecs 8/15 period 8.0 starting 6.0 (gap 1)
drivers/usb/host/ehci-sched.c: descheduled qh df517200, period = 8 frame = 1030 count = 2, urbs = 1
drivers/usb/host/ehci-sched.c: reused previous qh df517200 schedule
drivers/usb/host/ehci-sched.c: scheduled qh df517200 usecs 8/15 period 8.0 starting 6.0 (gap 1)

--Boundary_(ID_xqtFj7LrLlCkVSc9H7x5lw)
Content-type: text/plain; charset=iso-8859-15; name=dmesg-2.6.7-mm2
Content-transfer-encoding: 8BIT
Content-disposition: inline; filename=dmesg-2.6.7-mm2

Linux version 2.6.7-mm2 (root@t40) (gcc version 3.3.4 (Debian)) #2 Fri Jun 25 03:58:34 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff60000 (usable)
 BIOS-e820: 000000001ff60000 - 000000001ff77000 (ACPI data)
 BIOS-e820: 000000001ff77000 - 000000001ff79000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130912
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126816 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v002 IBM                                       ) @ 0x000f6e00
ACPI: XSDT (v001 IBM    TP-1R    0x00003051  LTP 0x00000000) @ 0x1ff6af83
ACPI: FADT (v003 IBM    TP-1R    0x00003051 IBM  0x00000001) @ 0x1ff6b000
ACPI: SSDT (v001 IBM    TP-1R    0x00003051 MSFT 0x0100000e) @ 0x1ff6b1b4
ACPI: ECDT (v001 IBM    TP-1R    0x00003051 IBM  0x00000001) @ 0x1ff76e06
ACPI: TCPA (v001 IBM    TP-1R    0x00003051 PTL  0x00000001) @ 0x1ff76e58
ACPI: BOOT (v001 IBM    TP-1R    0x00003051  LTP 0x00000001) @ 0x1ff76fd8
ACPI: DSDT (v001 IBM    TP-1R    0x00003051 MSFT 0x0100000e) @ 0x00000000
Built 1 zonelists
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Kernel command line: BOOT_IMAGE=Linux2.6.7-mm2 ro root=306 quiet
CPU 0 irqstacks, hard=c0504000 soft=c0503000
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1595.030 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 512552k/523648k available (2726k kernel code, 10328k reserved, 1193k data, 176k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3153.92 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU:     After vendor identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU:     After all inits, caps: a7e9fbbf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1600MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1594.0510 MHz.
..... host bus clock speed is 99.0656 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=8
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040615
    ACPI-0291: *** Info: Table [DSDT] replaced by host OS
ACPI: IRQ9 SCI: Level Trigger.
ACPI: Found ECDT
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 28)
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f6e30
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xb699, dseg 0x400
pnp: 00:0b: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0b: ioport range 0x1000-0x105f has been reserved
pnp: 00:0b: ioport range 0x1060-0x107f has been reserved
pnp: 00:0b: ioport range 0x1180-0x11bf has been reserved
PnPBIOS: 19 nodes reported by PnP BIOS; 19 recorded by driver
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:02:00.1[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
NET: Registered protocol family 23
Bluetooth: Core ver 2.5
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 9 (level, low) -> IRQ 9
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=252.00 Mhz, System=200.00 MHz
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: SXGA+ Single (85MHz)    
radeonfb: detected LVDS panel size from BIOS: 1400x1050
radeondb: BIOS provided dividers will be used
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB
Simple Boot Flag at 0x35 set to 0x1
Machine check exception polling timer started.
IBM machine detected. Enabling interrupts during APM calls.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
udf: registering filesystem
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 175x65
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xd0000000
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9]
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
pnp: Device 00:12 activated.
ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x3bc (0x7bc), irq 7, dma 1 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
lp0: using parport0 (interrupt-driven).
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
NET: Registered protocol family 24
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATCS05-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: UJDA745 DVD/CDRW, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/7898KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 > hda4
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 9 (level, low) -> IRQ 9
Yenta: CardBus bridge found at 0000:02:00.0 [1014:0512]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:00.0, mfunc 0x01d21022, devctl 0x64
Yenta: ISA IRQ mask 0x0078, PCI irq 9
Socket status: 30000006
ACPI: PCI interrupt 0000:02:00.1[B] -> GSI 10 (level, low) -> IRQ 10
Yenta: CardBus bridge found at 0000:02:00.1 [1014:0512]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:00.1, mfunc 0x01d21022, devctl 0x64
Yenta: ISA IRQ mask 0x0078, PCI irq 10
Socket status: 30000006
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 44
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
 -> pass-through port
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: Synaptics pass-through port at isa0060/serio1/input0
input: PS/2 Generic Mouse on synaptics-pt/serio0
input: PC Speaker
Advanced Linux Sound Architecture Driver Version 1.0.5 (Sun May 30 10:49:40 2004 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
IrCOMM protocol (Dag Brattli)
Bluetooth: L2CAP ver 2.2
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.3
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM ver 1.3
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.0
Bluetooth: BNEP filters: protocol multicast
speedstep-centrino: found "Intel(R) Pentium(R) M processor 1600MHz": max frequency: 1600000kHz
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 176k freed
Adding 498920k swap on /dev/hda5.  Priority:-1 extents:1
EXT3 FS on hda6, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 600 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 600 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB (ICH4) USB UHCI #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 9, io base 00001800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: detected 2 ports
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: Intel Corp. 82801DB (ICH4) USB UHCI #1
usb usb1: Manufacturer: Linux 2.6.7-mm2 uhci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB (ICH4) USB UHCI #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 10, io base 00001820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: detected 2 ports
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: default language 0x0409
usb usb2: Product: Intel Corp. 82801DB (ICH4) USB UHCI #2
usb usb2: Manufacturer: Linux 2.6.7-mm2 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.1
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB (ICH4) USB UHCI #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 11, io base 00001840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: detected 2 ports
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: default language 0x0409
usb usb3: Product: Intel Corp. 82801DB (ICH4) USB UHCI #3
usb usb3: Manufacturer: Linux 2.6.7-mm2 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.2
usb usb3: hotplug
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: individual port over-current protection
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: local power source is good
uhci_hcd 0000:00:1d.1: port 1 portsc 0093
hub 2-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
usb 2-1: new full speed USB device using address 2
usb 2-1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1: hotplug
usb 2-1: adding 2-1:1.0 (config #1, interface 0)
usb 2-1:1.0: hotplug
hub 2-1:1.0: usb_probe_interface
hub 2-1:1.0: usb_probe_interface - got id
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 4 ports detected
hub 2-1:1.0: standalone hub
hub 2-1:1.0: individual port power switching
hub 2-1:1.0: individual port over-current protection
hub 2-1:1.0: Port indicators are supported
hub 2-1:1.0: power on to power good time: 100ms
hub 2-1:1.0: local power source is good
hub 2-1:1.0: enabling power on all ports
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: reset hcs_params 0x103206 dbg=1 cc=3 pcc=2 ordered !ppc ports=6
ehci_hcd 0000:00:1d.7: reset hcc_params 6871 thresh 7 uframes 1024 64 bit addr
ehci_hcd 0000:00:1d.7: capability 0001 at 68
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 10, pci mem e18a5000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:1d.7: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: init command 010001 (park)=0 ithresh=1 period=1024 RUN
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
ehci_hcd 0000:00:1d.7: supports USB remote wakeup
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: default language 0x0409
usb usb4: Product: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
usb usb4: Manufacturer: Linux 2.6.7-mm2 ehci_hcd
usb usb4: SerialNumber: 0000:00:1d.7
usb usb4: hotplug
uhci_hcd 0000:00:1d.1: port 1 portsc 008a
hub 2-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
usb 2-1: USB disconnect, address 2
usb 2-1: usb_disable_device nuking all URBs
uhci_hcd 0000:00:1d.1: shutdown urb dfd45280 pipe 40408280 ep1in-intr
usb usb4: adding 4-0:1.0 (config #1, interface 0)
usb 4-0:1.0: hotplug
usb 2-1: unregistering interface 2-1:1.0
usb 2-1:1.0: hotplug
usb 2-1: unregistering device
usb 2-1: hotplug
hub 4-0:1.0: usb_probe_interface
hub 4-0:1.0: usb_probe_interface - got id
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
hub 4-0:1.0: standalone hub
hub 4-0:1.0: ganged power switching
hub 4-0:1.0: individual port over-current protection
hub 4-0:1.0: Single TT
hub 4-0:1.0: TT requires at most 8 FS bit times
hub 4-0:1.0: power on to power good time: 20ms
hub 4-0:1.0: local power source is good
hub 4-0:1.0: enabling power on all ports
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001803 POWER sig=j  CSC CONNECT
hub 4-0:1.0: port 3, status 0501, change 0001, 480 Mb/s
hub 4-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x501
hub 4-0:1.0: port 3 not reset yet, waiting 50ms
ehci_hcd 0000:00:1d.7: port 3 high speed
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001005 POWER sig=se0  PE CONNECT
usb 4-3: new high speed USB device using address 2
usb 4-3: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 4-3: hotplug
usb 4-3: adding 4-3:1.0 (config #1, interface 0)
usb 4-3:1.0: hotplug
hub 4-3:1.0: usb_probe_interface
hub 4-3:1.0: usb_probe_interface - got id
hub 4-3:1.0: USB hub found
hub 4-3:1.0: 4 ports detected
hub 4-3:1.0: standalone hub
hub 4-3:1.0: individual port power switching
hub 4-3:1.0: individual port over-current protection
hub 4-3:1.0: TT per port
hub 4-3:1.0: TT requires at most 8 FS bit times
hub 4-3:1.0: Port indicators are supported
hub 4-3:1.0: power on to power good time: 100ms
hub 4-3:1.0: local power source is good
drivers/usb/host/ehci-sched.c: scheduled qh df381100 usecs 7/0 period 256.0 starting 255.0 (gap 0)
hub 4-3:1.0: enabling power on all ports
hub 4-3:1.0: port 3, status 0301, change 0001, 1.5 Mb/s
uhci_hcd 0000:00:1d.0: suspend_hc
hub 4-3:1.0: debounce: port 3: total 100ms stable 100ms status 0x301
uhci_hcd 0000:00:1d.1: suspend_hc
usb 4-3.3: new low speed USB device using address 3
usb 4-3.3: skipped 1 descriptor after interface
usb 4-3.3: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 4-3.3: default language 0x0409
usb 4-3.3: Product: Microsoft IntelliMouse® Explorer
usb 4-3.3: Manufacturer: Microsoft
usb 4-3.3: hotplug
usb 4-3.3: adding 4-3.3:1.0 (config #1, interface 0)
usb 4-3.3:1.0: hotplug
uhci_hcd 0000:00:1d.2: suspend_hc
intel8x0_measure_ac97_clock: measured 79374 usecs
intel8x0: clocking to 48000
usbcore: registered new driver hiddev
usbhid 4-3.3:1.0: usb_probe_interface
usbhid 4-3.3:1.0: usb_probe_interface - got id
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Explorer] on usb-0000:00:1d.7-3.3
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.6 to 64
e1000: Ignoring new-style parameters in presence of obsolete ones
Intel(R) PRO/1000 Network Driver - version 5.2.52-k4
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 9 (level, low) -> IRQ 9
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: Battery Slot [BAT0] (battery present)
ACPI: AC Adapter [AC] (on-line)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THM0] (49 C)
cs: IO port probe 0x0100-0x04ff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
[drm] Loading R200 Microcode
drivers/usb/host/ehci-sched.c: scheduled qh df381200 usecs 8/15 period 8.0 starting 6.0 (gap 1)
drivers/usb/host/ehci-sched.c: descheduled qh df381200, period = 8 frame = 1030 count = 2, urbs = 1
drivers/usb/host/ehci-sched.c: reused previous qh df381200 schedule
drivers/usb/host/ehci-sched.c: scheduled qh df381200 usecs 8/15 period 8.0 starting 6.0 (gap 1)

--Boundary_(ID_xqtFj7LrLlCkVSc9H7x5lw)--
