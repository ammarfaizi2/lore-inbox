Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136816AbREKOs1>; Fri, 11 May 2001 10:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136929AbREKOsR>; Fri, 11 May 2001 10:48:17 -0400
Received: from s254-n148.tele2.cz ([212.65.254.148]:34039 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S136816AbREKOsC>;
	Fri, 11 May 2001 10:48:02 -0400
Posted-Date: Fri, 11 May 2001 16:47:53 +0200
Date: Fri, 11 May 2001 16:47:52 +0200 (CEST)
From: Martin Devera <devik@cdi.cz>
To: linux-kernel@vger.kernel.org
Subject: oops in kswapd with 2.4.4 on gigabyte MB
Message-ID: <Pine.LNX.4.10.10105111638550.20393-100000@luxik.cdi.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I installed 2.4.4 on host which was running win95 (without problems).
It is MB Gigabyte GA6BXC with one PCI net card (J2585B) and 128MB memory.
CPU is Pentium III (Katmai) fam.6 model 7 @ 450MHz.
One 15G IDE HDD.
After approx 1hr it gines me oops. I used ksymoops and result is
attached. 
The problem seems to be related to this particular MB plus Linux. MB
works for Win95 and the same Linux instalation works with another MB/CPU.
If someone wants to look at it .. it would be nice. If not .. dont worry.

thanks, devik


ksymoops 2.4.1 on i686 2.4.4.  Options used
     -v /boot/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.4/ (default)
     -m /usr/src/linux/System.map (default)
     -1

Unable to handle kernel paging request at virtual address a68b11c0
c013f161
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c013f161>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010216
eax: c0287104   ebx: c7c783c0   ecx: c7c78560   edx: a68b11c0
esi: c6e11140   edi: 00000fb1   ebp: 00000000   esp: c7f9dfac
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 3, stackpage=c7f9d000)
Stack: 00010f00 00000004 00000182 c013f4e1 000013a5 c0127eb7 00000006 00000004 
       00010f00 c0238a17 c7f9c239 0008e000 c0127f3b 00000004 00000000 c123ffbc 
       00000000 c0105454 00000000 00000078 c029dfc0 
Call Trace: [<c013f4e1>] [<c0127eb7>] [<c0127f3b>] [<c0105454>] 
Code: 89 02 89 09 89 49 04 8d 59 e0 f6 43 58 08 74 1f 80 63 58 f7 

>>EIP; c013f161 <prune_dcache+21/13c>   <=====
Trace; c013f4e1 <shrink_dcache_memory+21/30>
Trace; c0127eb7 <do_try_to_free_pages+5f/7c>
Trace; c0127f3b <kswapd+67/f4>
Trace; c0105454 <kernel_thread+28/38>
Code;  c013f161 <prune_dcache+21/13c>
00000000 <_EIP>:
Code;  c013f161 <prune_dcache+21/13c>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c013f163 <prune_dcache+23/13c>
   2:   89 09                     mov    %ecx,(%ecx)
Code;  c013f165 <prune_dcache+25/13c>
   4:   89 49 04                  mov    %ecx,0x4(%ecx)
Code;  c013f168 <prune_dcache+28/13c>
   7:   8d 59 e0                  lea    0xffffffe0(%ecx),%ebx
Code;  c013f16b <prune_dcache+2b/13c>
   a:   f6 43 58 08               testb  $0x8,0x58(%ebx)
Code;  c013f16f <prune_dcache+2f/13c>
   e:   74 1f                     je     2f <_EIP+0x2f> c013f190 <prune_dcache+50/13c>
Code;  c013f171 <prune_dcache+31/13c>
  10:   80 63 58 f7               andb   $0xf7,0x58(%ebx)



