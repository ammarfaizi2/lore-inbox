Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbUKFJr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbUKFJr6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 04:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbUKFJr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 04:47:58 -0500
Received: from imap.agarik.com ([217.174.207.5]:5139 "EHLO imap.agarik.com")
	by vger.kernel.org with ESMTP id S261351AbUKFJps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 04:45:48 -0500
Message-Id: <200411060945.iA627gSg093013@imap.agarik.com>
X-MessageWall-Score: 0 (agarik.com)
From: "Laurent SEROR" <seror@agarik.com>
To: <linux-kernel@vger.kernel.org>
Subject: Problem : Heavy load average (with no slowdown or side effect at all) on one (not always the same) of four Bi-Xeon running Linux 2.4.27 with heavy http trafic.
Date: Sat, 6 Nov 2004 10:45:41 +0100
Organization: AGARIK
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.181
thread-index: AcTD5WDnCoI23nL9Qvm4vhelvktApw==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This is the first time I do a bug report for the kernel so please do not
trash me if I got it wrong.

[1.]
We use 4 Intel BiXeon Linux 2.4.27 for http purpose and one of them, not
always the same, just have its load increase from nearly 0 to 10 without any
side effect.

[2.]
We use 4 boxes running Linux 2.4.27 with two Intel bi-xeon on each (specs
follows) and with http load balancing via Foundry ServerIron Appliance.
Sometime, one of the four boxes just have its load increase from nearly 0 to
nearly 10 and stay that way. There is nothing else. No slowing down, no
hangup, no IO, there is full of memory free.
When you compare it to the others 3 boxes, everyhting is the same, same
number of httpd processes, same vmstat, same usage of I/O, no blocking
processes, etc.

[3.] Keywords :
Kernel
Load
Vmstat

[4.] Kernel version (from /proc/version):

Linux version 2.4.27 (root@www3) (gcc version 3.2.2 20030222 (RedHat Linux
3.2.2-5)) #4 SMP Thu Sep 30 09:40:03 CEST 2004

[5.] No Oops.. Message

[6.] Not possible to provide a small shell script or example program which
triggers the
     problem

[7.] Environment



[7.1.] Software 

If some fields are empty or look unusual you may have an old version.

Compare to the current minimal requirements in Documentation/Changes.

 

Linux www3.jeuxvideo.com 2.4.27 #4 SMP Thu Sep 30 09:40:03 CEST 2004 i686
i686 i
386 GNU/Linux

 

Gnu C                  3.2.2

Gnu make               3.79.1

util-linux             2.11y

mount                  2.11y

modutils               2.4.22

e2fsprogs              1.32

jfsutils               1.0.17

quota-tools            3.06.

Linux C Library        2.3.2

Dynamic linker (ldd)   2.3.2

Procps                 2.0.11

Net-tools              1.60

Kbd                    1.08

Sh-utils               4.5.3

Modules Loaded                 

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0

vendor_id       : GenuineIntel

cpu family      : 15

model           : 2

model name      : Intel(R) Xeon(TM) CPU 2.66GHz

stepping        : 5

cpu MHz         : 2666.825

cache size      : 512 KB

fdiv_bug        : no

hlt_bug         : no

f00f_bug        : no

coma_bug        : no

fpu             : yes

fpu_exception   : yes

cpuid level     : 2

wp              : yes

flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid

bogomips        : 5321.52

 

processor       : 1

vendor_id       : GenuineIntel

cpu family      : 15

model           : 2

model name      : Intel(R) Xeon(TM) CPU 2.66GHz

stepping        : 5

cpu MHz         : 2666.825

cache size      : 512 KB

fdiv_bug        : no

hlt_bug         : no

f00f_bug        : no

coma_bug        : no

fpu             : yes

fpu_exception   : yes

cpuid level     : 2

wp              : yes

flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid

bogomips        : 5321.52

 

processor       : 2

vendor_id       : GenuineIntel

