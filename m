Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274560AbRITQaS>; Thu, 20 Sep 2001 12:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274562AbRITQaI>; Thu, 20 Sep 2001 12:30:08 -0400
Received: from mail.Virginia.EDU ([128.143.2.9]:33508 "HELO mail.virginia.edu")
	by vger.kernel.org with SMTP id <S274560AbRITQ3x>;
	Thu, 20 Sep 2001 12:29:53 -0400
Date: Thu, 20 Sep 2001 12:30:11 -0400 (EDT)
From: Aaron J Mackey <ajm6q@virginia.edu>
X-X-Sender: <ajm6q@alpha10.bioch.virginia.edu>
Reply-To: "Aaron J. Mackey" <amackey@virginia.edu>
To: linux-kernel@vger.kernel.org
MMDF-Warning: Parse error in original version of preceding line at mail.virginia.edu
Subject: 2.4.9 kernel bug
Message-ID: <Pine.OSF.4.33.0109201227530.23017-100000@alpha10.bioch.virginia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


here's the ksymoops output ... let me know if there's anything else you
need ...

-Aaron
amackey@virginia.edu

ksymoops 2.4.0 on i686 2.4.9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.9/ (default)
     -m /boot/System.map-2.4.9 (default)

kernel BUG at page_alloc.c:81!
invalid operand: 0000
CPU:    0
EIP:    0010:[__free_pages_ok+175/784]
EIP:    0010:[<c012c20f>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001f   ebx: 00000000   ecx: 00000012   edx: 02000000
esi: c17b1ae0   edi: 00000000   ebp: 00000000   esp: dd3a7e94
ds: 0018   es: 0018   ss: 0018
Process c34.worktfx (pid: 1389, stackpage=dd3a7000)
Stack: c0266ec9 c0266f9d 00000051 c17b1b68 c1044010 c02c8a64 00000206 fffffffe
       c17b1ae0 c17b1ae0 002ed000 df67ec20 c012d035 dd3a7f1c dd7f076c c020b6c1
       dd7f076c c17b1ae0 00000006 c0120ac5 c17b1ae0 0000001a 00000000 0030e000
Call Trace: [free_page_and_swap_cache+213/224] [sock_recvmsg+49/176] [zap_page_range+453/624] [do_page_fault+396/1184] [do_munmap+479/624]
Call Trace: [<c012d035>] [<c020b6c1>] [<c0120ac5>] [<c01102dc>] [<c012316f>]
   [<c011b350>] [<c01223f1>] [<c0106edb>]
Code: 0f 0b 83 c4 0c 8b 46 18 83 e0 20 74 16 6a 53 68 9d 6f 26 c0

>>EIP; c012c20f <__free_pages_ok+af/310>   <=====
Trace; c012d035 <free_page_and_swap_cache+d5/e0>
Trace; c020b6c1 <sock_recvmsg+31/b0>
Trace; c0120ac5 <zap_page_range+1c5/270>
Trace; c01102dc <do_page_fault+18c/4a0>
Trace; c012316f <do_munmap+1df/270>
Trace; c011b350 <update_process_times+20/a0>
Trace; c01223f1 <sys_brk+61/f0>
Trace; c0106edb <system_call+33/38>
Code;  c012c20f <__free_pages_ok+af/310>
00000000 <_EIP>:
Code;  c012c20f <__free_pages_ok+af/310>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012c211 <__free_pages_ok+b1/310>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012c214 <__free_pages_ok+b4/310>
   5:   8b 46 18                  mov    0x18(%esi),%eax
Code;  c012c217 <__free_pages_ok+b7/310>
   8:   83 e0 20                  and    $0x20,%eax
Code;  c012c21a <__free_pages_ok+ba/310>
   b:   74 16                     je     23 <_EIP+0x23> c012c232 <__free_pages_ok+d2/310>
Code;  c012c21c <__free_pages_ok+bc/310>
   d:   6a 53                     push   $0x53
Code;  c012c21e <__free_pages_ok+be/310>
   f:   68 9d 6f 26 c0            push   $0xc0266f9d


