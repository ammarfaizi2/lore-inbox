Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265724AbTFXGqR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 02:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265727AbTFXGqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 02:46:17 -0400
Received: from [195.228.112.1] ([195.228.112.1]:47364 "HELO goliat.otpbank.si")
	by vger.kernel.org with SMTP id S265724AbTFXGpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 02:45:52 -0400
Message-ID: <3EF7F619.6040405@dell633.otpefo.com>
Date: Tue, 24 Jun 2003 08:56:25 +0200
From: Nagy Tibor <nagyt@otpbank.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en, hu
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Fatal Oops on Dell6300 (kernel 2.4.20)
Content-Type: multipart/mixed;
 boundary="------------040102020906010403080508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040102020906010403080508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

See attached BUG REPORT

------------------------------------------------------------------------
Tibor Nagy
National Savings and Commercial Bank Ltd (OTP Bank)
E-mail: nagyt@otpbank.hu
------------------------------------------------------------------------


--------------040102020906010403080508
Content-Type: text/plain;
 name="REPORTING-BUGS"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="REPORTING-BUGS"

[1.] One line summary of the problem:    

Fatal Oops on Dell6300 (kernel 2.4.20)

[2.] Full description of the problem/report:

Our Dell PowerEdge 6300 server (4x550 MHz Xeon, 4GB RAM, SuSe Linux 8.0, 2.4.20 Linux kernel) crashed with the attached Oops.

[3.] Keywords (i.e., modules, networking, kernel):

kernel, oops

[4.] Kernel version (from /proc/version):

Linux version 2.4.20 (root@dell632) (gcc version 2.95.3 20010315 (SuSE)) #4 SMP Fri Jan 10 12:07:00 CET 2003

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

ksymoops 2.4.3 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/v2.4.20/System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Warning (compare_maps): ksyms_base symbol ip_conntrack_expect_find_get_R__ver_ip_conntrack_expect_find_get not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol ip_conntrack_expect_put_R__ver_ip_conntrack_expect_put not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol ip_conntrack_find_get_R__ver_ip_conntrack_find_get not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol ip_conntrack_put_R__ver_ip_conntrack_put not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol netlink_attach_R__ver_netlink_attach not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol netlink_detach_R__ver_netlink_detach not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol netlink_post_R__ver_netlink_post not found in System.map.  Ignoring ksyms_base entry
Oops:   0000
CPU:    0
EIP:    0010:[<c024ff2e>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 0000002c   ebx: e1e9b198     ecx: c0342dc8       edx: 00000000
esi: 00000000   edi: 00000000     ebp: d6d16080       esp: c02d5ed8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02d5000)
Stack: d6d16080 c024fedc 00000001 c0342dc0 00000800 00000000 e1e9b000 c02510d7
       d6d16080 d6d16080 c0251050 00000000 c011e75f d6d16080 00000000 00000000
       00000000 c0342dc0 c0319b4c c0319b20 00000000 40a8a186 00000086 d696e4e4
Call Trace:    [<c024fedc>] [<c02510d7>] [<c0251050>] [<c011e75f>] [<c011b360>]
  [<c011b243>] [<c011afcf>] [<c01088cb>] [<c01052a0>] [<c01052a0>] [<c01052a0>]
  [<c01052a0>] [<c01052cc>] [<c0105332>] [<c0105000>] [<c010504f>]
Code: 8b 40 2c 47 89 7c 24 10 b9 08 00 00 00 83 78 09 0f 4c c8 b8

