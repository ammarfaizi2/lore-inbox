Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290640AbSAYL0L>; Fri, 25 Jan 2002 06:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290641AbSAYL0C>; Fri, 25 Jan 2002 06:26:02 -0500
Received: from pint.pi.informatik.tu-darmstadt.de ([130.83.7.27]:25095 "EHLO
	walker.lahn.de") by vger.kernel.org with ESMTP id <S290640AbSAYLZs>;
	Fri, 25 Jan 2002 06:25:48 -0500
Date: Fri, 25 Jan 2002 12:23:05 +0100
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Oops
Message-ID: <20020125112305.GA31822@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Organization: UUCP-Freunde Lahn e.V.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello LKML!

A friend of mine captured this oops while running 2.4.18-pre7 patched
with kdb-2.1 and freeswan 1.94. It's a small P2-200 mit IDE and SCSI.

----- Forwarded message from Martin Girschick <mg_list@gmx.de> -----
kdb> ps
Task Addr  Pid      Parent   [*] cpu  State Thread     Command
0xc11d8000 00000001 00000000  1  000  stop  0xc11d8270 init
0xc11ce000 00000002 00000001  1  000  stop  0xc11ce270 keventd
0xc11ca000 00000003 00000001  1  000  stop  0xc11ca270 kapmd
0xc11c8000 00000004 00000000  1  000  stop  0xc11c8270 ksoftirqd_CPU0
0xc11c6000 00000005 00000000  1  000  stop  0xc11c6270 kswapd
0xc11c4000 00000006 00000000  1  000  stop  0xc11c4270 bdflush
0xc11c2000 00000007 00000000  1  000  stop  0xc11c2270 kupdated
0xc57f4000 00000008 00000001  1  000  stop  0xc57f4270 khubd
0xc53e2000 00000025 00000001  1  000  stop  0xc53e2270 devfsd
0xc51c0000 00000086 00000001  1  000  stop  0xc51c0270 scsi_eh_0
0xc49e0000 00000123 00000001  1  000  stop  0xc49e0270 portmap
0xc4690000 00000187 00000001  1  000  stop  0xc4690270 syslog-ng
0xc4664000 00000190 00000001  1  000  run   0xc4664270 klogd
0xc43e8000 00000207 00000001  1  000  stop  0xc43e8270 ptal-mlcd
0xc4376000 00000213 00000001  1  000  stop  0xc4376270 ptal-printd
0xc44b4000 00000217 00000001  1  000  stop  0xc44b4270 rpc.statd
0xc433c000 00000220 00000001  1  000  stop  0xc433c270 apmd
0xc4044000 00000277 00000001  1  000  stop  0xc4044270 faxq
0xc40ee000 00000281 00000001  1  000  stop  0xc40ee270 hfaxd
0xc3fe4000 00000286 00000001  1  000  stop  0xc3fe4270 inetd
0xc3ea6000 00000302 00000001  1  000  stop  0xc3ea6270 lpd
0xc3cb0000 00000398 00000001  1  000  stop  0xc3cb0270 master
0xc3bc0000 00000399 00000398  1  000  stop  0xc3bc0270 pickup
0xc3be4000 00000400 00000398  1  000  stop  0xc3be4270 qmgr
0xc3c10000 00000401 00000398  1  000  stop  0xc3c10270 tlsmgr
0xc3462000 00000410 00000001  1  000  stop  0xc3462270 sshd
0xc33f0000 00000417 00000001  1  000  stop  0xc33f0270 ntpd
0xc32f2000 00000425 00000001  1  000  stop  0xc32f2270 atalkd
0xc32d2000 00000429 00000001  1  000  stop  0xc32d2270 afpd
0xc328e000 00000431 00000001  1  000  stop  0xc328e270 papd
0xc31e4000 00000435 00000001  1  000  stop  0xc31e4270 proftpd
0xc31ba000 00000438 00000001  1  000  stop  0xc31ba270 atd
0xc3190000 00000441 00000001  1  000  stop  0xc3190270 cron
0xc2f80000 00000447 00000001  1  000  stop  0xc2f80270 apache
0xc56cc000 00000451 00000001  1  000  stop  0xc56cc270 getty
0xc4898000 00000452 00000001  1  000  stop  0xc4898270 getty
0xc4480000 00000453 00000001  1  000  stop  0xc4480270 getty
0xc3154000 00000454 00000001  1  000  stop  0xc3154270 getty
0xc3184000 00000455 00000001  1  000  stop  0xc3184270 getty
0xc3178000 00000456 00000001  1  000  stop  0xc3178270 getty
0xc2eb8000 00000458 00000447  1  000  stop  0xc2eb8270 apache
0xc2eae000 00000459 00000447  1  000  stop  0xc2eae270 apache
0xc2ea2000 00000460 00000447  1  000  stop  0xc2ea2270 apache
0xc2e96000 00000461 00000447  1  000  stop  0xc2e96270 apache
0xc2e4a000 00000462 00000447  1  000  stop  0xc2e4a270 apache
0xc258a000 00000570 00000286  1  000  stop  0xc258a270 nmbd
0xc25e8000 00000571 00000570  1  000  stop  0xc25e8270 nmbd
0xc2ad6000 00000580 00000277  1  000  run   0xc2ad6270*wedged
0xc32c4000 00000581 00000001  1  000  stop  0xc32c4270 faxgetty
kdb> bt
    EBP       EIP         Function(args)
0xc2ad7e30 0xc0127e1b kmem_cache_alloc+0x8f (0xc11671a0, 0x1f0, 0x0, 0xc1179340, 0x1002)
                               kernel .text 0xc0100000 0xc0127d8c 0xc0127e68
0xc2ad7e4c 0xc0141275 get_new_inode+0x19 (0xc1164400, 0x1002, 0xc1179340, 0x0, 0x0)
                               kernel .text 0xc0100000 0xc014125c 0xc01413c0
0xc2ad7e74 0xc0141543 iget4+0xb7 (0xc1164400, 0x1002, 0x0, 0x0, 0xc274dac0)
                               kernel .text 0xc0100000 0xc014148c 0xc0141550
0xc2ad7e94 0xc01489f1 proc_get_inode+0x41 (0xc1164400, 0x1002, 0xc11681a0, 0xc116a400, 0xc274dac0)
                               kernel .text 0xc0100000 0xc01489b0 0xc0148ac4
0xc2ad7eb8 0xc014a37d proc_lookup+0x7d (0xc116a400, 0xc274dac0, 0xfffffff4, 0xc116a400)
                               kernel .text 0xc0100000 0xc014a300 0xc014a3a4
0xc2ad7ed0 0xc0148b8d proc_root_lookup+0x2d (0xc116a400, 0xc274dac0, 0xc2ad7f28, 0x0, 0xc2ad7f7c)
                               kernel .text 0xc0100000 0xc0148b60 0xc0148bac
0xc2ad7eec 0xc01378f8 real_lookup+0x58 (0xc11691a0, 0xc2ad7f28, 0x0, 0xc45dd000, 0x0)
                               kernel .text 0xc0100000 0xc01378a0 0xc013796c
0xc2ad7f34 0xc0137f7c link_path_walk+0x500 (0xc2ad7f60)
                               kernel .text 0xc0100000 0xc0137a7c 0xc01381b0
0xc2ad7f3c 0xc01381cd path_walk+0x1d (0x0, 0x401751c6, 0x1, 0xc2ad7f98, 0x0)
                               kernel .text 0xc0100000 0xc01381b0 0xc01381d4
           0xc0138713 open_namei+0x73 (0xc45dd000, 0x1, 0x1b6, 0xc2ad7f7c, 0x3)
                               kernel .text 0xc0100000 0xc01386a0 0xc0138c5c
0xc2ad7f98 0xc012e922 filp_open+0x32 (0xc45dd000, 0x0, 0x1b6, 0xc2ad6000, 0x401751c6)
                               kernel .text 0xc0100000 0xc012e8f0 0xc012e940
0xc2ad7fbc 0xc012ec76 sys_open+0x3e (0xbfffdb84, 0x0, 0x1b6, 0x401751c6, 0x1)
                               kernel .text 0xc0100000 0xc012ec38 0xc012ecfc
           0xc0106c23 system_call+0x33
                               kernel .text 0xc0100000 0xc0106bf0 0xc0106c30
kdb> lsmod
Module                  Size  modstruct     Used by
appletalk              23708  0xc6074000    12  (autoclean)
ide-scsi                9376  0xc6070000     0
parport_pc             25040  0xc6068000     1  (autoclean)
lp                      8064  0xc6065000     0  (autoclean)
parport                31720  0xc605c000     1  (autoclean) [ parport_pc lp ]
dmfe                   15812  0xc6057000     1  (autoclean)
nls_cp437               5184  0xc6054000     2  (autoclean)
vfat                   11308  0xc6050000     1  (autoclean)
fat                    36320  0xc6046000     0  (autoclean) [ vfat ]
floppy                 51968  0xc6038000     0  (autoclean)
aha152x                33312  0xc602e000     1  (autoclean)
isa-pnp                36000  0xc6024000     0  (autoclean) [ aha152x ]
kdb> sr u
<6>SysRq : Emergency Remount R/O
kdb> sr m
SysRq : Show Memory
Mem-info:
Free pages:       38308kB (     0kB HighMem)
Zone:DMA freepages: 13800kB min:   128kB low:   256kB high:   384kB
Zone:Normal freepages: 24508kB min:   576kB low:  1152kB high:  1728kB
Zone:HighMem freepages:     0kB min:     0kB low:     0kB high:     0kB
( Active: 4957, inactive: 5353, free: 9577 )
0*4kB 1*8kB 4*16kB 5*32kB 4*64kB 2*128kB 1*256kB 1*512kB 0*1024kB 
6*2048kB = 13800kB)
147*4kB 52*8kB 63*16kB 57*32kB 17*64kB 1*128kB 2*256kB 1*512kB 
0*1024kB 9*2048kB = 24508kB)
= 0kB)
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap:       248996kB
22528 pages of RAM
0 pages of HIGHMEM
993 reserved pages
18082 pages shared
0 pages swap cached
0 pages in page table cache
Buffer memory:     2628kB
kdb> sr s
SysRq : Emergency Sync
kdb> go
Syncing device 03:05 ... OK
Syncing device 08:01 ... OK
Done.
Unable to handle kernel paging request at virtual address c67ee414
 printing eip:
c0127e1b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0127e1b>]    Not tainted
EFLAGS: 00010807
eax: 00ff00ff   ebx: de21de20   ecx: c282e000   edx: c1170000
esi: c11671a0   edi: 00000246   ebp: c56cdd48   esp: c56cdd3c
ds: 0018   es: 0018   ss: 0018
Process getty (pid: 451, stackpage=c56cd000)
Stack: 00000000 c117ac60 c117ac60 c56cdd64 c0141275 c11671a0 000001f0 
00000000
       c117ac60 00007ca9 c56cdd8c c0141543 c57cf000 00007ca9 c117ac60 
       00000000
       00000000 c284f0e0 c569f0c0 c284f0e0 c56cddac c0164393 c57cf000 
       00007ca9
Call Trace: [<c0141275>] [<c0141543>] [<c0164393>] [<c01378f8>] [<c0137f7c>]
   [<c01381cd>] [<c0135d5b>] [<c0136625>] [<c0129bdf>] [<c012995d>] 
[<c0120e9d>]
   [<c0120eee>] [<c012102c>] [<c0110d59>] [<c0110bd4>] [<c0172d2e>] 
[<c0137660>]
   [<c01058eb>] [<c0106c23>]
Code: 8b 44 81 18 89 41 14 03 59 0c 83 f8 ff 75 16 8b 41 04 8b 11

