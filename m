Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbTEPIRM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 04:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbTEPIRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 04:17:12 -0400
Received: from [195.228.112.1] ([195.228.112.1]:32794 "HELO goliat.otp-bank.hu")
	by vger.kernel.org with SMTP id S264373AbTEPIQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 04:16:56 -0400
Message-ID: <3EC4A11B.5050504@dell633.otpefo.com>
Date: Fri, 16 May 2003 10:28:11 +0200
From: Nagy Tibor <nagyt@otpbank.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en, hu
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Fatal Oops on Dell6600 (kernel 2.4.20)
Content-Type: multipart/mixed;
 boundary="------------090207070409050900070601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090207070409050900070601
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

See attached BUG REPORT

------------------------------------------------------------------------
Tibor Nagy
National Savings and Commercial Bank Ltd (OTP Bank)
E-mail: nagyt@otpbank.hu
------------------------------------------------------------------------

--------------090207070409050900070601
Content-Type: text/plain;
 name="REPORTING-BUGS"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="REPORTING-BUGS"

[1.] One line summary of the problem:    

Fatal Oops on Dell6600 (kernel 2.4.20)

[2.] Full description of the problem/report:

Our Dell PowerEdge 6600 server (4x1400 MHz multithread Xeon, 4GB RAM, SuSe Linux 8.0, 2.4.20 Linux kernel) crashed with the attached Oops.

[3.] Keywords (i.e., modules, networking, kernel):

kernel, oops

[4.] Kernel version (from /proc/version):

Linux version 2.4.20 (root@alfa) (gcc version 2.95.3 20010315 (SuSE)) #10 SMP Fri Mar 28 15:40:45 CET 2003

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

ksymoops 2.4.3 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/v2.4.20/System.map (specified)

Warning (compare_maps): ksyms_base symbol ip_conntrack_expect_find_get_R__ver_ip_conntrack_expect_find_get not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol ip_conntrack_expect_put_R__ver_ip_conntrack_expect_put not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol ip_conntrack_find_get_R__ver_ip_conntrack_find_get not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol ip_conntrack_put_R__ver_ip_conntrack_put not found in System.map.  Ignoring ksyms_base entry
CPU: 6
EIP: 0010:[<c0246400>] Not tained
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
Process rsh (pid: 27741, stackpage=ea8bd000)
Stack:  ea8bc000 ea8bdd64 f704df00 ea8bddf8 00002000 1f92fc04 01f0c90a 030ac90a
        f8806000 000003fe fe03f800 1f92fc04 01f0c90a 030ac90a c0246467 ea8bdd64
        00000000 ea86dd60 ea8bdd64 c0247028 ea8bdd64 00000000 ea8bdde8 c038a6f8
Call Trace:  [<c0246467>] [<c0247028>] [<c0220600>] [<c021fe03>] [<c02456c0>]
[<c0220600>] [<c021523c>] [<c0220600>] [<c0220600>] [<c021558f>] [<c0220600>]
[<c021fa29>] [<c0220600>] [<c0234116>] [<c022ef2e>] [<c022efe9>] [<c020af0e>]
[<c022f2ee>] [<c622511f>] [<c02410a6>] [<c0207905>] [<c020761e>] [<c0135fe7>]
[<c0106f23>]
Code: 8b 6d 8b ea 44 24 2c 03 44 24 24 31 d2 f7 74 24 10 8b 4c 24

>>EIP; c0246400 <__ip_conntrack_find+9c/120>   <=====
Trace; c0246466 <__ip_conntrack_find+102/120>
Trace; c0247028 <ip_conntrack_in+124/270>
Trace; c0220600 <ip_fragment+2f4/37c>
Trace; c021fe02 <ip_build_xmit_slow+37e/520>
Trace; c02456c0 <rtmsg_fib+a4/d0>
Trace; c0220600 <ip_fragment+2f4/37c>
Trace; c021523c <nf_iterate+30/84>
Trace; c0220600 <ip_fragment+2f4/37c>
Trace; c0220600 <ip_fragment+2f4/37c>
Trace; c021558e <nf_hook_slow+d6/194>
Trace; c0220600 <ip_fragment+2f4/37c>
Trace; c021fa28 <ip_queue_xmit+49c/4f8>
Trace; c0220600 <ip_fragment+2f4/37c>
Trace; c0234116 <tcp_v4_send_check+66/a8>
Trace; c022ef2e <tcp_transmit_skb+43a/5ac>
Trace; c022efe8 <tcp_transmit_skb+4f4/5ac>
Trace; c020af0e <skb_clone+76/1a8>
Trace; c022f2ee <tcp_push_one+76/100>
Trace; c622511e <_end+5e892a2/385d1184>
Trace; c02410a6 <inet_sendmsg+3a/40>
Trace; c0207904 <sock_sendmsg+68/88>
Trace; c020761e <sock_map_fd+a6/180>
Trace; c0135fe6 <sys_write+8e/100>
Trace; c0106f22 <system_call+32/38>
Code;  c0246400 <__ip_conntrack_find+9c/120>
00000000 <_EIP>:
Code;  c0246400 <__ip_conntrack_find+9c/120>   <=====
   0:   8b 6d 8b                  mov    0xffffff8b(%ebp),%ebp   <=====
