Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSIDTbk>; Wed, 4 Sep 2002 15:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315406AbSIDTbj>; Wed, 4 Sep 2002 15:31:39 -0400
Received: from [212.216.176.185] ([212.216.176.185]:50159 "EHLO
	smtp9.cp.tin.it") by vger.kernel.org with ESMTP id <S315388AbSIDTb0> convert rfc822-to-8bit;
	Wed, 4 Sep 2002 15:31:26 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Davide Patti <davidepatti@tin.it>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM : summer freeze
Date: Wed, 4 Sep 2002 21:44:34 +0000
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209042144.34536.davidepatti@tin.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




1. GENERAL :

Freeze under X.

2. DESCRIPTION :

It seems to happen sometimes under X.
Everything freezes, and then I must reboot. 

3. KEYWORDS :

kernel, X , freeze.

4. KERNEL VERSION :

Linux version 2.4.19 (root@eccepingus) (gcc version 2.96 20000731 (Mandrake 
Linux 8.1 2.96-0.62mdk)) #4 lun ago 26 17:29:12 UTC 2002
 
5. LOG OUTPUT 

NOTE: the line where is mentioned :
Sep  4 20:46:54 eccepingus kernel: Process X (pid: 1941, stackpage=cd767000)

isn't always the same. Sometimes , instead of X there was galeo-bin,
some times kdeinit, sometime another process ...

-------------------------------------------------------------
Sep  4 20:46:54 eccepingus kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Sep  4 20:46:54 eccepingus kernel:  printing eip:
Sep  4 20:46:54 eccepingus kernel: c021ca5f
Sep  4 20:46:54 eccepingus kernel: *pde = 00000000
Sep  4 20:46:54 eccepingus kernel: Oops: 0002
Sep  4 20:46:54 eccepingus kernel: CPU:    0
Sep  4 20:46:54 eccepingus kernel: EIP:    0010:[rwsem_wake+6847/6908]    Not 
tainted
Sep  4 20:46:54 eccepingus kernel: EIP:    0010:[<c021ca5f>]    Not tainted
Sep  4 20:46:54 eccepingus kernel: EFLAGS: 00013246
Sep  4 20:46:54 eccepingus kernel: eax: 00000000   ebx: 00000040   ecx: 
00000040   edx: 08399550
Sep  4 20:46:54 eccepingus kernel: esi: 08399510   edi: 00000000   ebp: 
00000000   esp: cd767dd8
Sep  4 20:46:54 eccepingus kernel: ds: 0018   es: 0018   ss: 0018
Sep  4 20:46:54 eccepingus kernel: Process X (pid: 1941, stackpage=cd767000)
set  4 20:46:54 eccepingus su(pam_unix)[3594]: session closed for user root
set  4 20:46:55 eccepingus su(pam_unix)[2887]: session closed for user root
Sep  4 20:46:55 eccepingus kernel: Stack: 00000000 00000040 00000040 cd767f54 
00000040 c01dd5d8 00000000 08399510 
Sep  4 20:46:55 eccepingus kernel:        00000040 fffffff2 c95e9c80 00000040 
c4d74160 c97fa874 c0215b0a c4d74160 
Sep  4 20:46:55 eccepingus kernel:        cd767f54 00000040 cd767e34 c97fa820 
00000000 c97fa820 c97fa4e0 ffffff95 
Sep  4 20:46:55 eccepingus kernel: Call Trace:    [memcpy_fromiovec+56/96] 
[unix_stream_sendmsg+410/688] [unix_write_space+55/112] 
[sock_sendmsg+108/144] [kfree_skbmem+11/96]
Sep  4 20:46:55 eccepingus kernel: Call Trace:    [<c01dd5d8>] [<c0215b0a>] 
[<c02142c7>] [<c01d8e7c>] [<c01dbebb>]
Sep  4 20:46:55 eccepingus kernel:   [__kfree_skb+262/272] 
[sock_readv_writev+147/160] [sock_writev+59/80] [do_readv_writev+399/640] 
[sock_read+136/160] [sys_read+226/240]
Sep  4 20:46:55 eccepingus kernel:   [<c01dc016>] [<c01d91a3>] [<c01d923b>] 
[<c01341cf>] [<c01d8fd8>] [<c0133f42>]
Sep  4 20:46:55 eccepingus kernel:   [sys_writev+67/96] [system_call+51/56]
Sep  4 20:46:55 eccepingus kernel:   [<c0134363>] [<c010881b>]
Sep  4 20:46:55 eccepingus kernel: 
Sep  4 20:46:55 eccepingus kernel: Code: f3 aa 58 59 e9 40 cb ff ff ba f2 ff 
ff ff e9 7d cb ff ff ba 
--------------------------------------------------------------------------



OUTPUT OF VER_LINUX:

Linux eccepingus 2.4.19 #4 lun ago 26 17:29:12 UTC 2002 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11h
mount                  2.11h
modutils               2.4.16
e2fsprogs              1.24a
reiserfsprogs          3.x.0j
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         ppp_synctty ppp_async ppp_generic slhc i810_audio 
ac97_codec lp parport_pc parport 8139too mii iptable_filter ipt_MASQUERADE 
iptable_nat ip_conntrack ip_tables vfat fat ntfs tuner tvaudio bttv videodev 
i2c-algo-bit i2c-core mga agpgart rtc



---------------------------------------------------------------------------
OUTPUT OF CPUINFO :

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 1
cpu MHz		: 651.276
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat 
pse36 mmx fxsr sse
bogomips	: 1300.88


----------------------------------------------------------------------------

OUTPUT OF /proc/modules

ppp_synctty             4864   0 (unused)
ppp_async               6368   1
ppp_generic            18604   3 [ppp_synctty ppp_async]
slhc                    4608   0 [ppp_generic]
i810_audio             20512   0
ac97_codec              9824   0 [i810_audio]
lp                      6624   0
parport_pc             25416   1
parport                23200   1 [lp parport_pc]
8139too                13216   2 (autoclean)
mii                     1088   0 (autoclean) [8139too]
iptable_filter          1696   1 (autoclean)
ipt_MASQUERADE          1216   2 (autoclean)
iptable_nat            13652   1 [ipt_MASQUERADE]
ip_conntrack           13868   1 [ipt_MASQUERADE iptable_nat]
ip_tables              10880   5 [iptable_filter ipt_MASQUERADE iptable_nat]
vfat                    9724   1 (autoclean)
fat                    30424   0 (autoclean) [vfat]
ntfs                   49920   1 (autoclean)
tuner                   8516   1 (autoclean)
tvaudio                11200   0 (autoclean) (unused)
bttv                   65600   1
videodev                5760   4 [bttv]
i2c-algo-bit            7020   1 [bttv]
i2c-core               13120   0 [tuner tvaudio bttv i2c-algo-bit]
mga                    98608   0 (unused)
agpgart                21440   1
rtc                     6044   0 (autoclean)

------------------------------------------------------------------------

OUTPUT OF /proc/ioports :

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
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0540-054f : Intel Corp. 82801AA SMBus
0cf8-0cff : PCI conf1
9000-9fff : PCI Bus #01
a000-bfff : PCI Bus #02
  b800-b8ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C (#2)
    b800-b8ff : 8139too
  bc00-bcff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
    bc00-bcff : 8139too
d400-d41f : Intel Corp. 82801AA USB
d800-d83f : Intel Corp. 82801AA AC'97 Audio
  d800-d83f : Intel ICH 82801AA
dc00-dcff : Intel Corp. 82801AA AC'97 Audio
  dc00-dcff : Intel ICH 82801AA
ffa0-ffaf : Intel Corp. 82801AA IDE
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

------------------------------------------------------------------------

OUTPUT OF /proc/iomem :


00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-0021ca9b : Kernel code
  0021ca9c-0026165f : Kernel data
0fff0000-0fff7fff : ACPI Tables
0fff8000-0fffffff : ACPI Non-volatile Storage
daa00000-deafffff : PCI Bus #01
  dc000000-ddffffff : Matrox Graphics, Inc. MGA G400 AGP
    dc000000-dcffffff : vesafb
deb00000-debfffff : PCI Bus #02
  debfe000-debfefff : Brooktree Corporation Bt878
    debfe000-debfefff : bttv
  debff000-debfffff : Brooktree Corporation Bt878
e0000000-e7ffffff : Intel Corp. 82820 820 (Camino) Chipset Host Bridge (MCH)
eed00000-efdfffff : PCI Bus #01
  ef000000-ef7fffff : Matrox Graphics, Inc. MGA G400 AGP
  efdfc000-efdfffff : Matrox Graphics, Inc. MGA G400 AGP
efe00000-efefffff : PCI Bus #02
  efeffe00-efeffeff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C (#2)
    efeffe00-efeffeff : 8139too
  efefff00-efefffff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
    efefff00-efefffff : 8139too
fff80000-ffffffff : reserved

---------------------------------------------------------------------


OUTPUT OF lspci -vvv




00:00.0 Host bridge: Intel Corporation 82820 820 (Camino) Chipset Host Bridge 
(MCH) (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corporation 82820 820 (Camino) Chipset PCI to AGP 
Bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: eed00000-efdfffff
	Prefetchable memory behind bridge: daa00000-deafffff
	BridgeCtl: Parity+ SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corporation 82801AA PCI Bridge (rev 02) (prog-if 00 
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000a000-0000bfff
	Memory behind bridge: efe00000-efefffff
	Prefetchable memory behind bridge: deb00000-debfffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801AA ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if 80 
[Master])
	Subsystem: Intel Corporation 82801AA IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corporation 82801AA USB (rev 02) (prog-if 00 
[UHCI])
	Subsystem: Intel Corporation 82801AA USB
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at d400 [size=32]

00:1f.3 SMBus: Intel Corporation 82801AA SMBus (rev 02)
	Subsystem: Intel Corporation 82801AA SMBus
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at 0540 [size=16]

00:1f.5 Multimedia audio controller: Intel Corporation 82801AA AC'97 Audio 
(rev 02)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at dc00 [size=256]
	Region 1: I/O ports at d800 [size=64]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) 
(prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SDRAM
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at dc000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at efdfc000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at ef000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at efde0000 [disabled] [size=64K]
	Capabilities: <available only to root>

02:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at bc00 [size=256]
	Region 1: Memory at efefff00 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

02:02.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Unex Technology Corp. ND010
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at b800 [size=256]
	Region 1: Memory at efeffe00 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

02:03.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at debfe000 (32-bit, prefetchable) [size=4K]
	Capabilities: <available only to root>

02:03.1 Multimedia controller: Brooktree Corporation Bt878 (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at debff000 (32-bit, prefetchable) [size=4K]
	Capabilities: <available only to root>



ADDITIONAL NOTES :

Mandrake 8.1, but I recompiled 2.4.19 vanilla kernel to include bttv
support.
x server is 4.2, kde 3.0 , but the problem was present even one year
ago.

bye bye !

-- 
______ Davide Patti ________________________
 " chi sta sveglio non piglia sogni "  ( Lodett Oio)
 from Linux v.2.4.19 / hompage : xedivad.interfree.it


