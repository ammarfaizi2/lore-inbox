Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759738AbWLDWOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759738AbWLDWOT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 17:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937164AbWLDWOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 17:14:19 -0500
Received: from lns-th2-5f-81-56-194-193.adsl.proxad.net ([81.56.194.193]:45894
	"EHLO philou.philou.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1759738AbWLDWOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 17:14:17 -0500
Date: Mon, 4 Dec 2006 23:14:13 +0100
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= <philippe@gramoulle.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: PROBLEM: 2.6.19: OOPS upon boot (not always)
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.18; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20061204221413.D014DEF@philou.gramoulle.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

[1.] One line summary of the problem:

Kernel oops upon boot, but not always. When it boots ok, then PC's working fine.

[2.] Full description of the problem/report:

Following the release of the 2.6.19 kernel, i installed it and after few
reboots , i caught this oops:

Picture's here : http://philou.org/2.6.19/2.6.19.crash.at.boot.jpg
config's  here : http://philou.org/2.6.19/config

Kernel oops upon boot, but not always. OOPS happened in a "one out of ten reboots"

Machine is a Desktop x86 Pentium 4, running Debian Sid

[3.] Keywords (i.e., modules, networking, kernel):

Boot, panic, init, kmap_atomic

[4.] Kernel version (from /proc/version):

Linux version 2.6.19 (root@p4) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-20)) #3 SMP PREEMPT Sun Dec 3 23:15:34 CET 2006

[5.] Most recent kernel version which did not have the bug:

Former kernel was 2.6.18.2 and things were ok, though i had a similar behavior:
2.6.18.2 once panicked out of 200 or 300 reboots.

