Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129696AbRBWM4q>; Fri, 23 Feb 2001 07:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130437AbRBWM4g>; Fri, 23 Feb 2001 07:56:36 -0500
Received: from [212.17.205.82] ([212.17.205.82]:26619 "EHLO mbox.reitek.com")
	by vger.kernel.org with ESMTP id <S129696AbRBWM42> convert rfc822-to-8bit;
	Fri, 23 Feb 2001 07:56:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Fabrizio Ammollo <f.ammollo@reitek.com>
Organization: Reitek S.p.A.
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: mount -o loop of ISO image lockup
Date: Fri, 23 Feb 2001 13:59:44 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01022313594402.01454@f-ammollo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] mount -o loop of ISO image lockup
[2.] mount of an ISO image created with mkisofs and correctly read and 
verified by isoread and isovrfy locks ; nothing is reported my mount, and it 
is unkillable ; the line is reported by ps this way:

root      4378  0.0  0.5  1508 1508 pts/12   DL   13:17   0:00 mount -o loop 
-t iso9660 image.iso /mnt/cdrom/
  
[3.] kernel, mount, loop, iso9660
[4.] 2.4.2
[5.] N/A
[6.] mount -o loop -t iso9660 image.iso /mnt/cdrom/
[7.]
[7.1.]
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux f-ammollo 2.4.2 #12 Thu Feb 22 11:11:08 CET 2001 i686 unknown
Kernel modules         2.3.21
Gnu C                  2.96
Gnu Make               3.79.1
Binutils               2.10.0.18
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.7
Mount                  2.10m
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         loop mad16 ad1848 uart401 sound soundcore 
nls_iso8859-1 nls_cp437 vfat fat 3c59x
[7.2.]
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Celeron (Covington)
stepping        : 1
cpu MHz         : 300.689
cache size      : 32 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 mmx fxsr
bogomips        : 599.65
[7.3.]
loop                    7552   2 (autoclean)
mad16                   7904   0 (autoclean)
ad1848                 17376   0 (autoclean) [mad16]
uart401                 6320   0 (autoclean) [mad16]
sound                  57200   0 (autoclean) [mad16 ad1848 uart401]
soundcore               3760   4 (autoclean) [sound]
nls_iso8859-1           2864   1 (autoclean)
nls_cp437               4384   1 (autoclean)
vfat                   11248   1 (autoclean)
fat                    31104   0 (autoclean) [vfat]
3c59x                  23424   1 (autoclean)
[7.4.]
/proc/ioports:
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
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0530-0533 : MAD16 WSS config
0534-0537 : MAD16 WSS
0cf8-0cff : PCI conf1
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
d000-dfff : PCI Bus #01
e000-e01f : Intel Corporation 82371AB PIIX4 USB
e400-e43f : 3Com Corporation 3c900 10BaseT [Boomerang]
  e400-e43f : eth0
f000-f00f : Intel Corporation 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1
/proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0fffffff : System RAM
  00100000-001be14d : Kernel code
  001be14e-001fffef : Kernel data
d0000000-dfffffff : Intel Corporation 440LX/EX - 82443LX/EX Host bridge
e8000000-efffffff : PCI Bus #01
  e8000000-ebffffff : S3 Inc. Trio 64 3D
ffff0000-ffffffff : reserved
[7.5.]
00:00.0 Host bridge: Intel Corporation 440LX/EX - 82443LX/EX Host bridge (rev 
03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440LX/EX - 82443LX/EX AGP bridge (rev 
03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: e8000000-efffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 
80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 
00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 0
	Region 4: I/O ports at e000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-

00:09.0 Ethernet controller: 3Com Corporation 3c900 10BaseT [Boomerang]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at e400 [size=64]
	Expansion ROM at f0000000 [disabled] [size=64K]

01:00.0 VGA compatible controller: S3 Inc. Trio 64 3D (rev 01) (prog-if 00 
[VGA])
	Subsystem: CardExpert Technology: Unknown device 8904
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
[7.6.] N/A
[7.7.]
[X.] N/A

Sorry if this not the totally right way of reporting a problem, but it's the 
first time I do it.

TIA

-- 
Bye,
	Fabrizio Ammollo
