Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286343AbSBUHeT>; Thu, 21 Feb 2002 02:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287283AbSBUHeJ>; Thu, 21 Feb 2002 02:34:09 -0500
Received: from jubjub.wizard.com ([209.170.216.9]:23309 "EHLO
	jubjub.wizard.com") by vger.kernel.org with ESMTP
	id <S286343AbSBUHeB>; Thu, 21 Feb 2002 02:34:01 -0500
Date: Wed, 20 Feb 2002 23:33:28 -0800
From: A Guy Called Tyketto <tyketto@wizard.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.5 oopsen
Message-ID: <20020221073328.GA2724@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux/2.5.5 (i686)
X-uptime: 11:32pm  up 19 min,  4 users,  load average: 0.00, 0.05, 0.07
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Got nailed by this, when trying to remove the snd-pcm-oss module (ALSA
emulation) after removing the snd-fm801 module. I probably should have done
this in reverse order, but still:

Unable to handle kernel paging request at virtual address e11a3a40
e11a3a40
*pde = 1cfe5067
Oops: 0000
CPU:    0
EIP:    0010:[<e11a3a40>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: e11a3a40   ebx: d720fa18   ecx: e118e3f8   edx: e118e3e4
esi: d720fa18   edi: d720faf8   ebp: d720faf0   esp: d14bdf5c
ds: 0018   es: 0018   ss: 0018
Stack: e118be3d d720fa18 d720fcf0 e118c11a d720fa18 d720fcf0 fffffff0 d7243000
       e118b000 e118e3f8 e118d90b d720fa18 e118b000 c011afe7 e118b000 fffffff0
       d7243000 bfffe7dc c011a249 e118b000 00000000 d14bc000 00000000 080682e8
Call Trace: [<e118be3d>] [<e118c11a>] [<e118e3f8>] [<e118d90b>] [<c011afe7>]
   [<c011a249>] [<c0108a3f>]
Code:  Bad EIP value.

>>EIP; e11a3a40 <[snd].bss.end+25242/2e802>   <=====
Trace; e118be3c <[snd].bss.end+d63e/2e802>
Trace; e118c11a <[snd].bss.end+d91c/2e802>
Trace; e118e3f8 <[snd].bss.end+fbfa/2e802>
Trace; e118d90a <[snd].bss.end+f10c/2e802>
Trace; c011afe6 <free_module+16/c0>
Trace; c011a248 <sys_delete_module+128/280>
Trace; c0108a3e <syscall_call+6/a>


22 warnings issued.  Results may not be reliable.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

