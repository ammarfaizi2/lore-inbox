Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132618AbRDSSdV>; Thu, 19 Apr 2001 14:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132616AbRDSSdH>; Thu, 19 Apr 2001 14:33:07 -0400
Received: from ucu-105-116.ucu.uu.nl ([131.211.105.116]:32546 "EHLO
	ronald.bitfreak.net") by vger.kernel.org with ESMTP
	id <S132615AbRDSScu>; Thu, 19 Apr 2001 14:32:50 -0400
Date: Thu, 19 Apr 2001 20:32:28 +0200
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: linux-kernel@vger.kernel.org
Subject: kernel oops
Message-ID: <20010419203228.I2149@tux.bitfreak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

when I have given my computer a 'quite heavy load' in X, it will sometimes
suddenly, without much reason at that moment itself, stop working... Ie,
the 'stop' itself can happen when the computer isn't even being worked on,
but five minutes after I've done some video editing (using a DC10+ with
Serguei Miridonov's zoran driver)...
Either I get:
- a full computer crash
- or it will segfault everything I try to do
# reboot
Segmentation fault
# ls
Segmentation fault
#
- or the kernel will oops.
Uptimes longer than a few days are usually out of the question. I've
experienced it since I switched over to kernel 2.4.x

I currently use kernel 2.4.3, on a Pentium II 400 MHz, 128 MB RAM, with
redhat 7.0. I also use the nvidia.com drivers for my videocard (tnt2),
maybe that's of importance...

the oops:

kernel BUG at page_alloc.c:81!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01298df>]
EFLAGS: 00010282
eax: 0000001f   ebx: c11bbb6c   ecx: 00000001   edx: c0223a28
esi: 00000000   edi: 00000000   ebp: 00000000   esp: c7affe84
ds: 0018   es: 0018   ss: 0018
Process blackbox (pid: 782, stackpage=c7aff000)
Stack: c01ec68b c01ec7b9 00000051 00000000 c11bbb6c c11bbb6c c0127dbc
c11bbb6c 
       00000001 c11bbb6c 000c0000 c7b6c310 c012a68a c11bbb6c 00000202
ffffffff 
       c11efe48 c11efe48 c11bbb6c 00000027 c011f184 c11bbb6c 00000003
00000000 
Call Trace: [<c0127dbc>] [<c012a68a>] [<c011f184>] [<c012142f>]
[<c012072a>] [<c01214fd>] [<fffd5000>] 
       [<c0106f27>] [<fffd5000>] 

Code: 0f 0b 83 c4 0c 8b 43 18 83 e0 20 74 16 6a 53 68 b9 c7 1e c0 
kernel BUG at page_alloc.c:81!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01298df>]
EFLAGS: 00013286
eax: 0000001f   ebx: c1209868   ecx: 00000001   edx: c0223a28
esi: 00000000   edi: 00000000   ebp: 00000000   esp: c1a95e98
ds: 0018   es: 0018   ss: 0018
Process X (pid: 777, stackpage=c1a95000)
Stack: c01ec68b c01ec7b9 00000051 00000000 c1209868 c1209868 c0127dbc
c1209868 
       00000000 c1209868 00161000 c4101644 c012a68a c1209868 00000010
c584f440 
       c012c368 c584f54c c1209868 00000004 c011f184 c1209868 0000002f
00000000 
Call Trace: [<c0127dbc>] [<c012a68a>] [<c012c368>] [<c011f184>]
[<c0141220>] [<c0140321>] [<c015a1c9>] 
       [<c01217d8>] [<c01062e5>] [<c0112336>] [<c0116032>] [<c01107a0>]
[<c0106f27>] 

Code: 0f 0b 83 c4 0c 8b 43 18 83 e0 20 74 16 6a 53 68 b9 c7 1e c0 

Ksymoops output when I last had the oops (only for first one, I lost the
other one):

ksymoops 2.3.4 on i686 2.4.3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.3/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Reading Oops report from the terminal

kernel BUG at page_alloc.c:81!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01298df>]
EFLAGS: 00010282
eax: 0000001f   ebx: c11bbb6c   ecx: 00000001   edx: c0223a28
esi: 00000000   edi: 00000000   ebp: 00000000   esp: c7affe84
ds: 0018   es: 0018   ss: 0018
Process blackbox (pid: 782, stackpage=c7aff000)
Stack: c01ec68b c01ec7b9 00000051 00000000 c11bbb6c c11bbb6c c0127dbc
c11bbb6c
       00000001 c11bbb6c 000c0000 c7b6c310 c012a68a c11bbb6c 00000202
ffffffff
       c11efe48 c11efe48 c11bbb6c 00000027 c011f184 c11bbb6c 00000003
00000000
Call Trace: [<c0127dbc>] [<c012a68a>] [<c011f184>] [<c012142f>]
[<c012072a>] [<c01214fd>] 
[<fffd500$       [<c0106f27>] [<fffd5000>]

Code: 0f 0b 83 c4 0c 8b 43 18 83 e0 20 74 16 6a 53 68 b9 c7 1e c0



invalid operand: 0000
CPU:    0
EIP:    0010:[<c01298df>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001f   ebx: c11bbb6c   ecx: 00000001   edx: c0223a28
esi: 00000000   edi: 00000000   ebp: 00000000   esp: c7affe84
ds: 0018   es: 0018   ss: 0018
Process blackbox (pid: 782, stackpage=c7aff000)
Stack: c01ec68b c01ec7b9 00000051 00000000 c11bbb6c c11bbb6c c0127dbc
c11bbb6c
       00000001 c11bbb6c 000c0000 c7b6c310 c012a68a c11bbb6c 00000202
ffffffff
       c11efe48 c11efe48 c11bbb6c 00000027 c011f184 c11bbb6c 00000003
00000000
Call Trace: [<c0127dbc>] [<c012a68a>] [<c011f184>] [<c012142f>]
[<c012072a>] [<c01214fd>] [<fffd500$       [<c0106f27>] [<fffd5000>]
Code: 0f 0b 83 c4 0c 8b 43 18 83 e0 20 74 16 6a 53 68 b9 c7 1e c0

>>EIP; c01298df <__free_pages_ok+af/310>   <=====
Trace; c0127dbc <lru_cache_del+2c/30>
Trace; c012a68a <free_page_and_swap_cache+6a/c0>
Trace; c011f184 <zap_page_range+1b4/260>
Trace; c012142f <do_munmap+1ff/2a0>
Trace; c012072a <sys_brk+5a/e0>
Trace; c01214fd <sys_munmap+2d/50>
Code;  c01298df <__free_pages_ok+af/310>
00000000 <_EIP>:
Code;  c01298df <__free_pages_ok+af/310>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01298e1 <__free_pages_ok+b1/310>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c01298e4 <__free_pages_ok+b4/310>
   5:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c01298e7 <__free_pages_ok+b7/310>
   8:   83 e0 20                  and    $0x20,%eax
Code;  c01298ea <__free_pages_ok+ba/310>
   b:   74 16                     je     23 <_EIP+0x23> c0129902
<__free_pages_ok+d2/310>
Code;  c01298ec <__free_pages_ok+bc/310>
   d:   6a 53                     push   $0x53
Code;  c01298ee <__free_pages_ok+be/310>
   f:   68 b9 c7 1e c0            push   $0xc01ec7b9


Is blackbox broken? Or is this a kernel bug? Or a bug in the nvidia
drivers?
I hope you can fix it (if it is a kernel bug)...

Ronald Bultje

