Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266129AbRGLMzc>; Thu, 12 Jul 2001 08:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266130AbRGLMzX>; Thu, 12 Jul 2001 08:55:23 -0400
Received: from kuku-rwcmta.excite.com ([198.3.99.63]:41120 "EHLO
	kuku.excite.com") by vger.kernel.org with ESMTP id <S266129AbRGLMzN>;
	Thu, 12 Jul 2001 08:55:13 -0400
Message-ID: <13568034.994942508879.JavaMail.imail@slippery>
Date: Thu, 12 Jul 2001 05:55:08 -0700 (PDT)
From: Mark Thomson <MarkTT@excite.com>
To: markhe@nextd.demon.co.uk, linux-kernel@vger.kernel.org
Subject: kernel BUG at slab.c:1062!
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: Excite Inbox
X-Sender-Ip: 212.38.145.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Motorola SM56 PCI modem, and I got the following error when doing
'insmod sm56'.
The sm56 module used to work for all 2.4 kernels prior to kernel 2.4.6. (It
can be found at
http://e-www.motorola.com/products/softmodem/support/software.html#linux)

Using /lib/modules/2.4.6/kernel/drivers/char/sm56.o
kernel BUG at slab.c:1062!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012924b>]
EFLAGS: 00010286
eax: 0000001b   ebx: c14452b4   ecx: c14c7bc0   edx: 00000005
esi: 00000007   edi: c14452b4   ebp: cc319e74   esp: cc319e1c
ds: 0018   es: 0018   ss: 0018
Process insmod (pid: 843, stackpage=cc319000)
Stack: c01e8c29 c01e8ca5 00000426 c14452b4 00000202 00000007 cc319e74
00000292
       0000000d c012951f c14452b4 00000007 00000064 d59f352c 00000000
d59f324b
       00000064 00000007 00000000 c010b178 d59a5000 00000000 cc319ea4
d59f3820
Call Trace: [<c012951f>] [<c010b178>] [<c0118d32>] [<c0106eb4>] [<c0116058>]
[<c0106e2b>]

Code: 0f 0b 83 c4 0c f7 c6 00 10 00 00 0f 85 e9 01 00 00 a1 88 a6
Segmentation fault


System info:
------------
/proc/version: 

Linux version 2.4.6 (mark@thompson) (gcc version egcs-2.91.66 19990314/Linux
(egcs-1.1.2 release)) #1 Tue Sep 4 21:29:24 EEST 2001

/proc/cpuinfo:


processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 4
model name	: AMD Athlon(tm) processor
stepping	: 2
cpu MHz		: 1006.796
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36
mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 2005.40


/proc/modules:

via82cxxx_audio        17360   0 (autoclean)
uart401                 6576   0 (autoclean) [via82cxxx_audio]
ac97_codec              8800   0 (autoclean) [via82cxxx_audio]
sound                  58400   0 (autoclean) [via82cxxx_audio uart401]
NVdriver              657856  15 (autoclean)
parport_pc             11152   1 (autoclean)
lp                      5296   0 (autoclean)
parport                15520   1 (autoclean) [parport_pc lp]
autofs4                 9824   1 (autoclean)
dmfe                   13632   1 (autoclean)
ide-scsi                8032   0
scsi_mod               82080   1 [ide-scsi]
ide-cd                 27520   0
cdrom                  28736   0 [ide-cd]

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
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-40ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
d000-d00f : VIA Technologies, Inc. Bus Master IDE
  d000-d007 : ide0
  d008-d00f : ide1
d400-d41f : VIA Technologies, Inc. UHCI USB
d800-d81f : VIA Technologies, Inc. UHCI USB (#2)
dc00-dcff : VIA Technologies, Inc. AC97 Audio Controller
  dc00-dcff : via82cxxx_audio
e000-e003 : VIA Technologies, Inc. AC97 Audio Controller
  e000-e003 : via82cxxx_audio
e400-e403 : VIA Technologies, Inc. AC97 Audio Controller
  e400-e403 : via82cxxx_audio
e800-e8ff : Advanced System Products, Inc ABP940-U / ABP960-U
ec00-ecff : Davicom Semiconductor, Inc. Ethernet 100/10 MBit
  ec00-ecff : eth0

/proc/iomem:

lspci -vvv:

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev
02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x2
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e6000000-e7ffffff
	Prefetchable memory behind bridge: e4000000-e5ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 22)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
(prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00
[UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00
[UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 11
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 20)
	Subsystem: VIA Technologies, Inc.: Unknown device 4511
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at dc00 [size=256]
	Region 1: I/O ports at e000 [size=4]
	Region 2: I/O ports at e400 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Communication controller: Analog Devices: Unknown device 1805
	Subsystem: Analog Devices: Unknown device 1805
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR+
	Latency: 32 (250ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e9001000 (32-bit, prefetchable) [size=256]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 SCSI storage controller: Advanced System Products, Inc ABP940-U /
ABP960-U (rev 03)
	Subsystem: Advanced System Products, Inc ASC1300 SCSI Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR+
	Latency: 32 (1000ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e800 [size=256]
	Region 1: Memory at e9000000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0a.0 Ethernet controller: Davicom Semiconductor, Inc. Ethernet 100/10
MBit (rev 31)
	Subsystem: Unknown device 3030:5032
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR+
	Latency: 32 (5000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at ec00 [size=256]
	Region 1: Memory at e9002000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=256K]
	Capabilities: [50] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15)
(prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e6000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e4000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=x2


/proc/scsi/scsi: 

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: MATSHITA Model: CD-RW  CW-7586   Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02

ver_linux script:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux ghazaleh1 2.4.6 #1 Tue Sep 4 21:29:24 EEST 2001 i686 unknown
 
Gnu C                  3.0
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.11d
mount                  2.11d
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0f
pcmcia-cs              3.1.22
PPP                    2.4.0
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         NVdriver parport_pc parport autofs4 dmfe ide-scsi
scsi_mod ide-cd cdrom









_______________________________________________________
Send a cool gift with your E-Card
http://www.bluemountain.com/giftcenter/


