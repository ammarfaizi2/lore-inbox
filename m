Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbTLUOY6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 09:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTLUOY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 09:24:58 -0500
Received: from nat-ph3-wh.rz.uni-karlsruhe.de ([129.13.73.33]:5004 "EHLO
	au.hadiko.de") by vger.kernel.org with ESMTP id S263137AbTLUOYs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 09:24:48 -0500
From: Jens =?iso-8859-1?q?K=FCbler?= <cleanerx@au.hadiko.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: nForce2 keeps crashing during network activity
Date: Sun, 21 Dec 2003 15:24:40 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_o0a5/V+U2/PBA4g"
Message-Id: <200312211524.40325.cleanerx@au.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_o0a5/V+U2/PBA4g
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

My computer will freeze if I produce heavy network traffic. The crashes happen 
after an arbitrary time and seem not to be related to hardware defects.
I tried the onboard nic and the rtl8139 which worked fine for me with my old 
mainboard. I've copied the same file with windowsXP and tried some other 
heavy network traffic just to see wheater it might be an hardware error but 
the system was stable. After I have started to import my home directory via 
NFS the crashes became more often. I will crash my system if I copy a big 
file via SMB.
I had the problem with Mandrake 9.1 and now with 9.2 and even compiled my own 
kernel (mandrake source) with no effect.

Any suggestions?

Jens

Here is some output of my system:

cat /proc/version
Linux version 2.4.22-21mdkcustom (root@a2.hadiko.de) (gcc version 3.3.1 
(Mandrake Linux 9.2 3.3.1-2mdk)) #4 So Dez 21 14:26:27 CET 2003

sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux a2.hadiko.de 2.4.22-21mdkcustom #4 So Dez 21 14:26:27 CET 2003 i686 
unknown unknown GNU/Linux

Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.25
e2fsprogs              1.34
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.11
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         lp parport_pc parport agpgart nvidia nls_cp437 
nls_iso8859-1 smbfs snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss 
snd-mixer-oss snd-intel8x0 snd-pcm snd-timer snd-ac97-codec snd-page-alloc 
snd-mpu401-uart snd-rawmidi snd-seq-device snd nfsd af_packet ide-floppy 
ide-tape floppy button thermal processor fan ac battery 8139too mii ohci1394 
ieee1394 nls_cp850 vfat fat nls_iso8859-15 ntfs supermount ide-cd cdrom tuner 
tvaudio bttv i2c-algo-bit soundcore i2c-core videodev ipv6 ehci-hcd usb-ohci 
usbcore rtc


cat /proc/cpu
cpufreq  cpuinfo
[jens@a2 linux]$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) XP 2500+
stepping        : 0
cpu MHz         : 1830.012
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3643.80

cat /proc/modules
lp                      8288   0
parport_pc             27208   1
parport                36840   1 [lp parport_pc]
agpgart                56356   3 (autoclean)
nvidia               1765344  11 (autoclean)
nls_cp437               5148   2 (autoclean)
nls_iso8859-1           3516   2 (autoclean)
smbfs                  43792   2 (autoclean)
snd-seq-oss            35616   0 (unused)
snd-seq-midi-event      6208   0 [snd-seq-oss]
snd-seq                46000   2 [snd-seq-oss snd-seq-midi-event]
snd-pcm-oss            45572   1
snd-mixer-oss          15864   0 [snd-pcm-oss]
snd-intel8x0           23556   3
snd-pcm                84964   0 [snd-pcm-oss snd-intel8x0]
snd-timer              19812   0 [snd-seq snd-pcm]
snd-ac97-codec         49816   0 [snd-intel8x0]
snd-page-alloc          9652   0 [snd-intel8x0 snd-pcm]
snd-mpu401-uart         5088   0 [snd-intel8x0]
snd-rawmidi            18784   0 [snd-mpu401-uart]
snd-seq-device          6152   0 [snd-seq-oss snd-seq snd-rawmidi]
snd                    44260   2 [snd-seq-oss snd-seq-midi-event snd-seq 
snd-pcm-oss snd-mixer-oss snd-intel8x0 snd-pcm snd-timer snd-ac97-codec 
snd-mpu401-uart snd-rawmidi snd-seq-device]
nfsd                   82544   8 (autoclean)
af_packet              15464   0 (autoclean)
ide-floppy             17184   0 (autoclean)
ide-tape               53296   0 (autoclean)
floppy                 57788   0
button                  3692   0 (unused)
thermal                 8164   0 (unused)
processor              10872   0 [thermal]
fan                     2528   0 (unused)
ac                      2784   0 (unused)
battery                 6944   0 (unused)
8139too                18248   1 (autoclean)
mii                     3992   0 (autoclean) [8139too]
ohci1394               29712   0 (unused)
ieee1394              205028   0 [ohci1394]
nls_cp850               4316   1 (autoclean)
vfat                   12844   1 (autoclean)
fat                    39480   0 (autoclean) [vfat]
nls_iso8859-15          4092   2 (autoclean)
ntfs                   80780   1 (autoclean)
supermount             87072   3 (autoclean)
ide-cd                 36132   0
cdrom                  34624   0 [ide-cd]
tuner                  12424   1 (autoclean)
tvaudio                16904   0 (autoclean) (unused)
bttv                  101440   0
i2c-algo-bit            9000   0 [bttv]
soundcore               6628   0 [snd bttv]
i2c-core               21220   0 [tuner tvaudio bttv i2c-algo-bit]
videodev                8384   2 [bttv]
ipv6                  191892  -1
ehci-hcd               20108   0 (unused)
usb-ohci               21912   0 (unused)
usbcore                79276   1 [ehci-hcd usb-ohci]
rtc                     9452   0 (autoclean)



