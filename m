Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292516AbSB0QOk>; Wed, 27 Feb 2002 11:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292605AbSB0QOW>; Wed, 27 Feb 2002 11:14:22 -0500
Received: from lsanca1-ar27-4-63-184-089.lsanca1.vz.dsl.gtei.net ([4.63.184.89]:4480
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S292514AbSB0QOJ>; Wed, 27 Feb 2002 11:14:09 -0500
Date: Wed, 27 Feb 2002 08:13:49 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.5-dj2 oops
In-Reply-To: <20020226223406.A26905@suse.de>
Message-ID: <Pine.LNX.4.33.0202270746090.2059-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Towards the end of my boot script, I get a sequence of oopses.

However, after all this has happened, it looks like everything that should
be running is running.

They are described in the log as:
Feb 27 07:52:25 barbarella kernel: Process mingetty (pid: 1605,
threadinfo=cc3da000 task=cc15e780)
Feb 27 07:52:25 barbarella kernel: Process mingetty (pid: 1610,
threadinfo=cbfe0000 task=cc03ed40)
Feb 27 07:52:25 barbarella kernel: Process mingetty (pid: 1611,
threadinfo=cc00a000 task=cc03f2e0)
Feb 27 07:52:25 barbarella kernel: Process mingetty (pid: 1612,
threadinfo=cc10e000 task=cc03f880)
Feb 27 07:52:25 barbarella kernel: Process mingetty (pid: 1613,
threadinfo=cc11e000 task=cc120220)

However, the mingettys get restarted and work.

Interestingly, there is one at 1604, which was means, that the first one
is starting up without problem.

The remaining mingetty/login processes are numbered:
 1604 vc/1     S      0:00 /sbin/mingetty tty1
 1633 vc/2     S      0:00 login -- root
 1634 vc/3     S      0:00 login -- benc
 1635 vc/4     S      0:00 login -- root
 1636 vc/5     S      0:00 login -- benc
 1637 vc/6     S      0:00 /sbin/mingetty tty6

I also get a similar OOPs when I try to run X.


ksymoops 2.4.1 on i686 2.5.5-dj2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.5-dj2/ (default)
     -m /boot/System.map-2.5.5-dj2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol idle_cpu_R__ver_idle_cpu not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol icmpv6_socket  , ipv6 says d093a5e0, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d09382e0.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol icmpv6_statistics  , ipv6 says d093a4e0, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d09381e0.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inet6_dev_count  , ipv6 says d093a100, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d0937e00.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inet6_ifa_count  , ipv6 says d093a104, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d0937e04.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inet6_protos  , ipv6 says d093a460, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d0938160.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inetsw6  , ipv6 says d093a080, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d0937d80.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol ip6_ra_chain  , ipv6 says d093a360, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d0938060.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol ipv6_statistics  , ipv6 says d093a2a0, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d0937fa0.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol raw6_sk_cachep  , ipv6 says d093a0e0, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d0937de0.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol raw_v6_htable  , ipv6 says d093a3e0, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d09380e0.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol rt6_stats  , ipv6 says d093a268, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d0937f68.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol tcp6_sk_cachep  , ipv6 says d093a0d8, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d0937dd8.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol udp6_sk_cachep  , ipv6 says d093a0dc, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d0937ddc.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol udp_stats_in6  , ipv6 says d093a3a0, /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o says d09380a0.  Ignoring /lib/modules/2.5.5-dj2/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol scsi_CDs  , sr_mod says d08e6834, /lib/modules/2.5.5-dj2/kernel/drivers/scsi/sr_mod.o says d08e6560.  Ignoring /lib/modules/2.5.5-dj2/kernel/drivers/scsi/sr_mod.o entry
8139too Fast Ethernet driver 0.9.24
ac97_codec: AC97 Audio codec, id: 0x4144:0x5360 (Analog Devices AD1885)
Unable to handle kernel NULL pointer dereference at virtual address 0000000c
c01883c4
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01883c4>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c1241100   ebx: cf605a00   ecx: 00000000   edx: 00000000
esi: 00000019   edi: 00000050   ebp: cfae3364   esp: cc3dbea0
ds: 0018   es: 0018   ss: 0018
Stack: cc042000 00000001 cc3d0402 c0189059 00000001 00000000 00000000 c017f726
       cc042000 cfae3364 00000002 cc042000 cfb08c80 cc3dbee8 cc3da000 cc3dbf84
       00000001 cf1ba009 cfb08c80 00000005 cfafb7ac c13650e4 00000000 00000000
Call Trace: [<c0189059>] [<c017f726>] [<c0172dc8>] [<c017331d>] [<c0139256>]
   [<c013915d>] [<c0143a2e>] [<c0139525>] [<c0108c0f>]
Code: a3 0c 00 00 00 31 c0 5b 5e 5f c3 90 55 a1 0c d8 2e c0 57 31

>>EIP; c01883c4 <vc_allocate+e4/f0>   <=====
Trace; c0189059 <con_open+19/70>
Trace; c017f726 <tty_open+216/3c0>
Trace; c0172dc8 <devfs_notify_change+b8/d0>
Trace; c017331d <devfs_open+ad/170>
Trace; c0139256 <dentry_open+e6/190>
Trace; c013915d <filp_open+4d/60>
Trace; c0143a2e <getname+5e/a0>
Trace; c0139525 <sys_open+35/70>
Trace; c0108c0f <syscall_call+7/b>
Code;  c01883c4 <vc_allocate+e4/f0>
00000000 <_EIP>:
Code;  c01883c4 <vc_allocate+e4/f0>   <=====
   0:   a3 0c 00 00 00            mov    %eax,0xc   <=====
Code;  c01883c9 <vc_allocate+e9/f0>
   5:   31 c0                     xor    %eax,%eax
Code;  c01883cb <vc_allocate+eb/f0>
   7:   5b                        pop    %ebx
Code;  c01883cc <vc_allocate+ec/f0>
   8:   5e                        pop    %esi
Code;  c01883cd <vc_allocate+ed/f0>
   9:   5f                        pop    %edi
Code;  c01883ce <vc_allocate+ee/f0>
   a:   c3                        ret
Code;  c01883cf <vc_allocate+ef/f0>
   b:   90                        nop
Code;  c01883d0 <vc_resize+0/3e0>
   c:   55                        push   %ebp
Code;  c01883d1 <vc_resize+1/3e0>
   d:   a1 0c d8 2e c0            mov    0xc02ed80c,%eax
Code;  c01883d6 <vc_resize+6/3e0>
  12:   57                        push   %edi
Code;  c01883d7 <vc_resize+7/3e0>
  13:   31 00                     xor    %eax,(%eax)

 <1>Unable to handle kernel NULL pointer dereference at virtual address 0000000c
c01883c4
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01883c4>]    Not tainted
EFLAGS: 00010246
eax: c1241100   ebx: cc4d6000   ecx: 00000000   edx: 00000000
esi: 00000019   edi: 00000050   ebp: cfd7e344   esp: cbfe1ea0
ds: 0018   es: 0018   ss: 0018
Stack: ce17b000 00000002 cbfe0403 c0189059 00000002 00000000 00000000 c017f726
       ce17b000 cfd7e344 00000002 ce17b000 cfb08d88 cbfe1ee8 cbfe0000 cbfe1f84
       00000001 cfdf5009 cfb08d88 00000005 cfafba04 c136516c 00000000 00000000