cpu family      : 15

model           : 2

model name      : Intel(R) Xeon(TM) CPU 2.66GHz

stepping        : 5

cpu MHz         : 2666.825

cache size      : 512 KB

fdiv_bug        : no

hlt_bug         : no

f00f_bug        : no

coma_bug        : no

fpu             : yes

fpu_exception   : yes

cpuid level     : 2

wp              : yes

flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid

bogomips        : 5321.52

 

processor       : 3

vendor_id       : GenuineIntel

cpu family      : 15

model           : 2

model name      : Intel(R) Xeon(TM) CPU 2.66GHz

stepping        : 5

cpu MHz         : 2666.825

cache size      : 512 KB

fdiv_bug        : no

hlt_bug         : no

f00f_bug        : no

coma_bug        : no

fpu             : yes

fpu_exception   : yes

cpuid level     : 2

wp              : yes

flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid

bogomips        : 5321.52


[7.3.] Module information (from /proc/modules):

No module

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

>cat /proc/ioports

0000-001f : dma1

0020-003f : pic1

0040-005f : timer

0060-006f : keyboard

0070-007f : rtc

0080-008f : dma page reg

00a0-00bf : pic2

00c0-00df : dma2

00f0-00ff : fpu

02f8-02ff : serial(auto)

03c0-03df : vga+

03f8-03ff : serial(auto)

0cf8-0cff : PCI conf1

9000-90ff : ATI Technologies Inc Rage XL

9800-983f : Intel Corp. 82557/8/9 [Ethernet Pro 100]

  9800-983f : e100

a000-afff : PCI Bus #02

  a000-afff : PCI Bus #04

    a400-a43f : Intel Corp. 82546EB Gigabit Ethernet Controller (Copper)

      a400-a43f : e1000

    a800-a83f : Intel Corp. 82546EB Gigabit Ethernet Controller (Copper)
(#2)   
      a800-a83f : e1000

c400-c41f : Intel Corp. 82801EB USB

c800-c81f : Intel Corp. 82801EB USB

d000-d01f : Intel Corp. 82801EB SMBus Controller

fc00-fc0f : Intel Corp. 82801EB Ultra ATA Storage Controller

  fc00-fc07 : ide0

  fc08-fc0f : ide1                  

> cat /proc/iomem                                                     
00000000-0009fbff : System RAM

0009fc00-0009ffff : reserved

000a0000-000bffff : Video RAM area

000c0000-000c7fff : Video ROM

000c8000-000cabff : Extension ROM

000f0000-000fffff : System ROM

00100000-7ffeffff : System RAM

  00100000-0029d07a : Kernel code

  0029d07b-0033697f : Kernel data

7fff0000-7fffefff : ACPI Tables

7ffff000-7fffffff : ACPI Non-volatile Storage

80000000-800003ff : Intel Corp. 82801EB Ultra ATA Storage Controller

f8300000-fc5fffff : PCI Bus #02

  f8300000-fc3fffff : PCI Bus #03

    fa000000-fbffffff : Mylex Corporation AcceleRAID 352/170/160 support
Device 
  fc400000-fc4fffff : PCI Bus #04

fd000000-fdffffff : ATI Technologies Inc Rage XL

fe6a0000-fe6bffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]

  fe6a0000-fe6bffff : e100

fe6fd000-fe6fdfff : Intel Corp. 82557/8/9 [Ethernet Pro 100]

  fe6fd000-fe6fdfff : e100

fe6ff000-fe6fffff : ATI Technologies Inc Rage XL

fe800000-feafffff : PCI Bus #02

  fe800000-fe8fffff : PCI Bus #03

  fe900000-fe9fffff : PCI Bus #04

    fe9c0000-fe9dffff : Intel Corp. 82546EB Gigabit Ethernet Controller
(Copper)
      fe9c0000-fe9dffff : e1000

    fe9e0000-fe9fffff : Intel Corp. 82546EB Gigabit Ethernet Controller
