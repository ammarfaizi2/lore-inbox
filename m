Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265899AbTF3VVv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 17:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbTF3VVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 17:21:51 -0400
Received: from host217-44-93-77.range217-44.btcentralplus.com ([217.44.93.77]:25817
	"EHLO camilya.cohen-waisel.org") by vger.kernel.org with ESMTP
	id S265899AbTF3VVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 17:21:43 -0400
From: "Ron Cohen" <rony@rony.clara.net>
To: <linux-kernel@vger.kernel.org>
Subject: kernel panic at high cpu utils
Date: Mon, 30 Jun 2003 22:30:50 +0100
Message-ID: <JJEILJCCDLIBIAEDMIIBGEPLCPAA.rony@rony.clara.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_002F_01C33F57.427EB290"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_002F_01C33F57.427EB290
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

[1.] One line summary of the problem:
 
   kernel panic under heavy cpu utilization

[2.] Full description of the problem/report:

[3.] Keywords (i.e., modules, networking, kernel):
kernel
[4.] Kernel version (from /proc/version):

Linux version 2.4.21 (root@pchome) (gcc version 3.2.2 20030222 (Red Hat Linux 3.
2.2-5)) #2 Sat Jun 28 22:53:23 BST 2003

(Also tested with 2.4.20)

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

CPU0 Machine check exception 0000000000000004
Kernel Panic: CPU context corrupt
(sysreq does not work) 

[6.] A small shell script or example program which triggers the
     problem (if possible)

running seti@home for a few seconds.

[7.] Environment
asus A7v8x-x, AMD athlon 2100 xp, RH 9.0, Elsa erazor III, 256MB ddr.
, 
[7.1.] Software (add the output of the ver_linux script here)
Linux pchome 2.4.21 #1 Sun Jun 29 16:30:48 BST 2003 i686 athlon i386 GNU/Linux

Gnu C                  3.2.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
modutils               2.4.22
e2fsprogs              1.32
jfsutils               1.0.17
reiserfsprogs          3.6.4
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               4.5.3
Modules Loaded         vfat fat loop lvm-mod

[7.2.] Processor information (from /proc/cpuinfo):


[7.3.] Module information (from /proc/modules):

loop                   11544   0 (autoclean)
lvm-mod                48320   0

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
rony@pchome rony]$ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0fffbfff : System RAM
  00100000-00244e3d : Kernel code
  00244e3e-0029e903 : Kernel data
0fffc000-0fffefff : ACPI Tables
0ffff000-0fffffff : ACPI Non-volatile Storage
f3000000-f30000ff : VIA Technologies, Inc. VT6102 [Rhine-II]
  f3000000-f30000ff : via-rhine
f3800000-f38000ff : VIA Technologies, Inc. USB 2.0
f4000000-f5efffff : PCI Bus #01
  f4000000-f4ffffff : nVidia Corporation NV5 [Riva TnT2]
f5f00000-f7ffffff : PCI Bus #01
  f6000000-f7ffffff : nVidia Corporation NV5 [Riva TnT2]
f8000000-fbffffff : VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[rony@pchome rony]$ cat /proc/ioports
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
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
b400-b4ff : VIA Technologies, Inc. VT6102 [Rhine-II]
  b400-b4ff : via-rhine
b800-b80f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  b800-b807 : ide0
  b808-b80f : ide1
d000-d01f : VIA Technologies, Inc. USB (#3)
d400-d41f : VIA Technologies, Inc. USB (#2)
d800-d81f : VIA Technologies, Inc. USB
e000-e0ff : VIA Technologies, Inc. VT8233 AC97 Audio Controller
  e000-e0ff : via82cxxx_audio


[7.5.] PCI information ('lspci -vvv' as root)
See attached 

[7.6.] SCSI information (from /proc/scsi/scsi)
N/A
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

using software raid 1

Installed win2k on a free partition and run seti@home for hours with no problems.

[X.] Other notes, patches, fixes, workarounds:
None

Thanks
	Ron Cohen



---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.493 / Virus Database: 292 - Release Date: 25/06/2003

------=_NextPart_000_002F_01C33F57.427EB290
Content-Type: text/plain;
	name="lspci.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="lspci.txt"

00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host =
Bridge
	Subsystem: Asustek Computer, Inc.: Unknown device 807f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=3D64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=3D31 SBA+ 64bit- FW- Rate=3Dx1,x2,x4
		Command: RQ=3D31 SBA- AGP- 64bit- FW- Rate=3D<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge (prog-if 00 =
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: f4000000-f5efffff
	Prefetchable memory behind bridge: f5f00000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 =
[UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 4: I/O ports at d800 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 =
[UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at d400 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 =
[UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at d000 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if =
20 [EHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at f3800000 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	Subsystem: Asustek Computer, Inc.: Unknown device 80a1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus =
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at b800 [size=3D16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 =
Audio Controller (rev 50)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a1
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 3
	Region 0: I/O ports at e000 [size=3D256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] =
(rev 74)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at b400 [size=3D256]
	Region 1: Memory at f3000000 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV5 [RIVA =
TNT2/TNT2 Pro] (rev 15) (prog-if 00 [VGA])
	Subsystem: Elsa AG: Unknown device 0c31
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=3D16M]
	Region 1: Memory at f6000000 (32-bit, prefetchable) [size=3D32M]
	Expansion ROM at f5ff0000 [disabled] [size=3D64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=3D31 SBA+ 64bit- FW- Rate=3Dx1,x2,x4
		Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>


------=_NextPart_000_002F_01C33F57.427EB290--

