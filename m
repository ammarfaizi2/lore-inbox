Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbQKEKQz>; Sun, 5 Nov 2000 05:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129182AbQKEKQg>; Sun, 5 Nov 2000 05:16:36 -0500
Received: from r57h68.res.gatech.edu ([128.61.57.68]:3076 "EHLO
	durandal.internal.greenbuffalo.com") by vger.kernel.org with ESMTP
	id <S129098AbQKEKQ0>; Sun, 5 Nov 2000 05:16:26 -0500
Date: Sun, 5 Nov 2000 05:16:23 -0500
To: linux-kernel@vger.kernel.org
Subject: 3c509 Oops with 2.4.0-test10
Message-ID: <20001105051623.A269@greenbuffalo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: chrisc@greenbuffalo.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to load the 3c509 module into a 2.4.0-test10 kernel, I
got an Oops as follows. Any help would be appreciated.

Thanks!

- Chris Campbell <chrisc@greenbuffalo.com>


Unable to handle kernel NULL pointer dereference at virtual address 00000070
c88195a5
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c88195a5>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: a0af2000   ebx: 00000004   ecx: b2f690a0   edx: 00000070
esi: 00000006   edi: 00000000   ebp: 00000220   esp: c7d43f08
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 35, stackpage=c7d43000)
Stack: 00000000 00000000 c881904e ffffffea c7d43f3c c7d43f2c 00000070 0000000a 
       00ff0001 c881904e ffffffea c1044010 c0235d60 a0af2000 ffff7d1d c881a209 
       00000000 c8819000 00000001 c01160b8 c7d42000 08050721 00001b80 bfffdf34 
Call Trace: [<c881904e>] [<c881904e>] [<c881a209>] [<c8819000>] [<c01160b8>] [<c8819048>] [<c8811000>] 
       [<c8819048>] [<c0108d3f>] 
Code: 89 02 8b 44 24 38 66 89 42 04 8b 4c 24 40 89 69 20 8b 44 24 

>>EIP; c88195a5 <[3c509].text.start+545/6d4>   <=====
Trace; c881904e <[isa-pnp]__module_using_checksums+fbb/fcd>
Trace; c881904e <[isa-pnp]__module_using_checksums+fbb/fcd>
Trace; c881a209 <[3c509]init_module+55/70>
Trace; c8819000 <[isa-pnp]__module_using_checksums+f6d/fcd>
Trace; c01160b8 <sys_init_module+3d0/440>
Trace; c8819048 <[isa-pnp]__module_using_checksums+fb5/fcd>
Trace; c8811000 <_end+856eaec/856eb4c>
Trace; c8819048 <[isa-pnp]__module_using_checksums+fb5/fcd>
Trace; c0108d3f <system_call+33/38>
Code;  c88195a5 <[3c509].text.start+545/6d4>
00000000 <_EIP>:
Code;  c88195a5 <[3c509].text.start+545/6d4>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c88195a7 <[3c509].text.start+547/6d4>
   2:   8b 44 24 38               mov    0x38(%esp,1),%eax
Code;  c88195ab <[3c509].text.start+54b/6d4>
   6:   66 89 42 04               mov    %ax,0x4(%edx)
Code;  c88195af <[3c509].text.start+54f/6d4>
   a:   8b 4c 24 40               mov    0x40(%esp,1),%ecx
Code;  c88195b3 <[3c509].text.start+553/6d4>
   e:   89 69 20                  mov    %ebp,0x20(%ecx)
Code;  c88195b6 <[3c509].text.start+556/6d4>
  11:   8b 44 24 00               mov    0x0(%esp,1),%eax

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
