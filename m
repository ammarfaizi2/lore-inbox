Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264418AbTLGMNV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 07:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264416AbTLGMNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 07:13:20 -0500
Received: from kuravelli.mail.saunalahti.fi ([195.197.172.113]:65175 "EHLO
	kuravelli.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S264419AbTLGMND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 07:13:03 -0500
Date: Sun, 7 Dec 2003 14:17:07 +0200
From: Anssi Saari <as@sci.fi>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.23 freezes with XFree86 and Radeon 9600 Pro
Message-ID: <20031207121707.GA8198@sci.fi>
Mail-Followup-To: Anssi Saari <as@sci.fi>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] One line summary of the problem:    
Linux 2.4.23 freezes with XFree86 and Radeon 9600 Pro

[2.] Full description of the problem/report:

Linux 2.4.23 (and 2.4.22) freezes with XFree86 and Radeon 9600
Pro (Sapphire Radeon 9600 Pro Atlantis Ultimate Edition), if
"XaaScreenToScreenCopy" option is enabled, i.e. if I don't have Option
"XaaNoScreenToScreenCopy" in XF86Config-4. The freeze seems total, machine
stops responding to pings from network and magic sysrq does nothing. With
the XaaNoScreenToScreenCopy things are fine except very slow, of course.

No error messages appear in XFree86.log and no OOPS is produced.

Versions of XFree86 tried so far:
4.1.0 with ATI binary drivers
4.2.0 with ATI binary drivers
4.3.0 with ATI binary drivers
4.3.0 with XFree86 native support for Radeon 9700, by making XFRee86 
      believe the 9600 Pro is really a 9700 with ChipID option
4.3.99.16 developement version with native support for Radeon 9600

ATI binary drivers hang as soon as X starts, XF86 drivers when first
bitblit kind of operation is done, i.e. draw a mwnu or scroll an Xterm.

I have also found that on the same system, this freeze doesn't happen
with Linux 2.6.0-test11 and XFree86 4.3.99.16 or FreeBSD 4.7-STABLE and
XFree86 4.3.0. The card also works fine in Windows XP. My previous Radeon 7500
also worked without problems, 2D and 3D acceleration both.

This freezing seems specific to Linux 2.4 and my particular hardware.
I suppose it might be my somewhat rare chipset, SiS 745 on an ASUS
A7S333 motherboard.

[3.] Keywords (i.e., modules, networking, kernel):

XFree86, freezing, linux 2.4, Radeon 9600 Pro, SiS 745.

[4.] Kernel version (from /proc/version):

Linux version 2.4.23 (as@dorkstar) (gcc version 2.95.4 20011002 (Debian
prerelease)) #1 Sun Nov 30 23:24:09 EET 2003

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux dorkstar 2.4.23 #1 Sun Nov 30 23:24:09 EET 2003 i686 unknown unknown GNU/Linux
 
 Gnu C                  2.95.4
 Gnu make               3.79.1
 util-linux             2.11n
 mount                  2.11n
 modutils               2.4.21
 e2fsprogs              1.27
 Linux C Library        2.3.2
 Dynamic linker (ldd)   2.3.2
 Procps                 3.1.9
 Net-tools              1.60
 Console-tools          0.2.3
 Sh-utils               2.0.12
 Modules Loaded         cmpci soundcore sg ncr53c8xx ide-scsi sr_mod cdrom scsi_mod it87 i2c-proc i2c-isa i2c-core autofs4 lirc_serial ipt_length ipt_REJECT ipt_limit ipt_multiport ipt_LOG ipt_state iptable_nat iptable_filter ip_tables rtc 3c59x nls_iso8859-1 nls_cp437 vfat fat apm mousedev hid input usb-ohci usbcore ip_conntrack_ftp ip_conntrack

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) XP 1900+
stepping        : 2
cpu MHz         : 1600.064
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3191.60

[7.3.] Module information (from /proc/modules):

cmpci                  27644   0 (autoclean)
soundcore               3524   2 (autoclean) [cmpci]
sg                     29220   0 (autoclean)
ncr53c8xx              51840   0 (autoclean)
ide-scsi                9056   0 (autoclean)
sr_mod                 13784   0 (autoclean)
cdrom                  29024   0 (autoclean) [sr_mod]
scsi_mod               93256   4 (autoclean) [sg ncr53c8xx ide-scsi sr_mod]
it87                    6848   0 (unused)
i2c-proc                6304   0 [it87]
i2c-isa                 1220   0 (unused)
i2c-core               12928   0 [it87 i2c-proc i2c-isa]
autofs4                 8548   2 (autoclean)
lirc_serial             7488   0
ipt_length               480   2 (autoclean)
ipt_REJECT              3264   2 (autoclean)
ipt_limit                960   4 (autoclean)
ipt_multiport            640   5 (autoclean)
ipt_LOG                 3296  13 (autoclean)
ipt_state                608   3 (autoclean)
iptable_nat            15252   1 (autoclean)
iptable_filter          1760   1 (autoclean)
ip_tables              11264  10 [ipt_length ipt_REJECT ipt_limit ipt_multiport ipt_LOG ipt_state iptable_nat iptable_filter]
rtc                     5980   0 (autoclean)
3c59x                  25000   1 (autoclean)
nls_iso8859-1           2848   2 (autoclean)
nls_cp437               4384   2 (autoclean)
vfat                    9564   2 (autoclean)
fat                    30008   0 (autoclean) [vfat]
apm                     9352   1
mousedev                3904   1
hid                    21696   0 (unused)
input                   3360   0 [mousedev hid]
usb-ohci               17920   0 (unused)
usbcore                57440   1 [hid usb-ohci]
ip_conntrack_ftp        3744   0 (unused)
ip_conntrack           18740   3 [ipt_state iptable_nat ip_conntrack_ftp]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

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
0290-0297 : it87
02f8-02ff : lirc_serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
7800-78ff : LSI Logic / Symbios Logic 53c810
  7800-787f : ncr53c8xx
