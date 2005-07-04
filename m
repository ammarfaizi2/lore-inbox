Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVGDPfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVGDPfP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 11:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVGDPfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 11:35:15 -0400
Received: from mta10.adelphia.net ([68.168.78.202]:16817 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S261254AbVGDPc3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 11:32:29 -0400
Message-ID: <42C9568B.3010101@adelphia.net>
Date: Mon, 04 Jul 2005 11:32:27 -0400
From: "Rinaldi J. Montessi" <rinaldij@adelphia.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8b2) Gecko/20050702 SeaMonkey/1.0a
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem:  scsi/libata/sata
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

About the time the SCSI subsystem is loaded the hard drive
activity light comes on and never goes out.

The disk is mounted and appears to function correctly:

mount
/dev/hda1 on / type ext2 (rw)
proc on /proc type proc (rw)
/dev/sda1 on /mnt/sda1 type ext3 (rw)
/dev/sda2 on /home type ext3 (rw)
/dev/sda3 on /usr type ext3 (rw)
/dev/sda6 on /storage type ext3 (rw)
/dev/hdb1 on /mnt/MM1 type ext3 (rw)
/dev/hdb2 on /mnt/MM2 type ext3 (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
tmpfs on /dev/shm type tmpfs (rw)

The motherboard is an ASUS P5DA2-E Deluxe (intel 925x chipset).

Western Digital and ASUS both recommended I check the jumper settings,
which I had done.  ASUS also sent me a CD containing updates for the
Windows drivers.  I don't use Windows, and presume the disk to be
not relevant to solving the problem.

The following is submitted per:

http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html

Linux version 2.4.31-pre2 (root@Senior) (gcc version 3.3.5) #2 Fri May
13 12:21:03 EDT 2005

Linux Senior 2.4.31-pre2 #2 Fri May 13 12:21:03 EDT 2005 i686 unknown
unknown GNU/Linux

Gnu C                  3.3.5
Gnu make               3.80
util-linux             2.12p
mount                  2.12p
modutils               2.4.27
e2fsprogs              1.35
jfsutils               1.1.6
xfsprogs               2.6.13
pcmcia-cs              3.2.8
quota-tools            3.12.
PPP                    2.4.2
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Linux C++ Library      5.0.7
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         smbus-arp eeprom i2c-proc i2c-isa i2c-i801
i2c-core snd-pcm-oss snd-mixer-oss snd-hda-intel snd-hda-codec snd-pcm
snd-timer snd snd-page-alloc soundcore nfsd lockd sunrpc ipt_MASQUERADE
iptable_mangle iptable_nat ipt_REJECT ipt_limit ipt_state ip_conntrack
ipt_LOG ipt_ULOG iptable_filter ip_tables af_packet ide-cd tulip crc32
sk98lin lp parport_pc parport

/proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 3
model name      : Intel(R) Pentium(R) 4 CPU 3.40GHz
stepping        : 4
cpu MHz         : 3412.219
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pni
monitor ds_cpl cid
bogomips        : 6815.74

/proc/modules
smbus-arp               4816   0
eeprom                  3564   0
i2c-proc                6084   0 [smbus-arp eeprom]
i2c-isa                  772   0 (unused)
i2c-i801                4988   0 (unused)
i2c-core               15268   0 [smbus-arp eeprom i2c-proc i2c-isa
i2c-i801]
snd-pcm-oss            38272   0
snd-mixer-oss          13464   2 [snd-pcm-oss]
snd-hda-intel           7168   2
snd-hda-codec          38352   0 [snd-hda-intel]
snd-pcm                57992   0 [snd-pcm-oss snd-hda-intel snd-hda-codec]
snd-timer              14436   0 [snd-pcm]
snd                    33284   0 [snd-pcm-oss snd-mixer-oss
snd-hda-intel snd-hda-codec snd-pcm snd-timer]
snd-page-alloc          5000   0 [snd-mixer-oss snd-hda-intel snd-pcm
snd-timer snd]
soundcore               3652   3 [snd]
nfsd                   72560   8
lockd                  48912   1 [nfsd]
sunrpc                 67680   1 [nfsd lockd]
ipt_MASQUERADE          1464   1 (autoclean)
iptable_mangle          2168   0 (autoclean) (unused)
iptable_nat            17614   1 (autoclean) [ipt_MASQUERADE]
ipt_REJECT              3352   8 (autoclean)
ipt_limit                888  29 (autoclean)
ipt_state                536   4 (autoclean)
ip_conntrack           19460   0 (autoclean) [ipt_MASQUERADE iptable_nat
ipt_state]
ipt_LOG                 3448  15 (autoclean)
ipt_ULOG                3588  12 (autoclean)
iptable_filter          1740   1 (autoclean)
ip_tables              12288  11 [ipt_MASQUERADE iptable_mangle
iptable_nat ipt_REJECT ipt_limit ipt_state ipt_LOG ipt_ULOG iptable_filter]
af_packet              13064   1 (autoclean)
ide-cd                 31168   0
tulip                  42304   1
crc32                   2880   0 [tulip]
sk98lin               171824   1
lp                      6660   0
parport_pc             16228   1
parport                24808   1 [lp parport_pc]

/proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0400-041f : PCI device 8086:266a (Intel Corp.)
    0400-040f : i801-smbus
0cf8-0cff : PCI conf1
9880-989f : PCI device 8086:2658 (Intel Corp.)
9c00-9c1f : PCI device 8086:2659 (Intel Corp.)
a000-a01f : PCI device 8086:265a (Intel Corp.)
a080-a09f : PCI device 8086:265b (Intel Corp.)
a400-a40f : PCI device 8086:2652 (Intel Corp.)
    a400-a40f : ahci
a480-a483 : PCI device 8086:2652 (Intel Corp.)
    a480-a483 : ahci
a800-a807 : PCI device 8086:2652 (Intel Corp.)
    a800-a807 : ahci
a880-a883 : PCI device 8086:2652 (Intel Corp.)
    a880-a883 : ahci
ac00-ac07 : PCI device 8086:2652 (Intel Corp.)
    ac00-ac07 : ahci
b000-b00f : Promise Technology, Inc. 20268
    b000-b007 : ide2
    b008-b00f : ide3
b080-b083 : Promise Technology, Inc. 20268
    b082-b082 : ide3
b400-b407 : Promise Technology, Inc. 20268
    b400-b407 : ide3
b480-b483 : Promise Technology, Inc. 20268
    b482-b482 : ide2
b800-b8ff : Linksys Network Everywhere Fast Ethernet 10/100 model NC100
    b800-b8ff : tulip
bc00-bc07 : Promise Technology, Inc. 20268
    bc00-bc07 : ide2
c000-cfff : PCI Bus #02
    c800-c8ff : PCI device 11ab:4362 (Galileo Technology Ltd.)
      c800-c8ff : sk98lin
d000-dfff : PCI Bus #03
e000-efff : PCI Bus #04
    e000-e0ff : PCI device 1002:5b62 (ATI Technologies Inc)
ffa0-ffaf : PCI device 8086:266f (Intel Corp.)
    ffa0-ffa7 : ide0
    ffa8-ffaf : ide1

/proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cd000-000cefff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffaffff : System RAM
    00100000-00236bbe : Kernel code
    00236bbf-002a0ae3 : Kernel data
3ffb0000-3ffbdfff : ACPI Tables
3ffbe000-3ffeffff : ACPI Non-volatile Storage
3fff0000-3fffffff : reserved
cfcf4000-cfcf7fff : PCI device 8086:2668 (Intel Corp.)
    cfcf4000-cfcf7fff : ICH HD audio
cfcff800-cfcffbff : PCI device 8086:265c (Intel Corp.)
cfcffc00-cfcfffff : PCI device 8086:2652 (Intel Corp.)
    cfcffc00-cfcfffff : ahci
cfdf4000-cfdf7fff : Texas Instruments TSB43AB22/A IEEE-1394a-2000
Controller (PHY/Link)
cfdf8000-cfdfbfff : Promise Technology, Inc. 20268
cfdff000-cfdff7ff : Texas Instruments TSB43AB22/A IEEE-1394a-2000
Controller (PHY/Link)
cfdffc00-cfdfffff : Linksys Network Everywhere Fast Ethernet 10/100
model NC100
    cfdffc00-cfdfffff : tulip
cfe00000-cfefffff : PCI Bus #02
    cfefc000-cfefffff : PCI device 11ab:4362 (Galileo Technology Ltd.)
      cfefc000-cfefffff : sk98lin
cff00000-cfffffff : PCI Bus #04
    cffe0000-cffeffff : PCI device 1002:5b62 (ATI Technologies Inc)
    cfff0000-cfffffff : PCI device 1002:5b72 (ATI Technologies Inc)
d0000000-dfffffff : PCI Bus #04
    d0000000-dfffffff : PCI device 1002:5b62 (ATI Technologies Inc)
ffb00000-ffffffff : reserved

lspci -vvv

00:00.0 Host bridge: Intel Corp. Workstation Memory Controller Hub (rev 0e)
	Subsystem: Intel Corp.: Unknown device 2580
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] #09 [0109]

