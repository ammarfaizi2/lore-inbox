Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbTFAP2e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 11:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264649AbTFAP2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 11:28:34 -0400
Received: from smtp7.wanadoo.fr ([193.252.22.29]:7185 "EHLO
	mwinf0204.wanadoo.fr") by vger.kernel.org with ESMTP
	id S264647AbTFAP20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 11:28:26 -0400
Message-ID: <3EDA1EBA.9020005@ifrance.com>
Date: Sun, 01 Jun 2003 17:41:46 +0200
From: Yoann <linux-yoann@ifrance.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030524 Debian/1.3.1-1.he-1
X-Accept-Language: fr, fr-fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.5.70 compilation fails
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
	The compilation of the kernel 2.5.70 fails

[2.] Full description of the problem/report:
	While making the bzImage with initrd option, the process exits with the
following messages:

....
scripts/fixdep scripts/.empty.o.d scripts/empty.o 'gcc
-Wp,-MD,scripts/.empty.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=pentium3 -Iinclude/asm-i386/mach-default
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=empty
-DKBUILD_MODNAME=empty -c -o scripts/.tmp_empty.o scripts/empty.c' >
scripts/.empty.o.tmp; rm -f scripts/.empty.o.d; mv -f scripts/.empty.o.tmp
scripts/.empty.o.cmd
   MKELF   scripts/elfconfig.h
   HOSTCC  scripts/file2alias.o
   HOSTCC  scripts/modpost.o
   HOSTLD  scripts/modpost
   SPLIT   include/linux/autoconf.h -> include/config/*
make[2]: `arch/i386/kernel/asm-offsets.s' is up to date.
   Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
   CHK     include/linux/compile.h
make[3]: *** No rule to make target `drivers/ide/ide-geometry.s', needed by
`drivers/ide/ide-geometry.o'.  Stop.
make[2]: *** [drivers/ide] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/usr/src/kernel-source-2.5.70'

[3.] Keywords (i.e., modules, networking, kernel):

          --bzimage --initrd kernel_image

[4.] Kernel version (from /proc/version):
Linux version 2.4.20 (root@von) (gcc version 3.2.3 20030415 (Debian
prerelease)) #1 SMP lun mai 19 20:32:10 CEST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)

no oops seen

[6.] A small shell script or example program which triggers the
      problem (if possible)

make-kpkg --bzImage --initrd

[7.] Environment

Debian testing distribution  - bash shell - gcc 3.2.3

[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux bolidino 2.4.20 #1 SMP Thu May 29 23:45:20 CEST 2003 i686 GNU/Linux

Gnu C                  3.3
Gnu make               3.80
util-linux             2.11z-1
mount                  2.11z-1
module-init-tools      2.4.21
e2fsprogs              1.32P-2
PPP                    2.4.1
Linux C Library        2.3.1-16
Procps                 3.1.8-1
Net-tools              1.60-4.1
Console-tools          0.2.3


[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 551.266
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr
bogomips        : 1101.00

[7.3.] Module information (from /proc/modules):

usb-ohci               19976   0 (unused)
loop                    9912   0 (unused)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

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
02f8-02ff : serial(set)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
4000-40ff : PCI CardBus #02
4400-44ff : PCI CardBus #02
a000-afff : PCI Bus #01
   ac80-acff : Silicon Integrated Systems [SiS] SiS630 GUI Accelerator+3D
d000-d0ff : Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
   d000-d0ff : sis900
d400-d4ff : Silicon Integrated Systems [SiS] SiS PCI Audio Accelerator
   d400-d4ff : SiS 7018 PCI Audio
d800-d87f : Silicon Integrated Systems [SiS] 56k Winmodem (Smart Link HAMR5600
compatible)
dc00-dcff : Silicon Integrated Systems [SiS] 56k Winmodem (Smart Link HAMR5600
compatible)
ff00-ff0f : Silicon Integrated Systems [SiS] 5513 [IDE]
   ff00-ff07 : ide0
   ff08-ff0f : ide1

=====

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0dfeffff : System RAM
   00100000-0039aa3f : Kernel code
   0039aa40-00466863 : Kernel data
0dff0000-0dff7fff : ACPI Tables
0dff8000-0dffffff : ACPI Non-volatile Storage
10000000-10000fff : O2 Micro, Inc. OZ6812 Cardbus Controller
10400000-107fffff : PCI CardBus #02
10800000-10bfffff : PCI CardBus #02
cfc00000-dfcfffff : PCI Bus #01
   d0000000-d7ffffff : Silicon Integrated Systems [SiS] SiS630 GUI Accelerator+3D
     d0000000-d1ffffff : sisfb FB
dfe00000-dfefffff : PCI Bus #01
   dfee0000-dfefffff : Silicon Integrated Systems [SiS] SiS630 GUI Accelerator+3D
     dfee0000-dfefffff : sisfb MMIO
dffc0000-dffc0fff : Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet
   dffc0000-dffc0fff : sis900
dffd0000-dffd0fff : Silicon Integrated Systems [SiS] 7001
   dffd0000-dffd0fff : usb-ohci
dffe0000-dffe0fff : Silicon Integrated Systems [SiS] 7001 (#2)
   dffe0000-dffe0fff : usb-ohci
dfff0000-dfff0fff : Silicon Integrated Systems [SiS] SiS PCI Audio Accelerator
e0000000-e3ffffff : Silicon Integrated Systems [SiS] 630 Host
ffef0000-ffefffff : reserved
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 31)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [c0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+
AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=x4

00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
(prog-if 80 [Master])
	Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B step)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 16
	Region 4: I/O ports at ff00 [size=16]

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0

00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100
Ethernet (rev 82)
	Subsystem: Uniwill Computer Corp: Unknown device 5002
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (13000ns min, 2750ns max)
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at d000 [size=256]
	Region 1: Memory at dffc0000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at dffa0000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=160mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.2 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB
Controller (rev 07) (prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS] SiS7001 USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 0: Memory at dffd0000 (32-bit, non-prefetchable) [size=4K]

00:01.3 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB
Controller (rev 07) (prog-if 10 [OHCI])
	Subsystem: Silicon Integrated Systems [SiS] Onboard USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 0: Memory at dffe0000 (32-bit, non-prefetchable) [size=4K]

00:01.4 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS PCI
Audio Accelerator (rev 02)
	Subsystem: Uniwill Computer Corp: Unknown device 5002
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at d400 [size=256]
	Region 1: Memory at dfff0000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=55mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.6 Modem: Silicon Integrated Systems [SiS] Intel 537 [56k Winmodem] (rev
a0) (prog-if 00 [Generic])
	Subsystem: Uniwill Computer Corp: Unknown device 4003
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (13000ns min, 2750ns max)
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at dc00 [size=256]
	Region 1: I/O ports at d800 [size=128]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual
PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: dfe00000-dfefffff
	Prefetchable memory behind bridge: cfc00000-dfcfffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:03.0 CardBus bridge: O2 Micro, Inc. OZ6812 Cardbus Controller (rev 05)
	Subsystem: Uniwill Computer Corp: Unknown device 3000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS630 GUI
Accelerator+3D (rev 31) (prog-if 00 [VGA])
	Subsystem: Uniwill Computer Corp: Unknown device 5002
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	BIST result: 00
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at dfee0000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at ac80 [size=128]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] AGP version 2.0
		Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW-
AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

[7.6.] SCSI information (from /proc/scsi/scsi)

cat: /proc/scsi/scsi: No such file or directory

[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):

[X.] Other notes, patches, fixes, workarounds:

	the ue of gcc-2.95 in place of gcc-3.2 did not help.

[Y.] .Other file
	
	.config for kernel 2.4.20
	http://file.mistur.org/config-2.4.20

	.config used for compilation
	http://file.mistur.org/config-2.5.70

	complet stdout
	http://file.mistur.org/stdout_kernel_compil.log

	complet stderr
	http://file.mistur.org/stderr_kernel_compil.log

[Z.] Other stuff

	It's the first time I try to compile a kernel 2.5.X and it's the first time I 
submit a bug repport, so I use an older bug report and change with my
own information. If there is anything wrong don't hesitate to send me an
email. I don't think there already is a bug report for this bug, if not sorry...
	I'm french and my english is not perfect, sorry for all mistakes

Yoann