>>EIP; c0127e1a <kmem_cache_alloc+8e/dc>   <=====
Trace; c0141274 <get_new_inode+18/164>
Trace; c0141542 <iget4+b6/c4>
Trace; c0164392 <ext2_lookup+42/6c>
Trace; c01378f8 <real_lookup+58/cc>
Trace; c0137f7c <link_path_walk+500/734>
Trace; c01381cc <path_walk+1c/24>
Trace; c0135d5a <open_exec+2e/d0>
Trace; c0136624 <do_execve+14/198>
Trace; c0129bde <__alloc_pages+32/154>
Trace; c012995c <_alloc_pages+18/20>
Trace; c0120e9c <do_anonymous_page+80/a0>
Trace; c0120eee <do_no_page+32/120>
Trace; c012102c <handle_mm_fault+50/b4>
Trace; c0110d58 <do_page_fault+184/4cc>
Trace; c0110bd4 <do_page_fault+0/4cc>
Trace; c0172d2e <tty_write+18e/1f8>
Trace; c0137660 <getname+60/a0>
Trace; c01058ea <sys_execve+2e/5c>
Trace; c0106c22 <system_call+32/40>
Code;  c0127e1a <kmem_cache_alloc+8e/dc>
00000000 <_EIP>:
Code;  c0127e1a <kmem_cache_alloc+8e/dc>   <=====
  0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c0127e1e <kmem_cache_alloc+92/dc>
  4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c0127e20 <kmem_cache_alloc+94/dc>
  7:   03 59 0c                  add    0xc(%ecx),%ebx
Code;  c0127e24 <kmem_cache_alloc+98/dc>
  a:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c0127e26 <kmem_cache_alloc+9a/dc>
  d:   75 16                     jne    25 <_EIP+0x25> c0127e3e 
  <kmem_cache_alloc+b2/dc>
Code;  c0127e28 <kmem_cache_alloc+9c/dc>
  f:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c0127e2c <kmem_cache_alloc+a0/dc>
 12:   8b 11                     mov    (%ecx),%edx
Entering kdb (current=0xc56cc000, pid 451) Oops: Oops
due to oops @ 0xc0127e1b
eax = 0x00ff00ff ebx = 0xde21de20 ecx = 0xc282e000 edx = 0xc1170000
esi = 0xc11671a0 edi = 0x00000246 esp = 0xc56cdd3c eip = 0xc0127e1b
ebp = 0xc56cdd48 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010807
xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xc56cdd08
kdb> sr b
<6>SysRq : Resetting
----- End forwarded message -----

The oops above is one of many he sent me. They all oops in
kmem_cache_allog(). If somebody is interested, I can mail them
privately.

.config is available at http://130.83.7.27/pmhahn/misc/config-2.4.18-pre7

Any advise would be helpful.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
