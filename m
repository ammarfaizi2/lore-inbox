Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262852AbVAQTvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262852AbVAQTvF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 14:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbVAQTvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 14:51:05 -0500
Received: from mail.belent.com ([207.96.133.20]:10645 "EHLO mail.belent.com")
	by vger.kernel.org with ESMTP id S262852AbVAQTuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 14:50:18 -0500
Message-ID: <41EC1721.8080405@belent.com>
Date: Mon, 17 Jan 2005 14:50:57 -0500
From: Gabriel Tataranu <tgabi@belent.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [UPDATE] Severe performance problems with kernel 2.6.10
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For those interested:

The performance issues (below) where due to a strange bug in the kernel
VM triggered by the motherboard BIOS. This affects Asus P4P800
motherboards(-MX and -VM tested) with more that 1 GB RAM. The built-in
VGA can use 1-32 MB RAM for display but configured with less than 16 MB
of video RAM the board will behave EXTREMELY poor in linux (2.6.9 also
tested to behave like this).

There are several ways around this problem, I've just configured the
board with 16 MB of video RAM. Disabling support for 4 GB of RAM works
too but more memory is lost this way. Running FreeBSD is also an option
but we don't like that, don't we ? Memtest86 (1.11) doesn't seems
affected either - but it detects the memory as "single channel" while
memory is installed in dual channel configuration (also confirmed by BIOS).

If anybody knows what's going on please let me know. Loosing 15 MB of
RAM is not a big deal but I like linux bug-free, fast and stable.

I'm available to give more details or run some tests if anyone cares.

Regards,

Gabriel


