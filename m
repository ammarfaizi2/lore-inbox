Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286934AbSA2XaY>; Tue, 29 Jan 2002 18:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287106AbSA2X3O>; Tue, 29 Jan 2002 18:29:14 -0500
Received: from yoda.edvz.uni-linz.ac.at ([140.78.3.63]:22979 "EHLO
	yoda.edvz.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S286895AbSA2X1z>; Tue, 29 Jan 2002 18:27:55 -0500
Reply-To: <k0156448@students.jku.at>
From: "Markus Jordan" <k0156448@students.jku.at>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: lost interrupt
Date: Wed, 30 Jan 2002 00:27:15 +0100
Message-ID: <000001c1a91c$7fcb8fb0$b121abc1@compus>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] I get the message " hda: lost interrupt" at the startup of the
kernel
[2.] 

PCI: using IRQ 14 for Device 00:07.5
PCI: routing conflict for 00:0C.1, have IRQ 10, want IRQ 14
....
....
....
hda: FUJITSU, MHN2300AT, ATA Disk Drive
hda: IRQ Probe failed ( 0xfffffff8)
hdb: IRQ Probe failed ( 0xfffffff8)
hdb: IRQ Probe failed ( 0xfffffff8)
hdc: is the CD-ROM - Drive, right checked
ide0 at 0x1f0-0x1f7, 0x3f6 on IRG 14
ide1 at 0x170-0x177, 0x376 on IRG 15
hda: information about sectors, are right
Partition Check
hda:had: lost interrupt
had: lost interrupt
had: lost interrupt
had: lost interrupt
hda1 hda2 hda3 hda4 < had: lost interrupt
hda5 had: lost interrupt
hda6 had: lost interrupt
hda7 had: lost interrupt
hda8>
...
...
...
after "freeing unused Kernel memory :  208K "
"had: lost interrupt" appears often, it doesn't go on any further


So the kernel doesn't start. The only way to boot is a Suse CD-Rom with
a kernelversion of 2.2.18, break the installation, and start the kernel
2.4.17 with that system.


[3.] harddisk, IRQ - problem, 
[4.] at the moment 2.4.17, but it also appears in 2.4.12
[7.]
[7.1.] 

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux Computix 2.2.18 #1 Wed Jan 24 12:28:55 GMT 2001 i686 unknown
 
Gnu C                  2.95.2
Gnu make               3.78.1
binutils               2.9.5.0.37
util-linux             
util-linux             Note: /usr/bin/fdformat is obsolete and is no
longer available.
util-linux             Please use /usr/bin/superformat instead (make
sure you have the 
util-linux             fdutils package installed first).  Also, there
had been some
util-linux             major changes from version 4.x.  Please refer to
the documentation.
util-linux             
mount                  2.10f
modutils               2.4.6
e2fsprogs              1.18
pcmcia-cs              3.1.8
PPP                    2.3.11
Linux C Library        2.1.3
ldd: version 1.9.11
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         lp parport_pc parport ds i82365 pcmcia_core
mousedev keybdev hid input usb-uhci usbcore 8390 nvram

[7.2.] nothing in there ( It is Pentium III / 1200 Mhz )
[7.3.] nothing in there
[7.4.] nothing in ioports, iomem doesn't exist
[7.5.]

00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev
c4)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0 set
	Region 0: Memory at e8000000 (32-bit, prefetchable)
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=421
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=4
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0 set
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: e0000000-e00fffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Communication controller: Lucent Microelectronics: Unknown
device 0450
	Subsystem: Askey Computer Corp.: Unknown device 4005
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fbefab00 (32-bit, non-prefetchable)
	Region 1: I/O ports at fff0
	Region 2: I/O ports at f800
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- AuxPwr+ DSI+ D1+ D2+ PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev
40)
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Region 4: I/O ports at 1000
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 1a)
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at 1020
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 40)
	Subsystem: VIA Technologies, Inc.: Unknown device 3057
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686
[Apollo Super AC97/Audio] (rev 50)
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1840
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 0
	Region 0: I/O ports at 1400
	Region 1: I/O ports at 1014
	Region 2: I/O ports at 1010
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Accton Technology Corporation: Unknown
device 1216 (rev 11)
	Subsystem: Accton Technology Corporation: Unknown device 2242
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at f900
	Region 1: Memory at fbefac00 (32-bit, non-prefetchable)
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME+
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 CardBus bridge: O2 Micro, Inc.: Unknown device 6933 (rev 01)
	Subsystem: O2 Micro, Inc.: Unknown device 6933
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 168 set
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 20000000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=20, subordinate=22, sec-latency=176
Memory window 0: 00000000-00000000
Memory window 1: 00000000-00000000
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+
PostWrite+
	16-bit legacy interface ports at 0087

00:0c.1 CardBus bridge: O2 Micro, Inc.: Unknown device 6933 (rev 01)
	Subsystem: O2 Micro, Inc.: Unknown device 6933
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 168 set
	Interrupt: pin B routed to IRQ 10
	Region 0: Memory at 20001000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=23, subordinate=25, sec-latency=176
Memory window 0: 00000000-00000000
Memory window 1: 00000000-00000000
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+
PostWrite+
	16-bit legacy interface ports at 0087

00:0d.0 FireWire (IEEE 1394): Lucent Microelectronics: Unknown device
5811 (rev 04) (prog-if 10 [OHCI])
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1881
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at ffeff000 (32-bit, non-prefetchable)
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME+
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device
4c59 (prog-if 00 [VGA])
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1930
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at f0000000 (32-bit, prefetchable)
	Region 1: I/O ports at 9000
	Region 2: Memory at e0000000 (32-bit, non-prefetchable)
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=421
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=4
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-



[7.6.] nothing in there
[7.7.] I didn't found any informations in /proc, except the mtrr, but
that isn't useful, I think.

I don't exactly know if this is really a kernel bug or if I have some
wrong configurations. If the latter one is true, I hope you could give
me some advice. 
If you had any further question, I will give you as much information as
I can.

Yours, Grateful

Markus Jordan
Computix@gmx.at
>From Linz, Austria




