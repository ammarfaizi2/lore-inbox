Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbSI2TYL>; Sun, 29 Sep 2002 15:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261751AbSI2TYL>; Sun, 29 Sep 2002 15:24:11 -0400
Received: from main.math.cornell.edu ([128.84.234.61]:48390 "EHLO
	main.math.cornell.edu") by vger.kernel.org with ESMTP
	id <S261742AbSI2TYF>; Sun, 29 Sep 2002 15:24:05 -0400
Date: Sun, 29 Sep 2002 15:29:06 -0400
From: Franco Saliola <saliola@polygon.math.cornell.edu>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel BUG in usb-ohci.c:902!
Message-ID: <20020929152906.A5092@main.math.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I thought this error may be of interest to someone on this list. My
computer called it a kernel BUG. I wasn't sure how much information was
needed, so I played it say and filled out the bug reporting form to the
best of my ability. If you are only interested in seeing the error
message, go all the way to the bottom of the message. It's the last
thing in this mail.

I'm not subscribed to this list, please copy me on any replies,
thoughts, suggestions. Thank you.

Franco

----- bug report -----

[1.] One line summary of the problem:    

	A bug in usb-ohci.c that causes my laptop (Presario 2800) to freeze.

[2.] Full description of the problem/report:

	The output from my machine is included all the way at the bottom of
	this message, section 7.7.
	
	The system is a Compaq Preasrio 2800 laptop. If I hit the FN+F2 key
	combination, to activate the stupid wireless lan multiport module,
	the system freezes. Sometimes it must be hit twice in succession, to
	get the bug to freeze the system, but most of the time once will do.
	I get a bug report, but I don't know what it means. I'd like to get
	some information about this. In particular, how to fix it. :-)

[3.] Keywords (i.e., modules, networking, kernel):

	kernel, modules, networking, wireless lan

[4.] Kernel version (from /proc/version):

	Linux version 2.4.19-16mdk (quintela@bi.mandrakesoft.com) (gcc
	version 3.2 (Mandrake Linux 9.0 3.2-1mdk)) #1 Fri Sep 20 18:15:05
	CEST 2002

	I had the same problem with Mandrake Linux 8.2.

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
     problem (if possible)

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
 
Linux localhost.localdomain 2.4.19-16mdk #1 Fri Sep 20 18:15:05 CEST 2002 i686 unknown unknown GNU/Linux
 
Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11u
mount                  2.11u
modutils               2.4.19
e2fsprogs              1.27ea
pcmcia-cs              3.2.0
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.15
Modules Loaded         sr_mod floppy irtty irda i810_audio soundcore ac97_codec nfsd lockd sunrpc ds yenta_socket pcmcia_core prism2_usb p80211 af_packet ip_vs e100 nls_cp850 vfat fat nls_iso8859-1 ntfs supermount ide-cd cdrom ide-scsi scsi_mod ehci-hcd usb-ohci usbcore rtc ext3 jbd
	

[7.2.] Processor information (from /proc/cpuinfo):


processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 Mobile CPU 1.40GHz
stepping	: 4
cpu MHz		: 1196.146
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 2385.51


[7.3.] Module information (from /proc/modules):


sr_mod                 15096   0 (autoclean) (unused)
floppy                 49340   0 (autoclean)
irtty                   5984   2 (autoclean)
irda                   87152   1 (autoclean) [irtty]
i810_audio             21352   0
soundcore               3780   0 [i810_audio]
ac97_codec              9928   0 [i810_audio]
nfsd                   66576   0 (autoclean)
lockd                  46480   0 (autoclean) [nfsd]
sunrpc                 60188   0 (autoclean) [nfsd lockd]
ds                      6828   1
yenta_socket            9728   1
pcmcia_core            42272   0 [ds yenta_socket]
prism2_usb             59088   0 (unused)
p80211                 10792   0 [prism2_usb]
af_packet              13000   1 (autoclean)
ip_vs                  74328   0 (autoclean)
e100                   53268   1 (autoclean)
nls_cp850               3580   1 (autoclean)
vfat                    9588   1 (autoclean)
fat                    31864   0 (autoclean) [vfat]
nls_iso8859-1           2844   2 (autoclean)
ntfs                   72908   1 (autoclean)
supermount             14340   2 (autoclean)
ide-cd                 28712   0
cdrom                  26848   0 [sr_mod ide-cd]
ide-scsi                8212   0
scsi_mod               90372   2 [sr_mod ide-scsi]
ehci-hcd               14472   0 (unused)
usb-ohci               18216   0 (unused)
usbcore                58304   1 [prism2_usb ehci-hcd usb-ohci]
rtc                     6560   0 (autoclean)
ext3                   74004   3
jbd                    38452   3 [ext3]


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
0376-0376 : ide1
03c0-03df : vesafb
03e8-03ef : serial(auto)
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
2000-2fff : PCI Bus #02
  2000-203f : Intel Corp. 82801CAM (ICH3) Chipset Ethernet Controller
    2000-203f : e100
  2040-2047 : Conexant HSF 56k HSFi Modem
3000-3fff : PCI Bus #01
  3000-30ff : ATI Technologies Inc Radeon Mobility M7 LW
