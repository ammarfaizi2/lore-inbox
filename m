Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281096AbRKLLKo>; Mon, 12 Nov 2001 06:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281415AbRKLLKe>; Mon, 12 Nov 2001 06:10:34 -0500
Received: from [203.94.130.164] ([203.94.130.164]:4627 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id <S281096AbRKLLKY>;
	Mon, 12 Nov 2001 06:10:24 -0500
Date: Mon, 12 Nov 2001 22:37:00 +1100 (EST)
From: <brett@bad-sports.com>
To: <linux-kernel@vger.kernel.org>
Subject: Oops in reiserfs w/2.4.7-10
Message-ID: <Pine.LNX.4.33.0111122233530.26293-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

Found this in dmesg today...
Default RH7.2 kernel

I have no idea how/what triggered it, so I doubt trying with a later
kernel to see if it happens again will help (it came after almost 10 days
of uptime).  Just posting this on the off chance it may be an undiscovered
bug.

ksymoops 2.4.1 on i686 2.4.7-10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.7-10/ (default)
     -m /boot/System.map-2.4.7-10 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base
says c01b30d0, System.map says c0154d30.  Ignoring ksyms_base entryWarning
(compare_maps): mismatch on symbol tone_control  , emu10k1 says d7aede94,
/lib/modules/2.4.7-10/kernel/drivers/sound/emu10k1/emu10k1.o says
d7aed0c0.  Ignoring
/lib/modules/2.4.7-10/kernel/drivers/sound/emu10k1/emu10k1.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_grace_period  , lockd
says d2980bd4, /lib/modules/2.4.7-10/kernel/fs/lockd/lockd.o says
d298003c.  Ignoring /lib/modules/2.4.7-10/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says
d2980bd0, /lib/modules/2.4.7-10/kernel/fs/lockd/lockd.o says d2980038.
Ignoring /lib/modules/2.4.7-10/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_timeout  , lockd says
d2980bd8, /lib/modules/2.4.7-10/kernel/fs/lockd/lockd.o says d2980040.
Ignoring /lib/modules/2.4.7-10/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says
d2972d40, /lib/modules/2.4.7-10/kernel/net/sunrpc/sunrpc.o says d2972a00.
Ignoring /lib/modules/2.4.7-10/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says
d2972d44, /lib/modules/2.4.7-10/kernel/net/sunrpc/sunrpc.o says d2972a04.
Ignoring /lib/modules/2.4.7-10/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says
d2972d48, /lib/modules/2.4.7-10/kernel/net/sunrpc/sunrpc.o says d2972a08.
Ignoring /lib/modules/2.4.7-10/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says
d2972d3c, /lib/modules/2.4.7-10/kernel/net/sunrpc/sunrpc.o says d29729fc.
Ignoring /lib/modules/2.4.7-10/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_garbage_args  , sunrpc says
d2972d1c, /lib/modules/2.4.7-10/kernel/net/sunrpc/sunrpc.o says d29729dc.
Ignoring /lib/modules/2.4.7-10/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_success  , sunrpc says
d2972d0c, /lib/modules/2.4.7-10/kernel/net/sunrpc/sunrpc.o says d29729cc.
Ignoring /lib/modules/2.4.7-10/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_system_err  , sunrpc says
d2972d20, /lib/modules/2.4.7-10/kernel/net/sunrpc/sunrpc.o says d29729e0.
Ignoring /lib/modules/2.4.7-10/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_one  , sunrpc says
d2972d04, /lib/modules/2.4.7-10/kernel/net/sunrpc/sunrpc.o says d29729c4.
Ignoring /lib/modules/2.4.7-10/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_two  , sunrpc says
d2972d08, /lib/modules/2.4.7-10/kernel/net/sunrpc/sunrpc.o says d29729c8.
Ignoring /lib/modules/2.4.7-10/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_zero  , sunrpc says
d2972d00, /lib/modules/2.4.7-10/kernel/net/sunrpc/sunrpc.o says d29729c0.
Ignoring /lib/modules/2.4.7-10/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore
says d285ba00, /lib/modules/2.4.7-10/kernel/drivers/usb/usbcore.o says
d285b520.  Ignoring /lib/modules/2.4.7-10/kernel/drivers/usb/usbcore.o
entry
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique
module object.  Trace may not be reliable.
Unable to handle kernel NULL pointer dereference at virtual address
00000000
c0113f15
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0113f15>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013246
eax: 00000000   ebx: cac3bf8c   ecx: cac3a000   edx: 00000000
esi: 049cafc6   edi: 00000005   ebp: cac3bfb4   esp: cac3bf88
ds: 0018   es: 0018   ss: 0018
Process kreiserfsd (pid: 301, stackpage=cac3b000)
Stack: cac3bf8c 00000000 00000000 049cafc6 cac3a000 c0113d40 c02aec20
00000018
       00000018 d2899108 00000286 cac3bfd8 c0114581 00000000 cac3a000
d2899108
       d2899108 00000700 ce8f3e20 cea40400 00004000 d288ee33 00000018
00000018
Call Trace: [<c0113d40>] [<d2899108>] [<c0114581>] [<d2899108>]
[<d2899108>]
   [<d288ee33>] [<c010570d>] [<c0105716>] [<d288ed80>]
Code: 00 00 00 c7 45 e8 00 80 25 c0 8b 55 dc c7 45 e0 18 fc ff ff

>>EIP; c0113f15 <schedule+c5/3d0>   <=====
Trace; c0113d40 <process_timeout+0/50>
Trace; d2899108 <[reiserfs]reiserfs_commit_thread_wait+4/c>
Trace; c0114581 <interruptible_sleep_on_timeout+41/60>
Trace; d2899108 <[reiserfs]reiserfs_commit_thread_wait+4/c>
Trace; d2899108 <[reiserfs]reiserfs_commit_thread_wait+4/c>
Trace; d288ee33 <[reiserfs]reiserfs_journal_commit_thread+b3/e0>
Trace; c010570d <kernel_thread+1d/30>
Trace; c0105716 <kernel_thread+26/30>
Trace; d288ed80 <[reiserfs]reiserfs_journal_commit_thread+0/e0>
Code;  c0113f15 <schedule+c5/3d0>
00000000 <_EIP>:
Code;  c0113f15 <schedule+c5/3d0>   <=====
   0:   00 00                     add    %al,(%eax)   <=====
Code;  c0113f17 <schedule+c7/3d0>
   2:   00 c7                     add    %al,%bh
Code;  c0113f19 <schedule+c9/3d0>
   4:   45                        inc    %ebp
Code;  c0113f1a <schedule+ca/3d0>
   5:   e8 00 80 25 c0            call   c025800a <_EIP+0xc025800a>
8036bf1f Before first symbol
Code;  c0113f1f <schedule+cf/3d0>
   a:   8b 55 dc                  mov    0xffffffdc(%ebp),%edx
Code;  c0113f22 <schedule+d2/3d0>
   d:   c7 45 e0 18 fc ff ff      movl   $0xfffffc18,0xffffffe0(%ebp)


18 warnings and 2 errors issued.  Results may not be reliable.

thanks,

	/ Brett

