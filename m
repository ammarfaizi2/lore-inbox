Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272632AbRIKXC7>; Tue, 11 Sep 2001 19:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272636AbRIKXCv>; Tue, 11 Sep 2001 19:02:51 -0400
Received: from front4m.grolier.fr ([195.36.216.54]:8609 "EHLO
	front4m.grolier.fr") by vger.kernel.org with ESMTP
	id <S272632AbRIKXCe>; Tue, 11 Sep 2001 19:02:34 -0400
Message-ID: <3B9E9839.82E28E17@club-internet.fr>
Date: Wed, 12 Sep 2001 01:03:21 +0200
From: Daniel Caujolle-Bert <segfault@club-internet.fr>
Reply-To: segfault@club-internet.fr
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: oops (ksymoopsed) decoding, please.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List, 

	Is there a good soul would help me here to know what happen:

kernel BUG at slab.c:1062!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012580b>]
EFLAGS: 00010086
eax: 0000001b   ebx: c1ccf69c   ecx: ef53a000   edx: c025c0e8
esi: 00000002   edi: c1ccf69c   ebp: 0000000f   esp: e9473cf4
ds: 0018   es: 0018   ss: 0018
Process setserial (pid: 5001, stackpage=e9473000)
Stack: c021012c c02101c8 00000426 c1ccf69c 00000002 0000000f f09b37c8
f09b3780 
       c0125aa9 c1ccf69c 0000000f 00001000 00000000 00000001 f098446d
00001000 
       0000000f 00000000 e9473d9c f09b3780 f09b3780 00000001 00000cfc
37363534 
Call Trace: [<c0125aa9>] [<c01288ac>] [<c016a882>] [<c016a8ac>]
[<c0136d5b>] [<c
0136437>] [<c012d552>] 
       [<c012c6d5>] [<c012c60e>] [<c012c908>] [<c0106aff>] 

Code: 0f 0b 83 c4 0c f7 c5 00 10 00 00 0f 85 c4 01 00 00 a1 48 58 
ksymoops 2.4.1 on i686 2.4.8.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.8/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol V32U96eyeLocation  , pctel
says f0995
5d0, /lib/modules/2.4.8/misc/pctel.o says f09b1964.  Ignoring
/lib/modules/2.4.8
/misc/pctel.o entry
kernel BUG at slab.c:1062!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012580b>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 0000001b   ebx: c1ccf69c   ecx: ef53a000   edx: c025c0e8
esi: 00000002   edi: c1ccf69c   ebp: 0000000f   esp: e9473cf4
ds: 0018   es: 0018   ss: 0018
Process setserial (pid: 5001, stackpage=e9473000)
Stack: c021012c c02101c8 00000426 c1ccf69c 00000002 0000000f f09b37c8
f09b3780 
       c0125aa9 c1ccf69c 0000000f 00001000 00000000 00000001 f098446d
00001000 
       0000000f 00000000 e9473d9c f09b3780 f09b3780 00000001 00000cfc
37363534 
Call Trace: [<c0125aa9>] [<c01288ac>] [<c016a882>] [<c016a8ac>]
[<c0136d5b>] [<c
0136437>] [<c012d552>] 
       [<c012c6d5>] [<c012c60e>] [<c012c908>] [<c0106aff>] 
Code: 0f 0b 83 c4 0c f7 c5 00 10 00 00 0f 85 c4 01 00 00 a1 48 58 

>>EIP; c012580b <kmem_cache_grow+2b/208>   <=====
Trace; c0125aa9 <kmalloc+6d/88>
Trace; c01288ac <get_zeroed_page+8/24>
Trace; c016a882 <tty_open+1d6/358>
Trace; c016a8ac <tty_open+200/358>
Trace; c0136d5b <path_walk+683/748>
Trace; c0136437 <permission+2b/30>
Trace; c012d552 <chrdev_open+3e/4c>
Trace; c012c6d5 <dentry_open+bd/148>
Trace; c012c60e <filp_open+52/5c>
Trace; c012c908 <sys_open+38/b8>
Trace; c0106aff <system_call+33/38>
Code;  c012580b <kmem_cache_grow+2b/208>
0000000000000000 <_EIP>:
Code;  c012580b <kmem_cache_grow+2b/208>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012580d <kmem_cache_grow+2d/208>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0125810 <kmem_cache_grow+30/208>
   5:   f7 c5 00 10 00 00         test   $0x1000,%ebp
Code;  c0125816 <kmem_cache_grow+36/208>
   b:   0f 85 c4 01 00 00         jne    1d5 <_EIP+0x1d5> c01259e0
<kmem_cache_g
row+200/208>
Code;  c012581c <kmem_cache_grow+3c/208>
  11:   a1 48 58 00 00            mov    0x5848,%eax


2 warnings issued.  Results may not be reliable.


Cheers.
-- 
73's de Daniel, F1RMB.

              -=- Daniel Caujolle-Bert -=- segfault@club-internet.fr -=-
                        -=- f1rmb@f1rmb.ampr.org (AMPR NET) -=-
