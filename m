Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132768AbRBESyI>; Mon, 5 Feb 2001 13:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132758AbRBESx6>; Mon, 5 Feb 2001 13:53:58 -0500
Received: from sci.la-mark.com.pl ([213.25.173.194]:21773 "HELO
	sci.infoland.com.pl") by vger.kernel.org with SMTP
	id <S132300AbRBESxq>; Mon, 5 Feb 2001 13:53:46 -0500
Date: Mon, 5 Feb 2001 19:53:03 +0100 (CET)
From: Jakub Wasielewski <wasyl@infoland.com.pl>
X-X-Sender: <wasielew@wasyl.dom.pl>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: kernel BUG at page_alloc.c:190!
Message-ID: <Pine.LNX.4.31.0102051942040.875-100000@wasyl.dom.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 at sci.net.pl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem: kernel BUG at page_alloc.c:190!
[2.] Full description of the problem/report:
Well, not to much to say. I tried to get the list of processes and ps re­
turned a SEG FAULT. The system was still running for about one minute  so
I had time to save the output of dmesg, and then it crushed.
It was a one time event never happend before. Also I think I can't repro­
duce this...
[3.] Keywords (i.e., modules, networking, kernel): kernel, SMP, memory
[4.] Kernel version (from /proc/version):
Linux version 2.4.0 (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 SMP wto sty 9 13:49:57 CET 2001
[5.] Output of Oops.. message (if applicable):

kernel BUG at page_alloc.c:190!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c012e0c9>]
EFLAGS: 00010092
eax: 00000020   ebx: c0217e60   ecx: 00000000   edx: 0000002a
esi: c0217e48   edi: c0217e20   ebp: 00000000   esp: c5edde44
ds: 0018   es: 0018   ss: 0018
Process kbgndwm (pid: 502, stackpage=c5edd000)
Stack: c01ede25 c01edfb3 000000be c0217e20 c02180b4 00000001 c47c9340 0000000e
       c0218054 c0218050 00000286 00000000 c0217e20 c012e465 c4a7a7a0 c7fb81e0
       00000001 c47c9340 00000000 c7980018 00000005 00000001 c02180ac c0123807
Call Trace: [<c012e465>] [<c0123807>] [<c0123884>] [<c0123a3a>] [<c0112e47>] [<c0112ce8>] [<c01137d4>]
       [<c011d99f>] [<c0113d7a>] [<c01090dc>] [<c010002b>]

Code: 0f 0b 83 c4 0c 89 f6 8b 53 04 8b 03 89 50 04 89 02 89 5c 24
NMI Watchdog detected LOCKUP on CPU1, registers:
CPU:    1
EIP:    0010:[<c01dc7b6>]
EFLAGS: 00000086
eax: c0217e48   ebx: 000402a4   ecx: 00000001   edx: c1000010
esi: c0217e20   edi: 00000f19   ebp: 00000000   esp: c5eddcb0
ds: 0018   es: 0018   ss: 0018
Process kbgndwm (pid: 502, stackpage=c5edd000)
Stack: c10402b4 00000059 00056000 000000f4 c1000010 c0217e48 00000203 ffffffff
       0000078c c012e6ef c012ebdb c10402b4 00000059 c01225aa c10402b4 c79ca5a0
       c7fb81e0 08056000 0014e000 c10402b4 00f19067 c7a8352c 00000000 001a4000
Call Trace: [<c012e6ef>] [<c012ebdb>] [<c01225aa>] [<c0124c44>] [<c01150b2>] [<c011952f>] [<c01096d4>]
       [<c01094c2>] [<c0109753>] [<c012e0c9>] [<c01090dc>] [<c012e0c9>] [<c012e465>] [<c0123807>] [<c0123884>]
       [<c0123a3a>] [<c0112e47>] [<c0112ce8>] [<c01137d4>] [<c011d99f>] [<c0113d7a>] [<c01090dc>] [<c010002b>]

Code: 7e f9 e9 32 17 f5 ff 80 39 00 f3 90 7e f9 e9 a9 18 f5 ff 80
console shuts up ...
APIC error on CPU1: 02(02)
NMI Watchdog detected LOCKUP on CPU0, registers:
CPU:    0
EIP:    0010:[<c01dc7bd>]
EFLAGS: 00000082
eax: 00000000   ebx: c0217e20   ecx: c0217e20   edx: 00000000
esi: c0217e48   edi: 00000001   ebp: 00000000   esp: c69f3e04
ds: 0018   es: 0018   ss: 0018
Process ps (pid: 13973, stackpage=c69f3000)
Stack: c0217e20 c02180b4 00000001 c7dfa08c 00000008 c0218054 c0218050 00000286
       00000000 c0217e20 c012e465 c54e2460 c1ce1300 00000001 c7dfa08c 00000000
       00000001 00000005 00000001 c02180ac c0123807 c54e2460 c1ce1300 00000001
Call Trace: [<c012e465>] [<c0123807>] [<c0123884>] [<c0123a3a>] [<c0112e47>] [<c0112ce8>] [<c0112e47>]
       [<c0112ce8>] [<c0146b09>] [<c0124587>] [<c01090dc>] [<c01208f0>] [<c01090dc>] [<c0108fab>]

Code: 80 39 00 f3 90 7e f9 e9 a9 18 f5 ff 80 3f 00 f3 90 7e f9 e9
console shuts up ...
NMI Watchdog detected LOCKUP on CPU1, registers:
CPU:    1
EIP:    0010:[<c01dc7bd>]
EFLAGS: 00000082
eax: 00000000   ebx: c0217e20   ecx: c0217e20   edx: 00000000
esi: c0217e48   edi: 00000001   ebp: 00000000   esp: c572dd74
ds: 0018   es: 0018   ss: 0018
Process setiathome (pid: 562, stackpage=c572d000)
Stack: c0217e20 c02180b4 00000001 c57d904c 00000008 c0218054 c0218050 00000286
       00000000 c0217e20 c012e465 c2106fa0 c5b338e0 00000001 c57d904c 00000000
       c010a726 00000005 00000001 c02180ac c0123807 c2106fa0 c5b338e0 00000001
Call Trace: [<c012e465>] [<c010a726>] [<c0123807>] [<c0123884>] [<c0123a3a>] [<c0112e47>] [<c0112ce8>]
       [<c0124d80>] [<c0123807>] [<c0123884>] [<c01090dc>] [<c01266ce>] [<c01266a0>] [<c0126339>] [<c0126757>]
       [<c01266a0>] [<c0133446>] [<c0108fab>]

Code: 80 39 00 f3 90 7e f9 e9 a9 18 f5 ff 80 3f 00 f3 90 7e f9 e9
console shuts up ...
NMI Watchdog detected LOCKUP on CPU0, registers:
CPU:    0
EIP:    0010:[<c01dc7bd>]
EFLAGS: 00000082
eax: 00000000   ebx: c0217e20   ecx: c0217e20   edx: 00000000
esi: c0217e48   edi: 00000001   ebp: 00000000   esp: c272be50
ds: 0018   es: 0018   ss: 0018
Process setiathome (pid: 14013, stackpage=c272b000)
Stack: c0217e20 c02180b4 00000001 c434d3b0 0000003a c0218054 c0218050 00000286
       00000000 c0217e20 c012e465 c4a7aea0 c1ce1620 00000001 c434d3b0 00000000
       00000018 00000005 00000001 c02180ac c0123807 c4a7aea0 c1ce1620 00000001
Call Trace: [<c012e465>] [<c0123807>] [<c0123884>] [<c0123a3a>] [<c0112e47>] [<c0112ce8>] [<c0123ff8>]
       [<c010dd7f>] [<c01090dc>]

Code: 80 39 00 f3 90 7e f9 e9 a9 18 f5 ff 80 3f 00 f3 90 7e f9 e9
console shuts up ...
NMI Watchdog detected LOCKUP on CPU1, registers:
CPU:    1
EIP:    0010:[<c01dc7c0>]
EFLAGS: 00000082
eax: 00000000   ebx: c0217e20   ecx: c0217e20   edx: 00000000
esi: c0217e48   edi: 00000001   ebp: 00000000   esp: c5907d74
ds: 0018   es: 0018   ss: 0018
Process setiathome (pid: 561, stackpage=c5907000)
Stack: c0217e20 c02180b4 00000001 c563d04c 0000003a c0218054 c0218050 00000286
       00000000 c0217e20 c012e465 c7c7f6a0 c7fb86e0 00000001 c563d04c 00000000
       c5b33840 00000005 00000001 c02180ac c0123807 c7c7f6a0 c7fb86e0 00000001
Call Trace: [<c012e465>] [<c0123807>] [<c0123884>] [<c0123a3a>] [<c0112e47>] [<c0112ce8>] [<c0124d80>]
       [<c0188c56>] [<c01090dc>] [<c01266ce>] [<c01266a0>] [<c0126339>] [<c0126757>] [<c01266a0>] [<c0133446>]
       [<c0108fab>]

Code: f3 90 7e f9 e9 a9 18 f5 ff 80 3f 00 f3 90 7e f9 e9 9c 20 f5
console shuts up ...
kernel BUG at page_alloc.c:203!
invalid operand: 0000
CPU:    1
EIP:    0010:[rmqueue+586/632]
EFLAGS: 00010292
eax: 00000020   ebx: c1092dc8   ecx: 00000001   edx: 00000024
esi: 00000001   edi: c0213a18   ebp: 00000000   esp: c6325e44
ds: 0018   es: 0018   ss: 0018
Process setiathome (pid: 471, stackpage=c6325000)
c01e9e05 c01e9f93 000000cb c0213a18 c0213bf0 00000001 c4b5fec0 c0213a40
0000128e 0000128e 00000286 00000000 c0213a18 c012eb05 c260ede0 c696ede0
00000001 c4b5fec0 00000000 00000018 00000005 00000001 c0213bec c0124047
Call Trace: [__alloc_pages+237/748] [do_anonymous_page+47/124] [do_no_page+48/196] [handle_mm_fault+290/424] [do_page_fault+351/1080] [do_page_fault+0/1080] [do_mmap_pgoff+864/1060]
       [old_mmap+195/240] [error_code+52/60] [stext+43/203]

Code: 0f 0b 83 c4 0c 90 89 d8 eb 1c 45 83 c6 0c 83 fd 09 0f 86 cf

[6.] A small shell script or example program which triggers the  problem (if possible): not possible :)
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux wasyl.dom.pl 2.4.0 #1 SMP wto sty 9 13:49:57 CET 2001 i686 unknown
Kernel modules         2.3.15
Gnu C                  egcs-2.91.66
Gnu Make               3.77
Binutils               2.9.1.0.24
Linux C Library        2.1.2
Dynamic linker         ldd (GNU libc) 2.1.2
Procps                 2.0.4
Mount                  2.9u
Net-tools              1.53
Console-tools          1999.03.02
Sh-utils               2.0
Modules Loaded         lirc_gpio_p lirc_dev tvaudio bttv tuner i2c-algo-bit i2c-core videodev sb sb_lib uart401 sound soundcore

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 539.512
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 1074.79

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 539.512
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 1078.06

