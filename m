Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264602AbUBIDKv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 22:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbUBIDKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 22:10:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:33741 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264602AbUBIDKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 22:10:40 -0500
Date: Sun, 8 Feb 2004 19:08:12 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Matthew Caron <matt@mattcaron.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2 PROBLEMs: mkinitrd fails during make install (2.6.1) + first
 network connect fails after boot (2.6.1)
Message-Id: <20040208190812.07703fce.rddunlap@osdl.org>
In-Reply-To: <40268B01.10608@mattcaron.net>
References: <40268B01.10608@mattcaron.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 08 Feb 2004 14:16:17 -0500 Matthew Caron <matt@mattcaron.net> wrote:

| PROBLEM 1:
| 
| 1. Summary:
| 	mkinitrd fails during make install (2.6.1)
| 
| 2. Description:
| 	mkinitrd fails with error:
| 
| No module 3w-xxxx found for kernel 2.6.1
| mkinitrd failed
| make[1]: *** [install] Error 1
| make: *** [install] Error 2
| 
| config command was: 'make xconfig'
| build command was: 'make clean modules_install install'

What version of mkinitrd?  Please send output from 'mkinitrd --version'.
Latest version seems to be 3.5.18.

| 3. Keywords:
| 	2.6.1 mkinitrd 3w-xxxx
| 
| 4. Kernel Version:
| Linux version 2.6.1 (root@localhost.localdomain) (gcc version 3.3.2 
| 20031022 (Red Hat Linux 3.3.2-1)) #4 Sun Feb 8 00:38:13 EST 2004
| 
| 5. Oops:
| 	None
| 
| 6. Trigger:
| 	config included below:
[snipped]



Wow, I almost missed prob. 2.  Probably better as separate postings.


| PROBLEM 2:
| 
| 1. Summary:
| 	first network connect fails after boot
| 
| 2. Description:
| 	The first connection to any host on any port fails after boot/reboot. 
| Subsequent connects work fine. Typical errors are:
| 
| ssh: connect to host foobar port 22: Resource temporarily unavailable
| 
| Firebird reports "Document Contains No Data"
| 
| 3. Keywords:
| 	2.6.1 network connection failure
| 
| 4. Kernel Version:
| Linux version 2.6.1 (root@case) (gcc version 3.3.2 20031022 (Red Hat 
| Linux 3.3.2-1)) #9 SMP Sun Feb 8 12:55:51 EST 2004
| 
| 5. Oops:
| 	None
| 
| 6. Trigger:
| 	ssh-ing to something shows the problem quite well.
| 	config included below:
[snipped]

