Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272223AbTHDWxi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 18:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272257AbTHDWxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 18:53:38 -0400
Received: from du117027.wb3.ptd.net ([204.186.117.27]:128 "EHLO main.net")
	by vger.kernel.org with ESMTP id S272223AbTHDWxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 18:53:30 -0400
Date: Mon, 4 Aug 2003 18:54:07 -0400
From: Stan Benoit <sab7@mail.ptd.net>
To: linux-kernel@vger.kernel.org
Subject: kernel panic linux-2.6.0-test2
Message-ID: <20030804225407.GA270@mail.ptd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Summary of Problem: Kernel Panic Attempted to kill the idle
task!

2. System lock up

3. Kernel

4. linux-2.6.0-test2

5. This is all I could see on my monitor
printing eip:
c01126a6
*pde = 00000000
Oops: 0000 [#1]
cpu: 0
eip: 0060:[<c01126a6>] not tainted
eflags: 00010202
eip is at apply_alternitives+0xa6/0x180
eax:00000003 ebx:c05844c0
ecx:c0000000 edx:c05844a0
esi:40585c45 edi:c039cd5e
ebp:c0555fc4 esp:c0555f9a
ds: 007b es: 007b ss:0068
Process swapper(pid:0, threading=c0554000 
task=c04a6340)
stack: 00000400 c04562df c055fc8 c04a7d40 00000004
00000000 c05844a0 00000000 0009fe00 c0105000
c0555fd4 c055a145 c057fbc8 c0584a0f c0555ff8
c05568fb 0007fff0 c058c620 c057f858 0000000d
c0556410 c058c620 00000000 0008e000 
Call Trace:
[<c0105000>]_stext+0x0/0x90
[<c055a145>]alternative_instructions+0x25/0x30
[<c05568fb>]start_kernel+0x16b/0x1d0
[<c05564a0>]unknown_bootoption+0x0/0x100
Code: 66 a5 a8 01 74 01 a4 8b 5d f0 8b 55 f0 0f
b6 5b 09 0f b6 42
Kernel Panic:
Attempted to kill the idle task!
In idle task not syncing

6. I just boot system. Strange thing is i did get one good boot, 
then went back to add sound support(modules) and the above started
happening.

7. Environment
7.1 Linux From Scratch 4.1
7.2 Processor information
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) MP 2600+
stepping        : 1
cpu MHz         : 2133.462
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr 
		  pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 
		  3dnow ext 3dnow
bogomips        : 4259.84

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) MP
stepping        : 1
cpu MHz         : 2133.462
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr 
	          pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 
		  3dnowext 3dnow
bogomips        : 4259.84

7.3 I cannot provide this info from /proc/modules. Im in the working
kernel

7.4 same as 7.3

7.5 
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P]
System Controller (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at fc000000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at e000 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=15 SBA+ 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P]
AGP Bridge (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f8000000-f9ffffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev
05)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
(rev 04) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev
03)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev
05) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 32
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fa000000-fbffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

01:05.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX]
(rev b2) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at f8000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
 
02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB
(rev 07) (prog-if 10 [OHCI])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin D routed to IRQ 19
        Region 0: Memory at fb020000 (32-bit, non-prefetchable)
[size=4K]

02:04.0 SCSI storage controller: Adaptec AHA-2940U2/U2W
        Subsystem: Adaptec AHA-2940U2W SCSI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (9750ns min, 6250ns max)
        Interrupt: pin A routed to IRQ 16
        BIST result: 00
        Region 0: I/O ports at c000 [disabled] [size=256]
        Region 1: Memory at fb023000 (64-bit, non-prefetchable)
[size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 SCSI storage controller: Advanced System Products, Inc ABP940-U
/ ABP960-U (rev 03)
        Subsystem: Advanced System Products, Inc ASC1300 SCSI Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at c400 [size=256]
        Region 1: Memory at fb021000 (32-bit, non-prefetchable)
[size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]

02:06.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
        Subsystem: Unknown device 4942:4c4c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at c800 [size=64]

02:04.0 SCSI storage controller: Adaptec AHA-2940U2/U2W
        Subsystem: Adaptec AHA-2940U2W SCSI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (9750ns min, 6250ns max)
        Interrupt: pin A routed to IRQ 16
        BIST result: 00
        Region 0: I/O ports at c000 [disabled] [size=256]
        Region 1: Memory at fb023000 (64-bit, non-prefetchable)
[size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 SCSI storage controller: Advanced System Products, Inc ABP940-U
/ ABP960-U (rev 03)
        Subsystem: Advanced System Products, Inc ASC1300 SCSI Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at c400 [size=256]
        Region 1: Memory at fb021000 (32-bit, non-prefetchable)
[size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]

02:06.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
        Subsystem: Unknown device 4942:4c4c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at c800 [size=64]

02:07.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 0d)
        Subsystem: Intel Corp. EtherExpress PRO/100 Server Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fb022000 (32-bit, non-prefetchable)
[size=4K]
        Region 1: I/O ports at cc00 [size=64]
        Region 2: Memory at fb000000 (32-bit, non-prefetchable)
[size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

7.6
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST318416N        Rev: 0010
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST318416N        Rev: 0010
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST318416N        Rev: 0010
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W1210S Rev: 1.04
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: TOSHIBA  Model: DVD-ROM SD-R1102 Rev: 1012
  Type:   CD-ROM                           ANSI SCSI revision: 02

7.7 Lilo sure does come up slow, i'm not sure what it has to do 
with this issue, but it is slower than it should be.

LILO version 22.2

lilo.conf
prompt
timeout=50
default=lfs  
boot=/dev/sda
map=/boot/map
install=/boot/boot.b
linear

image=/boot/vmlinuz-2.6.0-test2-smp
        label=kernel_test
        root=/dev/sda1
        read-only
        append="hcd=ide-scsi"


image=/boot/vmlinuz-2.4.21smp
        label=lfs_test
        root=/dev/sda1
        read-only
        append="hdc=ide-scsi"

image=/boot/lfskernel
        label=lfs
        root=/dev/sda1
        read-only
        append="hdc=ide-scsi"

Also here is free output:
[root@main ~]# free   
             total       used       free     shared    buffers
cached
Mem:       2069052      76820    1992232          0       6136
27504
-/+ buffers/cache:      43180    2025872
Swap:       265064          0     265064

X.
As mentioned in 6.  I did get one sucessful boot prior to 
rebuilding the kernel with modules for sound support.

I'm planning on putting up a small web page to post logs,
.config files, results of test's on 2.6.0xxxx perhaps that
might help you all. 

I sure hope this is good info, sorry about the format, the
machine locked up so I had to hand write the screen. 



Thanks,
-- 
Stan Benoit<sab7@mail.ptd.net>
http://home.ptd.net/~sab7