8000-800f : CMD Technology Inc PCI0649
  8000-8007 : ide2
  8008-800f : ide3
8400-8403 : CMD Technology Inc PCI0649
8800-8807 : CMD Technology Inc PCI0649
9000-9003 : CMD Technology Inc PCI0649
  9002-9002 : ide2
9400-9407 : CMD Technology Inc PCI0649
  9400-9407 : ide2
9800-987f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
  9800-987f : 00:08.0
a000-a0ff : C-Media Electronics Inc CM8738
  a000-a0ff : cmpci
b800-b80f : Silicon Integrated Systems [SiS] 5513 [IDE]
  b800-b807 : ide0
  b808-b80f : ide1
d000-dfff : PCI Bus #01
  d800-d8ff : PCI device 1002:4150 (ATI Technologies Inc)

/proc/iomem:
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d4000-000d7fff : Extension ROM
000f0000-000fffff : System ROM
00100000-1fffbfff : System RAM
  00100000-001fd997 : Kernel code
  001fd998-0027009f : Kernel data
1fffc000-1fffefff : ACPI Tables
1ffff000-1fffffff : ACPI Non-volatile Storage
b5000000-b50000ff : LSI Logic / Symbios Logic 53c810
b5800000-b580007f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
b6000000-b6000fff : Silicon Integrated Systems [SiS] USB 1.0 Controller (#2)
  b6000000-b6000fff : usb-ohci
b6800000-b6800fff : Silicon Integrated Systems [SiS] USB 1.0 Controller
  b6800000-b6800fff : usb-ohci
b7000000-b7ffffff : PCI Bus #01
  b7000000-b700ffff : PCI device 1002:4170 (ATI Technologies Inc)
  b7800000-b780ffff : PCI device 1002:4150 (ATI Technologies Inc)
    b7800000-b780ffff : radeonfb
b8000000-bbffffff : Silicon Integrated Systems [SiS] 745 Host
c0000000-febfffff : PCI Bus #01
  c0000000-cfffffff : PCI device 1002:4170 (ATI Technologies Inc)
  e0000000-efffffff : PCI device 1002:4150 (ATI Technologies Inc)
    e0000000-efffffff : radeonfb
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0745 (rev 01)
	Subsystem: Asustek Computer, Inc.: Unknown device 8083
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at b8000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [c0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: b7000000-b7ffffff
	Prefetchable memory behind bridge: c0000000-febfffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 (LPC Bridge)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:02.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8083
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin D routed to IRQ 6
	Region 0: Memory at b6800000 (32-bit, non-prefetchable) [size=4K]

00:02.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8083
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at b6000000 (32-bit, non-prefetchable) [size=4K]

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
	Subsystem: Asustek Computer, Inc.: Unknown device 8083
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Region 4: I/O ports at b800 [size=16]

00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: Asustek Computer, Inc.: Unknown device 80e2
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at a000 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 9800 [size=128]
	Region 1: Memory at b5800000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0a.0 RAID bus controller: CMD Technology Inc PCI0649 (rev 02)
	Subsystem: CMD Technology Inc: Unknown device 3649
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 9400 [size=8]
	Region 1: I/O ports at 9000 [size=4]
	Region 2: I/O ports at 8800 [size=8]
	Region 3: I/O ports at 8400 [size=4]
	Region 4: I/O ports at 8000 [size=16]
	Expansion ROM at <unassigned> [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=3 PME-

00:0b.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c810 (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 6
	Region 0: I/O ports at 7800 [size=256]
	Region 1: Memory at b5000000 (32-bit, non-prefetchable) [size=256]

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4150 (prog-if 00 [VGA])
	Subsystem: Unknown device 174b:7c19
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at b7800000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at dffe0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=79 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.1 Display controller: ATI Technologies Inc: Unknown device 4170
	Subsystem: Unknown device 174b:7c18
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Region 0: Memory at c0000000 (32-bit, prefetchable) [size=256M]
	Region 1: Memory at b7000000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: TEAC     Model: DV-W50E          Rev: 1.30
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: NEC      Model: CD-ROM DRIVE:462 Rev: 1.16
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 02 Lun: 00
  Vendor: RICOH    Model: CD-R/RW MP7060S  Rev: 1.70
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

