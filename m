Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbSLAQOp>; Sun, 1 Dec 2002 11:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbSLAQOp>; Sun, 1 Dec 2002 11:14:45 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:15557 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261894AbSLAQOk>; Sun, 1 Dec 2002 11:14:40 -0500
Message-ID: <3DEA322B.40204@enib.fr>
Date: Sun, 01 Dec 2002 17:00:43 +0100
From: XI <xizard@enib.fr>
Reply-To: xizard@enib.fr
Organization: http://www.chez.com/xizard
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: sound is stutter, sizzle with lasts kernel releases
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
[1] With kernel-2.4.19 and kernel-2.4.20 the sound stutter, sizzle

[2] The problem seems be correlated with my PCI graphic card (matrox
G200 PCI) and my sound card (sound blaster live 5.1).
In fact every time I listen music and that something appens on my screen
(moving a window, watching a movie) the sound stutter.

I think the first thing I should do is to try different kernel version
in order to find when this problem appeared first.

But before I spend time to do this, I would like to know if someone is
going to help me to find the problem.

If I get a positive response, I will do my best to help to find the bug.
But If you think this problem isn't really important, I don't want to
spend hours to find the problem ...


[3] Keywords:
~ modules: OSS or ALSA (same problem with both)
~ kernel: 2.4.20 (official), 2.4.19 at least. But it works fine with 2.4.8


[7.2] CPU:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) MP 2000+
stepping        : 2
cpu MHz         : 1666.754
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3322.67

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1666.754
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3329.22

[7.3] modules
binfmt_misc             6176   1
lp                      7008   0
parport_pc             23368   1
parport                27424   1 [lp parport_pc]
emu10k1                70380   1
soundcore               4516   0 [emu10k1]
ac97_codec             10504   0 [emu10k1]
af_packet              14792   0 (autoclean)
3c59x                  27792   1 (autoclean)
supermount             15716   4 (autoclean)
ide-cd                 30248   0
cdrom                  28800   0 [ide-cd]
ide-scsi                9044   0
scsi_mod               95684   1 [ide-scsi]
usb-ohci               19432   0 (unused)
usbcore                64512   1 [usb-ohci]
rtc                     7680   0 (autoclean)
ext3                   82292   2
jbd                    44736   2 [ext3]

[7.4] Loaded driver and hardware information
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1010-1013 : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System
Controller
2000-2fff : PCI Bus #02
      2000-207f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
        2000-207f : 02:08.0
      2080-209f : Creative Labs SB Live! EMU10k1
        2080-209f : EMU10K1
      20a0-20a7 : Creative Labs SB Live! MIDI/Game Port
f000-f00f : Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
      f000-f007 : ide0
      f008-f00f : ide1
[root@xii root]# cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c87ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1feeffff : System RAM
      00100000-00267a41 : Kernel code
      00267a42-002e0d7f : Kernel data
1fef0000-1fefefff : ACPI Tables
1feff000-1fefffff : ACPI Non-volatile Storage
1ff00000-1ff7ffff : System RAM
1ff80000-1fffffff : reserved
f4000000-f48fffff : PCI Bus #01
      f4000000-f47fffff : Matrox Graphics, Inc. MGA G200 AGP
      f4800000-f4803fff : Matrox Graphics, Inc. MGA G200 AGP
f4900000-f5ffffff : PCI Bus #02
      f4900000-f4900fff : Advanced Micro Devices [AMD] AMD-768 [Opus] USB
        f4900000-f4900fff : usb-ohci
      f4901000-f490107f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
      f4904000-f4907fff : Matrox Graphics, Inc. MGA G200
      f4908000-f490bfff : Matrox Graphics, Inc. MGA G200 (#2)
      f5000000-f57fffff : Matrox Graphics, Inc. MGA G200
      f5800000-f5ffffff : Matrox Graphics, Inc. MGA G200 (#2)
f6200000-f6200fff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P]
System Controller
f8000000-f9ffffff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P]
System Controller
fa000000-faffffff : PCI Bus #01
      fa000000-faffffff : Matrox Graphics, Inc. MGA G200 AGP
fb000000-fcffffff : PCI Bus #02
      fb000000-fbffffff : Matrox Graphics, Inc. MGA G200
      fc000000-fcffffff : Matrox Graphics, Inc. MGA G200 (#2)
fec00000-fec03fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

[7.5] PCI information
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P]
System Controller (rev 11)
            Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
            Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
    >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
            Latency: 64
            Region 0: Memory at f8000000 (32-bit, prefetchable) [size=32M]
            Region 1: Memory at f6200000 (32-bit, prefetchable) [size=4K]
            Region 2: I/O ports at 1010 [disabled] [size=4]
            Capabilities: [a0] AGP version 2.0
                    Status: RQ=15 SBA+ 64bit- FW+ Rate=x1,x2
                    Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P]
AGP Bridge (prog-if 00 [Normal decode])
            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
            Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
    >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 99
            Bus: primary=00, secondary=01, subordinate=01, sec-latency=69
            I/O behind bridge: 0000f000-00000fff
            Memory behind bridge: f4000000-f48fffff
            Prefetchable memory behind bridge: fa000000-faffffff
            BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
            Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
            Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
    >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
