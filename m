Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318357AbSIBTD5>; Mon, 2 Sep 2002 15:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318358AbSIBTD5>; Mon, 2 Sep 2002 15:03:57 -0400
Received: from ns1.netten.pl ([62.233.148.242]:20118 "EHLO janul")
	by vger.kernel.org with ESMTP id <S318357AbSIBTDq>;
	Mon, 2 Sep 2002 15:03:46 -0400
Date: Mon, 2 Sep 2002 21:06:41 +0200
From: janul@wp.pl
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel BUG at page_alloc.c:91!
Message-ID: <20020902190641.GA8645@janul>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.]
can't run logcheck (Segmentation fault): kernel BUG at page_alloc.c:91!

[2.]



[3.]
kernel


[4.]
Linux version 2.4.19 (root@janul) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Sun Aug 18 18:23:48 CEST 2002

[5.]
kernel BUG at page_alloc.c:91!
invalid operand: 0000
CPU:    0
EIP:    0010:[__free_pages_ok+45/612]    Tainted: P
EFLAGS: 00010282
eax: 01000009   ebx: c1204ee8   ecx: c1204ee8   edx: 00000000
esi: 00000000   edi: cb3d7cb0   ebp: 00000019   esp: c05a1ef8
ds: 0018   es: 0018   ss: 0018
Process cat (pid: 11444, stackpage=c05a1000)
Stack: c1204ee8 00001000 cb3d7cb0 00000019 c0a74270 c0114c36 c05a1f3c c07ea220
        c1204ee8 c1204ee8 c1279258 cb3d7cb0 00000018 c012d3d3 c0126eb3 c05a1f8c
        c1204ee8 00000000 00001000 00000000 c284c940 ffffffea 00001000 00001000
Call Trace:    [schedule+714/756] [__free_pages+27/28] [do_generic_file_read+503/1028]
+[generic_file_read+126/304] [file_read_actor+0/140]
  [sys_read+150/240] [system_call+51/56]

Code: 0f 0b 5b 00 53 62 27 c0 89 d8 2b 05 30 76 34 c0 69 c0 a3 8b


And:

/usr/sbin/logcheck: line 315: 11451 Segmentation fault      $LOGTAIL $file $offsetfile >>$TMPDIR/logoutput/$(/usr/bin/basename $file



kernel BUG at page_alloc.c:91!
invalid operand: 0000
CPU:    0
EIP:    0010:[__free_pages_ok+45/612]    Tainted: P
EFLAGS: 00010282
eax: 0100000d   ebx: c1204ee8   ecx: c1204ee8   edx: 00000000
esi: 00000000   edi: cb3d7cb0   ebp: 00000019   esp: c98b7ef8
ds: 0018   es: 0018   ss: 0018
Process logtail (pid: 11451, stackpage=c98b7000)
Stack: c1204ee8 00001000 cb3d7cb0 00000019 00000018 00000002 c5d8ac40 c0126c55
       c1204ee8 c1204ee8 c1279258 cb3d7cb0 00000018 c012d3d3 c0126eb3 c98b7f8c
       c1204ee8 00000000 00001000 00000000 c5d8ac40 ffffffea 00001000 00001000
Call Trace:    [generic_file_readahead+257/312] [__free_pages+27/28] [do_generic_file_read+503/1028]
+[generic_file_read+126/304] [file_read_actor+0/140]
 [sys_read+150/240] [system_call+51/56]

Code: 0f 0b 5b 00 53 62 27 c0 89 d8 2b 05 30 76 34 c0 69 c0 a3 8b

[6.]

2 * * * *       root    test -x /usr/sbin/logcheck && nice -n10 /usr/sbin/logcheck

[7.]

[7.1.]
Linux janul 2.4.19 #1 Sun Aug 18 18:23:48 CEST 2002 i686 unknown unknown GNU/Linux

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
pcmcia-cs              3.1.33
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.15
Modules Loaded         ipx nls_iso8859-1 ipt_REDIRECT iptable_filter ipt_mark ipt_TCPMSS ipt_tcpmss ipt_state ip_nat_ftp ip_conntrack_ftp ip_nat_irc ip_conntrack_irc iptable_nat ip_conntrack ipt_REJECT ip_tables NVdriver sound vfat fat 3c59x

[7.2.]
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 666.711
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1330.38

[7.3.]
ipx                    15668   0
nls_iso8859-1           2848   1 (autoclean)
ipt_REDIRECT             736   0 (unused)
iptable_filter          1728   1
ipt_mark                 480   0 (unused)
ipt_TCPMSS              2304   0 (unused)
ipt_tcpmss               928   0 (unused)
ipt_state                608   2
ip_nat_ftp              3488   0 (unused)
ip_conntrack_ftp        3424   0 [ip_nat_ftp]
ip_nat_irc              2784   0 (unused)
ip_conntrack_irc        2592   0 [ip_nat_irc]
iptable_nat            18516   2 [ipt_REDIRECT ip_nat_ftp ip_nat_irc]
ip_conntrack           20012   4 [ipt_REDIRECT ipt_state ip_nat_ftp ip_conntrack_ftp ip_nat_irc ip_conntrack_irc iptable_nat]
ipt_REJECT              2720   2
ip_tables              12896  10 [ipt_REDIRECT iptable_filter ipt_mark ipt_TCPMSS ipt_tcpmss ipt_state iptable_nat ipt_REJECT]
NVdriver              988512  10 (autoclean)
sound                  53548   0 (unused)
vfat                    9276   0 (unused)
fat                    29176   0 [vfat]
3c59x                  24904   1

[7.4.]
/proc/ioports

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
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
b400-b47f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  b400-b47f : 00:0d.0
b800-b8ff : Advanced System Products, Inc ABP940-U / ABP960-U
  b800-b80f : advansys
d000-d03f : Ensoniq ES1371 [AudioPCI-97]
  d000-d03f : es1371
d400-d41f : VIA Technologies, Inc. UHCI USB
  d400-d41f : usb-uhci
d800-d80f : VIA Technologies, Inc. Bus Master IDE
  d800-d807 : ide0
  d808-d80f : ide1

/proc/iomem

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d3fff : Extension ROM
000f0000-000fffff : System ROM
00100000-0bffbfff : System RAM
  00100000-0026d3c6 : Kernel code
  0026d3c7-003156d7 : Kernel data
0bffc000-0bffefff : ACPI Tables
0bfff000-0bffffff : ACPI Non-volatile Storage
df000000-df00007f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
df800000-df8000ff : Advanced System Products, Inc ABP940-U / ABP960-U
e0000000-e1dfffff : PCI Bus #01
  e0000000-e0ffffff : nVidia Corporation Vanta [NV6]
e1f00000-e3ffffff : PCI Bus #01
  e2000000-e3ffffff : nVidia Corporation Vanta [NV6]
e4000000-e7ffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
ffff0000-ffffffff : reserved


[7.5.]


00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
	Subsystem: Asustek Computer, Inc.: Unknown device 8017
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x2
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: e0000000-e1dfffff
	Prefetchable memory behind bridge: e1f00000-e3ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] (rev 23)
	Subsystem: Asustek Computer, Inc.: Unknown device 8017
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 11) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management (rev 30)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:09.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at d000 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 SCSI storage controller: Advanced System Products, Inc ABP940-U / ABP960-U (rev 03)
	Subsystem: Advanced System Products, Inc ASC1300 SCSI Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at b800 [size=256]
	Region 1: Memory at df800000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0d.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 64)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at b400 [size=128]
	Region 1: Memory at df000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e2000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at e1ff0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=x2



[7.6.]
Attached devices: none

[7.7.]