Code;  c0246402 <__ip_conntrack_find+9e/120>
   3:   ea 44 24 2c 03 44 24      ljmp   $0x2444,$0x32c2444
Code;  c024640a <__ip_conntrack_find+a6/120>
   a:   24 31                     and    $0x31,%al
Code;  c024640c <__ip_conntrack_find+a8/120>
   c:   d2                        (bad)  
Code;  c024640c <__ip_conntrack_find+a8/120>
   d:   f7 74 24 10               divl   0x10(%esp,1)
Code;  c0246410 <__ip_conntrack_find+ac/120>
  11:   8b 4c 24 00               mov    0x0(%esp,1),%ecx

<0>  Kernel panic: Aiee, killing interrupt handler!

4 warnings issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the
     problem (if possible)

None

[7.] Environment

Dell PowerEdge 6600 server
4x1400 MHz multithread Xeonxi
4GB RAM
SuSe Linux 8.0
2.4.20 Linux kernel (practically static kernel, with the exception of th SCSI tape driver, and its controller)

[7.1.] Software (add the output of the ver_linux script here)

Linux alfa 2.4.20 #10 SMP Fri Mar 28 15:40:45 CET 2003 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.12
e2fsprogs              1.26
jfsutils               1.0.15
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        x    1 root     root      1394238 Mar 23  2002 /lib/libc.so.6
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         st aic7xxx

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Xeon(TM) CPU 1.40GHz
stepping        : 1
cpu MHz         : 1393.773
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2778.72

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Xeon(TM) CPU 1.40GHz
stepping        : 1
cpu MHz         : 1393.773
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2785.28

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Xeon(TM) CPU 1.40GHz
stepping        : 1
cpu MHz         : 1393.773
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2785.28

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Xeon(TM) CPU 1.40GHz
stepping        : 1
cpu MHz         : 1393.773
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2785.28

processor       : 4
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Xeon(TM) CPU 1.40GHz
stepping        : 1
cpu MHz         : 1393.773
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2785.28

processor       : 5
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Xeon(TM) CPU 1.40GHz
stepping        : 1
cpu MHz         : 1393.773
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2785.28

processor       : 6
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Xeon(TM) CPU 1.40GHz
stepping        : 1
cpu MHz         : 1393.773
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2785.28

processor       : 7
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Xeon(TM) CPU 1.40GHz
stepping        : 1
cpu MHz         : 1393.773
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2785.28


[7.3.] Module information (from /proc/modules):

st                     27380   1 (autoclean)
aic7xxx               111360   1

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
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
08b0-08bf : ServerWorks CSB5 IDE Controller
08c0-08c7 : ServerWorks CSB5 IDE Controller
08c8-08cb : ServerWorks CSB5 IDE Controller
08d0-08d7 : ServerWorks CSB5 IDE Controller
08d8-08db : ServerWorks CSB5 IDE Controller
0cf8-0cff : PCI conf1
9cc0-9cff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
  9cc0-9cff : eepro100