(Copper)
 (#2)

      fe9e0000-fe9fffff : e1000

  feafe000-feafefff : Intel Corp. 82870P2 P64H2 I/OxAPIC

  feaff000-feafffff : Intel Corp. 82870P2 P64H2 I/OxAPIC (#2)

febffc00-febfffff : Intel Corp. 82801EB USB2

fec00000-fecfffff : reserved

fee00000-fee00fff : reserved

fff00000-ffffffff : reserved  


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp.: Unknown device 254c (rev 01)

        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR- FastB2B-

        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- 
<MAbort- >SERR- <PERR-

        Latency: 0

        Capabilities: [40] #09 [1105]

 

00:02.0 PCI bridge: Intel Corp. e7500 [Plumas] HI_B Virtual PCI Bridge (F0)
(rev
 01) (prog-if 00 [Normal decode])

        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR+ FastB2B-

        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- 
<MAbort- >SERR- <PERR-

        Latency: 64

        Bus: primary=00, secondary=02, subordinate=04, sec-latency=0

        I/O behind bridge: 0000a000-0000afff

        Memory behind bridge: fe800000-feafffff

        Prefetchable memory behind bridge: f8300000-fc5fffff

        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

                                                                          
00:1d.0 USB Controller: Intel Corp. 82801EB USB (Hub #1) (rev 02) (prog-if
00 [U
HCI])

        Subsystem: Intel Corp.: Unknown device 24d0

        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR- FastB2B-

        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-

        Latency: 0

        Interrupt: pin A routed to IRQ 16

        Region 4: I/O ports at c400 [size=32]

 

00:1d.1 USB Controller: Intel Corp. 82801EB USB (Hub #2) (rev 02) (prog-if
00 [U
HCI])

        Subsystem: Intel Corp.: Unknown device 24d0

        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR- FastB2B-

        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-

        Latency: 0

        Interrupt: pin B routed to IRQ 19

        Region 4: I/O ports at c800 [size=32] 
   
00:1d.7 USB Controller: Intel Corp. 82801EB USB EHCI Controller (rev 02)
(prog-i
f 20 [EHCI])

        Subsystem: Intel Corp.: Unknown device 24d0

        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR- FastB2B-

        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-

        Latency: 0

        Interrupt: pin D routed to IRQ 23

        Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]

        Capabilities: [50] Power Management version 2

                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3h
ot+,D3cold+)

                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

        Capabilities: [58] #0a [20a0]

 

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev c2) (prog-if
00 [N
ormal decode])

        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR+ FastB2B-

        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- 
<MAbort- >SERR- <PERR-

        Latency: 0

        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32

        I/O behind bridge: 00008000-00009fff

        Memory behind bridge: fc700000-fe7fffff  
        Prefetchable memory behind bridge: f8200000-f82fffff

        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

 

00:1f.0 ISA bridge: Intel Corp. 82801EB ISA Bridge (LPC) (rev 02)

        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Step
ping- SERR- FastB2B-

        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-

        Latency: 0

 

00:1f.1 IDE interface: Intel Corp. 82801EB ICH5 IDE (rev 02) (prog-if 8a
[Master
 SecP PriP])

        Subsystem: Intel Corp.: Unknown device 24d0

        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR- FastB2B-

        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-

        Latency: 0

        Interrupt: pin A routed to IRQ 18

        Region 0: I/O ports at <unassigned>

        Region 1: I/O ports at <unassigned>

        Region 2: I/O ports at <unassigned>

        Region 3: I/O ports at <unassigned>

        Region 4: I/O ports at fc00 [size=16]

        Region 5: Memory at 80000000 (32-bit, non-prefetchable) [size=1K]

 

00:1f.3 SMBus: Intel Corp. 82801EB SMBus (rev 02)

        Subsystem: Intel Corp.: Unknown device 24d0

        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR- FastB2B-

        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-

        Interrupt: pin B routed to IRQ 17

        Region 4: I/O ports at d000 [size=32]

 