[7.3.] Module information (from /proc/modules):

lirc_gpio_p             4776   1
lirc_dev                8464   1 [lirc_gpio_p]
tvaudio                 8144   1 (autoclean)
bttv                   57668   1 [lirc_gpio_p]
tuner                   3264   1 (autoclean)
i2c-algo-bit            7252   1 [bttv]
i2c-core               12076   0 [tvaudio bttv tuner i2c-algo-bit]
videodev                4928   4 [bttv]
sb                      2000   1
sb_lib                 34516   0 [sb]
uart401                 6384   0 [sb_lib]
sound                  58476   1 [sb_lib uart401]
soundcore               3812   5 (autoclean) [sb_lib sound]

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
0260-026f : soundblaster
0300-0303 : MPU-401 UART
0320-033f : eth0
0376-0376 : ide1
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
c000-c01f : Intel Corporation 82371AB PIIX4 USB
c400-c47f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
c800-c8ff : Tseng Labs Inc ET6000
cc00-cc07 : Triones Technologies, Inc. HPT366
  cc00-cc07 : ide2
d000-d003 : Triones Technologies, Inc. HPT366
  d002-d002 : ide2
d400-d4ff : Triones Technologies, Inc. HPT366
  d400-d407 : ide2
  d410-d4ff : HPT366
