Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283589AbRLCXqX>; Mon, 3 Dec 2001 18:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281819AbRLCXe1>; Mon, 3 Dec 2001 18:34:27 -0500
Received: from FSG1.nws.noaa.gov ([140.90.20.103]:65455 "EHLO
	fsg1.nws.noaa.gov") by vger.kernel.org with ESMTP
	id <S284927AbRLCSa3>; Mon, 3 Dec 2001 13:30:29 -0500
Date: Mon, 3 Dec 2001 13:30:23 -0500 (EST)
From: Brian McEntire <brianm@fsg1.nws.noaa.gov>
To: <linux-kernel@vger.kernel.org>, <mingo@redhat.com>
cc: <systems@clifford.nws.noaa.gov>
Subject: PROBLEM: system hangs on dual 1GHz PIII system with 2.4.13-ac8
Message-ID: <Pine.LNX.4.33.0112031300001.25875-400000@fsg1.nws.noaa.gov>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1519150868-225816453-1007404223=:25875"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1519150868-225816453-1007404223=:25875
Content-Type: TEXT/PLAIN; charset=US-ASCII

PROBLEM: system hangs on dual 1GHz PIII system with 2.4.13-ac8

Full Description:
  This system has frequent lockups. Lockups used to occur every few days
or as infrequently as once per two weeks. That was with the early 2.4.x
kernels. Since moving to the latest stable ac-series kernel, the kernel
stayed up two weeks (to the day) before the system hung.

Keywords: SMP, Dual CPU PIII, kernel hang, Paging Request, Virtual Address

Kernel version (from /proc/version):
Linux version 2.4.13-ac8 (root@willscarlet) (gcc version 2.96 20000731 
(Red Hat Linux 7.1 2.96-98)) #2 SMP Mon Nov 19 16:05:19 EST 2001

Oops output run through ksymoops:

ksymoops 2.4.1 on i686 2.4.13-ac8.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.13-ac8/ (default)
     -m /boot/System.map-2.4.13-ac8 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 810426b4
c0112995
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[smp_apic_timer_interrupt+21/272]    Not tainted
EIP:    0010:[<c0112995>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 3036342d   ebx: 00000000   ecx: 000002df   edx: e5027af8
esi: 3036342d   edi: 080d6fec   ebp: c2c8c31c   esp: e5027ad0
ds: 0018   es: 0018   ss: 0018
Process mvall (pid: 21006, stackpage=e5026000)
Stack: d67cb720 bffff9bc bffff6e8 00000b5c 00001000 fe00a484 080d6fec 
c2c8c31c
       c010b491 e5027af8 00001000 000002df e5027ba0 fe00a484 080d6fec 
c2c8c31c
       00000000 00000018 fe000018 ffffffef c0128d20 00000010 00010206 
00000001
Call Trace: [call_apic_timer_interrupt+5/16] [file_read_actor+112/224] 
[do_generic_file_read+550/1216] [generic_file_read+94/128] 
[file_read_actor+0/224]
Call Trace: [<c010b491>] [<c0128d20>] [<c0128a16>] [<c0128dee>] 
[<c0128cb0>]
   [<c0136e46>] [<c0106f1b>] [<c0106f1b>] [<c01173b4>] [<c011ad2a>] 
[<c0136989>]
   [<c012701f>] [<c0106f1b>] [<c0136989>] [<c012701f>] [<c0106f1b>] 
[<c0106f1b>]
Code: ff 04 b5 00 56 2b c0 c1 e0 05 89 1d b0 e0 ff ff ff 80 24 b5

>>EIP; c0112995 <smp_apic_timer_interrupt+15/110>   <=====
Trace; c010b491 <call_apic_timer_interrupt+5/10>
Trace; c0128d20 <file_read_actor+70/e0>
Trace; c0128a16 <do_generic_file_read+226/4c0>
Trace; c0128dee <generic_file_read+5e/80>
Trace; c0128cb0 <file_read_actor+0/e0>
Trace; c0136e46 <sys_read+96/d0>
Trace; c0106f1b <system_call+2f/34>
Trace; c0106f1b <system_call+2f/34>
Trace; c01173b4 <__mmdrop+24/30>
Trace; c011ad2a <do_exit+21a/230>
Trace; c0136989 <filp_close+89/a0>
Trace; c012701f <sys_munmap+2f/50>
Trace; c0106f1b <system_call+2f/34>
Trace; c0136989 <filp_close+89/a0>
Trace; c012701f <sys_munmap+2f/50>
Trace; c0106f1b <system_call+2f/34>
Trace; c0106f1b <system_call+2f/34>
Code;  c0112995 <smp_apic_timer_interrupt+15/110>
00000000 <_EIP>:
Code;  c0112995 <smp_apic_timer_interrupt+15/110>   <=====
   0:   ff 04 b5 00 56 2b c0      incl   0xc02b5600(,%esi,4)   <=====
Code;  c011299c <smp_apic_timer_interrupt+1c/110>
   7:   c1 e0 05                  shl    $0x5,%eax
Code;  c011299f <smp_apic_timer_interrupt+1f/110>
   a:   89 1d b0 e0 ff ff         mov    %ebx,0xffffe0b0
Code;  c01129a5 <smp_apic_timer_interrupt+25/110>
  10:   ff 80 24 b5 00 00         incl   0xb524(%eax)


1 warning issued.  Results may not be reliable.

Script to reproduce: N/A ... seems to occure randomly, even under light 
load.

Environment:

Software (report from ver_linux):
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux willscarlet 2.4.13-ac8 #2 SMP Mon Nov 19 16:05:19 EST 2001 i686 
unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.6
e2fsprogs              1.23
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         eepro100 st ext3 jbd

* This is a Redhat 7.2 system (upgraded from RH 7.1.) The kernel is a 
vanilla 2.4.13 kernel with the 2.4.13-ac8 patch applied and then compiled. 
The system is a dual CPU -- 1GHz PIII -- Via Apollo Pro chipset based 
system with SCSI on the mother board. It has 2GB physical RAM and .5GB 
swap space.

Processor information (from /proc/cpuinfo):
WS$more /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 1004.520
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
bogomips        : 2005.40

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 1004.520
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
bogomips        : 2005.40

Module information (from /proc/modules):
WS$cat /proc/modules
eepro100               17408   1
st                     26352   0 (unused)
ext3                   58192   4 (autoclean)
jbd                    38720   4 (autoclean) [ext3]

Loaded driver and hardware information (/proc/ioports, /proc/iomem):
WS$cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
a800-a8ff : Adaptec 7892A
  a800-a8ff : aic7xxx
b000-b0ff : LSI Logic / Symbios Logic (formerly NCR) 53c1010 Ultra3 SCSI 
Adapter (#2)
  b000-b0ff : sym53c8xx
b400-b4ff : LSI Logic / Symbios Logic (formerly NCR) 53c1010 Ultra3 SCSI 
Adapter
  b400-b4ff : sym53c8xx
b800-b83f : Intel Corporation 82557 [Ethernet Pro 100]
  b800-b83f : eepro100
d000-d01f : VIA Technologies, Inc. UHCI USB (#2)
d400-d41f : VIA Technologies, Inc. UHCI USB
d800-d80f : VIA Technologies, Inc. Bus Master IDE
e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]

WS$cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cc7ff : Extension ROM
000d0000-000d65ff : Extension ROM
000f0000-000fffff : System ROM
00100000-7fffbfff : System RAM
  00100000-00219640 : Kernel code
  00219641-0026dc9f : Kernel data
7fffc000-7fffefff : ACPI Tables
7ffff000-7fffffff : ACPI Non-volatile Storage
ea800000-ea800fff : Adaptec 7892A
  ea800000-ea800fff : aic7xxx
eb000000-eb001fff : LSI Logic / Symbios Logic (formerly NCR) 53c1010 
Ultra3 SCSI Adapter (#2)
eb800000-eb8003ff : LSI Logic / Symbios Logic (formerly NCR) 53c1010 
Ultra3 SCSI Adapter (#2)
ec000000-ec001fff : LSI Logic / Symbios Logic (formerly NCR) 53c1010 
Ultra3 SCSI Adapter
ec800000-ec8003ff : LSI Logic / Symbios Logic (formerly NCR) 53c1010 
Ultra3 SCSI Adapter
ed000000-ed0fffff : Intel Corporation 82557 [Ethernet Pro 100]
ed800000-ed800fff : Intel Corporation 82557 [Ethernet Pro 100]
  ed800000-ed800fff : eepro100
ee000000-efdfffff : PCI Bus #01
  ee000000-eeffffff : nVidia Corporation NV15 (Geforce2 Pro)
eff00000-fbffffff : PCI Bus #01
  f0000000-f7ffffff : nVidia Corporation NV15 (Geforce2 Pro)
fc000000-fdffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

PCI information ('lspci -vvv' as root):
WS$lspci -vvv|more
00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
        Subsystem: Asustek Computer, Inc.: Unknown device 8038
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo 
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: ee000000-efdfffff
        Prefetchable memory behind bridge: eff00000-fbffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 40)
        Subsystem: Asustek Computer, Inc.: Unknown device 8038
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d800 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 
00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 18
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 
00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 18
        Region 4: I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 
00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 18
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 
00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 18
        Region 4: I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] 
(rev 40)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] 
(rev 08)
        Subsystem: Intel Corporation EtherExpress PRO/100+ Management 
Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at ed800000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at b800 [size=64]
        Region 2: Memory at ed000000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=2 PME-

00:08.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c1010 
Ultra3 SCSI Adapter (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (4250ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at b400 [size=256]
        Region 1: Memory at ec800000 (64-bit, non-prefetchable) [size=1K]
        Region 3: Memory at ec000000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.1 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c1010 
Ultra3 SCSI Adapter (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (4250ns min, 4500ns max), cache line size 08
        Interrupt: pin B routed to IRQ 16
        Region 0: I/O ports at b000 [size=256]
        Region 1: Memory at eb800000 (64-bit, non-prefetchable) [size=1K]
        Region 3: Memory at eb000000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 SCSI storage controller: Adaptec 7892A (rev 02)
        Subsystem: Adaptec: Unknown device e2a0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 19
        BIST result: 00
        Region 0: I/O ports at a800 [disabled] [size=256]
        Region 1: Memory at ea800000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV15 (Geforce2 GTS) 
(rev a3) (prog-if 00 [VGA])
        Subsystem: LeadTek Research Inc.: Unknown device 2842
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at efff0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

SCSI information (from /proc/scsi/scsi):
WS$cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: ARCHIVE  Model: Python 04106-XXX Rev: 735B
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: QUANTUM  Model: ATLAS10K2-TY367L Rev: DDD6
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 08 Lun: 00
  Vendor: IBM      Model: DDYS-T36950N     Rev: S96H
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 10 Lun: 00
  Vendor: SEAGATE  Model: ST118273W        Rev: 6244
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 11 Lun: 00
  Vendor: IBM      Model: DDYS-T36950N     Rev: S96H
  Type:   Direct-Access                    ANSI SCSI revision: 03

* Please let me know if there is anything I can do to assist in 
troubleshooting, or if you need more information.

Thanks!
  Brian  (brianm@fsg1.nws.noaa.gov)

--1519150868-225816453-1007404223=:25875
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ksymoops.out"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0112031330230.25875@fsg1.nws.noaa.gov>
Content-Description: 
Content-Disposition: attachment; filename="ksymoops.out"

a3N5bW9vcHMgMi40LjEgb24gaTY4NiAyLjQuMTMtYWM4LiAgT3B0aW9ucyB1
c2VkDQogICAgIC1WIChkZWZhdWx0KQ0KICAgICAtayAvcHJvYy9rc3ltcyAo
ZGVmYXVsdCkNCiAgICAgLWwgL3Byb2MvbW9kdWxlcyAoZGVmYXVsdCkNCiAg
ICAgLW8gL2xpYi9tb2R1bGVzLzIuNC4xMy1hYzgvIChkZWZhdWx0KQ0KICAg
ICAtbSAvYm9vdC9TeXN0ZW0ubWFwLTIuNC4xMy1hYzggKGRlZmF1bHQpDQoN
Cldhcm5pbmc6IFlvdSBkaWQgbm90IHRlbGwgbWUgd2hlcmUgdG8gZmluZCBz
eW1ib2wgaW5mb3JtYXRpb24uICBJIHdpbGwNCmFzc3VtZSB0aGF0IHRoZSBs
b2cgbWF0Y2hlcyB0aGUga2VybmVsIGFuZCBtb2R1bGVzIHRoYXQgYXJlIHJ1
bm5pbmcNCnJpZ2h0IG5vdyBhbmQgSSdsbCB1c2UgdGhlIGRlZmF1bHQgb3B0
aW9ucyBhYm92ZSBmb3Igc3ltYm9sIHJlc29sdXRpb24uDQpJZiB0aGUgY3Vy
cmVudCBrZXJuZWwgYW5kL29yIG1vZHVsZXMgZG8gbm90IG1hdGNoIHRoZSBs
b2csIHlvdSBjYW4gZ2V0DQptb3JlIGFjY3VyYXRlIG91dHB1dCBieSB0ZWxs
aW5nIG1lIHRoZSBrZXJuZWwgdmVyc2lvbiBhbmQgd2hlcmUgdG8gZmluZA0K
bWFwLCBtb2R1bGVzLCBrc3ltcyBldGMuICBrc3ltb29wcyAtaCBleHBsYWlu
cyB0aGUgb3B0aW9ucy4NCg0KVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFn
aW5nIHJlcXVlc3QgYXQgdmlydHVhbCBhZGRyZXNzIDgxMDQyNmI0DQpjMDEx
Mjk5NQ0KKnBkZSA9IDAwMDAwMDAwDQpPb3BzOiAwMDAyDQpDUFU6ICAgIDEN
CkVJUDogICAgMDAxMDpbc21wX2FwaWNfdGltZXJfaW50ZXJydXB0KzIxLzI3
Ml0gICAgTm90IHRhaW50ZWQNCkVJUDogICAgMDAxMDpbPGMwMTEyOTk1Pl0g
ICAgTm90IHRhaW50ZWQNClVzaW5nIGRlZmF1bHRzIGZyb20ga3N5bW9vcHMg
LXQgZWxmMzItaTM4NiAtYSBpMzg2DQpFRkxBR1M6IDAwMDEwMDQ2DQplYXg6
IDMwMzYzNDJkICAgZWJ4OiAwMDAwMDAwMCAgIGVjeDogMDAwMDAyZGYgICBl
ZHg6IGU1MDI3YWY4DQplc2k6IDMwMzYzNDJkICAgZWRpOiAwODBkNmZlYyAg
IGVicDogYzJjOGMzMWMgICBlc3A6IGU1MDI3YWQwDQpkczogMDAxOCAgIGVz
OiAwMDE4ICAgc3M6IDAwMTgNClByb2Nlc3MgbXZhbGwgKHBpZDogMjEwMDYs
IHN0YWNrcGFnZT1lNTAyNjAwMCkNClN0YWNrOiBkNjdjYjcyMCBiZmZmZjli
YyBiZmZmZjZlOCAwMDAwMGI1YyAwMDAwMTAwMCBmZTAwYTQ4NCAwODBkNmZl
YyBjMmM4YzMxYw0KICAgICAgIGMwMTBiNDkxIGU1MDI3YWY4IDAwMDAxMDAw
IDAwMDAwMmRmIGU1MDI3YmEwIGZlMDBhNDg0IDA4MGQ2ZmVjIGMyYzhjMzFj
DQogICAgICAgMDAwMDAwMDAgMDAwMDAwMTggZmUwMDAwMTggZmZmZmZmZWYg
YzAxMjhkMjAgMDAwMDAwMTAgMDAwMTAyMDYgMDAwMDAwMDENCkNhbGwgVHJh
Y2U6IFtjYWxsX2FwaWNfdGltZXJfaW50ZXJydXB0KzUvMTZdIFtmaWxlX3Jl
YWRfYWN0b3IrMTEyLzIyNF0gW2RvX2dlbmVyaWNfZmlsZV9yZWFkKzU1MC8x
MjE2XSBbZ2VuZXJpY19maWxlX3JlYWQrOTQvMTI4XSBbZmlsZV9yZWFkX2Fj
dG9yKzAvMjI0XQ0KQ2FsbCBUcmFjZTogWzxjMDEwYjQ5MT5dIFs8YzAxMjhk
MjA+XSBbPGMwMTI4YTE2Pl0gWzxjMDEyOGRlZT5dIFs8YzAxMjhjYjA+XQ0K
ICAgWzxjMDEzNmU0Nj5dIFs8YzAxMDZmMWI+XSBbPGMwMTA2ZjFiPl0gWzxj
MDExNzNiND5dIFs8YzAxMWFkMmE+XSBbPGMwMTM2OTg5Pl0NCiAgIFs8YzAx
MjcwMWY+XSBbPGMwMTA2ZjFiPl0gWzxjMDEzNjk4OT5dIFs8YzAxMjcwMWY+
XSBbPGMwMTA2ZjFiPl0gWzxjMDEwNmYxYj5dDQpDb2RlOiBmZiAwNCBiNSAw
MCA1NiAyYiBjMCBjMSBlMCAwNSA4OSAxZCBiMCBlMCBmZiBmZiBmZiA4MCAy
NCBiNQ0KDQo+PkVJUDsgYzAxMTI5OTUgPHNtcF9hcGljX3RpbWVyX2ludGVy
cnVwdCsxNS8xMTA+ICAgPD09PT09DQpUcmFjZTsgYzAxMGI0OTEgPGNhbGxf
YXBpY190aW1lcl9pbnRlcnJ1cHQrNS8xMD4NClRyYWNlOyBjMDEyOGQyMCA8
ZmlsZV9yZWFkX2FjdG9yKzcwL2UwPg0KVHJhY2U7IGMwMTI4YTE2IDxkb19n
ZW5lcmljX2ZpbGVfcmVhZCsyMjYvNGMwPg0KVHJhY2U7IGMwMTI4ZGVlIDxn
ZW5lcmljX2ZpbGVfcmVhZCs1ZS84MD4NClRyYWNlOyBjMDEyOGNiMCA8Zmls
ZV9yZWFkX2FjdG9yKzAvZTA+DQpUcmFjZTsgYzAxMzZlNDYgPHN5c19yZWFk
Kzk2L2QwPg0KVHJhY2U7IGMwMTA2ZjFiIDxzeXN0ZW1fY2FsbCsyZi8zND4N
ClRyYWNlOyBjMDEwNmYxYiA8c3lzdGVtX2NhbGwrMmYvMzQ+DQpUcmFjZTsg
YzAxMTczYjQgPF9fbW1kcm9wKzI0LzMwPg0KVHJhY2U7IGMwMTFhZDJhIDxk
b19leGl0KzIxYS8yMzA+DQpUcmFjZTsgYzAxMzY5ODkgPGZpbHBfY2xvc2Ur
ODkvYTA+DQpUcmFjZTsgYzAxMjcwMWYgPHN5c19tdW5tYXArMmYvNTA+DQpU
cmFjZTsgYzAxMDZmMWIgPHN5c3RlbV9jYWxsKzJmLzM0Pg0KVHJhY2U7IGMw
MTM2OTg5IDxmaWxwX2Nsb3NlKzg5L2EwPg0KVHJhY2U7IGMwMTI3MDFmIDxz
eXNfbXVubWFwKzJmLzUwPg0KVHJhY2U7IGMwMTA2ZjFiIDxzeXN0ZW1fY2Fs
bCsyZi8zND4NClRyYWNlOyBjMDEwNmYxYiA8c3lzdGVtX2NhbGwrMmYvMzQ+
DQpDb2RlOyAgYzAxMTI5OTUgPHNtcF9hcGljX3RpbWVyX2ludGVycnVwdCsx
NS8xMTA+DQowMDAwMDAwMCA8X0VJUD46DQpDb2RlOyAgYzAxMTI5OTUgPHNt
cF9hcGljX3RpbWVyX2ludGVycnVwdCsxNS8xMTA+ICAgPD09PT09DQogICAw
OiAgIGZmIDA0IGI1IDAwIDU2IDJiIGMwICAgICAgaW5jbCAgIDB4YzAyYjU2
MDAoLCVlc2ksNCkgICA8PT09PT0NCkNvZGU7ICBjMDExMjk5YyA8c21wX2Fw
aWNfdGltZXJfaW50ZXJydXB0KzFjLzExMD4NCiAgIDc6ICAgYzEgZTAgMDUg
ICAgICAgICAgICAgICAgICBzaGwgICAgJDB4NSwlZWF4DQpDb2RlOyAgYzAx
MTI5OWYgPHNtcF9hcGljX3RpbWVyX2ludGVycnVwdCsxZi8xMTA+DQogICBh
OiAgIDg5IDFkIGIwIGUwIGZmIGZmICAgICAgICAgbW92ICAgICVlYngsMHhm
ZmZmZTBiMA0KQ29kZTsgIGMwMTEyOWE1IDxzbXBfYXBpY190aW1lcl9pbnRl
cnJ1cHQrMjUvMTEwPg0KICAxMDogICBmZiA4MCAyNCBiNSAwMCAwMCAgICAg
ICAgIGluY2wgICAweGI1MjQoJWVheCkNCg0KDQoxIHdhcm5pbmcgaXNzdWVk
LiAgUmVzdWx0cyBtYXkgbm90IGJlIHJlbGlhYmxlLg0K
--1519150868-225816453-1007404223=:25875
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="lspci-vvv.out"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0112031330231.25875@fsg1.nws.noaa.gov>
Content-Description: 
Content-Disposition: attachment; filename="lspci-vvv.out"

MDA6MDAuMCBIb3N0IGJyaWRnZTogVklBIFRlY2hub2xvZ2llcywgSW5jLiBW
VDgyQzY5MSBbQXBvbGxvIFBST10gKHJldiBjNCkNCglTdWJzeXN0ZW06IEFz
dXN0ZWsgQ29tcHV0ZXIsIEluYy46IFVua25vd24gZGV2aWNlIDgwMzgNCglD
b250cm9sOiBJL08tIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJ
TlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJC
LQ0KCVN0YXR1czogQ2FwKyA2Nk1oei0gVURGLSBGYXN0QjJCLSBQYXJFcnIt
IERFVlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydCsgPlNF
UlItIDxQRVJSLQ0KCUxhdGVuY3k6IDANCglSZWdpb24gMDogTWVtb3J5IGF0
IGZjMDAwMDAwICgzMi1iaXQsIHByZWZldGNoYWJsZSkgW3NpemU9MzJNXQ0K
CUNhcGFiaWxpdGllczogW2EwXSBBR1AgdmVyc2lvbiAyLjANCgkJU3RhdHVz
OiBSUT0zMSBTQkErIDY0Yml0LSBGVy0gUmF0ZT14MSx4Mg0KCQlDb21tYW5k
OiBSUT0wIFNCQS0gQUdQLSA2NGJpdC0gRlctIFJhdGU9PG5vbmU+DQoJQ2Fw
YWJpbGl0aWVzOiBbYzBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAyDQoJ
CUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTBtQSBQ
TUUoRDAtLEQxLSxEMi0sRDNob3QtLEQzY29sZC0pDQoJCVN0YXR1czogRDAg
UE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0NCg0KMDA6MDEuMCBQ
Q0kgYnJpZGdlOiBWSUEgVGVjaG5vbG9naWVzLCBJbmMuIFZUODJDNTk4LzY5
NHggW0Fwb2xsbyBNVlAzL1BybzEzM3ggQUdQXSAocHJvZy1pZiAwMCBbTm9y
bWFsIGRlY29kZV0pDQoJQ29udHJvbDogSS9PKyBNZW0rIEJ1c01hc3Rlcisg
U3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGlu
Zy0gU0VSUi0gRmFzdEIyQi0NCglTdGF0dXM6IENhcCsgNjZNaHorIFVERi0g
RmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9bWVkaXVtID5UQWJvcnQtIDxUQWJv
cnQtIDxNQWJvcnQrID5TRVJSLSA8UEVSUi0NCglMYXRlbmN5OiAwDQoJQnVz
OiBwcmltYXJ5PTAwLCBzZWNvbmRhcnk9MDEsIHN1Ym9yZGluYXRlPTAxLCBz
ZWMtbGF0ZW5jeT0wDQoJSS9PIGJlaGluZCBicmlkZ2U6IDAwMDBlMDAwLTAw
MDBkZmZmDQoJTWVtb3J5IGJlaGluZCBicmlkZ2U6IGVlMDAwMDAwLWVmZGZm
ZmZmDQoJUHJlZmV0Y2hhYmxlIG1lbW9yeSBiZWhpbmQgYnJpZGdlOiBlZmYw
MDAwMC1mYmZmZmZmZg0KCUJyaWRnZUN0bDogUGFyaXR5LSBTRVJSLSBOb0lT
QS0gVkdBKyBNQWJvcnQtID5SZXNldC0gRmFzdEIyQi0NCglDYXBhYmlsaXRp
ZXM6IFs4MF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDINCgkJRmxhZ3M6
IFBNRUNsay0gRFNJLSBEMSsgRDItIEF1eEN1cnJlbnQ9MG1BIFBNRShEMC0s
RDEtLEQyLSxEM2hvdC0sRDNjb2xkLSkNCgkJU3RhdHVzOiBEMCBQTUUtRW5h
YmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1FLQ0KDQowMDowNC4wIElTQSBicmlk
Z2U6IFZJQSBUZWNobm9sb2dpZXMsIEluYy4gVlQ4MkM2ODYgW0Fwb2xsbyBT
dXBlciBTb3V0aF0gKHJldiA0MCkNCglTdWJzeXN0ZW06IEFzdXN0ZWsgQ29t
cHV0ZXIsIEluYy46IFVua25vd24gZGV2aWNlIDgwMzgNCglDb250cm9sOiBJ
L08rIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNu
b29wLSBQYXJFcnItIFN0ZXBwaW5nKyBTRVJSLSBGYXN0QjJCLQ0KCVN0YXR1
czogQ2FwKyA2Nk1oei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1t
ZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJS
LQ0KCUxhdGVuY3k6IDANCglDYXBhYmlsaXRpZXM6IFtjMF0gUG93ZXIgTWFu
YWdlbWVudCB2ZXJzaW9uIDINCgkJRmxhZ3M6IFBNRUNsay0gRFNJLSBEMS0g
RDItIEF1eEN1cnJlbnQ9MG1BIFBNRShEMC0sRDEtLEQyLSxEM2hvdC0sRDNj
b2xkLSkNCgkJU3RhdHVzOiBEMCBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxl
PTAgUE1FLQ0KDQowMDowNC4xIElERSBpbnRlcmZhY2U6IFZJQSBUZWNobm9s
b2dpZXMsIEluYy4gQnVzIE1hc3RlciBJREUgKHJldiAwNikgKHByb2ctaWYg
OGEgW01hc3RlciBTZWNQIFByaVBdKQ0KCUNvbnRyb2w6IEkvTysgTWVtKyBC
dXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVy
ci0gU3RlcHBpbmcrIFNFUlItIEZhc3RCMkItDQoJU3RhdHVzOiBDYXArIDY2
TWh6LSBVREYtIEZhc3RCMkIrIFBhckVyci0gREVWU0VMPW1lZGl1bSA+VEFi
b3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItDQoJTGF0ZW5j
eTogMzINCglSZWdpb24gNDogSS9PIHBvcnRzIGF0IGQ4MDAgW3NpemU9MTZd
DQoJQ2FwYWJpbGl0aWVzOiBbYzBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lv
biAyDQoJCUZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50
PTBtQSBQTUUoRDAtLEQxLSxEMi0sRDNob3QtLEQzY29sZC0pDQoJCVN0YXR1
czogRDAgUE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0NCg0KMDA6
MDQuMiBVU0IgQ29udHJvbGxlcjogVklBIFRlY2hub2xvZ2llcywgSW5jLiBV
SENJIFVTQiAocmV2IDE2KSAocHJvZy1pZiAwMCBbVUhDSV0pDQoJU3Vic3lz
dGVtOiBVbmtub3duIGRldmljZSAwOTI1OjEyMzQNCglDb250cm9sOiBJL08r
IE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYrIFZHQVNub29w
LSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLQ0KCVN0YXR1czog
Q2FwKyA2Nk1oei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1tZWRp
dW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLQ0K
CUxhdGVuY3k6IDMyLCBjYWNoZSBsaW5lIHNpemUgMDgNCglJbnRlcnJ1cHQ6
IHBpbiBEIHJvdXRlZCB0byBJUlEgMTgNCglSZWdpb24gNDogSS9PIHBvcnRz
IGF0IGQ0MDAgW3NpemU9MzJdDQoJQ2FwYWJpbGl0aWVzOiBbODBdIFBvd2Vy
IE1hbmFnZW1lbnQgdmVyc2lvbiAyDQoJCUZsYWdzOiBQTUVDbGstIERTSS0g
RDEtIEQyLSBBdXhDdXJyZW50PTBtQSBQTUUoRDAtLEQxLSxEMi0sRDNob3Qt
LEQzY29sZC0pDQoJCVN0YXR1czogRDAgUE1FLUVuYWJsZS0gRFNlbD0wIERT
Y2FsZT0wIFBNRS0NCg0KMDA6MDQuMyBVU0IgQ29udHJvbGxlcjogVklBIFRl
Y2hub2xvZ2llcywgSW5jLiBVSENJIFVTQiAocmV2IDE2KSAocHJvZy1pZiAw
MCBbVUhDSV0pDQoJU3Vic3lzdGVtOiBVbmtub3duIGRldmljZSAwOTI1OjEy
MzQNCglDb250cm9sOiBJL08rIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUt
IE1lbVdJTlYrIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBG
YXN0QjJCLQ0KCVN0YXR1czogQ2FwKyA2Nk1oei0gVURGLSBGYXN0QjJCLSBQ
YXJFcnItIERFVlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9y
dC0gPlNFUlItIDxQRVJSLQ0KCUxhdGVuY3k6IDMyLCBjYWNoZSBsaW5lIHNp
emUgMDgNCglJbnRlcnJ1cHQ6IHBpbiBEIHJvdXRlZCB0byBJUlEgMTgNCglS
ZWdpb24gNDogSS9PIHBvcnRzIGF0IGQwMDAgW3NpemU9MzJdDQoJQ2FwYWJp
bGl0aWVzOiBbODBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAyDQoJCUZs
YWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTBtQSBQTUUo
RDAtLEQxLSxEMi0sRDNob3QtLEQzY29sZC0pDQoJCVN0YXR1czogRDAgUE1F
LUVuYWJsZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0NCg0KMDA6MDQuNCBIb3N0
IGJyaWRnZTogVklBIFRlY2hub2xvZ2llcywgSW5jLiBWVDgyQzY4NiBbQXBv
bGxvIFN1cGVyIEFDUEldIChyZXYgNDApDQoJQ29udHJvbDogSS9PLSBNZW0t
IEJ1c01hc3Rlci0gU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFy
RXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0NCglTdGF0dXM6IENhcCsg
NjZNaHotIFVERi0gRmFzdEIyQisgUGFyRXJyLSBERVZTRUw9bWVkaXVtID5U
QWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0NCglDYXBh
YmlsaXRpZXM6IFs2OF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDINCgkJ
RmxhZ3M6IFBNRUNsay0gRFNJLSBEMS0gRDItIEF1eEN1cnJlbnQ9MG1BIFBN
RShEMC0sRDEtLEQyLSxEM2hvdC0sRDNjb2xkLSkNCgkJU3RhdHVzOiBEMCBQ
TUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1FLQ0KDQowMDowNy4wIEV0
aGVybmV0IGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIDgyNTU3IFtF
dGhlcm5ldCBQcm8gMTAwXSAocmV2IDA4KQ0KCVN1YnN5c3RlbTogSW50ZWwg
Q29ycG9yYXRpb24gRXRoZXJFeHByZXNzIFBSTy8xMDArIE1hbmFnZW1lbnQg
QWRhcHRlcg0KCUNvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXIrIFNwZWND
eWNsZS0gTWVtV0lOVisgVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNF
UlItIEZhc3RCMkItDQoJU3RhdHVzOiBDYXArIDY2TWh6LSBVREYtIEZhc3RC
MkIrIFBhckVyci0gREVWU0VMPW1lZGl1bSA+VEFib3J0LSA8VEFib3J0LSA8
TUFib3J0LSA+U0VSUi0gPFBFUlItDQoJTGF0ZW5jeTogMzIgKDIwMDBucyBt
aW4sIDE0MDAwbnMgbWF4KSwgY2FjaGUgbGluZSBzaXplIDA4DQoJSW50ZXJy
dXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDE3DQoJUmVnaW9uIDA6IE1lbW9y
eSBhdCBlZDgwMDAwMCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6
ZT00S10NCglSZWdpb24gMTogSS9PIHBvcnRzIGF0IGI4MDAgW3NpemU9NjRd
DQoJUmVnaW9uIDI6IE1lbW9yeSBhdCBlZDAwMDAwMCAoMzItYml0LCBub24t
cHJlZmV0Y2hhYmxlKSBbc2l6ZT0xTV0NCglDYXBhYmlsaXRpZXM6IFtkY10g
UG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDINCgkJRmxhZ3M6IFBNRUNsay0g
RFNJKyBEMSsgRDIrIEF1eEN1cnJlbnQ9MG1BIFBNRShEMCssRDErLEQyKyxE
M2hvdCssRDNjb2xkKykNCgkJU3RhdHVzOiBEMCBQTUUtRW5hYmxlKyBEU2Vs
PTAgRFNjYWxlPTIgUE1FLQ0KDQowMDowOC4wIFNDU0kgc3RvcmFnZSBjb250
cm9sbGVyOiBTeW1iaW9zIExvZ2ljIEluYy4gKGZvcm1lcmx5IE5DUikgNTNj
MTAxMCBVbHRyYTMgU0NTSSBBZGFwdGVyIChyZXYgMDEpDQoJQ29udHJvbDog
SS9PKyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WKyBWR0FT
bm9vcC0gUGFyRXJyKyBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0NCglTdGF0
dXM6IENhcCsgNjZNaHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9
bWVkaXVtID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVS
Ui0NCglMYXRlbmN5OiA3MiAoNDI1MG5zIG1pbiwgNDUwMG5zIG1heCksIGNh
Y2hlIGxpbmUgc2l6ZSAwOA0KCUludGVycnVwdDogcGluIEEgcm91dGVkIHRv
IElSUSAxOQ0KCVJlZ2lvbiAwOiBJL08gcG9ydHMgYXQgYjQwMCBbc2l6ZT0y
NTZdDQoJUmVnaW9uIDE6IE1lbW9yeSBhdCBlYzgwMDAwMCAoNjQtYml0LCBu
b24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0xS10NCglSZWdpb24gMzogTWVtb3J5
IGF0IGVjMDAwMDAwICg2NC1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXpl
PThLXQ0KCUNhcGFiaWxpdGllczogWzQwXSBQb3dlciBNYW5hZ2VtZW50IHZl
cnNpb24gMg0KCQlGbGFnczogUE1FQ2xrLSBEU0ktIEQxKyBEMisgQXV4Q3Vy
cmVudD0wbUEgUE1FKEQwLSxEMS0sRDItLEQzaG90LSxEM2NvbGQtKQ0KCQlT
dGF0dXM6IEQwIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtDQoN
CjAwOjA4LjEgU0NTSSBzdG9yYWdlIGNvbnRyb2xsZXI6IFN5bWJpb3MgTG9n
aWMgSW5jLiAoZm9ybWVybHkgTkNSKSA1M2MxMDEwIFVsdHJhMyBTQ1NJIEFk
YXB0ZXIgKHJldiAwMSkNCglDb250cm9sOiBJL08rIE1lbSsgQnVzTWFzdGVy
KyBTcGVjQ3ljbGUtIE1lbVdJTlYrIFZHQVNub29wLSBQYXJFcnIrIFN0ZXBw
aW5nLSBTRVJSLSBGYXN0QjJCLQ0KCVN0YXR1czogQ2FwKyA2Nk1oei0gVURG
LSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRB
Ym9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLQ0KCUxhdGVuY3k6IDcyICg0
MjUwbnMgbWluLCA0NTAwbnMgbWF4KSwgY2FjaGUgbGluZSBzaXplIDA4DQoJ
SW50ZXJydXB0OiBwaW4gQiByb3V0ZWQgdG8gSVJRIDE2DQoJUmVnaW9uIDA6
IEkvTyBwb3J0cyBhdCBiMDAwIFtzaXplPTI1Nl0NCglSZWdpb24gMTogTWVt
b3J5IGF0IGViODAwMDAwICg2NC1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtz
aXplPTFLXQ0KCVJlZ2lvbiAzOiBNZW1vcnkgYXQgZWIwMDAwMDAgKDY0LWJp
dCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9OEtdDQoJQ2FwYWJpbGl0aWVz
OiBbNDBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAyDQoJCUZsYWdzOiBQ
TUVDbGstIERTSS0gRDErIEQyKyBBdXhDdXJyZW50PTBtQSBQTUUoRDAtLEQx
LSxEMi0sRDNob3QtLEQzY29sZC0pDQoJCVN0YXR1czogRDAgUE1FLUVuYWJs
ZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0NCg0KMDA6MDkuMCBTQ1NJIHN0b3Jh
Z2UgY29udHJvbGxlcjogQWRhcHRlYyA3ODkyQSAocmV2IDAyKQ0KCVN1YnN5
c3RlbTogQWRhcHRlYzogVW5rbm93biBkZXZpY2UgZTJhMA0KCUNvbnRyb2w6
IEkvTy0gTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVisgVkdB
U25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItDQoJU3Rh
dHVzOiBDYXArIDY2TWh6KyBVREYtIEZhc3RCMkIrIFBhckVyci0gREVWU0VM
PW1lZGl1bSA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBF
UlItDQoJTGF0ZW5jeTogMzIgKDEwMDAwbnMgbWluLCA2MjUwbnMgbWF4KSwg
Y2FjaGUgbGluZSBzaXplIDA4DQoJSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQg
dG8gSVJRIDE5DQoJQklTVCByZXN1bHQ6IDAwDQoJUmVnaW9uIDA6IEkvTyBw
b3J0cyBhdCBhODAwIFtkaXNhYmxlZF0gW3NpemU9MjU2XQ0KCVJlZ2lvbiAx
OiBNZW1vcnkgYXQgZWE4MDAwMDAgKDY0LWJpdCwgbm9uLXByZWZldGNoYWJs
ZSkgW3NpemU9NEtdDQoJRXhwYW5zaW9uIFJPTSBhdCA8dW5hc3NpZ25lZD4g
W2Rpc2FibGVkXSBbc2l6ZT0xMjhLXQ0KCUNhcGFiaWxpdGllczogW2RjXSBQ
b3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMg0KCQlGbGFnczogUE1FQ2xrLSBE
U0ktIEQxLSBEMi0gQXV4Q3VycmVudD0wbUEgUE1FKEQwLSxEMS0sRDItLEQz
aG90LSxEM2NvbGQtKQ0KCQlTdGF0dXM6IEQwIFBNRS1FbmFibGUtIERTZWw9
MCBEU2NhbGU9MCBQTUUtDQoNCjAxOjAwLjAgVkdBIGNvbXBhdGlibGUgY29u
dHJvbGxlcjogblZpZGlhIENvcnBvcmF0aW9uIE5WMTUgKEdlZm9yY2UyIEdU
UykgKHJldiBhMykgKHByb2ctaWYgMDAgW1ZHQV0pDQoJU3Vic3lzdGVtOiBM
ZWFkVGVrIFJlc2VhcmNoIEluYy46IFVua25vd24gZGV2aWNlIDI4NDINCglD
b250cm9sOiBJL08rIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJ
TlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJC
LQ0KCVN0YXR1czogQ2FwKyA2Nk1oeisgVURGLSBGYXN0QjJCKyBQYXJFcnIt
IERFVlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNF
UlItIDxQRVJSLQ0KCUxhdGVuY3k6IDY0ICgxMjUwbnMgbWluLCAyNTBucyBt
YXgpDQoJSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDE2DQoJUmVn
aW9uIDA6IE1lbW9yeSBhdCBlZTAwMDAwMCAoMzItYml0LCBub24tcHJlZmV0
Y2hhYmxlKSBbc2l6ZT0xNk1dDQoJUmVnaW9uIDE6IE1lbW9yeSBhdCBmMDAw
MDAwMCAoMzItYml0LCBwcmVmZXRjaGFibGUpIFtzaXplPTEyOE1dDQoJRXhw
YW5zaW9uIFJPTSBhdCBlZmZmMDAwMCBbZGlzYWJsZWRdIFtzaXplPTY0S10N
CglDYXBhYmlsaXRpZXM6IFs2MF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9u
IDENCgkJRmxhZ3M6IFBNRUNsay0gRFNJLSBEMS0gRDItIEF1eEN1cnJlbnQ9
MG1BIFBNRShEMC0sRDEtLEQyLSxEM2hvdC0sRDNjb2xkLSkNCgkJU3RhdHVz
OiBEMCBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1FLQ0KCUNhcGFi
aWxpdGllczogWzQ0XSBBR1AgdmVyc2lvbiAyLjANCgkJU3RhdHVzOiBSUT0z
MSBTQkEtIDY0Yml0LSBGVysgUmF0ZT14MSx4Mg0KCQlDb21tYW5kOiBSUT0w
IFNCQS0gQUdQLSA2NGJpdC0gRlctIFJhdGU9PG5vbmU+DQoNCg==
--1519150868-225816453-1007404223=:25875
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=ver_linux
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0112031330232.25875@fsg1.nws.noaa.gov>
Content-Description: 
Content-Disposition: attachment; filename=ver_linux

SWYgc29tZSBmaWVsZHMgYXJlIGVtcHR5IG9yIGxvb2sgdW51c3VhbCB5b3Ug
bWF5IGhhdmUgYW4gb2xkIHZlcnNpb24uDQpDb21wYXJlIHRvIHRoZSBjdXJy
ZW50IG1pbmltYWwgcmVxdWlyZW1lbnRzIGluIERvY3VtZW50YXRpb24vQ2hh
bmdlcy4NCiANCkxpbnV4IHdpbGxzY2FybGV0IDIuNC4xMy1hYzggIzIgU01Q
IE1vbiBOb3YgMTkgMTY6MDU6MTkgRVNUIDIwMDEgaTY4NiB1bmtub3duDQog
DQpHbnUgQyAgICAgICAgICAgICAgICAgIDIuOTYNCkdudSBtYWtlICAgICAg
ICAgICAgICAgMy43OS4xDQpiaW51dGlscyAgICAgICAgICAgICAgIDIuMTEu
OTAuMC44DQp1dGlsLWxpbnV4ICAgICAgICAgICAgIDIuMTFmDQptb3VudCAg
ICAgICAgICAgICAgICAgIDIuMTFnDQptb2R1dGlscyAgICAgICAgICAgICAg
IDIuNC42DQplMmZzcHJvZ3MgICAgICAgICAgICAgIDEuMjMNClBQUCAgICAg
ICAgICAgICAgICAgICAgMi40LjENCmlzZG40ay11dGlscyAgICAgICAgICAg
My4xcHJlMQ0KTGludXggQyBMaWJyYXJ5ICAgICAgICAyLjIuNA0KRHluYW1p
YyBsaW5rZXIgKGxkZCkgICAyLjIuNA0KUHJvY3BzICAgICAgICAgICAgICAg
ICAyLjAuNw0KTmV0LXRvb2xzICAgICAgICAgICAgICAxLjYwDQpDb25zb2xl
LXRvb2xzICAgICAgICAgIDAuMy4zDQpTaC11dGlscyAgICAgICAgICAgICAg
IDIuMC4xMQ0KTW9kdWxlcyBMb2FkZWQgICAgICAgICBlZXBybzEwMCBzdCBl
eHQzIGpiZA0K
--1519150868-225816453-1007404223=:25875--
