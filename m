Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261498AbTCKSVB>; Tue, 11 Mar 2003 13:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261505AbTCKSVB>; Tue, 11 Mar 2003 13:21:01 -0500
Received: from vulcan.americom.com ([208.187.207.195]:62866 "HELO
	solo.americom.com") by vger.kernel.org with SMTP id <S261498AbTCKSUz>;
	Tue, 11 Mar 2003 13:20:55 -0500
Date: 11 Mar 2003 18:31:38 -0000
Message-ID: <20030311183138.13152.qmail@solo.americom.com>
To: linux-kernel@vger.kernel.org
From: jeff@AmeriCom.com
Subject: kernel bug page_alloc.c 2.4.18-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This dual CPU system will stay up for a few days, and then it starts reporting these
errors to the console, shortly after these messages start appearing it will lock up.
Below is the output from dmesg. Below that is my system info. Is there a patch for
this? This is the standard redhat 8.0 kernel (2.4.18-14smp).

Thanks,

-Jeff Moss
jeff@americom.com

 ------------[ cut here ]------------
kernel BUG at page_alloc.c:125!
invalid operand: 0000
ipt_MASQUERADE ipt_state iptable_filter ip_nat_ftp iptable_nat ip_tables ip_co
CPU:    1
EIP:    0010:[<c0140b5e>]    Not tainted
EFLAGS: 00010286

EIP is at __free_pages_ok [kernel] 0x2e (2.4.18-14smp)
eax: 0200080c   ebx: c1dcb478   ecx: c1dcb478   edx: 00000000
esi: f2100e60   edi: 080fd000   ebp: 00000000   esp: c6fb1ed0
ds: 0018   es: 0018   ss: 0018
Process sshd2 (pid: 8073, stackpage=c6fb1000)
Stack: c03338e0 080f6000 0000008a c53a23e8 c013416c e502c520 d94fa9e0 401cd39c 
       edfea734 0000008b 00000073 0000008b 080fd000 0000008b c01321a2 c1dcb478 
       e615e080 08048000 000b5000 08448000 c03d85c0 0000008b 080fd000 e615e084 
Call Trace: [<c013416c>] zap_pte_range [kernel] 0x1ec (0xc6fb1ee0))
[<c01321a2>] do_zap_page_range [kernel] 0x152 (0xc6fb1f08))
[<c01326a8>] zap_page_range [kernel] 0x58 (0xc6fb1f40))
[<c0135af2>] exit_mmap [kernel] 0xe2 (0xc6fb1f64))
[<c011f3f1>] mmput [kernel] 0x51 (0xc6fb1f8c))
[<c0124b9f>] do_exit [kernel] 0xdf (0xc6fb1f9c))
[<c0124e13>] sys_exit [kernel] 0x13 (0xc6fb1fb8))
[<c0109437>] system_call [kernel] 0x33 (0xc6fb1fc0))


Code: 0f 0b 7d 00 39 bc 27 c0 8b 53 08 85 d2 0f 85 c2 02 00 00 8b 
 ------------[ cut here ]------------
kernel BUG at page_alloc.c:125!
invalid operand: 0000
ipt_MASQUERADE ipt_state iptable_filter ip_nat_ftp iptable_nat ip_tables ip_co
CPU:    1
EIP:    0010:[<c0140b5e>]    Not tainted
EFLAGS: 00010286

EIP is at __free_pages_ok [kernel] 0x2e (2.4.18-14smp)
eax: 0200080c   ebx: c1dcb478   ecx: c1dcb478   edx: 00000000
esi: f2100e60   edi: 080fd000   ebp: 00000000   esp: c4679ed0
ds: 0018   es: 0018   ss: 0018
Process sshd2 (pid: 9309, stackpage=c4679000)
Stack: c03338e0 080f6000 0000008a c639c3e8 c013416c c4b311c0 ed45ad20 401cd39c 
       f0c47734 0000008b 00000073 0000008b 080fd000 0000008b c01321a2 c1dcb478 
       e4b86080 08048000 000b5000 08448000 c03d85c0 0000008b 080fd000 e4b86084 
