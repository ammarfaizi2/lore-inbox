Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283774AbRLCXq2>; Mon, 3 Dec 2001 18:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282114AbRLCXhL>; Mon, 3 Dec 2001 18:37:11 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:7175 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S284769AbRLCQeK>; Mon, 3 Dec 2001 11:34:10 -0500
Message-ID: <3C0BA978.A26EF6C0@delusion.de>
Date: Mon, 03 Dec 2001 17:34:00 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre5 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [OOPS]: Linux-2.5.1-pre5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

I just got the following oops when running 2.5.1-pre5. pre5 has been running
otherwise stable for a few days. The only oddity I'm seeing is that ever
since I upgraded to -pre5 from -pre1 I'm seeing

keyboard: Timeout - AT keyboard not present?(f4)
keyboard: Timeout - AT keyboard not present?(f4)

whenever I (re)start X. This never happened before.

Regards,
Udo.


ksymoops 2.4.1 on i686 2.5.1-pre5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.1-pre5/ (default)
     -m /boot/System.map-2.5.1-pre5 (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000028
c01d0538
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01d0538>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: c1be11c0   ecx: 00000030   edx: 00000200
esi: 00000001   edi: c1be14c0   ebp: c10688ac   esp: cac1bdb0
ds: 0018   es: 0018   ss: 0018
Process kdeinit (pid: 223, stackpage=cac1b000)
Stack: 00000030 00000001 c1be11c0 00000000 c0135af7 00000001 c1be11c0 c010820c
       0000000b c1101ad4 000001f0 00000020 00000a0e c010a238 c1101ad4 c1be14c0
       c10688ac c1be14c0 c0135b5c c1be14c0 000001f0 00000018 00000018 ffffff0b
Call Trace: [<c0135af7>] [<c010820c>] [<c010a238>] [<c0135b5c>] [<c01346bc>]
   [<c012c328>] [<c012c5e0>] [<c012c64c>] [<c012cf51>] [<c012d19c>] [<c012d230>]
   [<c013f8d3>] [<c02638d5>] [<c022177f>] [<c013fb03>] [<c013fed2>] [<c01c9b5f>]
   [<c0106d1b>]
Code: 8b 48 28 66 c1 ea 09 0f b7 d2 0f af 53 04 89 10 0f b7 53 0c

>>EIP; c01d0538 <submit_bh+48/d0>   <=====
Trace; c0135af7 <sync_page_buffers+97/b0>
Trace; c010820c <do_IRQ+7c/b0>
Trace; c010a238 <call_do_IRQ+5/d>
Trace; c0135b5c <try_to_free_buffers+4c/100>
Trace; c01346bc <try_to_release_page+1c/50>
Trace; c012c328 <shrink_cache+188/310>
Trace; c012c5e0 <shrink_caches+50/90>
Trace; c012c64c <try_to_free_pages+2c/50>
Trace; c012cf51 <balance_classzone+51/190>
Trace; c012d19c <__alloc_pages+10c/190>
Trace; c012d230 <__get_free_pages+10/20>
Trace; c013f8d3 <__pollwait+33/90>
Trace; c02638d5 <unix_poll+25/a0>
Trace; c022177f <sock_poll+1f/30>
Trace; c013fb03 <do_select+f3/200>
Trace; c013fed2 <sys_select+292/4a0>
Trace; c01c9b5f <keyboard_interrupt+f/20>
Trace; c0106d1b <system_call+33/38>
Code;  c01d0538 <submit_bh+48/d0>
0000000000000000 <_EIP>:
Code;  c01d0538 <submit_bh+48/d0>   <=====
   0:   8b 48 28                  mov    0x28(%eax),%ecx   <=====
Code;  c01d053b <submit_bh+4b/d0>
   3:   66 c1 ea 09               shr    $0x9,%dx
Code;  c01d053f <submit_bh+4f/d0>
   7:   0f b7 d2                  movzwl %dx,%edx
Code;  c01d0542 <submit_bh+52/d0>
   a:   0f af 53 04               imul   0x4(%ebx),%edx
Code;  c01d0546 <submit_bh+56/d0>
   e:   89 10                     mov    %edx,(%eax)
Code;  c01d0548 <submit_bh+58/d0>
  10:   0f b7 53 0c               movzwl 0xc(%ebx),%edx