4000-40ff : Intel Corp. 82801CA/CAM AC'97 Audio
  4000-40ff : Intel ICH3
4400-443f : Intel Corp. 82801CA/CAM AC'97 Audio
  4400-443f : Intel ICH3
4440-444f : Intel Corp. 82801CAM IDE U100


/proc/iomem:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffcffff : System RAM
  00100000-0022614c : Kernel code
  0022614d-0029547f : Kernel data
0ffd0000-0fff0bff : reserved
0fff0c00-0fffbfff : ACPI Non-volatile Storage
0fffc000-0fffffff : reserved
10000000-100003ff : Intel Corp. 82801CAM IDE U100
40000000-402fffff : PCI Bus #02
  40000000-4000ffff : Conexant HSF 56k HSFi Modem
  40080000-40080fff : Texas Instruments PCI1410 PC card Cardbus Controller
  40100000-40100fff : Intel Corp. 82801CAM (ICH3) Chipset Ethernet Controller
    40100000-40100fff : e100
  40180000-40180fff : NEC Corporation USB
    40180000-40180fff : usb-ohci
  40200000-40200fff : NEC Corporation USB (#2)
    40200000-40200fff : usb-ohci
  40280000-402800ff : NEC Corporation USB 2.0
    40280000-402800ff : ehci-hcd
40300000-403fffff : PCI Bus #01
  40300000-4030ffff : ATI Technologies Inc Radeon Mobility M7 LW
48000000-4fffffff : PCI Bus #01
  48000000-4fffffff : ATI Technologies Inc Radeon Mobility M7 LW
    48000000-49feffff : vesafb
60000000-6fffffff : Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge


[7.5.] PCI information ('lspci -vvv' as root)


00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
	Subsystem: Compaq Computer Corporation: Unknown device 004a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at 60000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [e4] #09 [d104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW+ Rate=x1

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: 40300000-403fffff
	Prefetchable memory behind bridge: 48000000-4fffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=03, sec-latency=32
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: 40000000-402fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Compaq Computer Corporation: Unknown device 004a
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at <unassigned> [size=8]
	Region 1: I/O ports at <unassigned> [size=4]
	Region 2: I/O ports at <unassigned> [size=8]
	Region 3: I/O ports at <unassigned> [size=4]
	Region 4: I/O ports at 4440 [size=16]
	Region 5: Memory at 10000000 (32-bit, non-prefetchable) [disabled] [size=1K]

00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 02)
	Subsystem: Compaq Computer Corporation: Unknown device 004a
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at 4000 [size=256]
	Region 1: I/O ports at 4400 [size=64]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW (prog-if 00 [VGA])
	Subsystem: Compaq Computer Corporation: Unknown device 004a
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 48000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at 40300000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2,x4
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:04.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device 8d88
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at 40000000 (32-bit, non-prefetchable) [size=64K]
	Region 1: I/O ports at 2040 [size=8]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:06.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 02)
	Subsystem: Compaq Computer Corporation: Unknown device 004a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 40080000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=176
	Memory window 0: 00000000-00000000 (prefetchable)
	Memory window 1: 00000000-00000000
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) Chipset Ethernet Controller (rev 42)
	Subsystem: Compaq Computer Corporation: Unknown device 0093
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 40100000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 2000 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:0e.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 004a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 40 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 40180000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0e.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 004a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 40 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin B routed to IRQ 10
	Region 0: Memory at 40200000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0e.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
	Subsystem: Compaq Computer Corporation: Unknown device 004a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 8500ns max), cache line size 08
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at 40280000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)


Attached devices: 
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: TOSHIBA  Model: DVD-ROM SD-R2102 Rev: 1A16
  Type:   CD-ROM                           ANSI SCSI revision: 02


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Here is the output I got from the computer. 

kernel BUG at usb-ohci.c:902!
invalid operand: 0000
CPU:	0
EIP:	0010:[<d291dd63>]	Not tainted
EFLAGS:	00010286
eax: 0000003a	ebx: cf46dc10	ecx: 00000000	edx: cebd0000
esi: 00000000	edi: 00000002	ebp: c0297ed8	esp: c0297e84
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0297000)
Stack: d2920f40 cff3ba76 00000002 cf797800 cf46d610 00000202 c025f1f8 00000046
       cff37fd8 c0297ecc c01191a8 00000046 00000001 d291f66a cf422000 00000001
       00000000 00000002 cecfa800 ce526000 cd558000 c0297ee8 d290e135 cecfa800
Call Trace:    [<d2920f40>] [<c01191a8>] [<d291f66a>] [<d290e135>] [<d2a30e2a>]
  [<d2a30e10>] [<c0123f2c>] [<c01236ed>] [<c01202e2>] [<c01201d4>] [<c012000a>]
  [<c010a416>] [<c010c8c8>] [<c0110018>] [<c01071a4>] [<c0114b35>] [<c0114a80>]
  [<c0107212>] [<c0105000>]

Code: 0f 0b 86 03 0a 0e 92 d2 83 c4 0c e9 75 ff ff ff 57 68 15 0e
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
