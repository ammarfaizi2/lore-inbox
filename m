Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135986AbRD0HHv>; Fri, 27 Apr 2001 03:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135987AbRD0HHl>; Fri, 27 Apr 2001 03:07:41 -0400
Received: from 3jane.ashpool.org ([195.24.172.2]:31752 "EHLO 3jane.ashpool.org")
	by vger.kernel.org with ESMTP id <S135986AbRD0HH2>;
	Fri, 27 Apr 2001 03:07:28 -0400
Date: Fri, 27 Apr 2001 09:11:15 +0200 (CEST)
From: poptix <poptix@poptix.net>
X-X-Sender: <poptix@3jane.ashpool.org>
To: <linux-kernel@vger.kernel.org>
Subject: oops in 2.4.3-ac14
Message-ID: <Pine.LNX.4.33.0104270908060.444-100000@3jane.ashpool.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm on this list, so i'll see replies directed here.)

FYI:

ksymoops 2.4.0 on i686 2.4.3-ac14.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.3-ac14/ (default)
     -m /boot/System.map-2.4.3-ac14 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

 invalid operand: 0000
CPU:    0
EIP:    0010:[prune_icache+106/240]
EIP:    0010:[<c01419fa>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000001   ebx: c70acbe8   ecx: c70acbf8   edx: c70acbe0
esi: c70acbe0   edi: c7570608   ebp: c12e9f98   esp: c12e9f7c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 3, stackpage=c12e9000)
Stack: 00000000 00000007 c7a8b468 c7f43468 00010f00 00000004 00000048
00000004
       c0141aa1 000013b7 c0128dd6 00000004 00000004 c1225e6c 00000004
00010f00
       ffffffff 00000004 0008e000 c0128e6b 00000004 00000000 c0105000
0008e000
Call Trace: [shrink_icache_memory+33/64] [do_try_to_free_pages+102/128]
[kswapd$Call Trace: [<c0141aa1>] [<c0128dd6>] [<c0128e6b>] [<c0105000>]
[<c0105000>]
   [<c0105586>] [<c0128df0>]
Code: 0f 0b 8b 53 04 8b 03 89 50 04 89 02 8b 53 fc 8b 43 f8 89 50

>>EIP; c01419fa <prune_icache+6a/f0>   <=====
Trace; c0141aa1 <shrink_icache_memory+21/40>
Trace; c0128dd6 <do_try_to_free_pages+66/80>
Trace; c0128e6b <kswapd+7b/100>
Trace; c0105000 <do_linuxrc+0/e0>
Trace; c0105000 <do_linuxrc+0/e0>
Trace; c0105586 <kernel_thread+26/30>
Trace; c0128df0 <kswapd+0/100>
Code;  c01419fa <prune_icache+6a/f0>
00000000 <_EIP>:
Code;  c01419fa <prune_icache+6a/f0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01419fc <prune_icache+6c/f0>
   2:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c01419ff <prune_icache+6f/f0>
   5:   8b 03                     mov    (%ebx),%eax
Code;  c0141a01 <prune_icache+71/f0>
   7:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c0141a04 <prune_icache+74/f0>
   a:   89 02                     mov    %eax,(%edx)
Code;  c0141a06 <prune_icache+76/f0>
   c:   8b 53 fc                  mov    0xfffffffc(%ebx),%edx
Code;  c0141a09 <prune_icache+79/f0>
   f:   8b 43 f8                  mov    0xfffffff8(%ebx),%eax
Code;  c0141a0c <prune_icache+7c/f0>
  12:   89 50 00                  mov    %edx,0x0(%eax)




