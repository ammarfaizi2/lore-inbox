Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSGJM1d>; Wed, 10 Jul 2002 08:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315708AbSGJM1d>; Wed, 10 Jul 2002 08:27:33 -0400
Received: from [203.94.130.164] ([203.94.130.164]:19980 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id <S315634AbSGJM1c>;
	Wed, 10 Jul 2002 08:27:32 -0400
Date: Wed, 10 Jul 2002 23:01:44 +1000 (EST)
From: Brett <generica@email.com>
X-X-Sender: brett@bad-sports.com
To: linux-kernel@vger.kernel.org
Subject: oops in 2.4.19-rc1
Message-ID: <Pine.LNX.4.44.0207102259150.7269-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

Oops attached
Yes, the kernel is tainted, thanks to NVdriver
I booted with it, changed X to use nv driver and restarted X, so kernel 
stayed tainted, but module is no longer loaded.

need anything else, please ask

thanks,

	/ Brett

ksymoops 2.4.4 on i686 2.4.19-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-rc1/ (default)
     -m /boot/System.map-2.4.19-rc1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique 
module object.  Trace may not be reliable.
Unable to handle kernel paging request at virtual address d6bff6be
c0147154
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0147154>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: cff80000   ebx: d6bff6ae   ecx: 0000000f   edx: eff21631
esi: c2edd000   edi: c4c51f9c   ebp: d6bff6be   esp: c4c51ef8
ds: 0018   es: 0018   ss: 0018
Process updatedb (pid: 6780, stackpage=c4c51000)
Stack: cffbf3c0 c2edd000 eff21631 00000007 c4c51f64 c2edd000 c4c51f9c
cef2b5c0
       c013ebbe c3415540 c4c51f64 c4c51f64 c013f3ba c3415540 c4c51f64
00000000
       00000008 c2edd007 00000000 00000000 00000000 00000000 00001000
fffffff4
Call Trace: [<c013ebbe>] [<c013f3ba>] [<c013e99d>] [<c013f9f3>]
[<c013c8a4>]
   [<c01088bb>]
Code: 8b 6d 00 39 53 44 0f 85 80 00 00 00 8b 44 24 24 39 43 0c 75

>>EIP; c0147154 <d_lookup+64/110>   <=====
Trace; c013ebbe <cached_lookup+e/50>
Trace; c013f3ba <link_path_walk+5fa/890>
Trace; c013e99d <getname+5d/a0>
Trace; c013f9f3 <__user_walk+33/50>
Trace; c013c8a4 <sys_lstat64+14/70>
Trace; c01088bb <system_call+33/38>
Code;  c0147154 <d_lookup+64/110>
00000000 <_EIP>:
Code;  c0147154 <d_lookup+64/110>   <=====
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp   <=====
Code;  c0147157 <d_lookup+67/110>
   3:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  c014715a <d_lookup+6a/110>
   6:   0f 85 80 00 00 00         jne    8c <_EIP+0x8c> c01471e0 
<d_lookup+f0/110>
Code;  c0147160 <d_lookup+70/110>
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  c0147164 <d_lookup+74/110>
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  c0147167 <d_lookup+77/110>
  13:   75 00                     jne    15 <_EIP+0x15> c0147169 
<d_lookup+79/110>


2 warnings and 2 errors issued.  Results may not be reliable.