Call Trace: [<c0189059>] [<c017f726>] [<c0172dc8>] [<c017331d>] [<c0139256>]
   [<c013915d>] [<c0143a2e>] [<c0139525>] [<c0108c0f>]
Code: a3 0c 00 00 00 31 c0 5b 5e 5f c3 90 55 a1 0c d8 2e c0 57 31

>>EIP; c01883c4 <vc_allocate+e4/f0>   <=====
Trace; c0189059 <con_open+19/70>
Trace; c017f726 <tty_open+216/3c0>
Trace; c0172dc8 <devfs_notify_change+b8/d0>
Trace; c017331d <devfs_open+ad/170>
Trace; c0139256 <dentry_open+e6/190>
Trace; c013915d <filp_open+4d/60>
Trace; c0143a2e <getname+5e/a0>
Trace; c0139525 <sys_open+35/70>
Trace; c0108c0f <syscall_call+7/b>
Code;  c01883c4 <vc_allocate+e4/f0>
00000000 <_EIP>:
Code;  c01883c4 <vc_allocate+e4/f0>   <=====
   0:   a3 0c 00 00 00            mov    %eax,0xc   <=====
Code;  c01883c9 <vc_allocate+e9/f0>
   5:   31 c0                     xor    %eax,%eax
Code;  c01883cb <vc_allocate+eb/f0>
   7:   5b                        pop    %ebx
Code;  c01883cc <vc_allocate+ec/f0>
   8:   5e                        pop    %esi
Code;  c01883cd <vc_allocate+ed/f0>
   9:   5f                        pop    %edi
Code;  c01883ce <vc_allocate+ee/f0>
   a:   c3                        ret
Code;  c01883cf <vc_allocate+ef/f0>
   b:   90                        nop
Code;  c01883d0 <vc_resize+0/3e0>
   c:   55                        push   %ebp
Code;  c01883d1 <vc_resize+1/3e0>
   d:   a1 0c d8 2e c0            mov    0xc02ed80c,%eax
