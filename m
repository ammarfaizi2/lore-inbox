Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261559AbSK0Dov>; Tue, 26 Nov 2002 22:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbSK0Dov>; Tue, 26 Nov 2002 22:44:51 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:44240 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S261559AbSK0Dou>; Tue, 26 Nov 2002 22:44:50 -0500
Date: Tue, 26 Nov 2002 19:52:20 -0800
From: Joshua Kwan <joshk@mspencer.net>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] 2.4.20-rc4-ac1 (also occurs 2.4.20-rc2-ac3) in radeon DRI for XFree86
Message-Id: <20021126195220.5477caaa.joshk@mspencer.net>
X-Mailer: Sylpheed version 0.8.6cvs7 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ksymoops output follows.

I compiled Radeon DRM stuff into the kernel -- i845 agp support from agapgart.
I am using gcc-3.2 to compile. 100% reproducible (okay, i've been spending too much time on bugzillas...) Feel the power of the oops.

Hope this helps kernel development.
-Josh

Unable to handle kernel NULL pointer dereference at virtual address 00000002
c01bad2d
*pde = 0eb07067
Oops: 0002
CPU:    0
EIP:    0010:[<c01bad2d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013202
eax: d49391d0   ebx: e0000000   ecx: 00000011   edx: 00000002
esi: cf725080   edi: ce427efc   ebp: c1aa2800   esp: ce427ec4
ds: 0018   es: 0018   ss: 0018
Process XFree86 (pid: 374, stackpage=ce427000)
Stack: 00020000 00200000 000000f8 00000000 cdb49340 cdb49100 ce427efc c1aa2800 
       cea5fa80 ce348280 c01bb1ad c1aa2800 ce427efc 00000054 00000001 00000898 
       00000000 40000000 00800000 00100000 00002710 00000020 00000000 00001040 
Call Trace:    [<c01bb1ad>] [<c01b55ed>] [<c0149ce9>] [<c01072f7>]
Code: 89 02 89 34 24 e8 d9 f2 ff ff 89 74 24 04 89 2c 24 e8 0d f8


>>EIP; c01bad2d <radeon_do_init_cp+4bd/7c0>   <=====

>>esi; cf725080 <_end+f4174a8/12588488>
>>edi; ce427efc <_end+e11a324/12588488>
>>ebp; c1aa2800 <_end+1794c28/12588488>
>>esp; ce427ec4 <_end+e11a2ec/12588488>

Trace; c01bb1ad <radeon_cp_init+6d/80>
Trace; c01b55ed <radeon_ioctl+cd/150>
Trace; c0149ce9 <sys_ioctl+c9/250>
Trace; c01072f7 <system_call+33/38>

Code;  c01bad2d <radeon_do_init_cp+4bd/7c0>
00000000 <_EIP>:
Code;  c01bad2d <radeon_do_init_cp+4bd/7c0>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c01bad2f <radeon_do_init_cp+4bf/7c0>
   2:   89 34 24                  mov    %esi,(%esp,1)
Code;  c01bad32 <radeon_do_init_cp+4c2/7c0>
   5:   e8 d9 f2 ff ff            call   fffff2e3 <_EIP+0xfffff2e3>
Code;  c01bad37 <radeon_do_init_cp+4c7/7c0>
   a:   89 74 24 04               mov    %esi,0x4(%esp,1)
Code;  c01bad3b <radeon_do_init_cp+4cb/7c0>
   e:   89 2c 24                  mov    %ebp,(%esp,1)
Code;  c01bad3e <radeon_do_init_cp+4ce/7c0>
  11:   e8 0d f8 00 00            call   f823 <_EIP+0xf823>