>>EIP; c024ff2e <xprt_timer+52/100>   <=====
Trace; c024fedc <xprt_timer+0/100>
Trace; c02510d6 <rpc_run_timer+86/90>
Trace; c0251050 <rpc_run_timer+0/90>
Trace; c011e75e <timer_bh+292/3d0>
Trace; c011b360 <bh_action+4c/88>
Trace; c011b242 <tasklet_hi_action+66/a0>
Trace; c011afce <do_softirq+6e/cc>
Trace; c01088ca <do_IRQ+da/ec>
Trace; c01052a0 <default_idle+0/34>
Trace; c01052a0 <default_idle+0/34>
Trace; c01052a0 <default_idle+0/34>
Trace; c01052a0 <default_idle+0/34>
Trace; c01052cc <default_idle+2c/34>
Trace; c0105332 <cpu_idle+3e/54>
Trace; c0105000 <_stext+0/0>
Trace; c010504e <rest_init+4e/50>
Code;  c024ff2e <xprt_timer+52/100>
00000000 <_EIP>:
Code;  c024ff2e <xprt_timer+52/100>   <=====
   0:   8b 40 2c                  mov    0x2c(%eax),%eax   <=====
Code;  c024ff30 <xprt_timer+54/100>
   3:   47                        inc    %edi
Code;  c024ff32 <xprt_timer+56/100>
   4:   89 7c 24 10               mov    %edi,0x10(%esp,1)
Code;  c024ff36 <xprt_timer+5a/100>
   8:   b9 08 00 00 00            mov    $0x8,%ecx
Code;  c024ff3a <xprt_timer+5e/100>
   d:   83 78 09 0f               cmpl   $0xf,0x9(%eax)
Code;  c024ff3e <xprt_timer+62/100>
  11:   4c                        dec    %esp
Code;  c024ff40 <xprt_timer+64/100>
  12:   c8 b8 00 00               enter  $0xb8,$0x0

 <0> Kernel panic: Aiee, killing interrupt handler!

8 warnings issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the
     problem (if possible)

None

[7.] Environment

Dell PowerEdge 6300 server
4x550 MHz Xeon
4GB RAM
SuSe Linux 8.0
2.4.20 Linux kernel (static kernel, no modules loaded)

[7.1.] Software (add the output of the ver_linux script here)

Linux dell632 2.4.20 #4 SMP Fri Jan 10 12:07:00 CET 2003 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.12
e2fsprogs              1.26
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        x    1 root     root      1394238 Mar 23  2002 /lib/libc.so.6
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded

[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 3
cpu MHz		: 550.049
cache size	: 1024 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1097.72

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 3
cpu MHz		: 550.049
cache size	: 1024 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1097.72

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 3
cpu MHz		: 550.049
cache size	: 1024 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1097.72

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 3
cpu MHz		: 550.049
cache size	: 1024 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1097.72


[7.3.] Module information (from /proc/modules):

Empty

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
02f8-02ff : serial(auto)
03c0-03df : vga+
03f8-03ff : serial(auto)
0800-083f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
0840-085f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
0cf8-0cff : PCI conf1
1000-100f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
1020-103f : Intel Corp. 82371AB/EB/MB PIIX4 USB
d800-d8ff : Adaptec AHA-2940U/UW/D / AIC-7881U
dc00-dcff : ATI Technologies Inc 3D Rage Pro
ec00-ecff : Adaptec AIC-7860
fc80-fcbf : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
  fc80-fcbf : eepro100
fcc0-fcff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  fcc0-fcff : eepro100

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c87ff : Extension ROM
000cc000-000ccbff : Extension ROM
000d0000-000d07ff : Extension ROM
000f0000-000fffff : System ROM
00100000-fbffdfff : System RAM
  00100000-002630b0 : Kernel code
  002630b1-002d2b23 : Kernel data
fbffe000-fbffffff : reserved
fd000000-fdffffff : ATI Technologies Inc 3D Rage Pro
fe3f0000-fe3fffff : Intel Corp. 80960RP [i960RP Microprocessor]
fe500000-fe500fff : Adaptec AHA-2940U/UW/D / AIC-7881U
  fe500000-fe500fff : aic7xxx
fe501000-fe501fff : ATI Technologies Inc 3D Rage Pro
fe700000-fe700fff : Adaptec AIC-7860
  fe700000-fe700fff : aic7xxx
fe800000-fe8fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
fe900000-fe9fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
feb00000-feb00fff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
  feb00000-feb00fff : eepro100
feb01000-feb01fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  feb01000-feb01fff : eepro100
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:02.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:02.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 4: I/O ports at 1000 [disabled] [size=16]

00:02.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin D routed to IRQ 0
	Region 4: I/O ports at 1020 [disabled] [size=32]

00:02.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:04.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro (rev 5c) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 007f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Region 0: Memory at fd000000 (32-bit, prefetchable) [size=16M]
	Region 1: I/O ports at dc00 [size=256]
	Region 2: Memory at fe501000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]