01:01.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
10)  
        Subsystem: Intel Corp. EtherExpress PRO/100 S Server Adapter

        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Step
ping- SERR- FastB2B-

        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-

        Latency: 64 (2000ns min, 14000ns max), cache line size 10

        Interrupt: pin A routed to IRQ 17

        Region 0: Memory at fe6fd000 (32-bit, non-prefetchable) [size=4K]

        Region 1: I/O ports at 9800 [size=64]

        Region 2: Memory at fe6a0000 (32-bit, non-prefetchable) [size=128K]

        Capabilities: [dc] Power Management version 2

                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot
+,D3cold+)

                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

 

01:02.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
(prog-i
f 00 [VGA])

        Subsystem: ATI Technologies Inc Rage XL

        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping+ SERR- FastB2B-

        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-

        Latency: 64 (2000ns min), cache line size 10

        Interrupt: pin A routed to IRQ 18

        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]

        Region 1: I/O ports at 9000 [size=256]

        Region 2: Memory at fe6ff000 (32-bit, non-prefetchable) [size=4K]

        Expansion ROM at fe6c0000 [disabled] [size=128K]

        Capabilities: [5c] Power Management version 2

                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot
-,D3cold-)

                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

 

02:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20
[IO(X)-APIC
])

        Subsystem: Intel Corp. 82870P2 P64H2 I/OxAPIC

        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR- FastB2B-

        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- 
<MAbort- >SERR- <PERR-

        Latency: 0

        Region 0: Memory at feafe000 (32-bit, non-prefetchable) [size=4K]

        Capabilities: [50] PCI-X non-bridge device.

                Command: DPERE- ERO- RBC=0 OST=0

                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, 
DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

02:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
(prog-if 0
0 [Normal decode])

        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR+ FastB2B-

        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- 
<MAbort- >SERR- <PERR-

        Latency: 64, cache line size 10

        Bus: primary=02, secondary=04, subordinate=04, sec-latency=64

        I/O behind bridge: 0000a000-0000afff

        Memory behind bridge: fe900000-fe9fffff

        Prefetchable memory behind bridge: 00000000fc400000-00000000fc400000

        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

        Capabilities: [50] PCI-X non-bridge device.

                Command: DPERE+ ERO+ RBC=0 OST=0

                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, 
DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

02:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20
[IO(X)-APIC
])

        Subsystem: Intel Corp. 82870P2 P64H2 I/OxAPIC

        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR- FastB2B-

        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- 
<MAbort- >SERR- <PERR-

        Latency: 0

        Region 0: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]

        Capabilities: [50] PCI-X non-bridge device.

                Command: DPERE- ERO- RBC=0 OST=0

                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, 
DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

02:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
(prog-if 0
0 [Normal decode])

        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Step
ping- SERR+ FastB2B-

        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- 
<MAbort- >SERR- <PERR-       
        Latency: 64, cache line size 10

        Bus: primary=02, secondary=03, subordinate=03, sec-latency=64

        I/O behind bridge: 0000f000-00000fff

        Memory behind bridge: fe800000-fe8fffff

        Prefetchable memory behind bridge: 00000000f8300000-00000000fc300000

        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

        Capabilities: [50] PCI-X non-bridge device.

                Command: DPERE+ ERO+ RBC=0 OST=0

                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, 
DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-

03:03.0 RAID bus controller: Mylex Corporation AcceleRAID 352/170/160
support De
vice (rev 02)

        Subsystem: Mylex Corporation: Unknown device 0052

        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Step
ping- SERR- FastB2B-

        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-

        Latency: 64, cache line size 10

        Interrupt: pin A routed to IRQ 24

        Region 0: Memory at fa000000 (32-bit, prefetchable) [size=32M]

        Expansion ROM at fe8f0000 [disabled] [size=32K]

        Capabilities: [80] Power Management version 2

                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot
-,D3cold-)

                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

 

04:01.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller
(Co
pper) (rev 01)

        Subsystem: Intel Corp. PRO/1000 MT Dual Port Server Adapter

        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Step
ping- SERR- FastB2B-

        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-

        Latency: 64 (63750ns min), cache line size 10

        Interrupt: pin A routed to IRQ 48

        Region 0: Memory at fe9c0000 (64-bit, non-prefetchable) [size=128K]

        Region 4: I/O ports at a400 [size=64]

        Capabilities: [dc] Power Management version 2

                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot
+,D3cold+)

                Status: D0 PME-Enable- DSel=0 DScale=1 PME-

        Capabilities: [e4] PCI-X non-bridge device.

                Command: DPERE- ERO+ RBC=0 OST=0

                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, 
DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [f0] Message Signalled
Int
errupts: 64bit+ Queue=0/0 Enable- 
                Address: 0000000000000000  Data: 0000

 

04:01.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller
(Co
pper) (rev 01)

        Subsystem: Intel Corp. PRO/1000 MT Dual Port Server Adapter

        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Step
ping- SERR- FastB2B-

        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-

        Latency: 64 (63750ns min), cache line size 10

        Interrupt: pin B routed to IRQ 49

        Region 0: Memory at fe9e0000 (64-bit, non-prefetchable) [size=128K]

        Region 4: I/O ports at a800 [size=64]

        Capabilities: [dc] Power Management version 2

                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot
+,D3cold+)

                Status: D0 PME-Enable- DSel=0 DScale=1 PME-

        Capabilities: [e4] PCI-X non-bridge device.

                Command: DPERE- ERO+ RBC=0 OST=0

                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, 
DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [f0] Message Signalled
Int
errupts: 64bit+ Queue=0/0 Enable-

                Address: 0000000000000000  Data: 0000

 

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: none  

But there is a scsi Raid 5 card and disks (see lspci)

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Here is the top of the loading box :

10:26:30  up 31 days,  5:29,  1 user,  load average: 13.12, 13.01, 11.86

554 processes: 479 sleeping, 2 running, 73 zombie, 0 stopped

CPU0 states:   8.3% user  12.3% system    0.0% nice   0.0% iowait  78.3%
idle   
CPU1 states:   6.2% user   3.1% system    0.0% nice   0.0% iowait  90.0%
idle   
CPU2 states:   9.1% user   8.1% system    0.0% nice   0.0% iowait  82.2%
idle   
CPU3 states:   3.1% user   3.3% system    0.0% nice   0.0% iowait  92.4%
idle   
Mem:  2069224k av, 2016776k used,   52448k free,       0k shrd,  118172k
buff   
       621360k active,             750292k inactive

Swap: 2040244k av,    2036k used, 2038208k free                 1142944k
cached 
 

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND

26645 root       8   0  2452 2452  2364 S    14.4  0.1  14:30   1 httpd

 9142 root       8   0  1372 1372  1288 S     2.9  0.0   4:04   3 httpd

14340 root      14   0  1556 1556   784 R     1.1  0.0   0:00   0 top

16477 www        9   0   776  776   656 S     0.3  0.0   0:00   1 forums.cgi

16520 www       10   0     0    0     0 Z     0.3  0.0   0:00   2 search.cgi
<d 
    9 root       9   0     0    0     0 SW    0.1  0.0   4:36   2 kupdated

16407 www        9   0     0    0     0 Z     0.1  0.0   0:00   0 search.cgi
<d 
16464 www        9   0     0    0     0 Z     0.1  0.0   0:00   3 forums.cgi
<d 
16476 www        9   0     0    0     0 Z     0.1  0.0   0:00   0 search.cgi
<d 
16518 www        9   0     0    0     0 Z     0.1  0.0   0:00   0 pub.cgi
<defu 
16519 www        9   0     0    0     0 Z     0.1  0.0   0:00   1
printfile.cgi 
16552 www       12   0   776  776   648 S     0.1  0.0   0:00   0 forums.cgi