> Attached is the filled template describing the problem as in 
> REPORTING-BUGS.
> For more details please e-mail directly.
> 
>  Thank you,
> 
> Gabriel
> 
> 
> ------------------------------------------------------------------------
> 
> 
> [1.] One line summary of the problem:    
> Severe performance loss with kernel 2.6.10
> [2.] Full description of the problem/report:
> It looks like 2.6.10 suffers from severe performance issues at least on 
> Pentium 4 CPU. The system is sluggish and compilation of kernel takes more 
> than 5 times longer than 2.6.9.
> [3.] Keywords (i.e., modules, networking, kernel):
> kernel, performance
> [4.] Kernel version (from /proc/version):
> Linux version 2.6.9 (root@stor) (gcc version 3.3.4) #1 Fri Jan 14 14:18:38 
> EST 2005
> [5.] Output of Oops.. message (if applicable) with symbolic information 
>      resolved (see Documentation/oops-tracing.txt)
> [6.] A small shell script or example program which triggers the
>      problem (if possible)
> cd /usr/src/linx-2.6.10; time make
> [7.] Environment
> Standard PC; Slackware linux 10.0; 2.6.9 kernel.
> [7.1.] Software (add the output of the ver_linux script here)
> Linux stor 2.6.9 #1 Fri Jan 14 14:18:38 EST 2005 i686 unknown unknown 
> GNU/Linux
> 
> Gnu C                  3.3.4
> Gnu make               3.80
> binutils               2.15.90.0.3
> util-linux             2.12a
> mount                  2.12a
> module-init-tools      3.0
> e2fsprogs              1.35
> jfsutils               1.1.6
> reiserfsprogs          3.6.17
> reiser4progs           line
> xfsprogs               2.6.13
> Linux C Library        2.3.2
> Dynamic linker (ldd)   2.3.2
> Linux C++ Library      5.0.6
> Procps                 3.2.1
> Net-tools              1.60
> Kbd                    81:
> Sh-utils               5.2.1
> Modules Loaded         8139too
> [7.2.] Processor information (from /proc/cpuinfo):
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
> stepping        : 5
> cpu MHz         : 2800.867
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr 
> pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
> bogomips        : 5537.79
> 
> [7.3.] Module information (from /proc/modules):
> 8139too 17408 0 - Live 0xf8884000
> [7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
> 0000-001f : dma1
> 0020-0021 : pic1
> 0040-0043 : timer0
> 0050-0053 : timer1
> 0060-006f : keyboard
> 0070-0077 : rtc
> 0080-008f : dma page reg
> 00a0-00a1 : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : libata
> 0376-0376 : ide1
> 03c0-03df : vga+
> 03f8-03ff : serial
> 0400-041f : 0000:00:1f.3
> 0480-04bf : 0000:00:1f.0
> 0800-087f : 0000:00:1f.0
> 0cf8-0cff : PCI conf1
> d800-d8ff : 0000:01:0d.0
>   d800-d8ff : 8139too
> df90-df9f : 0000:01:0a.0
> dfa8-dfaf : 0000:01:0a.0
> dfe0-dfe3 : 0000:01:0a.0
> dfe4-dfe7 : 0000:01:0a.0
> dff0-dff7 : 0000:01:0a.0
> ef00-ef1f : 0000:00:1d.0
>   ef00-ef1f : uhci_hcd
> eff0-eff7 : 0000:00:02.0
> fc00-fc0f : 0000:00:1f.2
>   fc00-fc0f : libata
> 
> 00000000-0009fbff : System RAM
> 0009fc00-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000f0000-000fffff : System ROM
> 00100000-3fe2ffff : System RAM
>   00100000-0029400d : Kernel code
>   0029400e-0031537f : Kernel data
> 3fe30000-3fe3ffff : ACPI Tables
> 3fe40000-3feeffff : ACPI Non-volatile Storage
> 3fef0000-3fefffff : reserved
> f0000000-f7ffffff : 0000:00:02.0
> fe5ff800-fe5ff8ff : 0000:01:0d.0
>   fe5ff800-fe5ff8ff : 8139too
> fe5ffc00-fe5ffdff : 0000:01:0a.0
> fe77bc00-fe77bfff : 0000:00:1d.7
>   fe77bc00-fe77bfff : ehci_hcd
> fe780000-fe7fffff : 0000:00:02.0
> fe800000-febfffff : 0000:00:00.0
> ffb80000-ffffffff : reserved
> 
> [7.5.] PCI information ('lspci -vvv' as root)
> 00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub 
> Interface (rev 02)
>         Subsystem: Asustek Computer, Inc. P4P800 Mainboard
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 0
>         Region 0: Memory at fe800000 (32-bit, prefetchable) [size=4M]
>         Capabilities: [e4] #09 [1106]
> 
> 00:02.0 VGA compatible controller: Intel Corp. 82865G Integrated Graphics 
> Device (rev 02) (prog-if 00 [VGA])
>         Subsystem: Asustek Computer, Inc.: Unknown device 2572
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 10
>         Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
>         Region 1: Memory at fe780000 (32-bit, non-prefetchable) 
> [size=512K]
>         Region 2: I/O ports at eff0 [size=8]
>         Capabilities: [d0] Power Management version 1
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 
> (rev 02) (prog-if 00 [UHCI])
>         Subsystem: Asustek Computer, Inc.: Unknown device 24d0
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 10
>         Region 4: I/O ports at ef00 [size=32]
> 
> 00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI 
> Controller (rev 02) (prog-if 20 [EHCI])
>         Subsystem: Asustek Computer, Inc.: Unknown device 24d0
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin D routed to IRQ 5
>         Region 0: Memory at fe77bc00 (32-bit, non-prefetchable) [size=1K]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [58] #0a [20a0]
> 
> 00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI 
> Bridge (rev c2) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
>         I/O behind bridge: 0000d000-0000dfff
>         Memory behind bridge: fe400000-fe5fffff
>         Prefetchable memory behind bridge: fff00000-000fffff
>         BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
> 
> 00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 
> 02)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
> 
> 00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage 
> Controller (rev 02) (prog-if 8a [Master SecP PriP])
>         Subsystem: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage 
> Controller
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 11
>         Region 0: I/O ports at <unassigned>
>         Region 1: I/O ports at <unassigned>
>         Region 2: I/O ports at <unassigned>
>         Region 3: I/O ports at <unassigned>
>         Region 4: I/O ports at fc00 [size=16]
> 
> 00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 
> 02)
>         Subsystem: Asustek Computer, Inc.: Unknown device 24d0
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin B routed to IRQ 10
>         Region 4: I/O ports at 0400 [size=32]
> 
> 01:0a.0 RAID bus controller: CMD Technology Inc Silicon Image SiI 3112 
> SATARaid Controller (rev 02)
>         Subsystem: CMD Technology Inc: Unknown device 6112
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64, cache line size 04
>         Interrupt: pin A routed to IRQ 11
>         Region 0: I/O ports at dff0 [size=8]
>         Region 1: I/O ports at dfe4 [size=4]
>         Region 2: I/O ports at dfa8 [size=8]
>         Region 3: I/O ports at dfe0 [size=4]
>         Region 4: I/O ports at df90 [size=16]
>         Region 5: Memory at fe5ffc00 (32-bit, non-prefetchable) [size=512]
>         Expansion ROM at fe500000 [disabled] [size=512K]
>         Capabilities: [60] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-
> 
> 01:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
> RTL-8139/8139C/8139C+ (rev 10)
>         Subsystem: Asustek Computer, Inc.: Unknown device 80b3
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (8000ns min, 16000ns max)
>         Interrupt: pin A routed to IRQ 5
>         Region 0: I/O ports at d800 [size=256]
>         Region 1: Memory at fe5ff800 (32-bit, non-prefetchable) [size=256]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
> PME(D0-,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 
> [7.6.] SCSI information (from /proc/scsi/scsi)
> 
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: ST3300831AS      Rev: 3.01
>   Type:   Direct-Access                    ANSI SCSI revision: 05
> Host: scsi0 Channel: 00 Id: 01 Lun: 00
>   Vendor: ATA      Model: ST3300831AS      Rev: 3.01
>   Type:   Direct-Access                    ANSI SCSI revision: 05
> 
> 
> [7.7.] Other information that might be relevant to the problem
>        (please look in /proc and include all information that you
>        think to be relevant):
> [X.] Other notes, patches, fixes, workarounds:
> 
