Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311454AbSDAM0l>; Mon, 1 Apr 2002 07:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311475AbSDAM03>; Mon, 1 Apr 2002 07:26:29 -0500
Received: from isis.telemach.net ([213.143.65.10]:48647 "HELO
	isis.telemach.net") by vger.kernel.org with SMTP id <S311454AbSDAM0O>;
	Mon, 1 Apr 2002 07:26:14 -0500
Date: Mon, 1 Apr 2002 14:25:57 +0200
From: Jure Pecar <pegasus@telemach.net>
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.19pre5aa1 oops via kt266a
Message-Id: <20020401142557.171cb72e.pegasus@telemach.net>
Organization: Select Technology 
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-redhat-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This morning i found my box with frozen X; i sshed in from another and
found:


Apr  1 07:13:55 open kernel: Unable to handle kernel paging request at
virtual address 00fc5bd8 Apr  1 07:13:55 open kernel:  printing eip:
Apr  1 07:13:55 open kernel: c0144538
Apr  1 07:13:55 open kernel: *pde = 00000000
Apr  1 07:13:55 open kernel: Oops: 0002
Apr  1 07:13:55 open kernel: CPU:    0
Apr  1 07:13:55 open kernel: EIP:    0010:[prune_dcache+40/288]    Not
tainted Apr  1 07:13:55 open kernel: EIP:    0010:[<c0144538>]    Not
tainted Apr  1 07:13:55 open kernel: EFLAGS: 00010216
Apr  1 07:13:55 open kernel: eax: c034b2fc   ebx: d7fc5b58   ecx:
d551f240   edx: 00fc5bd8 Apr  1 07:13:55 open kernel: esi: d7fc5ac0  
edi: 0000109f   ebp: 0000000e   esp: dffd9ef0 Apr  1 07:13:55 open
kernel: ds: 0018   es: 0018   ss: 0018 Apr  1 07:13:55 open kernel:
Process kswapd (pid: 4, stackpage=dffd9000) Apr  1 07:13:56 open kernel:
Stack: d6cc12c0 d6cc12c0 d6cc12c0 00000212 c0137b38 dfe72600 c034a510
c158f8a0 Apr  1 07:13:56 open kernel:        0000d9c5 c10bfbe8 00000000
c01448a0 00007e9b c012d4ac 00000006 000001d0 Apr  1 07:13:56 open
kernel:        dffd8000 ffffffff 00002aa6 000001d0 c034a510 c1245d24
c012d6f2 c1245d08 Apr  1 07:13:56 open kernel: Call Trace:
[try_to_free_buffers+152/240] [shrink_dcache_memory+32/48] [shrink_c
ache+748/976] [refill_inactive+354/448] [shrink_caches+46/64] Apr  1
07:13:56 open kernel: Call Trace: [<c0137b38>] [<c01448a0>] [<c012d4ac>]
[<c012d6f2>] [<c012d77e>] Apr  1 07:13:56 open kernel:   
[try_to_free_pages+96/240] [kswapd_balance_pgdat+91/176]
[kswapd_balance+38/6 4] [kswapd+161/192] [kswapd+0/192] [_stext+0/48] 
Apr  1 07:13:56 open kernel:    [<c012d7f0>] [<c012d93b>] [<c012d9b6>]
[<c012db01>] [<c012da60>] [<c0105000>] 
Apr  1 07:13:56 open kernel:    [kernel_thread+38/48] [kswapd+0/192] 
Apr  1 07:13:56 open kernel:    [<c0106fb6>] [<c012da60>] 
Apr  1 07:13:56 open kernel: 
Apr  1 07:13:56 open kernel: Code: 89 02 89 1b 89 5b 04 8d 73 e8 8b 46
54 a9 08 00 00 00 74 24 Apr  1 08:09:41 open kernel:  <3>swap_free: Bad
swap offset entry c7000000 Apr  1 08:32:05 open kernel: Unable to handle
kernel paging request at virtual address 005ac389 Apr  1 08:32:05 open
kernel:  printing eip: Apr  1 08:32:05 open kernel: 005ac389
Apr  1 08:32:05 open kernel: *pde = 00000000
Apr  1 08:32:05 open kernel: Oops: 0000
Apr  1 08:32:05 open kernel: CPU:    0
Apr  1 08:32:05 open kernel: EIP:   
0010:[zisofs_cleanup+5948153/-1072693392]    Not tainted Apr  1 08:32:05
open kernel: EIP:    0010:[<005ac389>]    Not tainted Apr  1 08:32:05
open kernel: EFLAGS: 00013246 Apr  1 08:32:05 open kernel: eax: 000000d0
  ebx: c0c36580   ecx: 00000000   edx: d3c7fd80 Apr  1 08:32:05 open
kernel: esi: 00000014   edi: 00000000   ebp: c1c36c54   esp: c3213e60
Apr  1 08:32:05 open kernel: ds: 0018   es: 0018   ss: 0018 Apr  1
08:32:05 open kernel: Process X (pid: 804, stackpage=c3213000) Apr  1
08:32:05 open kernel: Stack: c029f291 c0c36580 00000014 00000000
d3c7fd80 00000014 d3c7fd80 c02a0285 Apr  1 08:32:05 open kernel:       
d3c7fd80 00000000 c02d50c4 d3c7fd80 d3c7fd80 00000001 00000000 ffffffa1 
Apr  1 08:32:05 open kernel:        00000001 00000784 00000000 c1c36c00
c510c820 c3213ebc 00000020 00000000 Apr  1 08:32:05 open kernel: Call
Trace: [sock_wfree+33/64] [__kfree_skb+101/224]
[unix_stream_recvmsg+756/89 6] [sock_recvmsg+48/176] [sock_writev+58/64]
Apr  1 08:32:05 open kernel: Call Trace: [<c029f291>] [<c02a0285>]
[<c02d50c4>] [<c029d2a0>] [<c029d5fa>] Apr  1 08:32:05 open kernel:   
[tty_poll+120/144] [sock_poll+31/48] [sock_read+136/160]
[sys_select+1131/115 2] [sys_read+149/240] [system_call+51/56] 
Apr  1 08:32:05 open kernel:    [<c02302e8>] [<c029d63f>] [<c029d3a8>]
[<c01413eb>] [<c0133d25>] [<c010874b>] 
Apr  1 08:32:05 open kernel: 
Apr  1 08:32:05 open kernel: Code:  Bad EIP value.



ksymoops says:


ksymoops 2.4.1 on i686 2.4.19-pre5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre5/ (default)
     -m /boot/System.map-2.4.19-pre5 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

cpu: 0, clocks: 2666499, slice: 1333249
SGI XFS with ACLs, quota, no debug enabled
Unable to handle kernel paging request at virtual address 00fc5bd8
c0144538
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0144538>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010216
eax: c034b2fc   ebx: d7fc5b58   ecx: d551f240   edx: 00fc5bd8
esi: d7fc5ac0   edi: 0000109f   ebp: 0000000e   esp: dffd9ef0
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=dffd9000)
Stack: d6cc12c0 d6cc12c0 d6cc12c0 00000212 c0137b38 dfe72600 c034a510
c158f8a0        0000d9c5 c10bfbe8 00000000 c01448a0 00007e9b c012d4ac
00000006 000001d0        dffd8000 ffffffff 00002aa6 000001d0 c034a510
c1245d24 c012d6f2 c1245d08 Call Trace: [<c0137b38>] [<c01448a0>]
[<c012d4ac>] [<c012d6f2>] [<c012d77e>]    [<c012d7f0>] [<c012d93b>]
[<c012d9b6>] [<c012db01>] [<c012da60>] [<c0105000>]    [<c0106fb6>]
[<c012da60>] Code: 89 02 89 1b 89 5b 04 8d 73 e8 8b 46 54 a9 08 00 00 00
74 24 

>>EIP; c0144538 <prune_dcache+28/120>   <=====
Trace; c0137b38 <try_to_free_buffers+98/f0>
Trace; c01448a0 <shrink_dcache_memory+20/30>
Trace; c012d4ac <shrink_cache+2ec/3d0>
Trace; c012d6f2 <refill_inactive+162/1c0>
Trace; c012d77e <shrink_caches+2e/40>
Trace; c012d7f0 <try_to_free_pages+60/f0>
Trace; c012d93b <kswapd_balance_pgdat+5b/b0>
Trace; c012d9b6 <kswapd_balance+26/40>
Trace; c012db01 <kswapd+a1/c0>
Trace; c012da60 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0106fb6 <kernel_thread+26/30>
Trace; c012da60 <kswapd+0/c0>
Code;  c0144538 <prune_dcache+28/120>
00000000 <_EIP>:
Code;  c0144538 <prune_dcache+28/120>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c014453a <prune_dcache+2a/120>
   2:   89 1b                     mov    %ebx,(%ebx)
Code;  c014453c <prune_dcache+2c/120>
   4:   89 5b 04                  mov    %ebx,0x4(%ebx)
Code;  c014453f <prune_dcache+2f/120>
   7:   8d 73 e8                  lea    0xffffffe8(%ebx),%esi
Code;  c0144542 <prune_dcache+32/120>
   a:   8b 46 54                  mov    0x54(%esi),%eax
Code;  c0144545 <prune_dcache+35/120>
   d:   a9 08 00 00 00            test   $0x8,%eax
Code;  c014454a <prune_dcache+3a/120>
  12:   74 24                     je     38 <_EIP+0x38> c0144570
<prune_dcache+60/120>

Unable to handle kernel paging request at virtual address 005ac389
005ac389
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<005ac389>]    Not tainted
EFLAGS: 00013246
eax: 000000d0   ebx: c0c36580   ecx: 00000000   edx: d3c7fd80
esi: 00000014   edi: 00000000   ebp: c1c36c54   esp: c3213e60
ds: 0018   es: 0018   ss: 0018
Process X (pid: 804, stackpage=c3213000)
Stack: c029f291 c0c36580 00000014 00000000 d3c7fd80 00000014 d3c7fd80
c02a0285        d3c7fd80 00000000 c02d50c4 d3c7fd80 d3c7fd80 00000001
00000000 ffffffa1        00000001 00000784 00000000 c1c36c00 c510c820
c3213ebc 00000020 00000000 Call Trace: [<c029f291>] [<c02a0285>]
[<c02d50c4>] [<c029d2a0>] [<c029d5fa>]    [<c02302e8>] [<c029d63f>]
[<c029d3a8>] [<c01413eb>] [<c0133d25>] [<c010874b>] Code:  Bad EIP
value.

>>EIP; 005ac389 Before first symbol   <=====
Trace; c029f291 <sock_wfree+21/40>
Trace; c02a0285 <__kfree_skb+65/e0>
Trace; c02d50c4 <unix_stream_recvmsg+2f4/380>
Trace; c029d2a0 <sock_recvmsg+30/b0>
Trace; c029d5fa <sock_writev+3a/40>
Trace; c02302e8 <tty_poll+78/90>
Trace; c029d63f <sock_poll+1f/30>
Trace; c029d3a8 <sock_read+88/a0>
Trace; c01413eb <sys_select+46b/480>
Trace; c0133d25 <sys_read+95/f0>
Trace; c010874b <system_call+33/38>


lspci -vv:

00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
        Subsystem: VIA Technologies, Inc. VT8367 [KT266]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-        Status: Cap+ 66Mhz- UDF-
FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR- 
      Latency: 8        Region 0: Memory at e0000000 (32-bit,
prefetchable) [size=64M]        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)                Status: D0 PME-Enable-
DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if
00 [Normal decode])        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-        Status: Cap+
66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+
>SERR- <PERR-        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: e6000000-e8ffffff
        Prefetchable memory behind bridge: e4000000-e5ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)                Status: D0 PME-Enable-
DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Winbond Electronics Corp W89C940
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-        Status: Cap- 66Mhz- UDF-
FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- 
      Interrupt: pin A routed to IRQ 5        Region 0: I/O ports at
c000 [size=32]        Expansion ROM at <unassigned> [disabled]
[size=32K]

00:0d.0 RAID bus controller: Promise Technology, Inc. 20265 (rev 02)
        Subsystem: Promise Technology, Inc.: Unknown device 4d33
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-        Status: Cap+ 66Mhz- UDF-
FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- 
      Latency: 32        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 1400 [size=8]
        Region 1: I/O ports at c800 [size=4]
        Region 2: I/O ports at 1c00 [size=8]
        Region 3: I/O ports at d000 [size=4]
        Region 4: I/O ports at d400 [size=64]
        Region 5: Memory at ea000000 (32-bit, non-prefetchable)
[size=128K]        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)                Status: D0 PME-Enable-
DSel=0 DScale=0 PME-

00:0e.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
10)        Subsystem: Soyo Computer, Inc: Unknown device a701
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-        Status: Cap+ 66Mhz- UDF-
FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- 
      Latency: 32 (500ns min, 6000ns max)        Interrupt: pin A routed
to IRQ 11        Region 0: I/O ports at d800 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)                Status: D0 PME-Enable-
DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
        Subsystem: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-        Status: Cap+ 66Mhz- UDF-
FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- 
      Latency: 0        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)                Status: D0 PME-Enable-
DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])        Subsystem: VIA Technologies, Inc.
Bus Master IDE        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-        Status: Cap+ 66Mhz-
UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR-        Latency: 32
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at dc00 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)                Status: D0 PME-Enable-
DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. Ethernet Controller
(rev 70)        Subsystem: VIA Technologies, Inc.: Unknown device 0102
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-        Status: Cap+ 66Mhz- UDF-
FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- 
      Latency: 32 (750ns min, 2000ns max), cache line size 08       
Interrupt: pin A routed to IRQ 11        Region 0: I/O ports at ec00
[size=256]        Region 1: Memory at ea020000 (32-bit,
non-prefetchable) [size=256]        Capabilities: [40] Power Management
version 2                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)                Status: D0 PME-Enable+
DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
(rev 82) (prog-if 00 [VGA])        Subsystem: Matrox Graphics, Inc.:
Unknown device 0541        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-        Status: Cap+
66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort-
>SERR- <PERR-        Latency: 64 (4000ns min, 8000ns max), cache line
size 08        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e4000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at e6000000 (32-bit, non-prefetchable)
[size=16K]        Region 2: Memory at e7000000 (32-bit,
non-prefetchable) [size=8M]        Expansion ROM at <unassigned>
[disabled] [size=128K]        Capabilities: [dc] Power Management
version 2                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)                Status: D0 PME-Enable-
DSel=0 DScale=0 PME-        Capabilities: [f0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1


this is soyo dragon+ with athlon xp 1800 and 512mb ram; redhat linux
7.2, gcc-2.96-98.

my .config:

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MCE=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM is not set
CONFIG_1GB=y
# CONFIG_2GB is not set
# CONFIG_3GB is not set
# CONFIG_05GB is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUSMGR=y
CONFIG_ACPI_SYS=y
CONFIG_ACPI_CPU=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_AC=y
# CONFIG_ACPI_EC is not set
# CONFIG_ACPI_CMBATT is not set
# CONFIG_ACPI_THERMAL is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=y
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_LINEAR is not set
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=m
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_TUX is not set
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CMD680 is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_PDC202XX=y
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_BLK_DEV_ATARAID=m
CONFIG_BLK_DEV_ATARAID_PDC=m
# CONFIG_BLK_DEV_ATARAID_HPT is not set

#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
CONFIG_SCSI_BUSLOGIC=m
# CONFIG_SCSI_OMIT_FLASHPOINT is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_LAN=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_TC35815 is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
CONFIG_NE2K_PCI=m
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_NEW_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
CONFIG_VIA_RHINE=m
CONFIG_VIA_RHINE_MMIO=y
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1152
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=864
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_ACPI is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_PHILIPSPAR is not set
# CONFIG_I2C_ELV is not set
# CONFIG_I2C_VELLEMAN is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_INPUT_NS558 is not set
# CONFIG_INPUT_LIGHTNING is not set
# CONFIG_INPUT_PCIGAME is not set
# CONFIG_INPUT_CS461X is not set
# CONFIG_INPUT_EMU10K1 is not set
# CONFIG_INPUT_SERIO is not set
# CONFIG_INPUT_SERPORT is not set
# CONFIG_INPUT_ANALOG is not set
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
CONFIG_NVRAM=m
CONFIG_RTC=m
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
CONFIG_AGP_VIA=y
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_DRM=y
# CONFIG_DRM_OLD is not set
CONFIG_DRM_NEW=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
CONFIG_DRM_MGA=y
# CONFIG_DRM_SIS is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y
# CONFIG_I2C_PARPORT is not set
CONFIG_VIDEO_BT848=m
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_ZORAN_BUZ is not set
# CONFIG_VIDEO_ZORAN_DC10 is not set
# CONFIG_VIDEO_ZORAN_LML33 is not set
# CONFIG_VIDEO_ZR36120 is not set
# CONFIG_VIDEO_MEYE is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_MIROPCM20 is not set
# CONFIG_RADIO_MIROPCM20_RDS is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# File systems
#
# CONFIG_QUOTA is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=m
# CONFIG_UDF_RW is not set
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_RT is not set
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_DMAPI is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_ZISOFS_FS=y
CONFIG_ZLIB_FS_INFLATE=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=m
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
# CONFIG_FB_MATROX_MAVEN is not set
CONFIG_FB_MATROX_G450=m
# CONFIG_FB_MATROX_MULTIHEAD is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_CFB8=m
CONFIG_FBCON_CFB16=m
CONFIG_FBCON_CFB24=m
CONFIG_FBCON_CFB32=m
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Sound
#
CONFIG_SOUND=m
# CONFIG_SOUND_BT878 is not set
CONFIG_SOUND_CMPCI=m
CONFIG_SOUND_CMPCI_FM=y
CONFIG_SOUND_CMPCI_FMIO=388
CONFIG_SOUND_CMPCI_FMIO=388
CONFIG_SOUND_CMPCI_MIDI=y
CONFIG_SOUND_CMPCI_MPUIO=330
# CONFIG_SOUND_CMPCI_JOYSTICK is not set
CONFIG_SOUND_CMPCI_CM8738=y
# CONFIG_SOUND_CMPCI_SPDIFINVERSE is not set
# CONFIG_SOUND_CMPCI_SPDIFLOOP is not set
CONFIG_SOUND_CMPCI_SPEAKERS=2
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
CONFIG_SOUND_TVMIXER=m

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set
# CONFIG_USB_DEVICEFS is not set
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_LONG_TIMEOUT is not set
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_UHCI is not set
CONFIG_USB_UHCI_ALT=m
# CONFIG_USB_OHCI is not set
CONFIG_USB_AUDIO=m
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_BLUETOOTH is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m
CONFIG_USB_HID=m
CONFIG_USB_HIDDEV=y
# CONFIG_USB_KBD is not set
CONFIG_USB_MOUSE=m
# CONFIG_USB_WACOM is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
CONFIG_USB_SCANNER=m
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set



-- 


Jure Pecar
