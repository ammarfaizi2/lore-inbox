Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130622AbRCEFWx>; Mon, 5 Mar 2001 00:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130621AbRCEFWp>; Mon, 5 Mar 2001 00:22:45 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:29336 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S130619AbRCEFWk>; Mon, 5 Mar 2001 00:22:40 -0500
Message-Id: <l03130302b6c8cc8f538e@[192.168.239.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 5 Mar 2001 05:22:25 +0000
To: linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: PROBLEM: ES1371 driver & high-pitched buzzing
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1) ES1371 driver in 2.4.2 produces high-pitched buzzing instead of sound.

2) AudioPCI/97 card in friend's Duron-based machine (very similar to mine,
but different soundcard) works fine under Mandrake 7.1 stock kernel
(2.2.15-4mdk), but produces only loud, high-pitched buzzing noises when
used under 2.4.2.  Driver is built into the kernel, appears to be detected
properly.  Problem easily reproduced from RealPlayer, XMMS and mpg123.

3) AudioPCI es1371 high-pitched buzzing

4) Linux version 2.4.2 (root@blueberry.wilee.chromatix.org.uk) (gcc version
2.95.3 19991030 (prerelease)) #2 Sun Mar 4 20:59:55 MST 2001

5) No OOPS.

6) Playing any sound using, eg. XMMS, mpg123 or RealPlayer.

7.1)
Linux blueberry.wilee.chromatix.org.uk 2.4.2 #2 Sun Mar 4 20:59:55 MST 2001
i686 unknown
Kernel modules         2.3.10
Gnu C                  2.95.3
Gnu Make               3.79
Binutils               2.9.5.0.31
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10h
Net-tools              1.55
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded
(none)

7.2)
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Duron(tm) Processor
stepping        : 1
cpu MHz         : 700.053
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1395.91

7.3) No modules loaded.

7.4)
[root@blueberry linux]# cat /proc/ioports
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
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0778-077a : parport0
0cf8-0cff : PCI conf1
4000-40ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
c000-cfff : PCI Bus #01
  c000-c0ff : ATI Technologies Inc Rage 128 RF
d000-d00f : VIA Technologies, Inc. Bus Master IDE
  d000-d007 : ide0
  d008-d00f : ide1
dc00-dc07 : US Robotics/3Com 56K FaxModem Model 5610
  dc00-dc07 : serial(auto)
e000-e03f : Ensoniq 5880 AudioPCI
  e000-e03f : es1371
e400-e47f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  e400-e47f : eth0

[root@blueberry linux]# cat /proc/iomem
00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-0025aa21 : Kernel code
  0025aa22-002d3967 : Kernel data
d0000000-d3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
d4000000-d7ffffff : PCI Bus #01
  d4000000-d7ffffff : ATI Technologies Inc Rage 128 RF
    d4000000-d7ffffff : aty128fb FB
d8000000-d9ffffff : PCI Bus #01
  d9000000-d9003fff : ATI Technologies Inc Rage 128 RF
    d9000000-d9003fff : aty128fb MMIO
db000000-db00007f : 3Com Corporation 3c905B 100BaseTX [Cyclone]

7.5)
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0 set
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305 (prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: d8000000-d9ffffff
        Prefetchable memory behind bridge: d4000000-d7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
10) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Region 4: I/O ports at d000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Serial controller: US Robotics/3Com 56K FaxModem Model 5610 (rev
01) (prog-if 02 [16550])
        Subsystem: US Robotics/3Com USR 56k Internal FAX Modem (Model 2977)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at dc00 [size=8]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2+ PME+
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
        Subsystem: Ensoniq: Unknown device 2003
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 12 min, 128 max, 32 set
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at e000 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI+ D1- D2+ PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 10 min, 10 max, 32 set, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e400 [size=128]
        Region 1: Memory at db000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF
(prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0008
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 32 set, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d4000000 (32-bit, prefetchable) [size=64M]
        Region 1: I/O ports at c000 [size=256]
        Region 2: Memory at d9000000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1+ D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

7.6) No SCSI.

7.7) The player apps mentioned seem to advance their timers very slowly
when the problem occurs - this appears to be of the order of 2 or 4 times
slower than realtime.  I can't personally see in great detail - the machine
and it's user are on the wrong side of the Atlantic!

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


