Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133008AbRDKVkd>; Wed, 11 Apr 2001 17:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133006AbRDKVkO>; Wed, 11 Apr 2001 17:40:14 -0400
Received: from rhenium.btinternet.com ([194.73.73.93]:14584 "EHLO rhenium")
	by vger.kernel.org with ESMTP id <S133008AbRDKVkF>;
	Wed, 11 Apr 2001 17:40:05 -0400
Date: Wed, 11 Apr 2001 22:36:19 +0000 (GMT)
From: James Stevenson <mistral@stev.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.3-ac4 ? pgd entry c0b610fc: 0000000000000000
Message-ID: <Pine.LNX.4.21.0104112232220.3556-100000@cyrix.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

my mail programs stoped working
fetchmail / procmail and a perl script
and i found this in the logs

Unable to handle kernel paging request at virtual address 0fff72bc
 printing eip:
c0123dbc
pgd entry c0b610fc: 0000000000000000
pmd entry c0b610fc: 0000000000000000
... pmd not present!
Oops: 0000
CPU:    0
EIP:    0010:[<c0123dbc>]
EFLAGS: 00010087
eax: c020a140   ebx: fff729f0   ecx: 7ffb94f8   edx: 00000020
esi: c020a0a0   edi: ffffffff   ebp: 00000000   esp: c07d9f04
ds: 0018   es: 0018   ss: 0018
Process mailpost (pid: 450, stackpage=c07d9000)
Stack: c002f838 009c4065 0013d000 c0d6141c c0046574 c25bd478 c020a0c8
00000a12 
       7ffb94f8 c012445a c0124927 c002f838 009c4065 c0119cb6 c002f838
c0b68e60 
       c0269ea0 080c7000 0013d000 00040000 00000041 00000000 00204000
c0b61080 
Call Trace: [<c25bd478>] [<c012445a>] [<c0124927>] [<c0119cb6>]
[<c011c245>] [<c010f056>] [<c011136d>] 
       [<c01114bf>] [<c0106ea3>] 

Code: 0f bb 0a 19 c0 85 c0 0f 84 be 00 00 00 89 f8 f7 d8 31 d8 89 


ksymoops 2.3.4 on i686 2.2.19.  Options used
     -v /home/mistral/data/kernels/SX2/vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.2.19/ (default)
     -m /home/mistral/data/kernels/SX2/System.map (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Oops: 0000
CPU:    0
EIP:    0010:[<c0123dbc>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010087
eax: c020a140   ebx: fff729f0   ecx: 7ffb94f8   edx: 00000020
esi: c020a0a0   edi: ffffffff   ebp: 00000000   esp: c07d9f04
ds: 0018   es: 0018   ss: 0018
Process mailpost (pid: 450, stackpage=c07d9000)
Stack: c002f838 009c4065 0013d000 c0d6141c c0046574 c25bd478 c020a0c8 00000a12 
       7ffb94f8 c012445a c0124927 c002f838 009c4065 c0119cb6 c002f838 c0b68e60 
       c0269ea0 080c7000 0013d000 00040000 00000041 00000000 00204000 c0b61080 
Call Trace: [<c25bd478>] [<c012445a>] [<c0124927>] [<c0119cb6>] [<c011c245>] [<c010f056>] [<c011136d>] 
       [<c01114bf>] [<c0106ea3>] 
Code: 0f bb 0a 19 c0 85 c0 0f 84 be 00 00 00 89 f8 f7 d8 31 d8 89 

>>EIP; c0123dbc <__free_pages_ok+11c/230>   <=====
Trace; c25bd478 <END_OF_CODE+2368424/???
Trace; c012445a <__free_pages+1a/20>
Trace; c0124927 <free_page_and_swap_cache+87/90>
Trace; c0119cb6 <zap_page_range+1c6/290>
Trace; c011c245 <exit_mmap+b5/120>
Trace; c010f056 <mmput+26/50>
Trace; c011136d <do_exit+7d/1a0>
Trace; c01114bf <sys_exit+f/10>
Trace; c0106ea3 <system_call+33/40>
Code;  c0123dbc <__free_pages_ok+11c/230>
00000000 <_EIP>:
Code;  c0123dbc <__free_pages_ok+11c/230>   <=====
   0:   0f bb 0a                  btc    %ecx,(%edx)   <=====
Code;  c0123dbf <__free_pages_ok+11f/230>
   3:   19 c0                     sbb    %eax,%eax
Code;  c0123dc1 <__free_pages_ok+121/230>
   5:   85 c0                     test   %eax,%eax
Code;  c0123dc3 <__free_pages_ok+123/230>
   7:   0f 84 be 00 00 00         je     cb <_EIP+0xcb> c0123e87 <__free_pages_ok+1e7/230>
Code;  c0123dc9 <__free_pages_ok+129/230>
   d:   89 f8                     mov    %edi,%eax
Code;  c0123dcb <__free_pages_ok+12b/230>
   f:   f7 d8                     neg    %eax
Code;  c0123dcd <__free_pages_ok+12d/230>
  11:   31 d8                     xor    %ebx,%eax
Code;  c0123dcf <__free_pages_ok+12f/230>
  13:   89 00                     mov    %eax,(%eax)


-- 
---------------------------------------------
Check Out: http://stev.org
E-Mail: mistral@stev.org
 10:30pm  up 16 days,  6:24,  5 users,  load average: 0.00, 0.00, 0.00