16568 www       18   0     0    0     0 Z     0.1  0.0   0:00   2
cybermetrie.c 
16571 www       13   0   776  776   656 S     0.1  0.0   0:00   3 forums.cgi


Here is the top of a box doing the same thing with the same amount of trafic
and http request :

 10:26:29  up 31 days,  5:55,  1 user,  load average: 0.51, 0.50, 0.38

565 processes: 479 sleeping, 1 running, 85 zombie, 0 stopped

CPU0 states:   5.2% user   9.3% system    0.0% nice   0.0% iowait  84.3%
idle   
CPU1 states:   1.4% user   1.4% system    0.0% nice   0.0% iowait  96.0%
idle   
CPU2 states:   7.3% user   6.1% system    0.0% nice   0.0% iowait  85.4%
idle   
CPU3 states:   3.1% user   2.3% system    0.0% nice   0.0% iowait  93.4%
idle   
Mem:  2069224k av, 2015084k used,   54140k free,       0k shrd,  114364k
buff   
       585728k active,             728204k inactive

Swap: 2040244k av,    2144k used, 2038100k free                 1082720k
cached 
 

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND

12381 root       9   0  2452 2452  2376 S     7.4  0.1  15:13   3 httpd

 9974 root       8   0  1380 1380  1284 S     2.4  0.0  17:53   3 httpd

30986 www       10   0     0    0     0 Z     2.1  0.0   0:00   0 miaou.cgi
<de 
30013 root      15   0  1592 1592   784 R     0.9  0.0   0:00   2 top

30848 www        9   0     0    0     0 Z     0.3  0.0   0:00   2 search.cgi
<d 
30712 www        9   0     0    0     0 Z     0.1  0.0   0:00   2
cybermetrie.c 
30794 www        9   0     0    0     0 Z     0.1  0.0   0:00   2
printfile.cgi 
30870 www        4   0     0    0     0 Z     0.1  0.0   0:00   3 forums.cgi
<d 
30886 www        9   0     0    0     0 Z     0.1  0.0   0:00   0 search.cgi
<d 
30907 www        9   0   776  776   648 S     0.1  0.0   0:00   0 forums.cgi

31033 www       15   0     0    0     0 Z     0.1  0.0   0:00   0
cybermetrie.c 
31037 www       18   0     0    0     0 Z     0.1  0.0   0:00   3 search.cgi
<d 
    1 root       8   0   508  476   456 S     0.0  0.0   0:29   1 init

    2 root       9   0     0    0     0 SW    0.0  0.0   0:00   0 keventd


Here is 20 vmstat 3 from the box that load :

   procs                      memory      swap          io     system
cpu  
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy
id  
 0  0  0   2036  52680 117700 1137304    0    0     3     2    0     3  0  1
3 
 0  0  0   2036  50704 117708 1137660    0    0   121   353 2377  2708  5  6
89 
 0  0  0   2036  51428 117720 1137776    0    0    39   383 2652  3019  5  8
87 
 1  0  0   2036  51340 117724 1137888    0    0    39     0 2298  2636  3  6
90 
 0  0  0   2036  49992 117724 1137012    0    0    93   372 2724  3257  5  7
88 
 1  0  0   2036  50328 117028 1121204    0    0    91     0 2210  2619 13  7
80 
 0  1  1   2036  66148 117040 1121820    0    0   208   375 2519  2839 14  7
79 
 1  0  0   2036  65472 117052 1122348    0    0   180   307 2351  2651  4  6
90 
 0  0  0   2036  64844 117052 1122664    0    0   105     0 2416  2733  5  7
88 
 1  0  0   2036  64648 117068 1123172    0    0   175   403 2160  2410  3  6