Code;  c01883d6 <vc_resize+6/3e0>
  12:   57                        push   %edi
Code;  c01883d7 <vc_resize+7/3e0>
  13:   31 00                     xor    %eax,(%eax)

 <1>Unable to handle kernel NULL pointer dereference at virtual address 0000000c
c01883c4
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01883c4>]    Not tainted
EFLAGS: 00010246
eax: c1241100   ebx: cc4d6200   ecx: 00000000   edx: 00000000
esi: 00000019   edi: 00000050   ebp: cfd7e2d4   esp: cc00bea0
ds: 0018   es: 0018   ss: 0018
Stack: cc0c6000 00000003 cc000404 c0189059 00000003 00000000 00000000 c017f726
       cc0c6000 cfd7e2d4 00000002 cc0c6000 cfb08e90 cc00bee8 cc00a000 cc00bf84
       00000001 cc467009 cfb08e90 00000005 cfafbc5c c13651f4 00000000 00000000
Call Trace: [<c0189059>] [<c017f726>] [<c0172dc8>] [<c017331d>] [<c0139256>]
   [<c013915d>] [<c0143a2e>] [<c0139525>] [<c0108c0f>]
Code: a3 0c 00 00 00 31 c0 5b 5e 5f c3 90 55 a1 0c d8 2e c0 57 31

>>EIP; c01883c4 <vc_allocate+e4/f0>   <=====
Trace; c0189059 <con_open+19/70>
Trace; c017f726 <tty_open+216/3c0>
Trace; c0172dc8 <devfs_notify_change+b8/d0>
Trace; c017331d <devfs_open+ad/170>
Trace; c0139256 <dentry_open+e6/190>
Trace; c013915d <filp_open+4d/60>
Trace; c0143a2e <getname+5e/a0>
Trace; c0139525 <sys_open+35/70>
Trace; c0108c0f <syscall_call+7/b>
Code;  c01883c4 <vc_allocate+e4/f0>
00000000 <_EIP>:
Code;  c01883c4 <vc_allocate+e4/f0>   <=====
   0:   a3 0c 00 00 00            mov    %eax,0xc   <=====
Code;  c01883c9 <vc_allocate+e9/f0>
   5:   31 c0                     xor    %eax,%eax
Code;  c01883cb <vc_allocate+eb/f0>
   7:   5b                        pop    %ebx
Code;  c01883cc <vc_allocate+ec/f0>
   8:   5e                        pop    %esi
Code;  c01883cd <vc_allocate+ed/f0>
   9:   5f                        pop    %edi
Code;  c01883ce <vc_allocate+ee/f0>
   a:   c3                        ret
Code;  c01883cf <vc_allocate+ef/f0>
   b:   90                        nop
Code;  c01883d0 <vc_resize+0/3e0>
   c:   55                        push   %ebp
Code;  c01883d1 <vc_resize+1/3e0>
   d:   a1 0c d8 2e c0            mov    0xc02ed80c,%eax
Code;  c01883d6 <vc_resize+6/3e0>
  12:   57                        push   %edi
Code;  c01883d7 <vc_resize+7/3e0>
  13:   31 00                     xor    %eax,(%eax)

 <1>Unable to handle kernel NULL pointer dereference at virtual address 0000000c
c01883c4
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01883c4>]    Not tainted
EFLAGS: 00010246
eax: c1241100   ebx: cc4d6400   ecx: 00000000   edx: 00000000
esi: 00000019   edi: 00000050   ebp: cd856234   esp: cc10fea0
ds: 0018   es: 0018   ss: 0018
Stack: cc026000 00000004 cc100405 c0189059 00000004 00000000 00000000 c017f726
       cc026000 cd856234 00000002 cc026000 cfaf90c4 cc10fee8 cc10e000 cc10ff84
       00000001 cc118009 cfaf90c4 00000005 cfafbeb4 c136527c 00000000 00000000
Call Trace: [<c0189059>] [<c017f726>] [<c0172dc8>] [<c017331d>] [<c0139256>]
   [<c013915d>] [<c0143a2e>] [<c0139525>] [<c0108c0f>]
Code: a3 0c 00 00 00 31 c0 5b 5e 5f c3 90 55 a1 0c d8 2e c0 57 31

>>EIP; c01883c4 <vc_allocate+e4/f0>   <=====
Trace; c0189059 <con_open+19/70>
Trace; c017f726 <tty_open+216/3c0>
Trace; c0172dc8 <devfs_notify_change+b8/d0>
Trace; c017331d <devfs_open+ad/170>
Trace; c0139256 <dentry_open+e6/190>
Trace; c013915d <filp_open+4d/60>
Trace; c0143a2e <getname+5e/a0>
Trace; c0139525 <sys_open+35/70>
Trace; c0108c0f <syscall_call+7/b>
Code;  c01883c4 <vc_allocate+e4/f0>
00000000 <_EIP>:
Code;  c01883c4 <vc_allocate+e4/f0>   <=====
   0:   a3 0c 00 00 00            mov    %eax,0xc   <=====
