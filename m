Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314558AbSD0CeO>; Fri, 26 Apr 2002 22:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314559AbSD0CeN>; Fri, 26 Apr 2002 22:34:13 -0400
Received: from enchanter.real-time.com ([208.20.202.11]:46351 "EHLO
	enchanter.real-time.com") by vger.kernel.org with ESMTP
	id <S314558AbSD0CeK>; Fri, 26 Apr 2002 22:34:10 -0400
Date: Fri, 26 Apr 2002 21:33:15 -0500
From: Bob Tanner <tanner@real-time.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Dual (2) AMD ATHLON MP 1900+ CPUs gives APIC error on CPU[0]: 00(02)
Message-ID: <20020426213315.K25965@real-time.com>
Reply-To: tanner@real-time.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-message-flag: Outlook has several security flaws. Please see http://cws.internet.com/mail.html for alternatives
X-MSMail-Priority: High
X-Priority: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    
Dual (2) AMD ATHLON MP 1900+ CPUs gives APIC error on CPU[0]: 00(02)

[2.] Full description of the problem/report:

Dual (2) AMD ATHLON MP 1900+ CPUs
ASUA7M266D Motherboard
2 sticks of  Corsair CM72SD512R-2100 (1Gb RAM)

When booting SMP-Kernels version 2.4.7, 2.4.9, 2.4.18 the box hangs with the
following error:

APIC error on CPU1: 00(02)
APIC error on CPU0: 00(02)

Durning the POST I get this, but do not know if it means anything.

CPU0 AMD ATHLONG (TM) MP 1900+
CPU1 *AMD ATHLONG (TM) MP 1900+

Not sure what the asterick means.

Complete message on the screen follows prior to lockup:

CPU0 AMD ATHLON (TM) XP 1900+ stepping 02
per CPU timeslice cutoff: 731.19 usecs
task migration cache decay timeout: 10 msecs
enabled ExtINT on CPU #0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU #1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop...3198.15 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/lines, Dcache 64 (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/lines)
Intel machine check reporting enabled on CPU #1
CPU1: AMD ATHLON (TM) XP 1900+ stepping 02
total of 2 processors activated (6389.76 BogoMIPS)
Enabling IO-APIC IRQs
Setting 2 in the phy_id_present_map
... chaning IO-APIC physical APIC ID to 2...ok
... TIMER vector 0x31 ping1=2 pin2=0
testing the IO APIC ...................................... done.
Using ocal APIC timer interrupts.
Calibrating APIC timer...
... CPU clock speed is 1600.0830 Mhz.
... host bus clock speed is 266.687 Mhz.
CPU: 0, clocks: 2666804, slice: 888934
CPUO <T0:2666800, T1:1777856, D:10, S:888934, C:2666804>
CPU: 1, clocks: 2666804, slice: 888934
CPU1 <T0:2666800, T1:8889286, D:4, S:888934, C:2666804>


[3.] Keywords (i.e., modules, networking, kernel):
kernel, SMP, Athlon

[4.] Kernel version (from /proc/version):
2.4.18

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
N/A 

[6.] A small shell script or example program which triggers the
     problem (if possible)

[7.] Environment
Dual (2) AMD ATHLON MP 1900+ CPUs
ASUA7M266D Motherboard
2 sticks of  Corsair CM72SD512R-2100 (1Gb RAM)

[7.1.] Software (add the output of the ver_linux script here)
Machine does not boot far enough to run the ver_linux. Here is the output when
booted under 2.4.18 non-SMP version.

Linux samurai 2.4.18 #1 Thu Apr 25 09:19:44 CDT 2002 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.13
e2fsprogs              1.26
reiserfsprogs          3.x.0j
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         tulip iptable_nat ipt_REJECT ipt_LOG ipt_state
ip_conntrack iptable_filter ip_tables ide-scsi scsi_mod ide-cd cdrom usb-ohci
usbcore ext3 jbd

[7.2.] Processor information (from /proc/cpuinfo):

Since I'm under a non-SMP, only 1 CPU shows.

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(TM) XP 1900+
stepping	: 2
cpu MHz		: 1600.111
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 3191.60

[7.3.] Module information (from /proc/modules):

tulip                  43968   1
iptable_nat            20852   0 (autoclean) (unused)
ipt_REJECT              4064   0 (autoclean)
ipt_LOG                 5568   0 (autoclean)
ipt_state               1504   0 (autoclean)
ip_conntrack           21196   2 (autoclean) [iptable_nat ipt_state]
iptable_filter          2784   0 (autoclean)
ip_tables              14112   7 [iptable_nat ipt_REJECT ipt_LOG ipt_state
iptable_filter]
ide-scsi               10176   0
scsi_mod              119948   1 [ide-scsi]
ide-cd                 35424   0
cdrom                  34400   0 [ide-cd]
usb-ohci               21376   0 (unused)
usbcore                74592   1 [usb-ohci]
ext3                   69600   1
jbd                    50336   1 [ext3]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
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
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
a000-afff : PCI Bus #02
  a400-a4ff : Lite-On Communications Inc LNE100TX
    a400-a4ff : tulip
  a800-a8ff : C-Media Electronics Inc CM8738
b800-b80f : Advanced Micro Devices [AMD] AMD-768 [??] IDE
  b800-b807 : ide0
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
a000-afff : PCI Bus #02
  a400-a4ff : Lite-On Communications Inc LNE100TX
    a400-a4ff : tulip
  a800-a8ff : C-Media Electronics Inc CM8738
b800-b80f : Advanced Micro Devices [AMD] AMD-768 [??] IDE
  b800-b807 : ide0
  b808-b80f : ide1
d000-dfff : PCI Bus #01
  d800-d87f : Silicon Integrated Systems [SiS] 86C326
e800-e803 : PCI device 1022:700c (Advanced Micro Devices [AMD])


00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-3ffebfff : System RAM
  00100000-00224fff : Kernel code
  00225000-002e8fff : Kernel data
3ffec000-3ffeefff : ACPI Tables
3ffef000-3fffefff : reserved
3ffff000-3fffffff : ACPI Non-volatile Storage
f7800000-f9ffffff : PCI Bus #02
  f7800000-f78000ff : PCI device 1033:00e0 (NEC Corporation)
  f8000000-f8000fff : NEC Corporation USB (#2)
    f8000000-f8000fff : usb-ohci
  f8800000-f8800fff : NEC Corporation USB
    f8800000-f8800fff : usb-ohci
  f9000000-f90000ff : Lite-On Communications Inc LNE100TX
    f9000000-f90000ff : tulip
fa000000-fadfffff : PCI Bus #01
  fa000000-fa00ffff : Silicon Integrated Systems [SiS] 86C326
fae00000-faefffff : PCI Bus #02
faf00000-fb7fffff : PCI Bus #01
  00100000-00224fff : Kernel code
  00225000-002e8fff : Kernel data
3ffec000-3ffeefff : ACPI Tables
3ffef000-3fffefff : reserved
3ffff000-3fffffff : ACPI Non-volatile Storage
f7800000-f9ffffff : PCI Bus #02
  f7800000-f78000ff : PCI device 1033:00e0 (NEC Corporation)
  f8000000-f8000fff : NEC Corporation USB (#2)
    f8000000-f8000fff : usb-ohci
  f8800000-f8800fff : NEC Corporation USB
    f8800000-f8800fff : usb-ohci
  f9000000-f90000ff : Lite-On Communications Inc LNE100TX
    f9000000-f90000ff : tulip
fa000000-fadfffff : PCI Bus #01
  fa000000-fa00ffff : Silicon Integrated Systems [SiS] 86C326
fae00000-faefffff : PCI Bus #02
faf00000-fb7fffff : PCI Bus #01
  fb000000-fb7fffff : Silicon Integrated Systems [SiS] 86C326
fb800000-fb800fff : PCI device 1022:700c (Advanced Micro Devices [AMD])
fc000000-fdffffff : PCI device 1022:700c (Advanced Micro Devices [AMD])
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at fb800000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at e800 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d (prog-if
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fa000000-fadfffff
        Prefetchable memory behind bridge: faf00000-fb7fffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD]: Unknown device 7440 (rev 04)
        Subsystem: Asustek Computer, Inc.: Unknown device 8044
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD]: Unknown device 7441 (rev
04) (prog-if 8a [Master SecP PriP])
        Subsystem: Advanced Micro Devices [AMD]: Unknown device 7441
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at b800 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD]: Unknown device 7443 (rev 03)
        Subsystem: Asustek Computer, Inc.: Unknown device 8044
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:10.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 7448 (rev 04)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: f7800000-f9ffffff
        Prefetchable memory behind bridge: fae00000-faefffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

01:05.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 (rev
0b) (prog-if 00 [VGA])
        Subsystem: Silicon Integrated Systems [SiS] SiS6326 GUI Accelerator
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min)
        Region 0: Memory at fb000000 (32-bit, prefetchable) [size=8M]
        Region 1: Memory at fa000000 (32-bit, non-prefetchable) [size=64K]
        Region 2: I/O ports at d800 [size=128]
        Expansion ROM at faff0000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] AGP version 1.0
                Status: RQ=1 SBA- 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

