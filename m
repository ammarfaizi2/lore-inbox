Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268039AbTBMNkL>; Thu, 13 Feb 2003 08:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268040AbTBMNkK>; Thu, 13 Feb 2003 08:40:10 -0500
Received: from [196.3.142.204] ([196.3.142.204]:20508 "EHLO [196.3.142.204]")
	by vger.kernel.org with ESMTP id <S268039AbTBMNkE>;
	Thu, 13 Feb 2003 08:40:04 -0500
Message-ID: <3E4BA394.9040706@illuminatnm.com>
Date: Thu, 13 Feb 2003 09:54:28 -0400
From: Kevin Hale Boyes <kevin.haleboyes@illuminatnm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: strange ide-scsi state
Content-Type: multipart/mixed;
 boundary="------------040401000305040407050402"
X-OriginalArrivalTime: 13 Feb 2003 13:42:51.0250 (UTC) FILETIME=[CD7D6520:01C2D365]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040401000305040407050402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I've attached a bug report using the format described in
http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html

I hope it is useful.

Kevin.

--------------040401000305040407050402
Content-Type: text/plain;
 name="linux-bug-report.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-bug-report.txt"


[1.] One line summary of the problem:

	ide-scsi sometimes gets into a strange state.

[2.] Full description of the problem/report:

	Every so often my system becomes very sluggish due to what appears to be excessive logging.
	It usually occurs when I've stopped working for the day and the computer is "idle".

	A snippet from /var/log/messages (and then the ATAPI reset and messages repeat until I reboot):

Feb 12 19:14:16 tigger kernel: scsi : aborting command due to timeout : pid 13943353, scsi0, channel 0, id 0, lun 0 Read TOC 00 00 00 00 00 00 00 0c 00 
Feb 12 19:14:16 tigger kernel: hdc: lost interrupt
Feb 12 19:14:16 tigger kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Feb 12 19:14:16 tigger kernel: hdc: ATAPI reset complete
Feb 12 19:14:16 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:16 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:16 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:16 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:16 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:16 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:16 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:16 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:16 tigger kernel: hdc: ATAPI reset complete
Feb 12 19:14:16 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: ATAPI reset complete
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: scsi0 channel 0 : resetting for second half of retries.
Feb 12 19:14:18 tigger kernel: SCSI bus is being reset for host 0 channel 0.
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: ATAPI reset complete
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: ATAPI reset complete
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: ATAPI reset complete
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: ATAPI reset complete
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: sr0: CDROM (ioctl) error, command: Read TOC 00 00 00 00 00 00 00 0c 00 
Feb 12 19:14:18 tigger kernel: sr00:00: old sense key None
Feb 12 19:14:18 tigger kernel: Non-extended sense class 0 code 0x0
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
Feb 12 19:14:18 tigger kernel: hdc: status error: status=0x00 { }
Feb 12 19:14:18 tigger kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted

[3.] Keywords (i.e., modules, networking, kernel):

	ide, ide-scsi, ATAPI, timeout

[4.] Kernel version (from /proc/version):

	Redhat 7.3
	Linux version 2.4.18-19.7.x (bhcompile@stripples.devel.redhat.com) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-112)) #1 Thu Dec 12 09:00:42 EST 2002

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

	Not applicable.

[6.] A small shell script or example program which triggers the problem (if possible)

	Not applicable.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

$ sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux tigger 2.4.18-19.7.x #1 Thu Dec 12 09:00:42 EST 2002 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.18
e2fsprogs              1.27
reiserfsprogs          3.x.0j
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         sr_mod i810_audio ac97_codec soundcore binfmt_misc autofs eepro100 ide-scsi scsi_mod ide-cd cdrom nls_iso8859-1 nls_cp437 vfat fat usb-uhci usbcore ext3 jbd

[7.2.] Processor information (from /proc/cpuinfo):

$ cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 1
model name	: Intel(R) Pentium(R) 4 CPU 1.60GHz
stepping	: 2
cpu MHz		: 1594.889
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3164.53


[7.3.] Module information (from /proc/modules):