--Boundary-00=_o0a5/V+U2/PBA4g
Content-Type: text/plain;
  charset="us-ascii";
  name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci"

00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) (rev c1)
	Subsystem: ABIT Computer Corp.: Unknown device 1c00
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [40] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4
	Capabilities: [60] #08 [2001]

00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
	Subsystem: nVidia Corporation: Unknown device 0c17
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a3)
	Subsystem: ABIT Computer Corp.: Unknown device 1c00
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [48] #08 [01e1]

00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
	Subsystem: ABIT Computer Corp.: Unknown device 1c00
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 23
	Region 0: I/O ports at c000 [size=32]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3) (prog-if 10 [OHCI])
	Subsystem: ABIT Computer Corp.: Unknown device 1c00
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at d9085000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3) (prog-if 10 [OHCI])
	Subsystem: ABIT Computer Corp.: Unknown device 1c00
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 22
	Region 0: Memory at d9081000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3) (prog-if 20 [EHCI])
	Subsystem: ABIT Computer Corp.: Unknown device 1c00
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin C routed to IRQ 21
	Region 0: Memory at d9082000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] #0a [2080]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Multimedia audio controller: nVidia Corporation nForce MultiMedia audio [Via VT82C686B] (rev a2)
	Subsystem: ABIT Computer Corp.: Unknown device 1c00
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 3000ns max)
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at d9000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
	Subsystem: ABIT Computer Corp.: Unknown device 1c00
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 21
	Region 0: I/O ports at b000 [size=256]
	Region 1: I/O ports at b400 [size=128]
	Region 2: Memory at d9086000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00009000-0000afff
	Memory behind bridge: d7000000-d8ffffff
	Prefetchable memory behind bridge: d4000000-d4ffffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 8a [Master SecP PriP])
	Subsystem: ABIT Computer Corp.: Unknown device 1c00
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at f000 [size=16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire (IEEE 1394) Controller (rev a3) (prog-if 10 [OHCI])
	Subsystem: ABIT Computer Corp.: Unknown device 1c00
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at d9083000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at d9084000 (32-bit, non-prefetchable) [size=64]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: d5000000-d6ffffff
	Prefetchable memory behind bridge: c0000000-cfffffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

01:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 9000 [size=256]
	Region 1: Memory at d8001000 (32-bit, non-prefetchable) [size=256]

01:09.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at d4000000 (32-bit, prefetchable) [size=4K]

01:09.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at d4001000 (32-bit, prefetchable) [size=4K]

02:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 4200] (rev a3) (prog-if 00 [VGA])
	Subsystem: LeadTek Research Inc. WinFast A250 LE TD (Dual VGA/TV-out/DVI)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at d5000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at c0000000 (32-bit, prefetchable) [size=128M]
	Region 2: Memory at c8000000 (32-bit, prefetchable) [size=512K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4


--Boundary-00=_o0a5/V+U2/PBA4g--