| 7. Environment:
| 7.1 Software:
| Linux case 2.6.1 #9 SMP Sun Feb 8 12:55:51 EST 2004 i686 athlon i386 
| GNU/Linux
| 
| Gnu C                  3.3.2
| Gnu make               3.79.1
| util-linux             2.11y
| mount                  2.11y
| module-init-tools      2.4.25
| e2fsprogs              1.34
| jfsutils               1.1.3
| reiserfsprogs          3.6.8
| pcmcia-cs              3.1.31
| quota-tools            3.06.
| PPP                    2.4.1
| nfs-utils              1.0.6
| Linux C Library        2.3.2
| Dynamic linker (ldd)   2.3.2
| Procps                 2.0.17
| Net-tools              1.60
| Kbd                    1.08
| Sh-utils               5.0
| Modules Loaded
| 
| 7.2 Processor:
| processor       : 0
| vendor_id       : AuthenticAMD
| cpu family      : 6
| model           : 6
| model name      : AMD Athlon(tm) Processor
| stepping        : 2
| cpu MHz         : 1000.490
| cache size      : 256 KB
| fdiv_bug        : no
| hlt_bug         : no
| f00f_bug        : no
| coma_bug        : no
| fpu             : yes
| fpu_exception   : yes
| cpuid level     : 1
| wp              : yes
| flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
| mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
| bogomips        : 1966.08
| 
| processor       : 1
| vendor_id       : AuthenticAMD
| cpu family      : 6
| model           : 6
| model name      : AMD Athlon(tm) Processor
| stepping        : 2
| cpu MHz         : 1000.490
| cache size      : 256 KB
| fdiv_bug        : no
| hlt_bug         : no
| f00f_bug        : no
| coma_bug        : no
| fpu             : yes
| fpu_exception   : yes
| cpuid level     : 1
| wp              : yes
| flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
| mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
| bogomips        : 1998.84
| 
| 7.3 Module Info:
| 	(none)
| 
| 7.4: Driver/Hardware:
| /proc/ioports:
| 0000-001f : dma1
| 0020-0021 : pic1
| 0040-005f : timer
| 0060-006f : keyboard
| 0070-0077 : rtc
| 0080-008f : dma page reg
| 00a0-00a1 : pic2
| 00c0-00df : dma2
| 00f0-00ff : fpu
| 0170-0177 : ide1
| 01f0-01f7 : ide0
| 02f8-02ff : serial
| 0376-0376 : ide1
| 0378-037a : parport0
| 037b-037f : parport0
| 03c0-03df : vga+
| 03f6-03f6 : ide0
| 03f8-03ff : serial
| 0cf8-0cff : PCI conf1
| 1000-101f : 0000:00:08.0
|    1000-101f : e1000
| 1030-1033 : 0000:00:00.0
| 2000-2fff : PCI Bus #01
|    2000-20ff : 0000:01:05.0
| 3000-3fff : PCI Bus #02
|    3000-307f : 0000:02:08.0
|      3000-307f : 0000:02:08.0
|    3080-309f : 0000:02:07.0
|      3080-309f : EMU10K1
|    30a0-30af : 0000:02:06.0
|      30a0-30af : 3ware Storage Controller
|    30b0-30b7 : 0000:02:07.1
|      30b0-30b7 : emu10k1-gp
| f000-f00f : 0000:00:07.1
|    f000-f007 : ide0
|    f008-f00f : ide1
| 
| /proc/iomem:
| 00000000-0009efff : System RAM
| 0009f000-0009ffff : reserved
| 000a0000-000bffff : Video RAM area
| 000cd000-000cd7ff : Extension ROM
| 000cd800-000cefff : Extension ROM
| 000cf000-000cffff : Extension ROM
| 000e0000-000effff : Extension ROM
| 000f0000-000fffff : System ROM
| 00100000-1feeffff : System RAM
|    00100000-0044a6f8 : Kernel code
|    0044a6f9-0058f0bf : Kernel data
| 1fef0000-1fefefff : ACPI Tables
| 1feff000-1fefffff : ACPI Non-volatile Storage
| 1ff00000-1ff7ffff : System RAM
| 1ff80000-1fffffff : reserved
| d0000000-d001ffff : 0000:00:08.0
|    d0000000-d001ffff : e1000
| d0020000-d003ffff : 0000:00:08.0
|    d0020000-d003ffff : e1000
| d0100000-d01fffff : PCI Bus #01
|    d0100000-d010ffff : 0000:01:05.0
| d0200000-d02fffff : PCI Bus #02
|    d0200000-d0203fff : 0000:02:04.0
|    d0204000-d0204fff : 0000:02:00.0
|      d0204000-d0204fff : ohci_hcd
|    d0205000-d02057ff : 0000:02:04.0
|      d0205000-d02057ff : ohci1394
|    d0205800-d020587f : 0000:02:08.0
| d0500000-d0500fff : 0000:00:00.0
| d8000000-dfffffff : 0000:00:00.0
| e0000000-efffffff : PCI Bus #01
|    e0000000-efffffff : 0000:01:05.0
| fec00000-fec03fff : reserved
| fee00000-fee00fff : reserved
| fff80000-ffffffff : reserved
| 
| 7.5 PCI Info:
| 00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
| System Controller (rev 11)
| 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
| Stepping- SERR- FastB2B-
| 	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
| <TAbort- <MAbort+ >SERR- <PERR-
| 	Latency: 32
| 	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
| 	Region 1: Memory at d0500000 (32-bit, prefetchable) [size=4K]
| 	Region 2: I/O ports at 1030 [disabled] [size=4]
| 	Capabilities: <available only to root>
| 
| 00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
| AGP Bridge (prog-if 00 [Normal decode])
| 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
| Stepping- SERR- FastB2B-
| 	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
| <TAbort- <MAbort- >SERR- <PERR-
| 	Latency: 99
| 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
| 	I/O behind bridge: 00002000-00002fff
| 	Memory behind bridge: d0100000-d01fffff
| 	Prefetchable memory behind bridge: e0000000-efffffff
| 	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
| 
| 00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
| 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
| Stepping- SERR- FastB2B-
| 	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
| <TAbort- <MAbort- >SERR- <PERR-
| 	Latency: 0
| 
| 00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE 
| (rev 04) (prog-if 8a [Master SecP PriP])
| 	Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
| 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
| Stepping- SERR- FastB2B-
| 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
| <TAbort- <MAbort- >SERR- <PERR-
| 	Latency: 0
| 	Region 4: I/O ports at f000 [size=16]
| 
| 00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
| 	Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI
| 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
| Stepping- SERR- FastB2B-
| 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
| <TAbort- <MAbort- >SERR- <PERR-
| 
| 00:08.0 Ethernet controller: Intel Corp. 82544EI Gigabit Ethernet 
| Controller (Copper) (rev 02)
| 	Subsystem: Intel Corp. PRO/1000 XT Server Adapter
| 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
| Stepping- SERR- FastB2B-
| 	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
| <TAbort- <MAbort- >SERR- <PERR-
| 	Latency: 64 (63750ns min), cache line size 10
| 	Interrupt: pin A routed to IRQ 20
| 	Region 0: Memory at d0020000 (32-bit, non-prefetchable) [size=128K]
| 	Region 1: Memory at d0000000 (32-bit, non-prefetchable) [size=128K]
| 	Region 2: I/O ports at 1000 [size=32]
| 	Expansion ROM at <unassigned> [disabled] [size=128K]
| 	Capabilities: <available only to root>
| 
| 00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 
| 05) (prog-if 00 [Normal decode])
| 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
| Stepping- SERR- FastB2B-
| 	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
| <TAbort- <MAbort+ >SERR- <PERR-
| 	Latency: 64
| 	Bus: primary=00, secondary=02, subordinate=02, sec-latency=168
| 	I/O behind bridge: 00003000-00003fff
| 	Memory behind bridge: d0200000-d02fffff
| 	Prefetchable memory behind bridge: fff00000-000fffff
| 	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
| 
| 01:05.0 VGA compatible controller: ATI Technologies Inc Radeon R200 QM 
| [Radeon 9100] (prog-if 00 [VGA])
| 	Subsystem: PC Partner Limited: Unknown device 7149
| 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
| Stepping+ SERR- FastB2B+
| 	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
| <TAbort- <MAbort- >SERR- <PERR-
| 	Latency: 66 (2000ns min), cache line size 10
| 	Interrupt: pin A routed to IRQ 18
| 	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
| 	Region 1: I/O ports at 2000 [size=256]
| 	Region 2: Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
| 	Expansion ROM at <unassigned> [disabled] [size=128K]
| 	Capabilities: <available only to root>
| 
| 02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB 
| (rev 07) (prog-if 10 [OHCI])
| 	Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] USB
| 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
| Stepping- SERR- FastB2B-
| 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
| <TAbort- <MAbort- >SERR- <PERR+
| 	Latency: 64 (20000ns max)
| 	Interrupt: pin D routed to IRQ 19
| 	Region 0: Memory at d0204000 (32-bit, non-prefetchable) [size=4K]
| 
| 02:04.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 
| IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
| 	Subsystem: Adaptec: Unknown device 0030
| 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
| Stepping- SERR- FastB2B-
| 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
| <TAbort- <MAbort- >SERR- <PERR-
| 	Latency: 64 (750ns min, 1000ns max), cache line size 10
| 	Interrupt: pin A routed to IRQ 16
| 	Region 0: Memory at d0205000 (32-bit, non-prefetchable) [size=2K]
| 	Region 1: Memory at d0200000 (32-bit, non-prefetchable) [size=16K]
| 	Capabilities: <available only to root>
| 
| 02:06.0 RAID bus controller: 3ware Inc 3ware ATA-RAID (rev 12)
| 	Subsystem: 3ware Inc 3ware ATA-RAID
| 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
| Stepping+ SERR- FastB2B-
| 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
| <TAbort- <MAbort- >SERR- <PERR-
| 	Latency: 64 (2250ns min)
| 	Interrupt: pin A routed to IRQ 18
| 	Region 0: I/O ports at 30a0 [size=16]
| 	Expansion ROM at <unassigned> [disabled] [size=64K]
| 
| 02:07.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 05)
| 	Subsystem: Creative Labs CT4760 SBLive!
| 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
| Stepping- SERR- FastB2B-
| 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
| <TAbort- <MAbort- >SERR- <PERR-
| 	Latency: 64 (500ns min, 5000ns max)
| 	Interrupt: pin A routed to IRQ 19
| 	Region 0: I/O ports at 3080 [size=32]
| 	Capabilities: <available only to root>
| 
| 02:07.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
| (rev 05)
| 	Subsystem: Creative Labs Gameport Joystick
| 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
| Stepping- SERR- FastB2B-
| 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
| <TAbort- <MAbort- >SERR- <PERR-
| 	Latency: 64
| 	Region 0: I/O ports at 30b0 [size=8]
| 	Capabilities: <available only to root>
| 
| 02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] 
| (rev 78)
| 	Subsystem: Tyan Computer: Unknown device 2466
| 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
| Stepping- SERR- FastB2B-
| 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
| <TAbort- <MAbort- >SERR- <PERR-
| 	Latency: 80 (2500ns min, 2500ns max), cache line size 10
| 	Interrupt: pin A routed to IRQ 19
| 	Region 0: I/O ports at 3000 [size=128]
| 	Region 1: Memory at d0205800 (32-bit, non-prefetchable) [size=128]
| 	Expansion ROM at <unassigned> [disabled] [size=128K]
| 	Capabilities: <available only to root>
| 
| 7.6 SCSI Info:
| Attached devices:
| Host: scsi0 Channel: 00 Id: 00 Lun: 00
|    Vendor: 3ware    Model: Logical Disk 0   Rev: 1.0
|    Type:   Direct-Access                    ANSI SCSI revision: ffffffff
| 
| 7.7 Other Info:
| 	None that I can think of
| 
| X. Notes:
| X.1 Machine 1 (above) does not exhibit this problem. Ethernet cards are 
| identical.
| X.2 This machine exhibits this problem regardless of Ethernet card used.
| 
| Thanks in advance.
| -- 


--
~Randy
