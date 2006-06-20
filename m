Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWFTTx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWFTTx3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 15:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWFTTx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 15:53:29 -0400
Received: from web52915.mail.yahoo.com ([206.190.49.25]:15190 "HELO
	web52915.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750816AbWFTTx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 15:53:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=0nuVDEUqE+kWWKn4fegLID90JLnwxLQ5y8ugdfhsfHPcaPfyhwlW4Ckh4tSiZ++Msoxdqe8y19Uwt6Ww3Ow2XFKUuR7vMamvYEspzDVChlfmhWmAROsxSptE57o3cCNDAzzs8H7quTkM/M2+5wtXM6tj3cfTQCGfgeD0uTuTcyg=  ;
Message-ID: <20060620195327.22016.qmail@web52915.mail.yahoo.com>
Date: Tue, 20 Jun 2006 20:53:27 +0100 (BST)
From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Linux 2.6.17: PM-Timer bug warning?
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060620084145.GA29378@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas,

I ran that test-app as "root", and saw this:

# ./pmtmr_test 0x808
0
100000
200000
300000
400000
500000
600000
700000
800000
900000
1000000
1100000
1200000
1300000
1400000
1500000
1600000
1700000
1800000
1900000
2000000
2100000
2200000
2300000
2400000
2500000
2600000
2700000
2800000
2900000
3000000
3100000
3200000
3300000
3400000
3500000
3600000
3700000
3800000
3900000
4000000
4100000
4200000
4300000
4400000
4500000
4600000
4700000
4800000
4900000
5000000
5100000
5200000
5300000
5400000
5500000
5600000
5700000
5800000
5900000
6000000
6100000
6200000
6300000
6400000
6500000
6600000
6700000
6800000
6900000
7000000
7100000
7200000
7300000
7400000
7500000
7600000
7700000
7800000
7900000
8000000
8100000
8200000
8300000
8400000
8500000
8600000
8700000
8800000
8900000
9000000
9100000
9200000
9300000
9400000
9500000
9600000
9700000
9800000
9900000

I'm thinking that this is a Good Thing :-). So here's the full PCI output of my Dell (Precision
650):

# lspci -vvvn
00:00.0 0600: 8086:2550 (rev 03)
        Subsystem: 1028:012c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+
FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR-
<PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [40] Vendor Specific Information
        Capabilities: [a0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+
Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
00:01.0 0604: 8086:2552 (rev 03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+
FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR-
<PERR-
        Latency: 64
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: ff800000-ff9fffff
        Prefetchable memory behind bridge: e8000000-f7ffffff
        Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR-
<PERR-
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [60] #0e [0035]

00:02.0 0604: 8086:2553 (rev 03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+
FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR-
<PERR-
        Latency: 64
        Bus: primary=00, secondary=02, subordinate=04, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: ff400000-ff7fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR-
<PERR-
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1d.0 0c03: 8086:24c2 (rev 01)
        Subsystem: 1028:012c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 17
        Region 4: I/O ports at ff80 [size=32]

00:1d.1 0c03: 8086:24c4 (rev 01)
        Subsystem: 1028:012c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 18
        Region 4: I/O ports at ff60 [size=32]

00:1d.2 0c03: 8086:24c7 (rev 01)
        Subsystem: 1028:012c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 16
        Region 4: I/O ports at ff40 [size=32]

00:1d.7 0c03: 8086:24cd (rev 01) (prog-if 20)
        Subsystem: 1028:012c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+
FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 21
        Region 0: Memory at ffa20800 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Debug port

00:1e.0 0604: 8086:244e (rev 81)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+
FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR-
<PERR-
        Latency: 0
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: ff200000-ff3fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR-
<PERR-
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 0601: 8086:24c0 (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR-
FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR-
        Latency: 0

00:1f.1 0101: 8086:24cb (rev 01) (prog-if 8a)
        Subsystem: 1028:012c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at ffa0 [size=16]
        Region 5: Memory at 50000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 0c05: 8086:24c3 (rev 01)
        Subsystem: 1028:012c
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR-
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at bc80 [size=32]

00:1f.5 0401: 8086:24c5 (rev 01)
        Subsystem: 1028:012c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 22
        Region 0: I/O ports at b800 [size=256]
        Region 1: I/O ports at bc40 [size=64]
        Region 2: Memory at ffa20400 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at ffa20000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 0300: 1002:5961 (rev 01)
        Subsystem: 174b:7c13
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+
FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR-
        Latency: 64 (2000ns min), Cache Line Size 10
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at ec00 [size=256]
        Region 2: Memory at ff8f0000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at ff800000 [disabled] [size=128K]
        Capabilities: [58] AGP version 3.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+
Rate=x4,x8
                Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.1 0380: 1002:5941 (rev 01)
        Subsystem: 174b:7c12
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR-
        Latency: 64 (2000ns min), Cache Line Size 10
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at ff8e0000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:1c.0 0800: 8086:1461 (rev 04) (prog-if 20)
        Subsystem: 1028:012c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+
FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR-
<PERR-
        Latency: 0
        Region 0: Memory at ff4ff000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] PCI-X non-bridge device
                Command: DPERE- ERO- RBC=512 OST=1
                Status: Dev=02:1c.0 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=512 DMOST=1 DMCRS=8
RSCEM- 266MHz- 533MHz-

02:1d.0 0604: 8086:1460 (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+
FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR-
<PERR-
        Latency: 64, Cache Line Size 10
        Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: ff600000-ff7fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR-
<PERR-
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] PCI-X bridge device
                Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=100MHz               
Status: Dev=02:1d.0 64bit+ 133MHz+ SCD- USC- SCO- SRD-
                Upstream: Capacity=65535 CommitmentLimit=65535
                Downstream: Capacity=65535 CommitmentLimit=65535

02:1e.0 0800: 8086:1461 (rev 04) (prog-if 20)
        Subsystem: 1028:012c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+
FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR-
<PERR-
        Latency: 0
        Region 0: Memory at ff4fe000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] PCI-X non-bridge device
                Command: DPERE- ERO- RBC=512 OST=1
                Status: Dev=02:1e.0 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=512 DMOST=1 DMCRS=8
RSCEM- 266MHz- 533MHz-

02:1f.0 0604: 8086:1460 (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+
FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR-
<PERR-
        Latency: 64, Cache Line Size 10
        Bus: primary=02, secondary=04, subordinate=04, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR-
<PERR-
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] PCI-X bridge device
                Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=100MHz               
Status: Dev=02:1f.0 64bit+ 133MHz+ SCD- USC- SCO- SRD-
                Upstream: Capacity=65535 CommitmentLimit=65535
                Downstream: Capacity=65535 CommitmentLimit=65535

And the summary:

# lspci
00:00.0 Host bridge: Intel Corporation E7505 Memory Controller Hub (rev 03)
00:01.0 PCI bridge: Intel Corporation E7505/E7205 PCI-to-AGP Bridge (rev 03)
00:02.0 PCI bridge: Intel Corporation E7505 Hub Interface B PCI-to-PCI Bridge (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller
#1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller
#2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller
#3 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corporation 82801DB/DBL (ICH4/ICH4-L) LPC Interface Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801DB (ICH4) IDE Controller (rev 01)
00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 01)
00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97
Audio Controller (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200] (rev 01)
01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200] (Secondary) (rev 01)
02:1c.0 PIC: Intel Corporation 82870P2 P64H2 I/OxAPIC (rev 04)
02:1d.0 PCI bridge: Intel Corporation 82870P2 P64H2 Hub PCI Bridge (rev 04)
02:1e.0 PIC: Intel Corporation 82870P2 P64H2 I/OxAPIC (rev 04)
02:1f.0 PCI bridge: Intel Corporation 82870P2 P64H2 Hub PCI Bridge (rev 04)

And the ACPI table stuff from the dmesg log:

Linux version 2.6.17 (chris@volcano.underworld) (gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)) #2
SMP PREEMPT Mon Jun 19 10:38:36 BST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff75000 (usable)
 BIOS-e820: 000000003ff75000 - 000000003ff77000 (ACPI NVS)
 BIOS-e820: 000000003ff77000 - 000000003ff98000 (ACPI data)
 BIOS-e820: 000000003ff98000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
On node 0 totalpages: 262005
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32629 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000febc0
ACPI: RSDT (v001 DELL    WS 650  0x00000008 ASL  0x00000061) @ 0x000fd4d9
ACPI: FADT (v001 DELL    WS 650  0x00000008 ASL  0x00000061) @ 0x000fd511
ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 0xfffefa6f
ACPI: MADT (v001 DELL    WS 650  0x00000008 ASL  0x00000061) @ 0x000fd585
ACPI: BOOT (v001 DELL    WS 650  0x00000008 ASL  0x00000061) @ 0x000fd609
ACPI: ASF! (v016 DELL    WS 650  0x00000008 ASL  0x00000061) @ 0x000fd631
ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000

Let me know if there's anything else,
Cheers,
Chris



		
___________________________________________________________ 
Try the all-new Yahoo! Mail. "The New Version is radically easier to use" – The Wall Street Journal 
http://uk.docs.yahoo.com/nowyoucan.html