d000-dfff : PCI Bus #04
  d800-d8ff : QLogic Corp. ISP12160 Dual Channel Ultra3 SCSI Processor (#2)
  dc00-dcff : QLogic Corp. ISP12160 Dual Channel Ultra3 SCSI Processor
e4c0-e4ff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  e4c0-e4ff : eepro100
e800-e8ff : ATI Technologies Inc Rage XL
ec00-ecff : Adaptec AIC-7892P U160/m

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c91ff : Extension ROM
000c9800-000ca7ff : Extension ROM
000ca800-000cb7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-dffeffff : System RAM
  00100000-0027f443 : Kernel code
  0027f444-002f589f : Kernel data
dfff0000-dfffebff : ACPI Tables
dfffec00-dfffefff : reserved
ee600000-ee6fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
ee800000-ee800fff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
  ee800000-ee800fff : eepro100
eff00000-eff0ffff : Broadcom Corporation NetXtreme BCM5700 Gigabit Ethernet
f0000000-f7ffffff : PCI Bus #04
  f0000000-f7ffffff : PCI Bus #05
    f0000000-f7ffffff : American Megatrends Inc. MegaRAID
fcd00000-fcffffff : PCI Bus #04
  fcdfe000-fcdfefff : QLogic Corp. ISP12160 Dual Channel Ultra3 SCSI Processor (#2)
  fcdff000-fcdfffff : QLogic Corp. ISP12160 Dual Channel Ultra3 SCSI Processor
  fcf00000-fcffffff : PCI Bus #05
fd000000-fdffffff : ATI Technologies Inc Rage XL
fe000000-fe0fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
fe200000-fe200fff : ServerWorks OSB4/CSB5 OHCI USB Controller
fe201000-fe201fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  fe201000-fe201fff : eepro100
fe202000-fe202fff : ATI Technologies Inc Rage XL
fe203000-fe203fff : Adaptec AIC-7892P U160/m
  fe203000-fe203fff : aic7xxx
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: ServerWorks CMIC-HE (rev 22)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.1 Host bridge: ServerWorks CMIC-HE
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 Host bridge: ServerWorks CMIC-HE
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.3 Host bridge: ServerWorks CMIC-HE
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:03.0 SCSI storage controller: Adaptec AIC-7892P U160/m (rev 02)
	Subsystem: Dell Computer Corporation: Unknown device 0109
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (10000ns min, 6250ns max), cache line size 10
	Interrupt: pin A routed to IRQ 16
	BIST result: 00
	Region 0: I/O ports at ec00 [disabled] [size=256]
	Region 1: Memory at fe203000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at fe100000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 0109
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 10
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at e800 [size=256]
	Region 2: Memory at fe202000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 10
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at fe201000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at e4c0 [size=64]
	Region 2: Memory at fe000000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at fe100000 [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0f.0 Host bridge: ServerWorks CSB5 South Bridge (rev 93)
	Subsystem: ServerWorks CSB5 South Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93) (prog-if 82 [Master PriP])
	Subsystem: ServerWorks CSB5 IDE Controller
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at 08c0 [size=8]
	Region 1: I/O ports at 08c8 [size=4]
	Region 2: I/O ports at 08d0 [size=8]
	Region 3: I/O ports at 08d8 [size=4]
	Region 4: I/O ports at 08b0 [size=16]

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 05) (prog-if 10 [OHCI])
	Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max)
	Interrupt: pin A routed to IRQ 7
	Region 0: Memory at fe200000 (32-bit, non-prefetchable) [size=4K]

00:0f.3 ISA bridge: ServerWorks: Unknown device 0225
	Subsystem: ServerWorks: Unknown device 0230
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:10.0 Host bridge: ServerWorks CIOB30 (rev 03)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Capabilities: [60] #07 [0040]

00:10.2 Host bridge: ServerWorks CIOB30 (rev 03)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Capabilities: [60] #07 [0040]

00:11.0 Host bridge: ServerWorks CIOB30 (rev 03)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Capabilities: [60] #07 [0040]

00:11.2 Host bridge: ServerWorks CIOB30 (rev 03)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Capabilities: [60] #07 [0040]

00:12.0 Host bridge: ServerWorks CIOB30 (rev 03)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Capabilities: [60] #07 [0040]

00:12.2 Host bridge: ServerWorks CIOB30 (rev 03)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Capabilities: [60] #07 [0040]

03:01.0 PCI bridge: Intel Corp.: Unknown device b154 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=03, secondary=04, subordinate=05, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fcd00000-fcffffff
	Prefetchable memory behind bridge: 00000000f0000000-00000000f7f00000
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

04:00.0 PCI bridge: Intel Corp.: Unknown device b154 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=04, secondary=05, subordinate=05, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fcf00000-fcffffff
	Prefetchable memory behind bridge: 00000000f0000000-00000000f7f00000
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

