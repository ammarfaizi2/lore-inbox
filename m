Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293445AbSCOWok>; Fri, 15 Mar 2002 17:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293447AbSCOWod>; Fri, 15 Mar 2002 17:44:33 -0500
Received: from web12807.mail.yahoo.com ([216.136.174.42]:37383 "HELO
	web12807.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S293445AbSCOWoR>; Fri, 15 Mar 2002 17:44:17 -0500
Message-ID: <20020315224416.78446.qmail@web12807.mail.yahoo.com>
Date: Fri, 15 Mar 2002 23:44:16 +0100 (CET)
From: =?iso-8859-1?q?napman?= <napmaniak@yahoo.com>
Reply-To: napmaniak@yahoo.com
Subject: "PROBLEM:  make xconfig "
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"PROBLEM:  make xconfig "

[1.] One line summary of the problem:
make xconfig doesn't work

[2.] Full description of the problem/report:

I tried new kernel 2.5.6 with make xconfig and it just
stopped after a few lines with the next message:

[root@offspring linux-2.5.6]# make xconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Cambiando a directorio (spanish)
`/usr/src/linux-2.5.6/scripts'
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
sound/core/Config.in: 4: can't handle
dep_bool/dep_mbool/dep_tristate condition
make[1]: *** [kconfig.tk] Error 1
make[1]: Saliendo directorio (spanish)
`/usr/src/linux-2.5.6/scripts'
make: *** [xconfig] Error 2

[3.] Keywords (i.e., modules, networking, kernel):

kernel xconfig

[4.] Kernel version (from /proc/version):
kernel 2.4.16 and 2.4.18 on RH 7.2, MDK 8.1 and debian
woody

[5.] Output of Oops.. message (if applicable) with
symbolic information
     resolved (see Documentation/oops-tracing.txt)

[6.] A small shell script or example program which
triggers the
     problem (if possible)

[7.] Environment
[7.1.] Software (add the output of the ver_linux
script here)
 sh scripts/ver_linux
If some fields are empty or look unusual you may have
an old version.
Compare to the current minimal requirements in
Documentation/Changes.

Linux offspring 2.4.16 #1 dom dic 2 00:00:59 CET 2001
i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11h
mount                  2.11h
modutils               2.4.6
e2fsprogs              1.24a
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded      -----------> is always empty (i
prefer inside kernel)



[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 2
cpu MHz		: 400.917
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr
pge mca cmov pat pse36 mmx fxsr
bogomips	: 799.53


[7.3.] Module information (from /proc/modules):
everything is inside the kernel

[7.4.] Loaded driver and hardware information
(/proc/ioports, /proc/iomem)
more /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
0220-022f : soundblaster
0330-0333 : MPU-401 UART
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
4000-403f : Intel Corp. 82371AB PIIX4 ACPI
5000-501f : Intel Corp. 82371AB PIIX4 ACPI
d000-dfff : PCI Bus #01
e000-e01f : Intel Corp. 82371AB PIIX4 USB
e400-e4ff : Realtek Semiconductor Co., Ltd. RTL-8139
  e400-e4ff : 8139too
e800-e8ff : Realtek Semiconductor Co., Ltd. RTL-8139
(#2)
  e800-e8ff : 8139too
f000-f00f : Intel Corp. 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corporation 440BX/ZX -
82443BX/ZX Host bridge (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, prefetchable)
[size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX -
82443BX/ZX AGP bridge (rev 02) (prog-if 00 [Normal
decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01,
sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: e4000000-e5ffffff
	Prefetchable memory behind bridge: e6000000-e6ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset-
FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4
ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4
IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB
PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at e000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI
(rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:0b.0 Multimedia video controller: Auravision VxP524
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at e7000000 (32-bit,
non-prefetchable) [size=1M]

00:0d.0 Ethernet controller: Realtek Semiconductor
Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Surecom Technology EP-320X-R
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at e400 [size=256]
	Region 1: Memory at e7100000 (32-bit,
non-prefetchable) [size=256]

00:0f.0 Ethernet controller: Realtek Semiconductor
Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at e800 [size=256]
	Region 1: Memory at e7101000 (32-bit,
non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Intel Corporation
i740 (rev 21) (prog-if 00 [VGA])
	Subsystem: Intel Corporation: Unknown device ff00
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e6000000 (32-bit, prefetchable)
[size=16M]
	Region 1: Memory at e5000000 (32-bit,
non-prefetchable) [size=512K]
	Expansion ROM at <unassigned> [disabled] [size=256K]
	Capabilities: [d0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-




[7.6.] SCSI information (from /proc/scsi/scsi)
 more /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: CREATIVE Model: DVD5240E-1       Rev: 1.14
  Type:   CD-ROM                           ANSI SCSI
revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SONY     Model: CD-RW  CRX140E   Rev: 1.0n
  Type:   CD-ROM                           ANSI SCSI
revision: 02



[7.7.] Other information that might be relevant to the
problem(please look in /proc and include all
information that youthink to be relevant):
[X.] Other notes, patches, fixes, workarounds:


Thank you



_______________________________________________________________
Do You Yahoo!?
Yahoo! Messenger
Comunicación instantánea gratis con tu gente.
http://messenger.yahoo.es