[6.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

Panicked too early i think, picture is available here :

http://philou.org/2.6.19/2.6.19.crash.at.boot.jpg

[7.] A small shell script or example program which triggers the
     problem (if possible)
[8.] Environment
[8.1.] Software (add the output of the ver_linux script here)

Linux p4 2.6.19 #3 SMP PREEMPT Sun Dec 3 23:15:34 CET 2006 i686 GNU/Linux
 
Gnu C                  4.1.2
Gnu make               3.81
binutils               2.17
util-linux             2.12r
mount                  2.12r
module-init-tools      3.3-pre2
e2fsprogs              1.40-WIP
reiserfsprogs          3.6.19
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.97
udev                   103
Modules Loaded         nvidia eth1394 usbhid snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_emu10k1 ohci1394 ieee1394 snd_rawmidi snd_util_mem snd_hwdep psmouse ehci_hcd
uhci_hcd

[8.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping	: 9
cpu MHz		: 3198.592
cache size	: 512 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips	: 6399.25

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping	: 9
cpu MHz		: 3198.592
cache size	: 512 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips	: 6396.02

[8.3.] Module information (from /proc/modules):

nvidia 4539732 12 - Live 0xf90c5000 (P)
eth1394 16132 0 - Live 0xf8bbf000
usbhid 29316 0 - Live 0xf8b97000
snd_emu10k1_synth 6144 0 - Live 0xf8a4e000
snd_emux_synth 30336 1 snd_emu10k1_synth, Live 0xf8a58000
snd_seq_virmidi 5504 1 snd_emux_synth, Live 0xf8a4b000
snd_seq_midi_emul 6016 1 snd_emux_synth, Live 0xf8a48000
snd_emu10k1 107584 1 snd_emu10k1_synth, Live 0xf895b000
ohci1394 30640 0 - Live 0xf8931000
ieee1394 279384 2 eth1394,ohci1394, Live 0xf8978000
snd_rawmidi 18336 2 snd_seq_virmidi,snd_emu10k1, Live 0xf891a000
snd_util_mem 3584 2 snd_emux_synth,snd_emu10k1, Live 0xf883e000
snd_hwdep 6788 2 snd_emux_synth,snd_emu10k1, Live 0xf883b000
psmouse 33160 0 - Live 0xf8910000
ehci_hcd 25736 0 - Live 0xf88fa000
uhci_hcd 19976 0 - Live 0xf88f2000

[8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
0290-0297 : pnp 00:09
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f8-03ff : serial
0400-041f : 0000:00:1f.3
0480-04bf : 0000:00:1f.0
0680-06ff : pnp 00:09
0800-087f : 0000:00:1f.0
  0800-0803 : ACPI PM1a_EVT_BLK
  0804-0805 : ACPI PM1a_CNT_BLK
  0808-080b : ACPI PM_TMR
  0828-082f : ACPI GPE0_BLK
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #02
  cf80-cf9f : 0000:02:01.0
    cf80-cf9f : e1000
d000-dfff : PCI Bus #03
  dc00-dc7f : 0000:03:03.0
  df80-df9f : 0000:03:0a.0
    df80-df9f : EMU10K1
  dfe0-dfe7 : 0000:03:0a.1
    dfe0-dfe7 : emu10k1-gp
e800-e8ff : 0000:00:1f.5
  e800-e8ff : Intel ICH5
ee80-eebf : 0000:00:1f.5
  ee80-eebf : Intel ICH5
eec0-eedf : 0000:00:1d.0
  eec0-eedf : uhci_hcd
ef00-ef1f : 0000:00:1d.1
  ef00-ef1f : uhci_hcd
ef20-ef3f : 0000:00:1d.2
  ef20-ef3f : uhci_hcd
ef40-ef5f : 0000:00:1d.3
  ef40-ef5f : uhci_hcd
ef90-ef9f : 0000:00:1f.2
  ef90-ef9f : libata
efa0-efa7 : 0000:00:1f.2
  efa0-efa7 : libata
efa8-efab : 0000:00:1f.2
  efa8-efab : libata
efac-efaf : 0000:00:1f.2
  efac-efaf : libata
efe0-efe7 : 0000:00:1f.2
  efe0-efe7 : libata
fc00-fc0f : 0000:00:1f.1
  fc00-fc07 : ide0
  fc08-fc0f : ide1
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-3ff2ffff : System RAM
  00100000-00396d79 : Kernel code
  00396d7a-0047c423 : Kernel data
3ff30000-3ff3ffff : ACPI Tables
3ff40000-3ffeffff : ACPI Non-volatile Storage
3fff0000-3fffffff : reserved
50000000-500003ff : 0000:00:1f.1
dff00000-efefffff : PCI Bus #01
  e0000000-e7ffffff : 0000:01:00.0
f0000000-f7ffffff : 0000:00:00.0
fa800000-fe8fffff : PCI Bus #01
  fc000000-fcffffff : 0000:01:00.0
  fd000000-fdffffff : 0000:01:00.0
    fd000000-fdffffff : nvidia
  fe8e0000-fe8fffff : 0000:01:00.0
fe900000-fe9fffff : PCI Bus #02
  fe9e0000-fe9fffff : 0000:02:01.0
    fe9e0000-fe9fffff : e1000
fea00000-feafffff : PCI Bus #03
  feaff800-feafffff : 0000:03:03.0
    feaff800-feafffff : ohci1394
febff400-febff4ff : 0000:00:1f.5
  febff400-febff4ff : Intel ICH5
febff800-febff9ff : 0000:00:1f.5
  febff800-febff9ff : Intel ICH5
febffc00-febfffff : 0000:00:1d.7
  febffc00-febfffff : ehci_hcd
ffb80000-ffffffff : reserved


[8.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 82875P/E7210 Memory Controller Hub (rev 02)
	Subsystem: ASUSTeK Computer Inc. Unknown device 80f6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [e4] Vendor Specific Information
	Capabilities: [a0] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=2 SBA+ AGP+ GART64- 64bit- FW- Rate=x8

00:01.0 PCI bridge: Intel Corporation 82875P Processor to AGP Controller (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fa800000-fe8fffff
	Prefetchable memory behind bridge: dff00000-efefffff
	Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:03.0 PCI bridge: Intel Corporation 82875P/E7210 Processor to PCI to CSA Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fe900000-fe9fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. P5P800-MX Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 4: I/O ports at eec0 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. P5P800-MX Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at ef00 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. P5P800-MX Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 16
	Region 4: I/O ports at ef20 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #4 (rev 02) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. P5P800-MX Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 4: I/O ports at ef40 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. P5P800-MX Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 20
	Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fea00000-feafffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC Interface Bridge (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc. P5P800-MX Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at fc00 [size=16]
	Region 5: Memory at 50000000 (32-bit, non-prefetchable) [size=1K]

00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: ASUSTeK Computer Inc. P4P800 SE Mainboard
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at efe0 [size=8]
	Region 1: I/O ports at efac [size=4]
	Region 2: I/O ports at efa0 [size=8]
	Region 3: I/O ports at efa8 [size=4]
	Region 4: I/O ports at ef90 [size=16]

00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
	Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 0400 [size=32]

00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
	Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at e800 [size=256]
	Region 1: I/O ports at ee80 [size=64]
	Region 2: Memory at febff800 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at febff400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV40 [GeForce 6800] (rev a1) (prog-if 00 [VGA])
	Subsystem: Giga-byte Technology Unknown device 310f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Region 2: Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
	[virtual] Expansion ROM at fe8e0000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 3.0
		Status: RQ=256 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x8

02:01.0 Ethernet controller: Intel Corporation 82547EI Gigabit Ethernet Controller
	Subsystem: ASUSTeK Computer Inc. Unknown device 80f7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (63750ns min), Cache Line Size: 16 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fe9e0000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at cf80 [size=32]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-

03:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. A8V Deluxe
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns max), Cache Line Size: 16 bytes
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at feaff800 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at dc00 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
	Subsystem: Creative Labs SBLive! Player 5.1
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 22
	Region 0: I/O ports at df80 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:0a.1 Input device controller: Creative Labs SB Live! Game Port (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at dfe0 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[8.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Maxtor 6V300F0   Rev: VA11
  Type:   Direct-Access                    ANSI SCSI revision: 05


[8.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[8.8] Other notes, patches, fixes, workarounds:

ACPI Patch found here is applied :

ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.19/acpi-release-20060707-2.6.19.diff.gz


Following ~/Documentation/BUG-HUNTING:

objdump --disassemble foo.o gives:

$ objdump --disassemble foo.o

foo.o:     file format elf32-i386

Disassembly of section .text:

00000000 <_main-0x40>:
   0:	4c                   	dec    %esp
   1:	c0 29 c2             	shrb   $0xc2,(%ecx)
   4:	8b 02                	mov    (%edx),%eax
   6:	85 c0                	test   %eax,%eax
   8:	75 21                	jne    2b <_main-0x15>
   a:	2b 0d 80 a2 4d c0    	sub    0xc04da280,%ecx
  10:	c1 f9 05             	sar    $0x5,%ecx
  13:	c1 e1 0c             	shl    $0xc,%ecx
  16:	0b 0d d8 56 4c c0    	or     0xc04c56d8,%ecx
  1c:	89 0a                	mov    %ecx,(%edx)
  1e:	8d 46 43             	lea    0x43(%esi),%eax
  21:	c1 e0 0c             	shl    $0xc,%eax
  24:	29 c3                	sub    %eax,%ebx
  26:	89 d8                	mov    %ebx,%eax
  28:	5b                   	pop    %ebx
  29:	5e                   	pop    %esi
  2a:	c3                   	ret    
  2b:	0f 0b                	ud2a   
  2d:	2a 00                	sub    (%eax),%al
  2f:	bf eb 3b c0 eb       	mov    $0xebc03beb,%edi
  34:	d5 89                	aad    $0xffffff89
  36:	c8 5b 5e e9          	enter  $0x5e5b,$0xe9
  3a:	15 19 03 00 56       	adc    $0x56000319,%eax
  3f:	53                   	push   %ebx


Thanks,

Philippe
