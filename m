Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130423AbRCCGbd>; Sat, 3 Mar 2001 01:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130425AbRCCGbO>; Sat, 3 Mar 2001 01:31:14 -0500
Received: from SMTP-OUT003.ONEMAIN.COM ([63.208.208.73]:40304 "HELO
	smtp04.mail.onemain.com") by vger.kernel.org with SMTP
	id <S130423AbRCCGay>; Sat, 3 Mar 2001 01:30:54 -0500
Message-ID: <3AA07471.3D46194B@mcn.net>
Date: Fri, 02 Mar 2001 21:34:57 -0700
From: TimO <hairballmt@mcn.net>
Organization: Don't you mean Disorganization!?
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OOPS-kernel 2.4.3-pre1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1]  Oops when booting kernel 2.4.3-pre1

[2]  Kernel oopses just after starting kswapd

[3]
[4]  
Linux nexxus.deenc.com 2.4.3-pre1 #2 Tue Jan 30 12:32:52 MST 2001 i686
unknown
 
Gnu C                  2.95.2
Gnu make               3.79
binutils               2.10.1
util-linux             2.10r
modutils               2.4.3
e2fsprogs              1.19
PPP                    2.3.10 not used
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Linux C++ Library      2.8.1
Procps                 2.0.6
Net-tools              1.55
Kbd                    0.94
Sh-utils               2.0
Modules Loaded         None at oops time

[5]
ksymoops 2.3.5 on i686 2.4.1.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1/ (default)
     -m /boot/System.map-2.4.3-pre1 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address
00000004
c0142a52
*pde = 00000000
Oops:  0000
CPU:  0
EIP:  0010:[<c0142a52>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS:  00010286
eax: 00000000  ebx: 00000000  ecx: 00000000  edx: 00000000
esi: c12ef840  edi: c12f1e28  ebp: c122e800  esp: c122bf18
ds: 0018  es: 0018  ss: 0018
Process swapper (pid: 1, stackpage=c122b000)
Stack: 00000000 c12f1e28 00000001 c122e800 c0142ca6 c122e800 00000001
c12f1e28
       00000000 00000000 c0200d80 c122e800 00000000 c0201440 c0145f01
c122e800
       00000001 00000000 00000000 c122e800 c122e800 c014601a c122e800
00000001
Call Trace: [<c0142ca6>] [<c0145f01>] [<c014601a>] [<c01349a4>]
[<c0134f7a>] [<c0107007>] [<c01074b8>]
Code: 83 78 04 00 74 10 8b 54 24 24 52 56 8b 40 04 ff d0 83 c4 08

>>EIP; c0142a52 <get_new_inode+b2/160>   <=====
Trace; c0142ca6 <iget4+b6/d0>
Trace; c0145f01 <proc_get_inode+41/120>
Trace; c014601a <proc_read_super+3a/b0>
Trace; c01349a4 <read_super+104/180>
Trace; c0134f7a <kern_mount+2a/80>
Trace; c0107007 <init+7/110>
Trace; c01074b8 <kernel_thread+28/40>
Code;  c0142a52 <get_new_inode+b2/160>
00000000 <_EIP>:
Code;  c0142a52 <get_new_inode+b2/160>   <=====
   0:   83 78 04 00               cmpl   $0x0,0x4(%eax)   <=====
Code;  c0142a56 <get_new_inode+b6/160>
   4:   74 10                     je     16 <_EIP+0x16> c0142a68
<get_new_inode+c8/160>
Code;  c0142a58 <get_new_inode+b8/160>
   6:   8b 54 24 24               mov    0x24(%esp,1),%edx
Code;  c0142a5c <get_new_inode+bc/160>
   a:   52                        push   %edx
Code;  c0142a5d <get_new_inode+bd/160>
   b:   56                        push   %esi
Code;  c0142a5e <get_new_inode+be/160>
   c:   8b 40 04                  mov    0x4(%eax),%eax
Code;  c0142a61 <get_new_inode+c1/160>
   f:   ff d0                     call   *%eax
Code;  c0142a63 <get_new_inode+c3/160>
  11:   83 c4 08                  add    $0x8,%esp

kernel panic:  Attempted to kill init!

[6]
[7]
[7.2]
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 2
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 751.714
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1500.77

[7.5] 
nexxus:/usr/src/linux# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8371 [KX133] (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8371 [PCI-PCI Bridge]
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: d4000000-d5ffffff
        Prefetchable memory behind bridge: d6000000-d7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev
22)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
10) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686
[Apollo Super AC97/Audio] (rev 20)
        Subsystem: Analog Devices: Unknown device 5340
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 9
        Region 0: I/O ports at dc00 [size=256]
        Region 1: I/O ports at e000 [size=4]
        Region 2: I/O ports at e400 [size=4]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR)
53c875 (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (4250ns min, 16000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at d9001000 (32-bit, non-prefetchable)
[size=256]
        Region 2: Memory at d9000000 (32-bit, non-prefetchable)
[size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev
15) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d4000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at d6000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=<none>

[7.6]
nexxus:/usr/src/linux# cat /proc/scsi/scsi
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ARCHIVE  Model: VIPER 150  21247 Rev: -011
  Type:   Sequential-Access                ANSI SCSI revision: 01
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: TANDBERG Model:  TDC 3800        Rev: =04:
  Type:   Sequential-Access                ANSI SCSI revision: 02

[7.7]
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     2.1e
South Bridge:                       VIA vt82c686a rev 0x22
Command register:                   0x7
Latency timer:                      32
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
FIFO Output Data 1/2 Clock Advance: off
BM IDE Status Register Read Retry:  on
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:           on                  on
End Sect. FIFO flush:          on                  on
Prefetch Buffer:               on                  on
Post Write Buffer:             on                  on
FIFO size:                      8                   8
Threshold Prim.:              1/2                 1/2
Bytes Per Sector:             512                 512
Both channels togth:          yes                 yes
-------------------drive0----drive1----drive2----drive3-----
BMDMA enabled:        yes       yes        no        no
Transfer Mode:       UDMA      UDMA   DMA/PIO   DMA/PIO
Address Setup:       30ns      30ns      90ns      60ns
Active Pulse:        90ns      90ns     300ns      90ns
Recovery Time:       30ns      30ns     300ns      60ns
Cycle Time:          30ns      60ns     600ns     150ns
Transfer Rate:   66.0MB/s  33.0MB/s   3.3MB/s  13.2MB/s


Sorry, no patch.

--- TimO
