Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264705AbUEORFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264705AbUEORFs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 13:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264711AbUEORFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 13:05:47 -0400
Received: from zeus.kernel.org ([204.152.189.113]:53477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264705AbUEORFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 13:05:37 -0400
X-T2-Posting-ID: /1y25pRTbS0SjMQpHVTImbM1UsgcS8ZvodPmtYWBEWE=
From: snagg <snagg@openssl.it>
To: linux-kernel@vger.kernel.org
Subject: schedule() problem
Date: Sat, 15 May 2004 16:13:37 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200405151613.41880.snagg@openssl.it>
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[1.] schedule() freeze

[2.]because of a failed control the system crashs , maybe the problem is that
the active_mm of a task is NULL .

[3.]scheduler

[4.]Linux version 2.4.22 (root@midas) (gcc version 3.2.3) #6 Tue Sep 2
17:43:01 PDT 2003

[5.]I only have a photo alternauts.altervista.org/schedfault.jpg because after
that the system crashs

[6.]Cannot recreate the problem , sorry

[7.1]
sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux aVaTaR 2.4.22 #6 Tue Sep 2 17:43:01 PDT 2003 i686 unknown unknown
GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
modutils               2.4.25
e2fsprogs              1.35
jfsutils               1.1.6
xfsprogs               2.6.10
pcmcia-cs              3.2.7
quota-tools            3.09.
PPP                    2.4.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.5
Procps                 2.0.18
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         soundcore appletalk ipx usb-ohci usbcore 8139too mii
crc32 pcmcia_core ide-scsi agpgart

[7.2]
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Pentium(R) 4 CPU 1.70GHz
stepping        : 2
cpu MHz         : 1716.928
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3420.97

[7.3]
soundcore               3332   0 (autoclean)
appletalk              21540   1 (autoclean)
ipx                    17348   1 (autoclean)
usb-ohci               18888   0 (unused)
usbcore                58400   1 [usb-ohci]
8139too                15240   1
mii                     2304   0 [8139too]
crc32                   2880   0 [8139too]
pcmcia_core            40032   0
ide-scsi                9424   0
agpgart                39576   0 (unused)

[7.4]
cat /proc/ioports
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
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  c000-c07f : Silicon Integrated Systems [SiS] SiS65x/M650/740 PCI/AGP VGA
Display Adapter
d800-d8ff : Silicon Integrated Systems [SiS] Sound Controller
dc00-dc7f : Silicon Integrated Systems [SiS] Sound Controller
e000-e0ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  e000-e0ff : 8139too
f000-f00f : Silicon Integrated Systems [SiS] 5513 [IDE]
  f000-f007 : ide0
  f008-f00f : ide1

cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0dfeffff : System RAM
  00100000-002c5635 : Kernel code
  002c5636-0035f063 : Kernel data
0dff0000-0dff2fff : ACPI Non-volatile Storage
0dff3000-0dffffff : ACPI Tables
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : Silicon Integrated Systems [SiS] SiS65x/M650/740 PCI/AGP
VGA Display Adapter
    e0000000-e017ffff : vesafb
e8000000-ebffffff : Silicon Integrated Systems [SiS] 650 Host
ec000000-ec0fffff : PCI Bus #01
  ec000000-ec01ffff : Silicon Integrated Systems [SiS] SiS65x/M650/740 PCI/AGP
VGA Display Adapter
ec100000-ec100fff : Silicon Integrated Systems [SiS] USB 1.0 Controller
  ec100000-ec100fff : usb-ohci
ec101000-ec101fff : Silicon Integrated Systems [SiS] USB 1.0 Controller (#2)
  ec101000-ec101fff : usb-ohci
ec102000-ec1020ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  ec102000-ec1020ff : 8139too
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5]
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 650/M650 Host (rev 01)
        Subsystem: Silicon Integrated Systems [SiS] 650/M650 Host
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [c0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans-
64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI bridge
(AGP) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: ec000000-ec0fffff
        Prefetchable memory behind bridge: e0000000-e7ffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 (LPC
Bridge) (rev 10)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:02.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller
(rev 07) (prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] USB 1.0 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 0: Memory at ec100000 (32-bit, non-prefetchable) [size=4K]

00:02.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller
(rev 07) (prog-if 10 [OHCI])
        Subsystem: Silicon Integrated Systems [SiS] USB 1.0 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ec101000 (32-bit, non-prefetchable) [size=4K]

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
(prog-if 80 [Master])
        Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller
(A,B step)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Region 4: I/O ports at f000 [size=16]

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound
Controller (rev a0)
        Subsystem: Giga-byte Technology: Unknown device a001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (13000ns min, 2750ns max)
        Interrupt: pin C routed to IRQ 9
        Region 0: I/O ports at d800 [size=256]
        Region 1: I/O ports at dc00 [size=128]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e000 [size=256]
        Region 1: Memory at ec102000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]
65x/M650/740 PCI/AGP VGA Display Adapter (prog-if 00 [VGA])
        Subsystem: Silicon Integrated Systems [SiS] 65x/M650/740 PCI/AGP VGA
Display Adapter
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        BIST result: 00
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at ec000000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at c000 [size=128]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] AGP version 2.0
                Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans-
64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>

[7.6]
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: HL-DT-ST Model: CD-RW GCE-8240B  Rev: 1.07
  Type:   CD-ROM                           ANSI SCSI revision: 02


[X]
I read the code of sched.c in kernel 2.4.26 and it seems not to be changed in
the section in wich the problem occurs, however I cannot exploit again the
scedule() so I'm not sure that the error is still there.The kernel is the
official slackware ones.


- --
You can download my public key from :
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xAF03412D


Per me si va tra la perduta gente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQCVAwUBQKYllcRZnwcjHpecAQJurgP/RW+kAGHqf9oERBbcqp9epvRlgyK1gCTO
EA0NrQhqeLDLV40ZblP0R+jH/A93EAq3x3xQiZcP4Ck92hbd3HgrUSUFQPbcDYhT
yJO6Y7WusY6ZTW77gM2IJQqppP6r9QZSwv/ZaagZVDjteAfI6V7Qavh4RUYizvUG
poF6mmm5KpA=
=GGlT
-----END PGP SIGNATURE-----