00:01.0 PCI bridge: Intel Corp. Workstation Memory Controller Hub PCI
Express Port (rev 0e) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: cff00000-cfffffff
	Prefetchable memory behind bridge: d0000000-dfffffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [88] #0d [0000]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [a0] #10 [0141]

00:1b.0 Class 0403: Intel Corp.: Unknown device 2668 (rev 04)
	Subsystem: Asustek Computer, Inc.: Unknown device 813d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at cfcf4000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] #10 [0091]

00:1c.0 PCI bridge: Intel Corp. I/O Controller Hub PCI Express Port 0
(rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1c.1 PCI bridge: Intel Corp. I/O Controller Hub PCI Express Port 1
(rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: cfe00000-cfefffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1d.0 USB Controller: Intel Corp. I/O Controller Hub USB (rev 04)
(prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 4: I/O ports at 9880 [size=32]

00:1d.1 USB Controller: Intel Corp. I/O Controller Hub USB (rev 04)
(prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at 9c00 [size=32]

00:1d.2 USB Controller: Intel Corp. I/O Controller Hub USB (rev 04)
(prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at a000 [size=32]

00:1d.3 USB Controller: Intel Corp. I/O Controller Hub USB (rev 04)
(prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 16
	Region 4: I/O ports at a080 [size=32]

00:1d.7 USB Controller: Intel Corp. I/O Controller Hub USB2 (rev 04)
(prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at cfcff800 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [20a0]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI
Bridge (rev d4) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: cfd00000-cfdfffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corp. I/O Controller Hub LPC (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. I/O Controller Hub PATA (rev 04)
(prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at ffa0 [size=16]

00:1f.2 Class 0106: Intel Corp. I/O Controller Hub SATA cc=raid (rev 04)
(prog-if 01)
	Subsystem: Asustek Computer, Inc.: Unknown device 2606
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 0: I/O ports at ac00 [size=8]
	Region 1: I/O ports at a880 [size=4]
	Region 2: I/O ports at a800 [size=8]
	Region 3: I/O ports at a480 [size=4]
	Region 4: I/O ports at a400 [size=16]
	Region 5: Memory at cfcffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.3 SMBus: Intel Corp. I/O Controller Hub SMBus (rev 04)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at 0400 [size=32]

01:03.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A
IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max), cache line size 04
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at cfdff000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at cfdf4000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0a.0 Unknown mass storage controller: Promise Technology, Inc. 20268
(rev 01) (prog-if 85)
	Subsystem: Promise Technology, Inc. Ultra100TX2
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 4500ns max), cache line size 04
	Interrupt: pin A routed to IRQ 21
	Region 0: I/O ports at bc00 [size=8]
	Region 1: I/O ports at b480 [size=4]
	Region 2: I/O ports at b400 [size=8]
	Region 3: I/O ports at b080 [size=4]
	Region 4: I/O ports at b000 [size=16]
	Region 5: Memory at cfdf8000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at cfde0000 [disabled] [size=16K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:0b.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet
10/100 model NC100 (rev 11)
	Subsystem: Linksys: Unknown device 0574
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min, 63750ns max), cache line size 04
	Interrupt: pin A routed to IRQ 22
	Region 0: I/O ports at b800 [size=256]
	Region 1: Memory at cfdffc00 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at cfdc0000 [disabled] [size=128K]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 Ethernet controller: Marvell: Unknown device 4362 (rev 19)
	Subsystem: Asustek Computer, Inc.: Unknown device 8142
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR+ <PERR-
	Latency: 0, cache line size 04
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at cfefc000 (64-bit, non-prefetchable) [size=16K]
	Region 2: I/O ports at c800 [size=256]
	Expansion ROM at cfec0000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [e0] #10 [0011]

04:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device
5b62 (prog-if 00 [VGA])
	Subsystem: PC Partner Limited: Unknown device 0450
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Region 1: I/O ports at e000 [size=256]
	Region 2: Memory at cffe0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at cffc0000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #10 [0001]
	Capabilities: [80] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

04:00.1 Display controller: ATI Technologies Inc: Unknown device 5b72
	Subsystem: PC Partner Limited: Unknown device 0451
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04
	Region 0: Memory at cfff0000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #10 [0001]

/proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
    Vendor: ATA      Model: WDC WD1200JD-00H Rev: 08.0
    Type:   Direct-Access                    ANSI SCSI revision: 05

Rinaldi
-- 
The day after tomorrow is the third day of the rest of your life.




