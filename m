Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316082AbSENVpc>; Tue, 14 May 2002 17:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316085AbSENVpc>; Tue, 14 May 2002 17:45:32 -0400
Received: from adsl-132-170.wanadoo.be ([213.177.132.170]:45875 "EHLO
	slack.local") by vger.kernel.org with ESMTP id <S316082AbSENVp0> convert rfc822-to-8bit;
	Tue, 14 May 2002 17:45:26 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Pol <blenderman@wanadoo.be>
Reply-To: blenderman@wanadoo.be
To: linux-kernel@vger.kernel.org
Subject: Oops again with 2.4.19-pre8
Date: Tue, 14 May 2002 23:45:19 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200205142345.25173.blenderman@wanadoo.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Yop yop,

Like the first message I post here 2 days ago, I have been told to apply the 
latest patch to the kernel before reporting oops. I currently use 2.5.15 
without any problem if I do not set the ide0 = ata100 in the lilo.
So that's what I did ...

here is my oops at the start of my machine:

Unable to handle kernel NULL pointer dereference at virtual address 00000018
printing eip: 00000018
*pde = 00000000
Oops = 0000
CPU = 1
EIP = 0010:[<00000018>]   Not tainted
EFLAGS = 00010246
ttyS00 at 0x02f8  (irq = 4) is a 16550A
esi: c2018000    edi: c01051c0    ebp: 00000000   esp: c2019fb0
Stack: ttyS01 at 0x02f8 (irq = 3) is a 16550A
c0105252   00000002   00000000   00000000   c02c3f16   00000bfc   00000bfc
00000286   fffff404   00000292   c02a5e40   00000000   00000001   00000286
00000001   0000002a   c01171c8   c031f9ca   00000000   c01170de
Call trace: [<c0105252>] [<c01171c8>] [<c01170de>]
Code: Bad EIP value.
<0> Kernel Panic: Attempted to kill the idle task!
In idle task - Not syncing

***************    Some informations:   *************************

[23:37:32][root@slack:/home/blenderman]# cat /proc/version  
Linux version 2.5.15 (root@slack) (gcc version 2.95.3 20010315 (release)) #1 
SMP Sat May 11 23:02:24 CEST 2002


[23:38:05][root@slack:/home/blenderman]# perl 
/usr/src/linux-2.5.15/scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux slack 2.5.15 #1 SMP Sat May 11 23:02:24 CEST 2002 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.19
util-linux             2.11f
mount                  2.11b
modutils               2.4.14
e2fsprogs              1.22
pcmcia-cs              3.1.26
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         pwcx-i386 pwc videodev mga agpgart fealnx mii crc32 
analog gameport emu10k1 sound ac97_codec soundcore joydev

[23:38:19][root@slack:/home/blenderman]# cat /proc/modules 
pwcx-i386              87136   1
pwc                    34976   1 [pwcx-i386]
videodev                4992   0 [pwc]
mga                   104880   3
agpgart                13024   3
fealnx                 11720   1
mii                     1408   0 [fealnx]
crc32                    824   1 [fealnx]
analog                  7360   0 (unused)
gameport                1528   0 [analog]
emu10k1                61632   0
sound                  56908   0 [emu10k1]
ac97_codec              9632   0 [emu10k1]
soundcore               3556   0 [emu10k1 sound]
joydev                  7616   0 (unused)
[23:38:56][root@slack:/home/blenderman]# 
[23:38:56][root@slack:/home/blenderman]# cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 1002.287
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips        : 1998.84

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 1002.287
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips        : 1998.84

[23:39:14][root@slack:/home/blenderman]# cat /proc/ioports 
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
02f8-02ff : serial(auto)
0376-0376 : ide1
03bc-03be : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
d000-d00f : VIA Technologies, Inc. Bus Master IDE
  d000-d007 : ide0
  d008-d00f : ide1
d400-d41f : VIA Technologies, Inc. UHCI USB
  d400-d41f : usb-uhci
d800-d81f : VIA Technologies, Inc. UHCI USB (#2)
  d800-d81f : usb-uhci
dc00-dc1f : Creative Labs SB Live! EMU10k1
  dc00-dc1f : EMU10K1
e000-e007 : Creative Labs SB Live!
e400-e4ff : PCI device 1516:0803 (MYSON Technology Inc)
  e400-e4ff : à~r÷è~r÷è~r÷ð~r÷ð~r÷

[23:39:34][root@slack:/home/blenderman]# cat /proc/iomem  
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-3fffffff : System RAM
  00100000-002678ad : Kernel code
  002678ae-002dc373 : Kernel data
c0000000-cfffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
d0000000-d1ffffff : PCI Bus #01
  d0000000-d1ffffff : Matrox Graphics, Inc. MGA G400 AGP
d2000000-d4ffffff : PCI Bus #01
  d2000000-d2003fff : Matrox Graphics, Inc. MGA G400 AGP
  d3000000-d37fffff : Matrox Graphics, Inc. MGA G400 AGP
d6000000-d60003ff : PCI device 1516:0803 (MYSON Technology Inc)
  d6000000-d60003ff : à~r÷è~r÷è~r÷ð~r÷ð~r÷
fec00000-ffffffff : reserved

[23:40:26][root@slack:/home/blenderman]# lspci -vvv | more
00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort
- - <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at c0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x2
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot
- -,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] (prog-if 
0
0 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort
- - <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: d2000000-d4ffffff
        Prefetchable memory behind bridge: d0000000-d1ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot
- -,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Step
ping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort
- - <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot
- -,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) 
(pr
og-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort
- - <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot
- -,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16) (prog-if 
0
0 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort
- - <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot
- -,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16) (prog-if 
0
0 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort
- - <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot
- -,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40
)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort
- - <MAbort- >SERR- <PERR-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot
- -,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 07)
        Subsystem: Creative Labs: Unknown device 8061
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort
- - <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at dc00 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot
- -,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.1 Input device controller: Creative Labs SB Live! (rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort
- - <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at e000 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot
- -,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 Ethernet controller: MYSON Technology Inc: Unknown device 0803
        Subsystem: MYSON Technology Inc: Unknown device 0803
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort
- - <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e400 [size=256]
        Region 1: Memory at d6000000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [88] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA 
PME(D0-,D1+,D2-,D3h
ot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) 
(
prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G400 Dual Head Max
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort
- - <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at d2000000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at d3000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot
- -,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x2

[23:41:23][root@slack:/home/blenderman]# dmesg | more 
Linux version 2.5.15 (root@slack) (gcc version 2.95.3 20010315 (release)) #1 
SMP
 Sat May 11 23:02:24 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000040000000 (usable)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
128MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5fd0
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 262144
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32768 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: BOOT_IMAGE=2.5.15 root=302
Initializing CPU#0
Detected 1002.287 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1998.84 BogoMIPS
Memory: 1035216k/1048576k available (1438k kernel code, 12972k reserved, 466k 
da
ta, 228k init, 131072k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 0a
per-CPU timeslice cutoff: 731.04 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1998.84 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (3997.69 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not 
co
nnected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 19.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 002 02  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  1    1    0   1   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    0    0   0   0    1    1    71
 0a 003 03  1    1    0   1   0    1    1    79
 0b 003 03  1    1    0   1   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1002.2684 MHz.
..... host bus clock speed is 133.6356 MHz.
cpu: 0, clocks: 1336356, slice: 445452
CPU0<T0:1336352,T1:890896,D:4,S:445452,C:1336356>
cpu: 1, clocks: 1336356, slice: 445452
CPU1<T0:1336352,T1:445440,D:8,S:445452,C:1336356>
checking TSC synchronization across CPUs: passed.
migration_task 0 on cpu=0
migration_task 1 on cpu=1
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb2c0, last bus=1
PCI: Using configuration type 1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI->APIC IRQ transform: (B0,I7,P3) -> 5
PCI->APIC IRQ transform: (B0,I7,P3) -> 5
PCI->APIC IRQ transform: (B0,I14,P0) -> 10
PCI->APIC IRQ transform: (B0,I16,P0) -> 11
PCI->APIC IRQ transform: (B1,I0,P0) -> 10
Starting kswapd
highmem bounce pool size: 64 pages
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
PCI: Enabling Via external APIC routing
parport0: PC-style at 0x3bc [PCSPP(,...)]
parport_pc: Via 686A parallel port: io=0x3BC
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
IS
APNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
block: 256 slots per queue, batch=32
FDC 0 is a post-1991 82077
ATA/ATAPI driver v7.0.0
ATA: system bus speed 33MHz
ATA: VIA Technologies, Inc. Bus Master IDE (1106:0571) on PCI slot 00:07.1
ATA: chipset rev.: 6
ATA: non-legacy mode: IRQ probe delayed
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: IC35L080AVVA07-0, ATA DISK drive
hda: IRQ probe failed (0xfffffff8)
hdc: 40X CD-ROM, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 160836480 sectors w/1863KiB Cache, CHS=159560/16/63, UDMA(33)
hdc: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: [PTBL] [10011/255/63] hda1 hda2
uhci.c: USB Universal Host Controller Interface driver v1.1
uhci.c: USB UHCI at I/O 0xd400, IRQ 5
hcd.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found at /
hub.c: 2 ports detected
uhci.c: USB UHCI at I/O 0xd800, IRQ 5
hcd.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found at /
hub.c: 2 ports detected
usb.c: registered new driver hid
hid-core.c: v1.31:USB HID core driver
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.0 (8192 buckets, 65536 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
found reiserfs format "3.6" with standard journal
hub.c: new USB device 00:07.2-1, assigned address 2
hid-core.c: ctrl urb status -32 received
input.c: calling /sbin/hotplug input [HOME=/ 
PATH=/sbin:/bin:/usr/sbin:/usr/bin 
ACTION=add PRODUCT=3/45e/40/121 NAME=Microsoft Microsoft Wheel Mouse Optical®]
input.c: hotplug returned -2
input,hiddev0: USB HID v1.00 Mouse [Microsoft Microsoft Wheel Mouse Optical®] 
on 
usb-00:07.2-1
hub.c: new USB device 00:07.2-2, assigned address 3
usb.c: USB device 3 (vend/prod 0x41e/0x400c) is not claimed by any active 
driver
.
Reiserfs journal params: device 03:02, size 8192, journal first block 18, max 
tr
ans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,2)) for (ide0(3,2))
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 228k freed
Adding Swap: 1951856k swap-space (priority -1)
Creative EMU10K1 PCI Audio Driver, version 0.16, 23:07:13 May 11 2002
emu10k1: EMU10K1 rev 7 model 0x8061 found, IO at 0xdc00-0xdc1f, IRQ 10
ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708)
fealnx.c:v2.51 Nov-17-2001
eth0: 100/10M Ethernet PCI Adapter at 0xe400, 00:02:44:20:58:f1, IRQ 11.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 256M @ 0xc0000000
[drm] AGP 0.99 on VIA Apollo Pro @ 0xc0000000 256MB
[drm] Initialized mga 3.0.2 20010321 on minor 0
blk: queue c0382c84, I/O limit 4095Mb (mask 0xffffffff)
Linux video capture interface: v1.00
pwc Philips PCA645/646 + PCVC675/680/690 + PCVC730/740/750 webcam module 
version
 8.5 loaded.
pwc Also supports the Askey VC010, Logitech Quickcam 3000 Pro, Samsung MPC-C10 
a
nd MPC-C30, the Creative WebCam 5 and the SOTEC CMS-001.
usb.c: registered new driver Philips webcam
pwc Creative Labs Webcam 5 detected.
pwc Registered as /dev/video0.
pwc Philips webcam decompressor routines version 8.2
pwc Supports all cameras supported by the main module (pwc).

[23:43:20][root@slack:/home/blenderman]# hdparm -I /dev/hda | more

/dev/hda:

non-removable ATA device, with non-removable media
powers-up in standby; SET FEATURES subcmd spins-up.

        WARNING: ID response incomplete.
        WARNING: Following data may be incorrect.

        Model Number:           IC35L080AVVA07-0                        
        Serial Number:                VNC400A4G1GK9A
        Firmware Revision:      VA4OA50K
Standards:
        Used: ATA/ATAPI-5 T13 1321D revision 1 
        Supported: 2 3 4 5 
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        bytes/track:    0               (obsolete)
        bytes/sector:   0               (obsolete)
        current sector capacity: 16514064
        LBA user addressable sectors = 160836480
Capabilities:
        LBA, IORDY(can be disabled)
        Buffer size: 1863.5kB   ECC bytes: 52   Queue depth: 32
        Standby timer values: spec'd by standard, no device specific minimum
        r/w multiple sector transfer: Max = 16  Current = 16
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 udma10 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
                release interrupt
           *    look-ahead
           *    write cache
           *    Power Management feature set
                Security Mode feature set
           *    SMART feature set
                SET MAX security extension
                Address offset used (large drive)
                SET FEATURES subcommand required to spinup after power up
                Power-Up In Standby feature set
                Advanced Power Management feature set
           *    READ/WRITE DMA QUEUED
Security: 
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
        48min for SECURITY ERASE UNIT. 
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
Checksum: correct




- -- 
- -pol-
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE84YV1EIL3A0sGDSERAjBnAJ9o4x3lkatYR33OH/yaUaJQDe1W9wCdFVjL
HIETmS+cblFpZB2Qubbr96E=
=XnM5
-----END PGP SIGNATURE-----