04:01.0 SCSI storage controller: QLogic Corp. ISP12160 Dual Channel Ultra3 SCSI Processor (rev 06)
	Subsystem: American Megatrends Inc. QLA12160 on AMI MegaRAID
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (16000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 32
	Region 0: I/O ports at dc00 [size=256]
	Region 1: Memory at fcdff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at fce00000 [disabled] [size=128K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

04:02.0 SCSI storage controller: QLogic Corp. ISP12160 Dual Channel Ultra3 SCSI Processor (rev 06)
	Subsystem: American Megatrends Inc. QLA12160 on AMI MegaRAID
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (16000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 31
	Region 0: I/O ports at d800 [size=256]
	Region 1: Memory at fcdfe000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at fce00000 [disabled] [size=128K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

05:00.0 RAID bus controller: American Megatrends Inc. MegaRAID (rev 20)
	Subsystem: Dell Computer Corporation PowerEdge RAID Controller 3/QC
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 10
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at fcf00000 [disabled] [size=32K]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0a:01.0 Ethernet controller: BROADCOM Corporation NetXtreme BCM5700 Gigabit Ethernet (rev 14)
	Subsystem: Dell Computer Corporation: Unknown device 0109
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (16000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at eff00000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] #07 [0002]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: 408263f9804a5ff8  Data: 572f

10:01.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 10
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at ee800000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 9cc0 [size=64]
	Region 2: Memory at ee600000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at ee700000 [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: PE/PV    Model: 1x8 SCSI BP      Rev: 0.28
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi0 Channel: 02 Id: 06 Lun: 00
  Vendor: DELL     Model: PV22XS           Rev: E.10
  Type:   Processor                        ANSI SCSI revision: 03
Host: scsi0 Channel: 03 Id: 06 Lun: 00
  Vendor: DELL     Model: PV22XS           Rev: E.10
  Type:   Processor                        ANSI SCSI revision: 03
Host: scsi0 Channel: 04 Id: 00 Lun: 00
  Vendor: MegaRAID Model: LD0 RAID1 17278R Rev: 161N
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 04 Id: 01 Lun: 00
  Vendor: MegaRAID Model: LD1 RAID1 22600R Rev: 161N
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 04 Id: 02 Lun: 00
  Vendor: MegaRAID Model: LD2 RAID1 22600R Rev: 161N
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 04 Id: 03 Lun: 00
  Vendor: MegaRAID Model: LD3 RAID1 24678R Rev: 161N
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 04 Id: 04 Lun: 00
  Vendor: MegaRAID Model: LD4 RAID1 22600R Rev: 161N
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 04 Id: 05 Lun: 00
  Vendor: MegaRAID Model: LD5 RAID1 22600R Rev: 161N
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 04 Id: 06 Lun: 00
  Vendor: MegaRAID Model: LD6 RAID1 24678R Rev: 161N
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 04 Id: 08 Lun: 00
  Vendor: MegaRAID Model: LD7 RAID1 22600R Rev: 161N
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 04 Id: 09 Lun: 00
  Vendor: MegaRAID Model: LD8 RAID1 22600R Rev: 161N
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 04 Id: 10 Lun: 00
  Vendor: MegaRAID Model: LD9 RAID1 24678R Rev: 161N
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 04 Id: 11 Lun: 00
  Vendor: MegaRAID Model: LD: RAID1 22600R Rev: 161N
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 04 Id: 12 Lun: 00
  Vendor: MegaRAID Model: LD; RAID1 22600R Rev: 161N
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 04 Id: 13 Lun: 00
  Vendor: MegaRAID Model: LD< RAID1 24678R Rev: 161N
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 04 Id: 14 Lun: 00
  Vendor: MegaRAID Model: LD= RAID1 22600R Rev: 161N
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 04 Id: 15 Lun: 00
  Vendor: MegaRAID Model: LD> RAID1 22600R Rev: 161N
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 05 Id: 00 Lun: 00
  Vendor: MegaRAID Model: LD? RAID1 24678R Rev: 161N
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 05 Id: 01 Lun: 00
  Vendor: MegaRAID Model: LD@ RAID1 70008R Rev: 161N
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor: QUANTUM  Model: DLT7000          Rev: 2561
  Type:   Sequential-Access                ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
       
[X.] Other notes, patches, fixes, workarounds:


Thank you

--------------090207070409050900070601--

