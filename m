Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbTFJXHP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 19:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbTFJXHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 19:07:15 -0400
Received: from mout2.freenet.de ([194.97.50.155]:21951 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S261568AbTFJXHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 19:07:01 -0400
From: Andreas Hartmann <andihartmann@freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: [2.4.21rc7] big problems with DMA on via KT333 board
Date: Wed, 11 Jun 2003 01:26:39 +0200
Organization: privat
Message-ID: <bc5pff$6vp$1@ID-44327.news.dfncis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: susi.maya.org 1055287599 7161 192.168.1.3 (10 Jun 2003 23:26:39 GMT)
X-Complaints-To: abuse@fu-berlin.de
User-Agent: KNode/0.7.2
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

there are a lot of problems with this kernel on KT333 boards. This kernel
can't be called stable at all. Sorry.

The last problem I saw was this problem during writing datas to the hd
coming via nfs:

Jun 11 00:31:16 athlon kernel: hda: dma_timer_expiry: dma status == 0x61
Jun 11 00:31:30 athlon kernel: hda: timeout waiting for DMA
Jun 11 00:31:30 athlon kernel: hda: timeout waiting for DMA
Jun 11 00:31:30 athlon kernel: hda: (__ide_dma_test_irq) called while not
waiting
Jun 11 00:31:30 athlon kernel: hda: status error: status=0x51 { DriveReady
SeekComplete Error }
Jun 11 00:31:30 athlon kernel: hda: status error: error=0x04 {
DriveStatusError }
Jun 11 00:31:30 athlon kernel: hda: no DRQ after issuing MULTWRITE
Jun 11 00:31:30 athlon kernel: hda: status error: status=0x51 { DriveReady
SeekComplete Error }
Jun 11 00:31:30 athlon kernel: hda: status error: error=0x04 {
DriveStatusError }
Jun 11 00:31:30 athlon kernel: hda: no DRQ after issuing MULTWRITE
Jun 11 00:31:30 athlon kernel: via_audio: ignoring drain playback error -11
Jun 11 00:31:30 athlon kernel: hda: status error: status=0x51 { DriveReady
SeekComplete Error }
Jun 11 00:31:30 athlon kernel: hda: status error: error=0x04 {
DriveStatusError }
Jun 11 00:31:30 athlon kernel: hda: no DRQ after issuing MULTWRITE
Jun 11 00:31:30 athlon kernel: hda: status error: status=0x51 { DriveReady
SeekComplete Error }
Jun 11 00:31:30 athlon kernel: hda: status error: error=0x04 {
DriveStatusError }
Jun 11 00:31:30 athlon kernel: hdb: DMA disabled
Jun 11 00:31:30 athlon kernel: hda: no DRQ after issuing WRITE
Jun 11 00:31:30 athlon kernel: ide0: reset: success
Jun 11 00:31:30 athlon kernel: blk: queue c029e0e0, I/O limit 4095Mb (mask
0xffffffff)
Jun 11 00:31:50 athlon kernel: hda: dma_timer_expiry: dma status == 0x21
Jun 11 00:32:05 athlon kernel: hda: timeout waiting for DMA
Jun 11 00:32:05 athlon kernel: hda: timeout waiting for DMA
Jun 11 00:32:05 athlon kernel: hda: (__ide_dma_test_irq) called while not
waiting
Jun 11 00:32:05 athlon kernel: hda: status error: status=0x58 { DriveReady
SeekComplete DataRequest }
Jun 11 00:32:05 athlon kernel:
Jun 11 00:32:05 athlon kernel: hda: drive not ready for command
Jun 11 00:32:05 athlon kernel: hda: status timeout: status=0xd0 { Busy }
Jun 11 00:32:05 athlon kernel:
Jun 11 00:32:05 athlon kernel: hda: drive not ready for command
Jun 11 00:32:05 athlon kernel: ide0: reset: success
Jun 11 00:32:25 athlon kernel: hda: dma_timer_expiry: dma status == 0x21
Jun 11 00:32:40 athlon kernel: hda: timeout waiting for DMA
Jun 11 00:32:40 athlon kernel: hda: timeout waiting for DMA
Jun 11 00:32:40 athlon kernel: hda: (__ide_dma_test_irq) called while not
waiting
Jun 11 00:32:40 athlon kernel: hda: status error: status=0x58 { DriveReady
SeekComplete DataRequest }
Jun 11 00:32:40 athlon kernel:
Jun 11 00:32:40 athlon kernel: hda: drive not ready for command
Jun 11 00:32:40 athlon kernel: hda: status timeout: status=0xd0 { Busy }
Jun 11 00:32:40 athlon kernel:
Jun 11 00:32:40 athlon kernel: hda: drive not ready for command
Jun 11 00:32:40 athlon kernel: ide0: reset: success
Jun 11 00:33:00 athlon kernel: hda: dma_timer_expiry: dma status == 0x21
Jun 11 00:33:15 athlon kernel: hda: timeout waiting for DMA
Jun 11 00:33:15 athlon kernel: hda: timeout waiting for DMA
Jun 11 00:33:15 athlon kernel: hda: (__ide_dma_test_irq) called while not
waiting
Jun 11 00:33:15 athlon kernel: hda: status error: status=0x58 { DriveReady
SeekComplete DataRequest }
Jun 11 00:33:15 athlon kernel:
Jun 11 00:33:15 athlon kernel: hda: drive not ready for command
Jun 11 00:33:15 athlon kernel: hda: status timeout: status=0xd0 { Busy }
Jun 11 00:33:15 athlon kernel:
Jun 11 00:33:15 athlon kernel: hda: drive not ready for command
Jun 11 00:33:15 athlon kernel: ide0: reset: success

During this time, the machine seemed to be dead. It reacts to nothing.


Afterwards, the hd had the following config:
/dev/hda:
 multcount    = 0 (off)
 I/O support  =  0 (32-bit)
 unmaskirq    =  0 (on)
 using_dma    =  0 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2494/255/63, sectors = 40079088, start = 0

The systemload was very high while copying after this great hang. 
It took a long time too to get this information from hdparm - I really
thought, the machine would be dead again.


this should be:

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2494/255/63, sectors = 40079088, start = 0

I had to reboot to get this config running again because reconfigure didn't
work at all.


The other problem I reported some days ago: APIC is unuseable too (sound is
broken).
I tested therefore 2.4.21rc7-ac1: this kernel is totally broken when using
sound. The module crashes and the screen doesn't stop with printing kernel
oops'es. One logentry I found was in /var/log/messages:
Jun  8 20:10:49 athlon kernel: Unable to handle kernel paging request at
virtual address 2deb2120
Jun  10 20:10:49 athlon kernel:  printing eip:
Jun  10 20:10:49 athlon kernel: df3de02b
Jun  10 20:10:49 athlon kernel: *pde = 00000000
Jun  10 20:10:49 athlon kernel: Oops: 0000
Jun  10 20:10:49 athlon kernel: CPU:    0

The sound-modules (ac97_codec, via82cxxx_audio) crashed during initializing
no matter if APIC was activated or not.


00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333
AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: dc000000-ddffffff
        Prefetchable memory behind bridge: d8000000-dbffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100
Ethernet (rev 02)
        Subsystem: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (13000ns min, 2750ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d000 [size=256]
        Region 1: Memory at df022000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d400 [size=256]
        Region 1: Memory at df020000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:0c.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
0c)
        Subsystem: Intel Corp. EtherExpress PRO/100 S Desktop Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at df021000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at d800 [size=64]
        Region 2: Memory at df000000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. USB
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. USB
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 5
        Region 4: I/O ports at e000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. USB
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin C routed to IRQ 11
        Region 4: I/O ports at e400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20
[EHCI])
        Subsystem: VIA Technologies, Inc. USB 2.0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 0: Memory at df023000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
        Subsystem: VIA Technologies, Inc. VT8235 ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc.
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at e800 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235
AC97 Audio Controller (rev 50)
        Subsystem: Unknown device 1695:3005
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 11
        Region 0: I/O ports at ec00 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO AGP
4x TMDS (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage Fury Pro/Xpert 2000 Pro
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
        Region 1: I/O ports at c000 [size=256]
        Region 2: Memory at dd000000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



Kind regards,
Andreas Hartmann
