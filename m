Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbUCPCCV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 21:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263417AbUCPCBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 21:01:03 -0500
Received: from mail.cyclades.com ([64.186.161.6]:31149 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263432AbUCPB4n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 20:56:43 -0500
Date: Mon, 15 Mar 2004 22:45:23 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: Eva Myers <E.R.Myers@statslab.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: __alloc_pages: 0-order allocation failed messages
In-Reply-To: <E1B2swn-0006YR-00@barbu.statslab.cam.ac.uk>
Message-ID: <Pine.LNX.4.44.0403152244390.1619-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Eva, 

Can you check the availability of swap space when this problem happens? 

Usually this means you ran out of swap. 

On Mon, 15 Mar 2004, Eva Myers wrote:

> [1.] One line summary of the problem:    
> __alloc_pages: 0-order allocation failed messages
> 
> [2.] Full description of the problem/report:
> Since I upgraded to 2.4.25, some (not all) of my machines have
> regularly had messages like the following appearing in their logs:
> 
> Mar 11 16:18:13 racingdemon kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> Mar 11 16:18:14 racingdemon kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> Mar 11 16:18:14 racingdemon kernel: VM: killing process Sqpe
> 
> (or processes other than Sqpe).
> 
> I don't think this happened with 2.4.23, and it definitely didn't
> happen with any earlier version.
> 
> [3.] Keywords (i.e., modules, networking, kernel):
> 
> [4.] Kernel version (from /proc/version):
> Linux version 2.4.25 (root@barbu) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Wed Feb 25 14:47:41 GMT 2004
> 
> [5.] Output of Oops.. message (if applicable) with symbolic information 
>      resolved (see Documentation/oops-tracing.txt)
> n/a
> 
> [6.] A small shell script or example program which triggers the
>      problem (if possible)
> 
> [7.] Environment
> [7.1.] Software (add the output of the ver_linux script here)
> Gnu C                  2.95.4
> Gnu make               3.79.1
> util-linux             2.11n
> mount                  2.11n
> modutils               2.4.15
> e2fsprogs              1.27
> PPP                    2.4.1
> Linux C Library        2.2.5
> Dynamic linker (ldd)   2.2.5
> Procps                 2.0.7
> Net-tools              1.60
> Console-tools          0.2.3
> Sh-utils               2.0.11
> Modules Loaded         3c59x
> 
> [7.2.] Processor information (from /proc/cpuinfo):
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 4
> model name      : AMD Athlon(tm) Processor
> stepping        : 2
> cpu MHz         : 699.680
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
> bogomips        : 1395.91
> 
> [7.3.] Module information (from /proc/modules):
> 3c59x                  25008   1
> 
> [7.4.] Loaded driver and hardware information (/proc/ioports,
> /proc/iomem)
> 0000-001f : dma1
> 0020-003f : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0080-008f : dma page reg
> 00a0-00bf : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : ide0
> 02f8-02ff : serial(set)
> 0376-0376 : ide1
> 03c0-03df : vesafb
> 03f6-03f6 : ide0
> 03f8-03ff : serial(set)
> 0cf8-0cff : PCI conf1
> 5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
> 6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
> c000-cfff : PCI Bus #01
>   c000-c0ff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
> d000-d00f : VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE
> d400-d41f : VIA Technologies, Inc. USB
> d800-d81f : VIA Technologies, Inc. USB (#2)
> dc00-dcff : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
> e000-e003 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
> e400-e403 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
> ec00-ec7f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
>   ec00-ec7f : 00:0c.0
> 
> 00000000-0009fbff : System RAM
> 0009fc00-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000cc000-000cc7ff : Extension ROM
> 000f0000-000fffff : System ROM
> 00100000-07feffff : System RAM
>   00100000-00237325 : Kernel code
>   00237326-002b6d67 : Kernel data
> 07ff0000-07ff2fff : ACPI Non-volatile Storage
> 07ff3000-07ffffff : ACPI Tables
> d0000000-d3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
> d4000000-d6ffffff : PCI Bus #01
>   d4000000-d4ffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
>     d4000000-d447ffff : vesafb
>   d6000000-d6000fff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
> d8000000-d800007f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
> ffff0000-ffffffff : reserved
> 
> [7.5.] PCI information ('lspci -vvv' as root)
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
> 	Latency: 0
> 	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
> 	Capabilities: [a0] AGP version 2.0
> 		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
> 		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
> 	Capabilities: [c0] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
> 	Latency: 0
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> 	I/O behind bridge: 0000c000-0000cfff
> 	Memory behind bridge: d4000000-d6ffffff
> 	Prefetchable memory behind bridge: fff00000-000fffff
> 	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
> 	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Capabilities: [c0] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32
> 	Region 4: I/O ports at d000 [size=16]
> 	Capabilities: [c0] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
> 	Subsystem: Unknown device 0925:1234
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32, cache line size 08
> 	Interrupt: pin D routed to IRQ 5
> 	Region 4: I/O ports at d400 [size=32]
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
> 	Subsystem: Unknown device 0925:1234
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32, cache line size 08
> 	Interrupt: pin D routed to IRQ 5
> 	Region 4: I/O ports at d800 [size=32]
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Interrupt: pin ? routed to IRQ 9
> 	Capabilities: [68] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 50)
> 	Subsystem: Micro-star International Co Ltd: Unknown device 3300
> 	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Interrupt: pin C routed to IRQ 11
> 	Region 0: I/O ports at dc00 [size=256]
> 	Region 1: I/O ports at e000 [size=4]
> 	Region 2: I/O ports at e400 [size=4]
> 	Capabilities: [c0] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
> 	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (2500ns min, 2500ns max), cache line size 08
> 	Interrupt: pin A routed to IRQ 10
> 	Region 0: I/O ports at ec00 [size=128]
> 	Region 1: Memory at d8000000 (32-bit, non-prefetchable) [size=128]
> 	Expansion ROM at <unassigned> [disabled] [size=128K]
> 	Capabilities: [dc] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable+ DSel=0 DScale=2 PME-
> 
> 01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X (rev 5c) (prog-if 00 [VGA])
> 	Subsystem: ATI Technologies Inc: Unknown device 0084
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (2000ns min), cache line size 08
> 	Interrupt: pin A routed to IRQ 5
> 	Region 0: Memory at d4000000 (32-bit, non-prefetchable) [size=16M]
> 	Region 1: I/O ports at c000 [size=256]
> 	Region 2: Memory at d6000000 (32-bit, non-prefetchable) [size=4K]
> 	Expansion ROM at <unassigned> [disabled] [size=128K]
> 	Capabilities: [50] AGP version 1.0
> 		Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
> 		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
> 
> 
> 
> [7.6.] SCSI information (from /proc/scsi/scsi)
> n/a (no SCSI)
> 
> [7.7.] Other information that might be relevant to the problem
>        (please look in /proc and include all information that you
>        think to be relevant):
> 
> [X.] Other notes, patches, fixes, workarounds:
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