Call Trace: [<c013416c>] zap_pte_range [kernel] 0x1ec (0xc4679ee0))
[<c01321a2>] do_zap_page_range [kernel] 0x152 (0xc4679f08))
[<c01326a8>] zap_page_range [kernel] 0x58 (0xc4679f40))
[<c0135af2>] exit_mmap [kernel] 0xe2 (0xc4679f64))
[<c011f3f1>] mmput [kernel] 0x51 (0xc4679f8c))
[<c0124b9f>] do_exit [kernel] 0xdf (0xc4679f9c))
[<c0124e13>] sys_exit [kernel] 0x13 (0xc4679fb8))
[<c0109437>] system_call [kernel] 0x33 (0xc4679fc0))


Code: 0f 0b 7d 00 39 bc 27 c0 8b 53 08 85 d2 0f 85 c2 02 00 00 8b 
 ------------[ cut here ]------------
kernel BUG at page_alloc.c:125!
invalid operand: 0000
ipt_MASQUERADE ipt_state iptable_filter ip_nat_ftp iptable_nat ip_tables ip_co
CPU:    0
EIP:    0010:[<c0140b5e>]    Not tainted
EFLAGS: 00010286

EIP is at __free_pages_ok [kernel] 0x2e (2.4.18-14smp)
eax: 0200080c   ebx: c1dcb478   ecx: c1dcb478   edx: 00000000
esi: f2100e60   edi: 080fd000   ebp: 00000000   esp: dd31ded0
ds: 0018   es: 0018   ss: 0018
Process sshd2 (pid: 10175, stackpage=dd31d000)
Stack: c03338e0 080f6000 0000008a da68e3e8 c013416c c77eb5e0 d42b3f80 401cd39c 
       ec299734 0000008b 00000073 0000008b 080fd000 0000008b c01321a2 c1dcb478 
       ea863080 08048000 000b5000 08448000 c03d7dc0 0000008b 080fd000 ea863084 
Call Trace: [<c013416c>] zap_pte_range [kernel] 0x1ec (0xdd31dee0))
[<c01321a2>] do_zap_page_range [kernel] 0x152 (0xdd31df08))
[<c01326a8>] zap_page_range [kernel] 0x58 (0xdd31df40))
[<c0135af2>] exit_mmap [kernel] 0xe2 (0xdd31df64))
[<c011f3f1>] mmput [kernel] 0x51 (0xdd31df8c))
[<c0124b9f>] do_exit [kernel] 0xdf (0xdd31df9c))
[<c0124e13>] sys_exit [kernel] 0x13 (0xdd31dfb8))
[<c0109437>] system_call [kernel] 0x33 (0xdd31dfc0))


Code: 0f 0b 7d 00 39 bc 27 c0 8b 53 08 85 d2 0f 85 c2 02 00 00 8b 
 ------------[ cut here ]------------
kernel BUG at page_alloc.c:125!
invalid operand: 0000
ipt_MASQUERADE ipt_state iptable_filter ip_nat_ftp iptable_nat ip_tables ip_co
CPU:    0
EIP:    0010:[<c0140b5e>]    Not tainted
EFLAGS: 00010286

EIP is at __free_pages_ok [kernel] 0x2e (2.4.18-14smp)
eax: 0200080c   ebx: c1dcb478   ecx: c1dcb478   edx: 00000000
esi: f2100e60   edi: 080fd000   ebp: 00000000   esp: f58dbed0
ds: 0018   es: 0018   ss: 0018
Process sshd2 (pid: 10272, stackpage=f58db000)
Stack: c03338e0 080f6000 0000008a eebe03e8 c013416c c34a4088 c01b40fc c34a4088 
       c361d1a0 0000008b 00000073 0000008b 080fd000 0000008b c01321a2 c1dcb478 
       ecb97080 08048000 000b5000 08448000 c03d7dc0 0000008b 080fd000 ecb97084 
Call Trace: [<c013416c>] zap_pte_range [kernel] 0x1ec (0xf58dbee0))
[<c01b40fc>] account_io_end [kernel] 0x2c (0xf58dbee8))
[<c01321a2>] do_zap_page_range [kernel] 0x152 (0xf58dbf08))
[<c01326a8>] zap_page_range [kernel] 0x58 (0xf58dbf40))
[<c0135af2>] exit_mmap [kernel] 0xe2 (0xf58dbf64))
[<c011f3f1>] mmput [kernel] 0x51 (0xf58dbf8c))
[<c0124b9f>] do_exit [kernel] 0xdf (0xf58dbf9c))
[<c0124e13>] sys_exit [kernel] 0x13 (0xf58dbfb8))
[<c0109437>] system_call [kernel] 0x33 (0xf58dbfc0))


