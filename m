Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262783AbSLURv7>; Sat, 21 Dec 2002 12:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbSLURv7>; Sat, 21 Dec 2002 12:51:59 -0500
Received: from lapd.cj.edu.ro ([193.231.142.101]:30084 "HELO lapd.cj.edu.ro")
	by vger.kernel.org with SMTP id <S262783AbSLURvy>;
	Sat, 21 Dec 2002 12:51:54 -0500
Date: Sat, 21 Dec 2002 19:59:52 +0200 (EET)
From: "Lists (lst)" <linux@lapd.cj.edu.ro>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] Kernel 2.4.20 ...
Message-ID: <Pine.LNX.4.43L0.0212211945090.9863-100000@lapd.cj.edu.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I receive this oops from the begining of 2.4.19. Now I'm running a 2.4.20 
in SMP mode. Is there anyone who can tell me what is the problem of my 
kernel?

Thank you,
Cosmin
--------------------------------------------------------------------------
ksymoops 2.4.8 on i686 2.4.20-SMP.  Options used
     -V (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-SMP/ (default)
     -m /usr/src/linux/System.map (default)

kernel BUG at /usr/src/linux-2.4.20-SMP/include/asm/spinlock.h:86!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c011f86b>]  Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000001   ebx: c0388165     ecx: c02f762c       edx: 00000001
esi: 00000046   edi: 0000003f     ebp: 00000003       esp: f5449f10
ds: 0018  es: 0018  ss: 0018
Process pppd (pid: 1518, stackpage=f5449000)
Stack:  f5448000 00000000 f5449f54 c01154e3 c02bb780 00000000 c010ac8d 00000001
        00000001 00000000 00000000 c9fe1d0c 00000000 c0357870 c010941e f5449f54
        00000000 c9fe1d0c c9fe1d0c f5449fc4 00000000 c0357870 00000003 00000001
Call trace:     [<c01154e3>]        (0xf5449f1c))
[<c010ac8d>]    (0xf5449f28))
[<c010941e>]    (0xf5449f48))
[<c010ac8d>]    (0xf5449f7c))
[<c010b02c>]    (0xf5449f98))
Code: 0f 0b 56 00 20 50 2b c0 c6 05 44 76 2f c0 01 b8 00 e0 ff ff


>>EIP; c011f86b <printk+1db/210>   <=====

>>ebx; c0388165 <printk_buf.1+25/400>
>>ecx; c02f762c <iomem_resource+0/1c>
>>esp; f5449f10 <[i2c-dev].data.end+f3d015/10e4165>

Trace; c01154e3 <nmi_watchdog_tick+a3/189>
Trace; c010ac8d <handle_IRQ_event+2d/90>
Trace; c010941e <nmi+1e/30>
Trace; c010ac8d <handle_IRQ_event+2d/90>
Trace; c010b02c <do_IRQ+11c/1e0>

Code;  c011f86b <printk+1db/210>
00000000 <_EIP>:
Code;  c011f86b <printk+1db/210>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c011f86d <printk+1dd/210>
   2:   56                        push   %esi
Code;  c011f86e <printk+1de/210>
   3:   00 20                     add    %ah,(%eax)
Code;  c011f870 <printk+1e0/210>
   5:   50                        push   %eax
Code;  c011f871 <printk+1e1/210>
   6:   2b c0                     sub    %eax,%eax
Code;  c011f873 <printk+1e3/210>
   8:   c6 05 44 76 2f c0 01      movb   $0x1,0xc02f7644
Code;  c011f87a <printk+1ea/210>
   f:   b8 00 e0 ff ff            mov    $0xffffe000,%eax

 <0>Kernel panic: Aiee, killing interrupt handler!