(rev 04) (prog-if 8a [Master SecP PriP])
            Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
            Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
            Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
    >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 0
            Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
            Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI
            Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
            Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
    >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev
05) (prog-if 00 [Normal decode])
            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
            Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
    >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
            Latency: 64
            Bus: primary=00, secondary=02, subordinate=02, sec-latency=69
            I/O behind bridge: 00002000-00002fff
            Memory behind bridge: f4900000-f5ffffff
            Prefetchable memory behind bridge: fb000000-fcffffff
            BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

01:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP
(rev 01) (prog-if 00 [VGA])
            Subsystem: Matrox Graphics, Inc. MGA-G200 AGP
            Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
            Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
    >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 128 (4000ns min, 8000ns max), cache line size 10
            Interrupt: pin A routed to IRQ 5
            Region 0: Memory at fa000000 (32-bit, prefetchable) [size=16M]
            Region 1: Memory at f4800000 (32-bit, non-prefetchable)
[size=16K]
            Region 2: Memory at f4000000 (32-bit, non-prefetchable) 
[size=8M]
            Expansion ROM at <unassigned> [disabled] [size=64K]
            Capabilities: [dc] Power Management version 1
                    Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
            Capabilities: [f0] AGP version 1.0
                    Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                    Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x2

02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB
(rev 07) (prog-if 10 [OHCI])
            Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] USB
            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
            Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
    >TAbort- <TAbort- <MAbort- >SERR- <PERR+
            Latency: 64 (20000ns max)
            Interrupt: pin D routed to IRQ 10
            Region 0: Memory at f4900000 (32-bit, non-prefetchable) 
[size=4K]

02:04.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 (rev
01) (prog-if 00 [VGA])
            Subsystem: Matrox Graphics, Inc. Millennium G200 SD
            Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
            Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
    >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 128 (4000ns min, 8000ns max), cache line size 10
            Interrupt: pin A routed to IRQ 11
            Region 0: Memory at fb000000 (32-bit, prefetchable) [size=16M]
            Region 1: Memory at f4904000 (32-bit, non-prefetchable)
[size=16K]
            Region 2: Memory at f5000000 (32-bit, non-prefetchable) 
[size=8M]
            Expansion ROM at <unassigned> [disabled] [size=64K]
            Capabilities: [dc] Power Management version 1
                    Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                    Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:06.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
            Subsystem: Creative Labs: Unknown device 8064
            Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
            Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
    >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 64 (500ns min, 5000ns max)
            Interrupt: pin A routed to IRQ 5
            Region 0: I/O ports at 2080 [size=32]
            Capabilities: [dc] Power Management version 1
                    Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                    Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:06.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
(rev 07)
            Subsystem: Creative Labs Gameport Joystick
            Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
            Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
    >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 64
            Region 0: I/O ports at 20a0 [size=8]
            Capabilities: [dc] Power Management version 1
                    Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                    Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:07.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 (rev
01) (prog-if 00 [VGA])
            Subsystem: Matrox Graphics, Inc. Millennium G200 SD
            Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
            Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
    >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 128 (4000ns min, 8000ns max), cache line size 10
            Interrupt: pin A routed to IRQ 10
            Region 0: Memory at fc000000 (32-bit, prefetchable) [size=16M]
            Region 1: Memory at f4908000 (32-bit, non-prefetchable)
[size=16K]
            Region 2: Memory at f5800000 (32-bit, non-prefetchable) 
[size=8M]
            Expansion ROM at <unassigned> [disabled] [size=64K]
            Capabilities: [dc] Power Management version 1
                    Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                    Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado]
(rev 78)
            Subsystem: Tyan Computer: Unknown device 2466
            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
            Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
    >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 80 (2500ns min, 2500ns max), cache line size 10
            Interrupt: pin A routed to IRQ 10
            Region 0: I/O ports at 2000 [size=128]
            Region 1: Memory at f4901000 (32-bit, non-prefetchable)
[size=128]
            Expansion ROM at <unassigned> [disabled] [size=128K]
            Capabilities: [dc] Power Management version 2
                    Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                    Status: D0 PME-Enable- DSel=0 DScale=2 PME-


[8] Some informations that may be usefull
*** Just down-grading to the kernel 2.4.8 solves the problem
*** I have several graphic cards in my P.C. (one AGP and 2 PCI), but
using only one PCI cause the problem to occur.
*** I have a SMP machine, but I have tried using only one processor,
same problem.
*** I have tried official kernel 2.4.20, with the same problem
*** I also tried to use OSS emu10k1-v0.20a drivers: always the same:
problem doesn't occurs with 2.4.8 but occurs with 2.4.19 and 2.4.20
*** I was thinking about some timings changed for PCI bus since kernel
2.4.8 ?

*** As I said before, if I get a positive response, I will do my best to
help to find the bug. But If you think this problem isn't really
important, I don't want to spend hours to find it ...


Thanks,
			Xavier