Code;  c01883c9 <vc_allocate+e9/f0>
   5:   31 c0                     xor    %eax,%eax
Code;  c01883cb <vc_allocate+eb/f0>
   7:   5b                        pop    %ebx
Code;  c01883cc <vc_allocate+ec/f0>
   8:   5e                        pop    %esi
Code;  c01883cd <vc_allocate+ed/f0>
   9:   5f                        pop    %edi
Code;  c01883ce <vc_allocate+ee/f0>
   a:   c3                        ret
Code;  c01883cf <vc_allocate+ef/f0>
   b:   90                        nop
Code;  c01883d0 <vc_resize+0/3e0>
   c:   55                        push   %ebp
Code;  c01883d1 <vc_resize+1/3e0>
   d:   a1 0c d8 2e c0            mov    0xc02ed80c,%eax
Code;  c01883d6 <vc_resize+6/3e0>
  12:   57                        push   %edi
Code;  c01883d7 <vc_resize+7/3e0>
  13:   31 00                     xor    %eax,(%eax)

 <1>Unable to handle kernel NULL pointer dereference at virtual address 0000000c
c01883c4
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01883c4>]    Not tainted
EFLAGS: 00010246
eax: c1241100   ebx: cc4d6600   ecx: 00000000   edx: 00000000
esi: 00000019   edi: 00000050   ebp: cc782724   esp: cc11fea0
ds: 0018   es: 0018   ss: 0018
Stack: cc080000 00000005 cc110406 c0189059 00000005 00000000 00000000 c017f726
       cc080000 cc782724 00000002 cc080000 cfaf91cc cc11fee8 cc11e000 cc11ff84
       00000001 cc0dd009 cfaf91cc 00000005 cfaf8190 c1365304 00000000 00000000
Call Trace: [<c0189059>] [<c017f726>] [<c0172dc8>] [<c017331d>] [<c0139256>]
   [<c013915d>] [<c0143a2e>] [<c0139525>] [<c0108c0f>]
Code: a3 0c 00 00 00 31 c0 5b 5e 5f c3 90 55 a1 0c d8 2e c0 57 31

>>EIP; c01883c4 <vc_allocate+e4/f0>   <=====
Trace; c0189059 <con_open+19/70>
Trace; c017f726 <tty_open+216/3c0>
Trace; c0172dc8 <devfs_notify_change+b8/d0>
Trace; c017331d <devfs_open+ad/170>
Trace; c0139256 <dentry_open+e6/190>
Trace; c013915d <filp_open+4d/60>
Trace; c0143a2e <getname+5e/a0>
Trace; c0139525 <sys_open+35/70>
Trace; c0108c0f <syscall_call+7/b>
Code;  c01883c4 <vc_allocate+e4/f0>
00000000 <_EIP>:
Code;  c01883c4 <vc_allocate+e4/f0>   <=====
   0:   a3 0c 00 00 00            mov    %eax,0xc   <=====
Code;  c01883c9 <vc_allocate+e9/f0>
   5:   31 c0                     xor    %eax,%eax
Code;  c01883cb <vc_allocate+eb/f0>
   7:   5b                        pop    %ebx
Code;  c01883cc <vc_allocate+ec/f0>
   8:   5e                        pop    %esi
Code;  c01883cd <vc_allocate+ed/f0>
   9:   5f                        pop    %edi
Code;  c01883ce <vc_allocate+ee/f0>
   a:   c3                        ret
Code;  c01883cf <vc_allocate+ef/f0>
   b:   90                        nop
Code;  c01883d0 <vc_resize+0/3e0>
   c:   55                        push   %ebp
Code;  c01883d1 <vc_resize+1/3e0>
   d:   a1 0c d8 2e c0            mov    0xc02ed80c,%eax
Code;  c01883d6 <vc_resize+6/3e0>
  12:   57                        push   %edi
Code;  c01883d7 <vc_resize+7/3e0>
  13:   31 00                     xor    %eax,(%eax)


18 warnings issued.  Results may not be reliable.


- -- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950
http://www.hawaga.org.uk/resume/resume001.pdf
Live Ben-cam: http://barbarella.hawaga.org.uk/benc-cgi/watchers.cgi

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8fQXBsYXoezDwaVARAmmBAJ412xWWARAVXUfCx6VRpZqwbAufZwCeIS8l
7Xe/hWBhumrwebxMche9QIE=
=4iSu
-----END PGP SIGNATURE-----

