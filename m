Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316577AbSFULxY>; Fri, 21 Jun 2002 07:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSFULxX>; Fri, 21 Jun 2002 07:53:23 -0400
Received: from albert.physik.hu-berlin.de ([141.20.40.11]:60943 "EHLO
	albert.physik.hu-berlin.de") by vger.kernel.org with ESMTP
	id <S316573AbSFULxR>; Fri, 21 Jun 2002 07:53:17 -0400
Date: Fri, 21 Jun 2002 13:53:08 +0200 (MEST)
From: Burkhard Bunk <bunk@physik.hu-berlin.de>
To: David McIlwraith <quack@bigpond.net.au>
cc: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: Re: PROBLEM: DAC960 kernel driver hangs with SMP enabled
In-Reply-To: <004101c218c2$2c5e6120$0100000a@ValVenus>
Message-ID: <Pine.LNX.4.21.0206211348320.24582-100000@irz11.physik.hu-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

I understand that your system works with boot option "nosmp", right?
This implies "noapic" in a sence, AFAIK.

Try with "noapic" alone, this may allow you to use both processors.

It worked for me in a similar case (dual Pentium Pro 200, old hardware).

Regards,
Burkhard Bunk.
----------------------------------------------------------------------
 bunk@physik.hu-berlin.de      Physics Institute, Humboldt University
 fax:    ++49-30 2093 7628     Invalidenstr. 110
 phone:  ++49-30 2093 7980     10115 Berlin, Germany
----------------------------------------------------------------------

On Fri, 21 Jun 2002, David McIlwraith wrote:

> [1.] One line summary of the problem:
> DAC960 driver hangs at boot with SMP enabled
> [2.] Full description of the problem/report:
> The DAC960 driver, after displaying its 2-line initial version message,
> hangs at boot, on a Linux 2.4.18 kernel with SMP enabled. I tested Linux
> version 2.2.21 kernel as well; I encountered the same problem. After
> disabling SMP [and no other options] the driver performed correctly.
> The controller in question is a DAC960PG, running with the latest
> firmware from http://www.mylex.com/. No problems have been encountered
> with any other operating systems.
> 
> I attempted to use patches I had found on the [linux-smp], [linux-kernel]
> mailing lists, referring to
> a deadlock occurring with this driver and SMP. However, the kernel still
> refused to boot correctly.
> [3.] Keywords:
> kernel, DAC960, Mylex, RAID, SCSI
> [4.] Kernel version:
> Linux version 2.4.x with SMP, 2.2.x with SMP
> [5.] Output of Oops.. message:
> Not applicable.
> [6.] A small shell script or program which triggers the problem:
> Not applicable.
> [7.] Environment
> The machine in question is an NEC Express5800/130A Pro dual processor
> system, with 2x Pentium Pro 200MHz processors, running Debian 2.2.
> [7.1.] Software
> Linux linux 2.4.18 #7 Thu Jun 20 15:09:48 EST 2002 i686 unknown
> 
> Gnu C                  2.95.2
> Gnu make               3.79.1
> binutils               2.9.5.0.37
> util-linux
> util-linux             Note: /usr/bin/fdformat is obsolete and is no longer
> available.
> util-linux             Please use /usr/bin/superformat instead (make sure
> you have the
> util-linux             fdutils package installed first).  Also, there had
> been some
> util-linux             major changes from version 4.x.  Please refer to the
> documentation.
> util-linux
> mount                  2.10f
> modutils               2.3.11
> e2fsprogs              1.18
> PPP                    2.3.11
> Linux C Library        2.1.3
> ldd: version 1.9.11
> Procps                 2.0.6
> Net-tools              1.54
> Console-tools          0.2.3
> Sh-utils               2.0
> [7.2.] Processor information:
> Note: only one processor shown, since kernel with SMP fails to boot;
> however, both processors are identical.
> 
> processor : 0
> vendor_id : GenuineIntel
> cpu family : 6
> model  : 1
> model name : Pentium Pro
> stepping : 9
> cpu MHz  : 198.961
> cache size : 256 KB
> fdiv_bug : no
> hlt_bug  : no
> f00f_bug : no
> coma_bug : no
> fpu  : yes
> fpu_exception : yes
> cpuid level : 2
> wp  : yes
> flags  : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> bogomips : 396.49
> [7.3.] Module information:
> Not applicable; kernel was built without module support.
> [7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
> IO ports:
> 0000-001f : dma1
> 0020-003f : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0070-007f : rtc
> 0080-008f : dma page reg
> 00a0-00bf : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : Compaq Computer Corporation Triflex Dual EIDE Controller
> 01f0-01f7 : Compaq Computer Corporation Triflex Dual EIDE Controller
>   01f0-01f7 : ide0
> 02f8-02ff : serial(set)
> 0376-0376 : Compaq Computer Corporation Triflex Dual EIDE Controller
> 03c0-03df : vga+
> 03f6-03f6 : Compaq Computer Corporation Triflex Dual EIDE Controller
>   03f6-03f6 : ide0
> 03f8-03ff : serial(set)
> 0cf8-0cff : PCI conf1
> d000-dfff : PCI Bus #02
>   d400-d4ff : Realtek Semiconductor Co., Ltd. RTL-8139
>     d400-d4ff : 8139too
>   d800-d8ff : Adaptec AIC-7860
>     d800-d8ff : aic7xxx
>   dce0-dcff : Intel Corp. 82557 [Ethernet Pro 100]
>     dce0-dcff : eepro100
> ecf0-ecff : Compaq Computer Corporation Triflex Dual EIDE Controller
>   ecf0-ecf7 : ide0
> 
> IO memory:
> 00000000-0009efff : System RAM
> 0009f000-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000c8000-000c87ff : Extension ROM
> 000c8800-000cb7ff : Extension ROM
> 000f0000-000fffff : System ROM
> 00100000-0fffffff : System RAM
>   00100000-0021332e : Kernel code
>   0021332f-002582cb : Kernel data
> fceee000-fceeffff : Mylex Corporation DAC960PX
> fd000000-fe9fffff : PCI Bus #02
>   fd000000-fdffffff : Cirrus Logic GD 5446
>   fe800000-fe8fffff : Intel Corp. 82557 [Ethernet Pro 100]
>   fe9fd000-fe9fdfff : Intel Corp. 82557 [Ethernet Pro 100]
>     fe9fd000-fe9fdfff : eepro100
>   fe9fe000-fe9fefff : Adaptec AIC-7860
>     fe9fe000-fe9fefff : aic7xxx
>   fe9ff800-fe9ff8ff : Realtek Semiconductor Co., Ltd. RTL-8139
>     fe9ff800-fe9ff8ff : 8139too
> fec00000-fec00fff : reserved
> fee00000-fee00fff : reserved
> ffff8119-ffffffff : reserved
> [7.5.] PCI information ('lspci -vvv' as root)
> 
> 00:00.0 Host bridge: Relience Computer: Unknown device 0005
>  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
> Stepping- SERR+ FastB2B-
>  Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort+ >SERR- <PERR-
>  Latency: 48 set, cache line size 08
> 
> 00:0a.0 PCI bridge: Intel Corporation 80960RP [i960 RP
> Microprocessor/Bridge] (rev 01) (prog-if 00 [Normal decode])
>  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>  Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR-
>  Latency: 64 set, cache line size 08
>  Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
>  I/O behind bridge: 0000f000-00000fff
>  Memory behind bridge: fff00000-000fffff
>  Prefetchable memory behind bridge: ff000000-000fffff
>  BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
> 
> 00:0a.1 RAID bus controller: Mylex Corporation DAC960PX (rev 01)
>  Subsystem: Mylex Corporation: Unknown device 0010
>  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>  Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR-
>  Latency: 64 set, cache line size 08
>  Interrupt: pin A routed to IRQ 9
>  Region 0: Memory at fceee000 (32-bit, prefetchable) [size=8K]
>  Expansion ROM at <unassigned> [disabled] [size=32K]
> 
> 00:0b.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 01)
> (prog-if 00 [Normal decode])
>  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
> Stepping- SERR+ FastB2B-
>  Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR-
>  Latency: 123 set, cache line size 08
>  Bus: primary=00, secondary=02, subordinate=02, sec-latency=68
>  I/O behind bridge: 0000d000-0000dfff
>  Memory behind bridge: fd000000-fe9fffff
>  Prefetchable memory behind bridge: 00000000ff000000-0000000000000000
>  BridgeCtl: Parity+ SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
> 
> 00:0f.0 ISA bridge: Compaq Computer Corporation Triflex PCI to ISA Bridge
> (rev 0c)
>  Subsystem: Compaq Computer Corporation: Unknown device a0f3
>  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>  Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR-
>  Latency: 0 set
> 
> 00:0f.1 IDE interface: Compaq Computer Corporation: Unknown device ae33 (rev
> 0a) (prog-if ea)
>  Subsystem: Compaq Computer Corporation: Unknown device ae33
>  Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>  Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR-
>  Latency: 0 set
>  Interrupt: pin A routed to IRQ 0
>  Region 0: I/O ports at 01f0 [size=8]
>  Region 1: I/O ports at 03f4
>  Region 2: I/O ports at 0170 [size=8]
>  Region 3: I/O ports at 0374
>  Region 4: I/O ports at ecf0 [size=16]
> 
> 02:06.0 VGA compatible controller: Cirrus Logic GD 5446 (prog-if 00 [VGA])
>  Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>  Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR-
>  Region 0: Memory at fd000000 (32-bit, prefetchable) [size=16M]
>  Expansion ROM at <unassigned> [disabled] [size=32K]
> 
> 02:07.0 SCSI storage controller: Adaptec AIC-7860 (rev 01)
>  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>  Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR-
>  Latency: 4 min, 4 max, 64 set, cache line size 08
>  Interrupt: pin A routed to IRQ 11
>  Region 0: I/O ports at d800 [disabled] [size=256]
>  Region 1: Memory at fe9fe000 (32-bit, non-prefetchable) [size=4K]
> 
> 02:08.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev
> 01)
>  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>  Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR-
>  Latency: 8 min, 56 max, 66 set
>  Interrupt: pin A routed to IRQ 5
>  Region 0: Memory at fe9fd000 (32-bit, prefetchable) [size=4K]
>  Region 1: I/O ports at dce0 [size=32]
>  Region 2: Memory at fe800000 (32-bit, non-prefetchable) [size=1M]
>  Expansion ROM at <unassigned> [disabled] [size=1M]
> 
> 02:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RT8139 (rev 10)
>  Subsystem: Realtek Semiconductor Co., Ltd. RT8139
>  Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>  Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR-
>  Latency: 32 min, 64 max, 64 set
>  Interrupt: pin A routed to IRQ 9
>  Region 0: I/O ports at d400 [size=256]
>  Region 1: Memory at fe9ff800 (32-bit, non-prefetchable) [size=256]
>  Expansion ROM at <unassigned> [disabled] [size=64K]
>  Capabilities: [50] Power Management version 2
>   Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
>   Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> [7.6.] SCSI information (from /proc/scsi/scsi)
> Attached devices: none
> [7.7.] Other information that might be relevant to the problem
> Data from: /proc/rd/c0/current_status [controller 0 information]
> 
> ***** DAC960 RAID Driver Version 2.4.11 of 11 October 2001 *****
> Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
> Configuring Mylex DAC960PG PCI RAID Controller
>   Firmware Version: 4.06-0-08, Channels: 1, Memory Size: 4MB
>   PCI Bus: 0, Device: 10, Function: 1, I/O Address: Unassigned
>   PCI Address: 0xFCEEE000 mapped at 0xD0800000, IRQ Channel: 9
>   Controller Queue Depth: 64, Maximum Blocks per Command: 128
>   Driver Queue Depth: 63, Scatter/Gather Limit: 33 of 33 Segments
>   Stripe Size: 64KB, Segment Size: 8KB, BIOS Geometry: 128/32
>   Physical Devices:
>     0:0  Vendor: SEAGATE   Model: ST34371W          Revision: 0484
>          Serial Number: JDP417330J6N3C
>          Disk Status: Online, 8495104 blocks
>     0:1  Vendor: SEAGATE   Model: ST34371W          Revision: 0484
>          Serial Number: JDY9579709XP48
>          Disk Status: Online, 8495104 blocks
>     0:2  Vendor: SEAGATE   Model: ST34572WC         Revision: 0784
>          Serial Number: JK2616440V0B9K
>          Disk Status: Online, 8888320 blocks
>     0:6  Vendor: SDR       Model: GEM200            Revision: 1
>   Logical Drives:
>     /dev/rd/c0d0: RAID-0, Online, 25485312 blocks, Write Thru
>   No Rebuild or Consistency Check in Progress
> [X.] Other notes, patches, fixes, workarounds:
> In order to boot this kernel, I also had to add a patch which is
> referenced at http://linux-kernel.skylab.org/20011125/msg01431.html. As
> the author of the DAC960 driver notes, "the Linux kernel team has
> consistently refused to add the boot patches to init/main.c". However,
> this is an entirely separate issue to the SMP conflict.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-smp" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