$ cat /proc/modules
sr_mod                 16056   0 (autoclean)
i810_audio             23136   1 (autoclean)
ac97_codec             12224   0 (autoclean) [i810_audio]
soundcore               6212   2 (autoclean) [i810_audio]
binfmt_misc             7236   1
autofs                 11172   0 (autoclean) (unused)
eepro100               20240   1
ide-scsi                9376   0
scsi_mod              104848   2 [sr_mod ide-scsi]
ide-cd                 30144   0
cdrom                  31936   0 [sr_mod ide-cd]
nls_iso8859-1           3488   1 (autoclean)
nls_cp437               5120   1 (autoclean)
vfat                   11804   1 (autoclean)
fat                    36152   0 (autoclean) [vfat]
usb-uhci               24324   0 (unused)
usbcore                71072   1 [usb-uhci]
ext3                   64768   4
jbd                    47892   4 [ext3]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

$ cat /proc/ioports
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
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
df00-df3f : Intel Corp. 82801BA/BAM/CA/CAM Ethernet Controller
  df00-df3f : eepro100
e800-e8ff : Intel Corp. 82801BA/BAM AC'97 Audio
  e800-e8ff : Intel ICH2
ef00-ef3f : Intel Corp. 82801BA/BAM AC'97 Audio
  ef00-ef3f : Intel ICH2
ef40-ef5f : Intel Corp. 82801BA/BAM USB (Hub #1)
  ef40-ef5f : usb-uhci
ef80-ef9f : Intel Corp. 82801BA/BAM USB (Hub #2)
  ef80-ef9f : usb-uhci
efa0-efaf : Intel Corp. 82801BA/BAM SMBus
ffa0-ffaf : Intel Corp. 82801BA IDE U100
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

$ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cb800-000cc7ff : Extension ROM
000cc800-000cd7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffbffff : System RAM
  00100000-002206b4 : Kernel code
  002206b5-0031459f : Kernel data
1ffc0000-1fff7fff : ACPI Tables
1fff8000-1fffffff : ACPI Non-volatile Storage
f0600000-f46fffff : PCI Bus #01
  f2000000-f3ffffff : nVidia Corporation Vanta [NV6]
f8000000-fbffffff : Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
fc900000-fe9fffff : PCI Bus #01
  fd000000-fdffffff : nVidia Corporation Vanta [NV6]
feaff000-feafffff : Intel Corp. 82801BA/BAM/CA/CAM Ethernet Controller
  feaff000-feafffff : eepro100
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffb80000-ffbfffff : reserved
fff00000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [e4] #09 [9104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fc900000-fe9fffff
	Prefetchable memory behind bridge: f0600000-f46fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fea00000-feafffff
	Prefetchable memory behind bridge: f4700000-f47fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05) (prog-if 80 [Master])
	Subsystem: Intel Corp.: Unknown device 4856
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: [virtual] I/O ports at 01f0
	Region 1: [virtual] I/O ports at 03f4
	Region 2: [virtual] I/O ports at 0170
	Region 3: [virtual] I/O ports at 0374
	Region 4: I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub  (rev 05) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 4856
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 3
	Region 4: I/O ports at ef40 [size=32]

00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
	Subsystem: Intel Corp.: Unknown device 4856
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 9
	Region 4: I/O ports at efa0 [size=16]

00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub  (rev 05) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 4856
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at ef80 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio (rev 05)
	Subsystem: Intel Corp.: Unknown device 6876
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 9
	Region 0: I/O ports at e800 [size=256]
	Region 1: I/O ports at ef00 [size=64]

01:00.0 VGA compatible controller: nVidia Corporation NV6 [Vanta] (rev 15) (prog-if 00 [VGA])
	Subsystem: VISIONTEK: Unknown device 0038
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at f2000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at fe9f0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

02:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM Ethernet Controller (rev 03)
	Subsystem: Intel Corp. EtherExpress PRO/100 VE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at df00 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: _NEC     Model: NR-7900A         Rev: 1.23
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[X.] Other notes, patches, fixes, workarounds:

--------------040401000305040407050402--