91 
 1  2  1   2036  64648 117076 1123496    0    0   111   372 2568  2811  4  5
91 
 0  0  0   2036  63796 117096 1123956    0    0   160     0 2326  2589  4  6
90 
 0  0  0   2036  63060 117100 1124504    0    0   184   352 2523  2819  5  7
88 
 0  0  0   2036  62192 117108 1124972    0    0   159     0 2535  2888  8  8
85 
 0  0  0   2036  59688 117128 1125096    0    0    43   437 2523  2934  5  7
87 
 2  0  0   2036  58096 117140 1125452    0    0   121   395 2485  2796  7  7
86 
 2  0  0   2036  57384 117148 1125868    0    0   141     0 2532  2850  6  7
87 
 0  0  0   2036  57988 117160 1126100    0    0    80   449 2538  2852  6  7
87 
 0  0  1   2036  57640 117160 1126284    0    0    61   272 2032  2412  4  7
89 
 0  0  0   2036  57128 117176 1127012    0    0   248   167 2134  5110 13 19
68 

Here is 20 vmstat 3 from a box that do the same thing but doesn't load :

  procs                      memory      swap          io     system
cpu  
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy
id  
 0  0  0   2144  52528 114380 1084732    0    0     3     1    1     2  1  2
1 
 0  0  0   2144  52472 114380 1084812    0    0    27     0 2455  2789  5  6
89 
 2  0  0   2144  51224 114384 1084896    0    0    28   375 2161  2304  5  5
90 
 0  0  0   2144  50428 114384 1085052    0    0    52   379 2499  2880  5  5
90 
 1  0  0   2144  51112 114408 1084168    0    0    57   511 2428  2696 10  5
85 
 3  0  0   2144  50168 114408 1084304    0    0    45   228 2423  2578 10  5
84 
 0  0  0   2144  51364 114368 1083436    0    0    67     0 2316  2657  7  7
86 
 1  0  0   2144  52040 114380 1083668    0    0    79   361 2672  3119  6  7
87 
 1  0  0   2144  51456 114392 1083824    0    0    55   360 2595  2979  5  8
87 
 0  0  0   2144  49460 114392 1082960    0    0    41     0 2464  2808  4  7
89 
 0  0  0   2144  51380 114348 1080984    0    0    69   376 2336  3181  6 11
83 
 3  1  1   2144  51860 114364 1081140    0    0    56   392 2225  2631  4  7
89 
 0  0  0   2144  52396 114364 1081288    0    0    49     0 2261  2529  5  5
89 
 0  0  0   2144  52144 114368 1081420    0    0    45   349 2003  2240  3  6
91 
 0  0  0   2144  52520 114372 1081836    0    0   140     0 1984  2132  4  5
91 
 0  0  0   2144  52224 114376 1081340    0    0   207   663 2515  4421 14 19
67 
 1  1  0   2144  51116 114376 1081552    0    0    71   311 2831  4426 12 18
70 
 1  0  0   2144  50020 114360 1080556    0    0    40     0 2681  3144  7  7
85 
 0  0  0   2144  50632 114252 1079072    0    0   180   477 2587  3008  7  9
85 
 0  0  0   2144  50212 114256 1079388    0    0   107     0 2556  3019  5  8
88 

The is no slow down whatsoever on the machine which load, and they both have
a network trafic of 25 Mbits/s (with less than 500 httpd process
simultaneously running on each box)
 
[X.] Other notes, patches, fixes, workarounds:

When we stop Apache server, load is decreasing. We can wait as much as we
want, when we restart it, load is going up again.

When we reboot the box that is loading, it restart we a very low load and
stay that way. Later, but we don't have found a pattern, the same or another
box start to mysteriously load and we have to reboot it to get a low load.



Someway I think that the calcul of the load is taint by something and is not
accurate.

Thank you for taking note of this bug report.

Regards,
Laurent SEROR