Code: 0f 0b 7d 00 39 bc 27 c0 8b 53 08 85 d2 0f 85 c2 02 00 00 8b 
 ------------[ cut here ]------------
kernel BUG at page_alloc.c:125!
invalid operand: 0000
ipt_MASQUERADE ipt_state iptable_filter ip_nat_ftp iptable_nat ip_tables ip_co
CPU:    0
EIP:    0010:[<c0140b5e>]    Not tainted
EFLAGS: 00010286

EIP is at __free_pages_ok [kernel] 0x2e (2.4.18-14smp)
eax: 0200080c   ebx: c1dcb478   ecx: c1dcb478   edx: 00000000
esi: f2100e60   edi: 080fd000   ebp: 00000000   esp: f58dbed0
ds: 0018   es: 0018   ss: 0018
Process sshd2 (pid: 10282, stackpage=f58db000)
Stack: c03338e0 080f6000 0000008a efdd03e8 c013416c f00dd480 f3a271e0 401cd39c 
       f0521734 0000008b 00000073 0000008b 080fd000 0000008b c01321a2 c1dcb478 
       c3f20080 08048000 000b5000 08448000 c03d7dc0 0000008b 080fd000 c3f20084 
Call Trace: [<c013416c>] zap_pte_range [kernel] 0x1ec (0xf58dbee0))
[<c01321a2>] do_zap_page_range [kernel] 0x152 (0xf58dbf08))
[<c01326a8>] zap_page_range [kernel] 0x58 (0xf58dbf40))
[<c0135af2>] exit_mmap [kernel] 0xe2 (0xf58dbf64))
[<c011f3f1>] mmput [kernel] 0x51 (0xf58dbf8c))
[<c0124b9f>] do_exit [kernel] 0xdf (0xf58dbf9c))
[<c0124e13>] sys_exit [kernel] 0x13 (0xf58dbfb8))
[<c0109437>] system_call [kernel] 0x33 (0xf58dbfc0))


Code: 0f 0b 7d 00 39 bc 27 c0 8b 53 08 85 d2 0f 85 c2 02 00 00 8b


SYSTEM INFO

00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+
>SERR- <PERR-
	Latency: 8
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+
>SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: d6000000-d7ffffff
	Prefetchable memory behind bridge: d4000000-d5ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] (rev 23)
	Subsystem: VIA Technologies, Inc. VT82C596/A/B PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR-
FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog-if 8a
[Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at c000 [size=16]
	Capabilities: <available only to root>

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 11) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 12
	Region 4: I/O ports at c400 [size=32]
	Capabilities: <available only to root>

00:07.3 Bridge: VIA Technologies, Inc. VT82C596 Power Management (rev 30)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort-
>SERR- <PERR-

00:08.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
	Subsystem: Netgear FA310TX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at c800 [size=256]
	Region 1: Memory at d9000000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=256K]

00:0a.0 Ethernet controller: 3Com Corporation 3c900 Combo [Boomerang]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at cc00 [size=64]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0b.0 Unknown mass storage controller: HighPoint Technologies, Inc. HPT366/370
UltraDMA 66/100 IDE Controller (rev 03)
	Subsystem: HighPoint Technologies, Inc.: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
	Latency: 120 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at d000 [size=8]
	Region 1: I/O ports at d400 [size=4]
	Region 2: I/O ports at d800 [size=8]
	Region 3: I/O ports at dc00 [size=4]
	Region 4: I/O ports at e000 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15) (prog-if
00 [VGA])
	Subsystem: Unknown device 3842:3107
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort-
>SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d6000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d4000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>

CPU INFO:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 866.378
cache size	: 256 KB
Physical processor ID	: 775501358
Number of siblings	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx
fxsr sse
bogomips	: 1720.95

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 866.378
cache size	: 256 KB
Physical processor ID	: 757085748
Number of siblings	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx
fxsr sse
bogomips	: 1729.05


cat iomem 
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-0026ac09 : Kernel code
  0026ac0a-003758c3 : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
d0000000-d3ffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
d4000000-d5ffffff : PCI Bus #01
  d4000000-d5ffffff : nVidia Corporation Vanta [NV6]
d6000000-d7ffffff : PCI Bus #01
  d6000000-d6ffffff : nVidia Corporation Vanta [NV6]
d9000000-d90000ff : Lite-On Communications Inc LNE100TX
  d9000000-d90000ff : tulip
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved





