Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289721AbSAKLuu>; Fri, 11 Jan 2002 06:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289742AbSAKLuk>; Fri, 11 Jan 2002 06:50:40 -0500
Received: from [62.98.196.93] ([62.98.196.93]:260 "EHLO
	gandalf.rhpk.springfield.inwind.it") by vger.kernel.org with ESMTP
	id <S289721AbSAKLu2>; Fri, 11 Jan 2002 06:50:28 -0500
Date: Fri, 11 Jan 2002 12:46:19 +0100 (CET)
From: Cristiano Paris <c.paris@libero.it>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.18pre2 oops
Message-ID: <Pine.LNX.4.33.0201111241580.279-100000@gandalf.rhpk.springfield.inwind.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the latest oops from my collection. It's strange, it happens
randomly and refers always to different parts of the kernel : sometimes
in the VFS, some time in the VM.

The kernel becomes stable as you deactivate the agpgart driver.

Unable to handle kernel paging request at virtual address 0000eb22
c0129aa7
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0129aa7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010013
eax: 00001a2c   ebx: 0000d164   ecx: 00000003   edx: 0000e7de
esi: c1385900   edi: 00000002   ebp: c02548b8   esp: ce131e24
ds: 0018   es: 0018   ss: 0018
Process X (pid: 847, stackpage=ce131000)
Stack: c02549fc 000001ff 00000122 00000000 000001b6 00000282 00000000 c0254888
       c0129d7f 000001d2 cd0d4910 00000122 c145c748 c0254888 c02549f8 000001d2
       c1347e80 c0129be2 00000122 c01237ea 00000122 00000005 0000014d ce28ab60
Call Trace: [<c0129d7f>] [<c0129be2>] [<c01237ea>] [<c012385a>] [<c0124a93>]
   [<c01218d9>] [<c01219fa>] [<c0111e78>] [<c0111d18>] [<c011d509>] [<c0122b84>]
   [<c0118309>] [<c0106bfc>]
Code: 0f bb 02 8b 4c 24 18 8b 54 24 1c b8 01 00 00 00 d3 e0 89 f9
Error (Oops_bfd_perror): set_section_contents Bad value

>>EIP; c0129aa6 <rmqueue+82/1a8>   <=====
Trace; c0129d7e <__alloc_pages+32/164>
Trace; c0129be2 <_alloc_pages+16/18>
Trace; c01237ea <page_cache_read+6e/b8>
Trace; c012385a <read_cluster_nonblocking+26/40>
Trace; c0124a92 <filemap_nopage+10a/1f8>
Trace; c01218d8 <do_no_page+4c/11c>
Trace; c01219fa <handle_mm_fault+52/b4>
Trace; c0111e78 <do_page_fault+160/498>
Trace; c0111d18 <do_page_fault+0/498>
Trace; c011d508 <sys_kill+4c/58>
Trace; c0122b84 <do_brk+118/1fc>
Trace; c0118308 <sys_gettimeofday+20/134>
Trace; c0106bfc <error_code+34/3c>

Cristiano

----
GnuPG Public Key Fingerprint (certserver.pgp.com)
pub  1024D/BF762716 2002-01-08 Cristiano Paris (privata) <c.paris@libero.it>
     Key fingerprint = 91BA C55F 4B75 730D 5FB3  16AB 4202 9ACA BF76 2716


