Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266496AbRGGPnU>; Sat, 7 Jul 2001 11:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266499AbRGGPnL>; Sat, 7 Jul 2001 11:43:11 -0400
Received: from mail1.home.nl ([213.51.129.225]:51966 "EHLO mail1.home.nl")
	by vger.kernel.org with ESMTP id <S266496AbRGGPm4>;
	Sat, 7 Jul 2001 11:42:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: JES <yez@home.nl>
To: t.sailer@alumni.ethz.ch
Subject: bugreport : system unacceptably slow.
Date: Sat, 7 Jul 2001 17:37:05 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01070717370500.02081@CC90001-A>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Every once in a while, my system gets unbelievable slow. So slow that I 
almost can't do anything anymore. This happens only once in a few months.
I think it has to do with sound, because when I start using sound, it happens.
"top" gives me then about 90% idle time, and "top" is using this 10% then. 
This already happens quite a while. I already had this with a 2.2.x kernel 
and I just had it with the 2.4.2 kernel. Could you tell me what I can do to 
give you more information ? Do you think it could be in this module ?

I use the es1370 driver as a loadable module that gets loaded when asked for 
it.
I always use standard distribution installation. Now I have RH7.1


With kind regards,
Edwin.

info :

[root@CC90001-A /root]# cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 4).
      Master Capable.  Latency=64.
      Non-prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 4).
      Master Capable.  Latency=64.  Min Gnt=8.
  Bus  0, device   2, function  0:
    USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 3).
      IRQ 9.
      Master Capable.  Latency=64.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xde800000 [0xde800fff].
  Bus  0, device   3, function  0:
    Bridge: Acer Laboratories Inc. [ALi] M7101 PMU (rev 0).
  Bus  0, device   7, function  0:
    ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin 
IV] (rev 195).
  Bus  0, device   9, function  0:
    Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 1).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=12.Max Lat=128.
      I/O at 0xd800 [0xd83f].
  Bus  0, device  10, function  0:
    Ethernet controller: Winbond Electronics Corp W89C940 (rev 11).
      IRQ 7.
      I/O at 0xd400 [0xd41f].
  Bus  0, device  11, function  0:
    Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip 
Pass 3] (rev 33).
      IRQ 10.
      Master Capable.  Latency=32.
      I/O at 0xd000 [0xd07f].
      Non-prefetchable 32 bit memory at 0xde000000 [0xde00007f].
  Bus  0, device  12, function  0:
    SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c810 (rev 
35).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=64.
      I/O at 0xb800 [0xb8ff].
      Non-prefetchable 32 bit memory at 0xdd800000 [0xdd8000ff].
  Bus  0, device  15, function  0:
    IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 193).
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=4.
      I/O at 0xb400 [0xb40f].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation Riva TnT 128 [NV04] (rev 4).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xdf000000 [0xdfffffff].
      Prefetchable 32 bit memory at 0xe7000000 [0xe7ffffff].

[root@CC90001-A /root]# lspci -vvv
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
        Subsystem: Acer Laboratories Inc. [ALi] ALI M1541 Aladdin V/V+ AGP 
System Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [b0] AGP version 1.0
                Status: RQ=28 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04) (prog-if 00 
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: df000000-dfffffff
        Prefetchable memory behind bridge: e6f00000-e7ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) 
(prog-if 10 [OHCI])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at de800000 (32-bit, non-prefetchable) [size=4K]

00:03.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
        Subsystem: Acer Laboratories Inc. [ALi] ALI M7101 Power Management 
Controller
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge 
[Aladdin IV] (rev c3)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 0

00:09.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
        Subsystem: Unknown device 4942:4c4c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d800 [size=64]

00:0a.0 Ethernet controller: Winbond Electronics Corp W89C940 (rev 0b)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 7
        Region 0: I/O ports at d400 [size=32]
        Expansion ROM at <unassigned> [disabled] [size=32K]

00:0b.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 
[Tulip Pass 3] (rev 21)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d000 [size=128]
        Region 1: Memory at de000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=256K]
 
00:0c.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c810 
(rev 23)
        Subsystem: Symbios Logic Inc. (formerly NCR) 8100S
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 16000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at b800 [size=256]
        Region 1: Memory at dd800000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1) 
(prog-if
8a [Master SecP PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at b400 [size=16]
 
01:00.0 VGA compatible controller: nVidia Corporation Riva TnT 128 [NV04] 
(rev 04) (prog-if 00 [VGA])
        Subsystem: Diamond Multimedia Systems Viper V550
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at df000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e7000000 (32-bit, prefetchable) [size=16M]
        Expansion ROM at e6ff0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 1.0
                Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


[root@CC90001-A /root]# lsmod
Module                  Size  Used by
es1370                 24896   0  (autoclean)
soundcore               4432   4  (autoclean) [es1370]
ov511                  38768   0
videodev                4896   1  [ov511]
autofs                 11136   1  (autoclean)
ne2k-pci                4864   1  (autoclean)
8390                    6752   0  (autoclean) [ne2k-pci]
tulip                  38096   1  (autoclean)
ipchains               38944   0  (unused)
nls_iso8859-1           2880   2  (autoclean)
nls_cp437               4384   2  (autoclean)
vfat                    9168   2  (autoclean)
fat                    32832   0  (autoclean) [vfat]
usb-ohci               17264   0  (unused)
usbcore                49632   1  [ov511 usb-ohci]
ncr53c8xx              58000   0  (unused)
sd_mod                 11808   0  (unused)
scsi_mod               94304   2  [ncr53c8xx sd_mod]

[root@CC90001-A /root]# cat /proc/version
Linux version 2.4.2-2 (root@porky.devel.redhat.com) (gcc version 2.96 
20000731 (Red Hat Linux 7.1 2.96-79)) #1 Sun Apr 8 19:37:14 EDT 2001

[edwin@CC90001-A linux]$ sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux CC90001-A 2.4.2-2 #1 Sun Apr 8 19:37:14 EDT 2001 i586 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10s
mount                  2.10r
modutils               2.4.2
e2fsprogs              1.19
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         es1370 soundcore ov511 videodev autofs ne2k-pci 8390 
tulip ipchains nls_iso8859-1 nls_cp437 vfat fat usb-ohci usbcore ncr53c8xx 
sd_mod scsi_mod

[root@CC90001-A /root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 350.810
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips        : 699.59

[root@CC90001-A /root]# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5c20-5c3f : Acer Laboratories Inc. [ALi] M7101 PMU
b400-b40f : Acer Laboratories Inc. [ALi] M5229 IDE
  b400-b407 : ide0
  b408-b40f : ide1
b800-b8ff : Symbios Logic Inc. (formerly NCR) 53c810
  b800-b87f : ncr53c8xx
d000-d07f : Digital Equipment Corporation DECchip 21041 [Tulip Pass 3]
  d000-d07f : eth0
d400-d41f : Winbond Electronics Corp W89C940
  d400-d41f : ne2k-pci
d800-d83f : Ensoniq ES1370 [AudioPCI]
  d800-d83f : es1370



