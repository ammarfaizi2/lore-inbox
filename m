Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278086AbRJ3Utk>; Tue, 30 Oct 2001 15:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278085AbRJ3Ute>; Tue, 30 Oct 2001 15:49:34 -0500
Received: from zeus.kernel.org ([204.152.189.113]:955 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S278086AbRJ3UtU> convert rfc822-to-8bit;
	Tue, 30 Oct 2001 15:49:20 -0500
Date: Tue, 30 Oct 2001 21:46:16 +0100 (CET)
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Oops on 2.4.14-pre3
Message-ID: <Pine.LNX.4.40.0110302143390.4681-100000@lt.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
Maybe this trace is not very important, but...

ksymoops 2.4.1 on i586 2.4.14-pre3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.14-pre3/ (default)
     -m /lib/modules/2.4.14-pre3/System.map (specified)

CPU:    0
EIP:    0010:[<c01298a4>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013202
eax: 00000001   ebx: 0009b000   ecx: 00000000   edx: 00000000
esi: c139e840   edi: c139e840   ebp: 00000000   esp: c83b7eb4
ds: 0018   es: 0018   ss: 0018
Process X (pid: 4140, stackpage=c83b7000)
Stack: c02c3f80 000009b0 0009b000 c139e840 0009b000 c02c3f80 c139e840 08400000
       c012aa3d c139e840 0007d000 00400000 d2b611f4 c011fdf3 0009b000 00000012
       00000000 08800000 cacc5084 0000004c 0888e000 cacc5084 c83b7f5c 00000000
Call Trace: [<c012aa3d>] [<c011fdf3>] [<c01303bf>] [<c012250d>] 
[<c0112339>]
   [<c01162e8>] [<c0106199>] [<c0110410>] [<c0106dd3>]
Code: 0f 0b 8b 46 18 83 e0 20 74 02 0f 0b 8b 46 18 83 e0 40 74 02

>>EIP; c01298a4 <__free_pages_ok+44/1e0>   <=====
Trace; c012aa3d <free_swap_and_cache+4d/a0>
Trace; c011fdf3 <zap_page_range+153/200>
Trace; c01303bf <fput+af/d0>
Trace; c012250d <exit_mmap+ad/110>
Trace; c0112339 <mmput+39/50>
Trace; c01162e8 <do_exit+98/1c0>
Trace; c0106199 <sys_sigreturn+b9/f0>
Trace; c0110410 <do_page_fault+0/4f0>
Trace; c0106dd3 <system_call+33/40>
Code;  c01298a4 <__free_pages_ok+44/1e0>
00000000 <_EIP>:
Code;  c01298a4 <__free_pages_ok+44/1e0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01298a6 <__free_pages_ok+46/1e0>
   2:   8b 46 18                  mov    0x18(%esi),%eax
Code;  c01298a9 <__free_pages_ok+49/1e0>
   5:   83 e0 20                  and    $0x20,%eax
Code;  c01298ac <__free_pages_ok+4c/1e0>
   8:   74 02                     je     c <_EIP+0xc> c01298b0 
<__free_pages_ok+50/1e0>
Code;  c01298ae <__free_pages_ok+4e/1e0>
   a:   0f 0b                     ud2a
Code;  c01298b0 <__free_pages_ok+50/1e0>
   c:   8b 46 18                  mov    0x18(%esi),%eax
Code;  c01298b3 <__free_pages_ok+53/1e0>
   f:   83 e0 40                  and    $0x40,%eax
Code;  c01298b6 <__free_pages_ok+56/1e0>
  12:   74 02                     je     16 <_EIP+0x16> c01298ba 
<__free_pages_ok+5a/1e0>


-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl

