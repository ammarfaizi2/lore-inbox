Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272808AbTGaHzx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 03:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272813AbTGaHzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 03:55:53 -0400
Received: from ns.imn.nl ([212.206.253.42]:64007 "EHLO ns.imn.nl")
	by vger.kernel.org with ESMTP id S272808AbTGaHzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 03:55:47 -0400
Message-ID: <001601c35738$ea8892f0$210a0a0a@kossen.nl>
From: "Willem Kossen" <w.kossen@imn.nl>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: kernel panic on filemap.c  kernelversion 2.4.2-2
Date: Thu, 31 Jul 2003 09:54:03 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4922.1500
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4925.2800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in the hope it will be useful, and yes, i do need to upgrade someday...

1. Kernel panic: Kernel bug on filemap.c line 85

2. Server hung reporting this kernel bug

3. Kernel, Bug, Filemap, Panic

4. Linux version 2.4.2-2 (root@porky.devel.redhat.com) (gcc version 2.96
20000731 (Red Hat Linux 7.1 2.96-79)) #1 Sun Apr 8 19:37:14 EDT 2001

5.   from here ------------------=================----------------
Jul 30 16:01:57 server kernel: kernel BUG at filemap.c:85!
Jul 30 16:01:57 server kernel: invalid operand: 0000
Jul 30 16:01:57 server kernel: CPU:    0
Jul 30 16:01:58 server kernel: EIP:    0010:[add_page_to_hash_queue+52/64]
Jul 30 16:01:58 server kernel: EIP:    0010:[<c0124c64>]
Jul 30 16:01:58 server kernel: EFLAGS: 00010282
Jul 30 16:01:58 server kernel: eax: 0000001c   ebx: 1804aff4   ecx: ffffffff
edx: 00000000
Jul 30 16:01:58 server kernel: esi: c1134a90   edi: 00602d00   ebp: 048a0047
esp: c4f3be6c
Jul 30 16:01:58 server kernel: ds: 0018   es: 0018   ss: 0018
Jul 30 16:01:58 server kernel: Process kswapd (pid: 4, stackpage=c4f3b000)
Jul 30 16:01:58 server kernel: Stack: c020f7db c020f99a 00000055 c01254c8
c1134a90 c4f46dec c1134a90 c1134a90
Jul 30 16:01:58 server kernel:        00000004 c012df30 c1134a90 c0257fa0
00602d00 00602d00 c012b62a c1134a90
Jul 30 16:01:58 server kernel:        00602d00 00602d00 0000000e c0119d82
c02aa5c0 c4f3bee4 c272d460 c4c0e7b8
Jul 30 16:01:58 server kernel: Call Trace: [error_table+19651/44216]
[error_table+20098/44216] [add_to_page_cache_locked+120/144]
[add_to_swap_cache+144/160] [try_to_swap_out+346/464] [do_softirq+82/128]
[swap_out_pmd+234/272]
Jul 30 16:01:58 server kernel: Call Trace: [<c020f7db>] [<c020f99a>]
[<c01254c8>] [<c012df30>] [<c012b62a>] [<c0119d82>] [<c012b78a>]
Jul 30 16:01:58 server kernel:        [swap_out_vma+147/240]
[do_IRQ+109/176] [do_IRQ+140/176] [swap_out_mm+60/96] [swap_out+138/176]
[refill_inactive+147/192] [do_try_to_free_pages+73/128] [kswapd+112/272]
Jul 30 16:01:58 server kernel:        [<c012b843>] [<c010a4dd>] [<c010a4fc>]
[<c012b8dc>] [<c012b98a>] [<c012cb13>] [<c012cb89>] [<c012cc30>]
Jul 30 16:01:58 server kernel:        [empty_bad_page+0/4096]
[empty_bad_page+0/4096] [kernel_thread+38/48] [kswapd+0/272]
Jul 30 16:01:58 server kernel:        [<c0105000>] [<c0105000>] [<c0107576>]
[<c012cbc0>]
Jul 30 16:01:58 server kernel:
Jul 30 16:01:58 server kernel: Code: 0f 0b 83 c4 0c ff 05 60 7d 25 c0 c3 53
8b 5c 24 08 8b 43 18
Jul 30 16:01:59 server kernel: kernel BUG at exit.c:465!
Jul 30 16:01:59 server kernel: invalid operand: 0000
Jul 30 16:01:59 server kernel: CPU:    0
Jul 30 16:01:59 server kernel: EIP:    0010:[do_exit+560/576]
Jul 30 16:01:59 server kernel: EIP:    0010:[<c0118cd0>]
Jul 30 16:01:59 server kernel: EFLAGS: 00010282
Jul 30 16:01:59 server kernel: eax: 0000001a   ebx: 00000000   ecx: fffffffe
edx: 00000000
Jul 30 16:01:59 server kernel: esi: c4f3a000   edi: 0000000b   ebp: 048a0047
esp: c4f3bd4c
to here ------------------------=====================--------------

6. unfortunately i have no idea to reproduce this.

7.1. output of ver_linux:
[root@server scripts]# sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux server.gazzary.nl 2.4.2-2 #1 Sun Apr 8 19:37:14 EDT 2001 i586 unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.11f
mount                  2.11b
module-init-tools      2.4.2
e2fsprogs              1.26
quota-tools            03/09/2001.
PPP                    2.4.0
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         ipt_MASQUERADE ipt_LOG ipt_limit ipt_REJECT ipt_state
ipt_unclean iptable_nat ip_conntrack_ftp ip_conntrack iptable_filter
ip_tables 3c509 aic7xxx sd_mod scsi_mod

7.2.
[root@server linux-2.6.0-test2]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 2
model name      : Pentium 75 - 200
stepping        : 12
cpu MHz         : 133.271
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8
bogomips        : 265.42

7.3.
[root@server linux-2.6.0-test2]# cat /proc/modules
ipt_MASQUERADE          1680   1 (autoclean)
ipt_LOG                 3856  12 (autoclean)
ipt_limit               1408  13 (autoclean)
ipt_REJECT              2496  16 (autoclean)
ipt_state               1136   4 (autoclean)
ipt_unclean             7312   2 (autoclean)
iptable_nat            15968   0 (autoclean) [ipt_MASQUERADE]
ip_conntrack_ftp        2448   0 (unused)
ip_conntrack           15824   3 [ipt_MASQUERADE ipt_state iptable_nat
ip_conntrack_ftp]
iptable_filter          2240   0 (unused)
ip_tables              11488  10 [ipt_MASQUERADE ipt_LOG ipt_limit
ipt_REJECT ipt_state ipt_unclean iptable_nat iptable_filter]
3c509                   7664   2
aic7xxx               133360   0 (unused)
sd_mod                 11808   0 (unused)
scsi_mod               94304   2 [aic7xxx sd_mod]

7.4.
[root@server linux-2.6.0-test2]# cat /proc/ioports
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
0280-028f : 3c509
02e8-02ef : serial(auto)
02f8-02ff : serial(auto)
0300-030f : 3c509
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
6000-60ff : ATI Technologies Inc 3D Rage II+ 215GTB [Mach64 GTB]
6100-61ff : Adaptec AHA-7850
  6100-61fe : aic7xxx
f000-f00f : Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
  f000-f007 : ide0
  f008-f00f : ide1

[root@server linux-2.6.0-test2]# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000ce7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-04ffffff : System RAM
  00100000-00254ea7 : Kernel code
  00254ea8-0026becb : Kernel data
e0000000-e0ffffff : ATI Technologies Inc 3D Rage II+ 215GTB [Mach64 GTB]
e1000000-e1000fff : ATI Technologies Inc 3D Rage II+ 215GTB [Mach64 GTB]
e1001000-e1001fff : Adaptec AHA-7850
ffff0000-ffffffff : reserved

7.5.
[root@server linux-2.6.0-test2]# lspci -vvv
00:00.0 Host bridge: Intel Corp. 430VX - 82437VX TVX [Triton VX] (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32

00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev
01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at f000 [size=16]

00:08.0 VGA compatible controller: ATI Technologies Inc 3D Rage II+ 215GTB
[Mach64 GTB] (rev 9a) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc 3D Rage II+ 215GTB [Mach64 GTB]
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at 6000 [size=256]
        Region 2: Memory at e1000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]

00:09.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
        Subsystem: Adaptec AHA-2904/Integrated AIC-7850
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 6100 [size=256]
        Region 1: Memory at e1001000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

7.6.
[root@server linux-2.6.0-test2]# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: PHILIPS  Model: CDD3600 CD-R/RW  Rev: 2.00
  Type:   CD-ROM                           ANSI SCSI revision: 02

7.7.
[root@server scripts]# cat /proc/filesystems
nodev   sockfs
nodev   tmpfs
nodev   shm
nodev   pipefs
nodev   proc
        ext2
        iso9660
nodev   devpts

X.