d800-d807 : Triones Technologies, Inc. HPT366 (#2)
dc00-dc03 : Triones Technologies, Inc. HPT366 (#2)
e000-e0ff : Triones Technologies, Inc. HPT366 (#2)
  e000-e007 : ide3
  e010-e0ff : HPT366
f000-f00f : Intel Corporation 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

/proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c97ff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-001e0985 : Kernel code
  001e0986-0022bfbf : Kernel data
d0000000-d3ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
d5000000-d5ffffff : Tseng Labs Inc ET6000
d6000000-d600007f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
d6001000-d6001fff : Brooktree Corporation Bt878
  d6001000-d6001fff : bttv
d6002000-d6002fff : Brooktree Corporation Bt878
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32 set
        Region 0: Memory at d0000000 (32-bit, prefetchable)
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=21
                Command: RQ=31 SBA+ AGP- 64bit- FW- Rate=21

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Region 4: I/O ports at f000

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Interrupt: pin D routed to IRQ 19
        Region 4: I/O ports at c000

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
        Subsystem: Unknown device 10b7:9055
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 10 min, 10 max, 32 set, cache line size 08
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at c400
        Region 1: Memory at d6000000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 VGA compatible controller: Tseng Labs Inc ET6000 (rev 30)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at d5000000 (32-bit, non-prefetchable)
        Region 1: I/O ports at c800

00:0f.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
        Subsystem: Unknown device 1461:0003
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 min, 40 max, 32 set
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at d6001000 (32-bit, prefetchable)

00:0f.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
        Subsystem: Unknown device 1461:0003
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 4 min, 255 max, 32 set
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at d6002000 (32-bit, prefetchable)

00:13.0 Unknown mass storage controller: Triones Technologies, Inc.: Unknown device 0004 (rev 01)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 8 max, 120 set, cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at cc00
        Region 1: I/O ports at d000
        Region 4: I/O ports at d400

00:13.1 Unknown mass storage controller: Triones Technologies, Inc.: Unknown device 0004 (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 8 max, 120 set, cache line size 08
        Interrupt: pin B routed to IRQ 18
        Region 0: I/O ports at d800
        Region 1: I/O ports at dc00
        Region 4: I/O ports at e000

[7.6.] SCSI information (from /proc/scsi/scsi): not found

[7.7.] Other information that might be relevant to the problem:
Well,  as  you can see the procs are overclocked (433@541) but that never
caused me problems. If my bug is caused by overclocking please accept  my
apologies!

Cheers!

-- 
[X]       Jakub Wasielewski        [X] GB/CA  s+:+  a24  UBLOC+++ L+++ [X]
[X] Network & System Administrator [X] P+  W++ E---  N++ PS+  PE+  C++ [X]
[X]     wasyl@infoland.com.pl      [X] Y+  PGP+  X++ R b++ D+  G++  d- [X]

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
