Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271146AbTG2CRt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 22:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271211AbTG2CRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 22:17:49 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:48611 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S271146AbTG2CRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 22:17:38 -0400
Date: Mon, 28 Jul 2003 19:17:13 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1007] New: Kernel panic: Attempted to kill init!
Message-ID: <3965170000.1059445033@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1007

           Summary: Kernel panic: Attempted to kill init!
    Kernel Version: 2.6.0-test2
            Status: NEW
          Severity: blocking
             Owner: bugme-janitors@lists.osdl.org
         Submitter: services@dynamicbits.com


Distribution: Slackware 9.0
Hardware Environment: Sony VAIO PCG-GRZ610 (This is a laptop)
NIC: Intel PRO100 VE
Sound: Yamaha AC-XG
Video: ATI Mobility Radeon 7500 C

cat /proc/cpuinfo returns:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.00GHz
stepping        : 7
cpu MHz         : 1988.559
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3971.48



lspci -vvv returns:
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
        Subsystem: Sony Corporation: Unknown device 8142
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at ec000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [d104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans-
64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW+ Rate=x1

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev
04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 96
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: e8100000-e81fffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02) (prog-if
00 [UHCI])
        Subsystem: Sony Corporation: Unknown device 8142
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 9
        Region 4: I/O ports at 1800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02) (prog-if
00 [UHCI])
        Subsystem: Sony Corporation: Unknown device 8142
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 9
        Region 4: I/O ports at 1820 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02) (prog-if
00 [UHCI])
        Subsystem: Sony Corporation: Unknown device 8142
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 9
        Region 4: I/O ports at 1840 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42) (prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: e8200000-e82fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if 8a
[Master SecP PriP])
        Subsystem: Sony Corporation: Unknown device 8142
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 255
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at 1860 [size=16]
        Region 5: Memory at e8000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 02)
        Subsystem: Sony Corporation: Unknown device 8142
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 9
        Region 4: I/O ports at 1880 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 02)
        Subsystem: Sony Corporation: Unknown device 8142
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 9
        Region 0: I/O ports at 1c00 [size=256]
        Region 1: I/O ports at 18c0 [size=64]

00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 02) (prog-if 00 [Generic])
        Subsystem: Sony Corporation: Unknown device 8142
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 9
        Region 0: I/O ports at 2400 [size=256]
        Region 1: I/O ports at 2000 [size=128]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW
[Radeon Mobility 7500] (prog-if 00 [VGA])
        Subsystem: Sony Corporation: Unknown device 8135
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B+
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 10
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 3000 [size=256]
        Region 2: Memory at e8100000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans-
64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
        Subsystem: Sony Corporation: Unknown device 8142
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00004400-000044ff
        I/O window 1: 00004800-000048ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

02:05.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
        Subsystem: Sony Corporation: Unknown device 8142
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin B routed to IRQ 9
        Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
        Memory window 0: 10c00000-10fff000 (prefetchable)
        Memory window 1: 11000000-113ff000
        I/O window 0: 00004c00-00004cff
        I/O window 1: 00005000-000050ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

02:05.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (prog-if
10 [OHCI])
        Subsystem: Sony Corporation: Unknown device 8142
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin C routed to IRQ 9
        Region 0: Memory at e8201000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME+

02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM)
Ethernet Controller (rev 42)
        Subsystem: Sony Corporation: Unknown device 8142
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at e8200000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 4000 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-



Please note that the above commands were run under my 2.4.21 kernel as the
2.6.0-test2 will not boot.

Software Environment: (Mostly stock Slack9 plus a few things) KDE 3.1.0, XFree86
4.3.0

Originally had kernel 2.4.20. I have a 2.4.21 kernel with the ACPI patch that I
currently use. I used the 2.4.21 kernel with gcc v3.2.2 to compile the
2.6.0-test2 kernel. I issued the following commands as su (leaving out the tar
and ln -s):

cd /usr/src/linux
make clean

I then ran a script (/newk.sh) with the following commands in it:

make xconfig
make bzImage
make modules
make modules_install
cp arch/i386/boot/bzImage /boot/bzImage-260t2-20030728
cp .config /boot/config-260t2-20030728
cp System.map /boot/System.map-260t2-20030728
lilo
lilo -q

Within xconfig, I only made a few changes in the categories up to (and
including) Plug and Play.



Problem Description: When I boot, I get a kernel panic as shown below.

Steps to reproduce: Turn computer on, select 260t2 kernel in lilo, hit enter.

Following is what I see on the screen.
+-----------------------------------------------------------------------------+
eax: 00000001   ebx: 00000228   ecx: 001a0000   edx: 0000000a
esi: 0000c046   edi: 00000000   ebp: cff31e28   esp: cff31dd8
ds: 00a0   es: 00b0   ss: 0068
Process swapper (pid: 1, threadinfo=cff30000 task=c128f880)
Stack: c08b8ab5 8ab5000a c0653032 c0290003 0a110011 0027bfec bfd98aaa 0000bfc5
       bfb08aa9 0000bf9e 00030000 1e280000 1e1ecff3 8a91cff3 00000000 00270000
       0001001a c5940000 00000246 cff77db0 0000000e cff31e8c 1e90ffff c03bcff3
Call Trace:
 [<c0290003>] setup_DMA+0xfb/0x147
 [<c0161861>] d_instantiate+0x6b/0x6d
 [<c0168a7c>] dcache_dir_lseek+0xf0/0x6d
 [<c024bdd6>] __pnp_bios_get_dev_node+0x145/0x1c6
 [<c0240000>] acpi_pci_irq_add_entry+0x105/0x153
 [<c024be7a>] pnp_bios_get_dev_node+0x23/0x47
 [<c04dea8a>] build_devlist+0x86/0x13b
 [<c04ded11>] pnpbios_init+0xa8/0x26b
 [<c04d26b2>] do_initcalls+0x2b/0x98
 [<c0128a67>] init_workqueues+0x12/0x2b
 [<c010509e>] init+0x34/0x192
 [<c010506a>] init+0x0/0x192
 [<c0107291>] kernel_thread_helper+0x5/0xb

Code:  Bad EIP value.
 <0>Kernel panic: Attempted to kill init!
+-----------------------------------------------------------------------------+

I had tried kernel 2.6.0-test 1 in the past and had the same issue. I gave up
and deleted the source and compiled bzImage from my system. I figured
2.6.0-test2 might have fixed the issue, but it didn't. I had a feeling this
would happen, so I didn't bother to go through the entire xconfig.

This is my first kernel bug report, so I am sure there is more information that
will be needed.


