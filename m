Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315191AbSEaGvI>; Fri, 31 May 2002 02:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315182AbSEaGvI>; Fri, 31 May 2002 02:51:08 -0400
Received: from mgw-x2.nokia.com ([131.228.20.22]:58347 "EHLO mgw-x2.nokia.com")
	by vger.kernel.org with ESMTP id <S315171AbSEaGvF> convert rfc822-to-8bit;
	Fri, 31 May 2002 02:51:05 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: PROBLEM: PS/2 mouse movements cause lock up of all mouse and keyboard input
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Fri, 31 May 2002 08:51:02 +0200
Message-ID: <C81155EA3E579046A8894738881BBEDD4CF0D0@waebe001.NOE.Nokia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROBLEM: PS/2 mouse movements cause lock up of all mouse and keyboard input
Thread-Index: AcIH+QCubziGd3P3EdaaKwCAx/YHKQ==
From: <Krzysztof.Dubowik@nokia.com>
To: <rubini@vision.unipv.it>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 31 May 2002 06:51:03.0551 (UTC) FILETIME=[87FA38F0:01C2086F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  I would like to report a kernel problem with PS/2 input.

1. Summary: PS/2 mouse movements cause lock up of all mouse and keyboard input

2. Description: When I move the mouse it gets locked up after a while. Both mouse and keyboard stop to respond. I reckon it is not gpm or XFree related prolem because is occurs with gpm started and XFree stopped and vice-versa. Also 'cat /dev/mouse' results in mouse and keyboard lockup. My computer has no network card so I cannot test if I can access it via network after mouse and keyboard blocks. However I believe it is not a complete kernel freeze because XFree starts the screensaver even if my mouse and keyboard stopped working before.
I wanted to do some kernel debugging, but I had some problem understanding kernel-debug HowTo and I did not know where to start, sorry :( I believe you will need some kernel traces, so please provide me with information of what you need.

3. Keywords: ps/2, mouse

4. Kernel version: 2.4.7-10 (provided with Redhat 7.2), but it also occured with 2.4.7 recompiled by me and 2.4.18 also compiled myself.

5. Environment:

scripts/ver_linux:

Linux localhost.localdomain 2.4.7-10 #1 Thu Sep 6 17:27:27 EDT 2001 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.6
e2fsprogs              tune2fs
reiserfsprogs          3.x.0j
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         nls_iso8859-1 nls_cp437 vfat fat binfmt_misc ipchains usb-uhci usbcore


/proc/cpuinfo:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 6
model name	: Celeron (Mendocino)
stepping	: 5
cpu MHz		: 400.917
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 799.53


/proc/modules:

nls_iso8859-1           2832   1 (autoclean)
nls_cp437               4352   1 (autoclean)
vfat                    9584   1 (autoclean)
fat                    32384   0 (autoclean) [vfat]
binfmt_misc             6416   1
ipchains               39200   0
usb-uhci               21536   0 (unused)
usbcore                51712   1 [usb-uhci]


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
0213-0213 : isapnp read
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f0-03f5 : floppy
03f6-03f6 : ide0
03f7-03f7 : floppy DIR
03f8-03ff : serial(auto)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
d000-dfff : PCI Bus #01
e000-e01f : Intel Corporation 82371AB PIIX4 USB
  e000-e01f : usb-uhci
e400-e43f : US Robotics/3Com USR 56k Internal WinModem
f000-f00f : Intel Corporation 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1


/proc/iomem:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0dfeffff : System RAM
  00100000-0023d5ff : Kernel code
  0023d600-002541cb : Kernel data
0dff0000-0dff2fff : ACPI Non-volatile Storage
0dff3000-0dffffff : ACPI Tables
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : nVidia Corporation NV11
e8000000-ebffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
ec000000-edffffff : PCI Bus #01
  ec000000-ecffffff : nVidia Corporation NV11
ee000000-ee00ffff : US Robotics/3Com USR 56k Internal WinModem
ee010000-ee017fff : US Robotics/3Com USR 56k Internal WinModem
ee018000-ee01803f : US Robotics/3Com USR 56k Internal WinModem
ffff0000-ffffffff : reserved


`lspci -vvv`:

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: ec000000-edffffff
	Prefetchable memory behind bridge: e0000000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at e000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:14.0 Communication controller: US Robotics/3Com USR 56k Internal WinModem
	Subsystem: US Robotics/3Com: Unknown device 00b2
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at ee018000 (32-bit, prefetchable) [size=64]
	Region 1: Memory at ee000000 (32-bit, prefetchable) [size=64K]
	Region 2: Memory at ee010000 (32-bit, prefetchable) [size=32K]
	Region 3: I/O ports at e400 [size=64]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV11 (rev b2) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at ed000000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


/proc/interrupts;

           CPU0       
  0:     133013          XT-PIC  timer
  1:       2939          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  6:         39          XT-PIC  floppy
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  usb-uhci
 12:         28          XT-PIC  PS/2 Mouse
 14:      20428          XT-PIC  ide0
 15:         30          XT-PIC  ide1
NMI:          0 
ERR:          0


/proc/misc:

135 rtc
  1 psaux
134 apm_bios



-- 
Krzysiek