02:04.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: Asustek Computer, Inc.: Unknown device 8077
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at a800 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
        Subsystem: Netgear FA310TX
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at a400 [size=256]
        Region 1: Memory at f9000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=256K]

02:08.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: Unknown device 807d:0035
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (250ns min, 10500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at f8800000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: Unknown device 807d:0035
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (250ns min, 10500ns max), cache line size 08
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

        Latency: 32 (250ns min, 10500ns max), cache line size 08
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.2 USB Controller: NEC Corporation: Unknown device 00e0 (rev 02) (prog-if
20)
        Subsystem: Unknown device 807d:1043
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 8500ns max), cache line size 08
        Interrupt: pin C routed to IRQ 10
        Region 0: Memory at f7800000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: CyberDrv Model: CW068D CD-R/RW   Rev: 110D
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

I ran memtester <http://www.qcc.sk.ca/~charlesc/software/memtester/> on the box
for 25 hours with no errors, so I pretty sure the problem is not with the RAM.

The box runs fine on a single CPU kernel. I swapped CPUs on the motherboard (to
test the other CPU), booted an SMP kernel and the box hung. 

Booted a single CPU kernel and the box works.

Swapped BOTH CPUs out with for new CPUs. Booted and SMP kernel. Box hangs.

Swapped out the motherboard. Tried both the new CPUs and the older CPUs and an
SMP kernel. Box hangs.
-- 
Bob Tanner <tanner@real-time.com>         | Phone : (952)943-8700
http://www.mn-linux.org, Minnesota, Linux | Fax   : (952)943-8500
Key fingerprint =  6C E9 51 4F D5 3E 4C 66 62 A9 10 E5 35 85 39 D9 