00:06.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 14
	Region 0: I/O ports at d800 [disabled] [size=256]
	Region 1: Memory at fe500000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at fe400000 [disabled] [size=64K]

00:08.0 PCI bridge: Intel Corp. 80960RP [i960 RP Microprocessor/Bridge] (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:08.1 SCSI storage controller: Intel Corp. 80960RP [i960RP Microprocessor] (rev 03)
	Subsystem: Dell Computer Corporation PowerEdge Expandable RAID Controller 2/SC
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fe3f0000 (32-bit, prefetchable) [size=64K]
	Expansion ROM at fe400000 [disabled] [size=32K]

00:10.0 Host bridge: Intel Corp. 450NX - 82451NX Memory & I/O Controller (rev 03)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:12.0 Host bridge: Intel Corp. 450NX - 82454NX/84460GX PCI Expander Bridge (rev 04)
	Subsystem: Intel Corp. 450NX - 82454NX/84460GX PCI Expander Bridge
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 72, cache line size 08

00:13.0 Host bridge: Intel Corp. 450NX - 82454NX/84460GX PCI Expander Bridge (rev 04)
	Subsystem: Intel Corp. 450NX - 82454NX/84460GX PCI Expander Bridge
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 72, cache line size 08

00:14.0 Host bridge: Intel Corp. 450NX - 82454NX/84460GX PCI Expander Bridge (rev 04)
	Subsystem: Intel Corp. 450NX - 82454NX/84460GX PCI Expander Bridge
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 72, cache line size 08

02:08.0 SCSI storage controller: Adaptec AIC-7860 (rev 03)
	Subsystem: Adaptec: Unknown device 7860
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 20
	Region 0: I/O ports at ec00 [disabled] [size=256]
	Region 1: Memory at fe700000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:01.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corp. EtherExpress PRO/100+ Server Adapter (PILA8470B)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at feb01000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at fcc0 [size=64]
	Region 2: Memory at fe900000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

03:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corp. EtherExpress PRO/100+ Server Adapter (PILA8470B)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at feb00000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at fc80 [size=64]
	Region 2: Memory at fe800000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-R412C  Rev: 1.03
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: QUANTUM  Model: DLT7000          Rev: 2150
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor: NEC      Model: CD-ROM DRIVE:466 Rev: 1.06
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 06 Lun: 00
  Vendor: DELL     Model: 1x6 U2W SCSI BP  Rev: 5.23
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi2 Channel: 01 Id: 00 Lun: 00
  Vendor: MegaRAID Model: LD0 RAID0 17278R Rev: 3.13
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 01 Id: 01 Lun: 00
  Vendor: MegaRAID Model: LD1 RAID0 17278R Rev: 3.13
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 01 Id: 02 Lun: 00
  Vendor: MegaRAID Model: LD2 RAID0 17278R Rev: 3.13
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 01 Id: 03 Lun: 00
  Vendor: MegaRAID Model: LD3 RAID0 17278R Rev: 3.13
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 01 Id: 04 Lun: 00
  Vendor: MegaRAID Model: LD4 RAID0 17278R Rev: 3.13
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 01 Id: 05 Lun: 00
  Vendor: MegaRAID Model: LD5 RAID0 17278R Rev: 3.13
  Type:   Direct-Access                    ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
       
[X.] Other notes, patches, fixes, workarounds:


Thank you

--------------040102020906010403080508--

