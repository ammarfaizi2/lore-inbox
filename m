Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263978AbRFHMQv>; Fri, 8 Jun 2001 08:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263981AbRFHMQl>; Fri, 8 Jun 2001 08:16:41 -0400
Received: from web13902.mail.yahoo.com ([216.136.175.28]:47623 "HELO
	web13902.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263978AbRFHMQe>; Fri, 8 Jun 2001 08:16:34 -0400
Message-ID: <20010608121633.39690.qmail@web13902.mail.yahoo.com>
Date: Fri, 8 Jun 2001 05:16:33 -0700 (PDT)
From: szonyi calin <caszonyi@yahoo.com>
Subject: oops with kernel 2.4.5
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
we found in logs a oops and here are the results from
ksymoops (2.4.1)

Unable to handle kernel NULL pointer dereference at
virtual address 00000004
c012db89
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012db89>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c00725c0   ecx: c00725c0   edx:
00000004
esi: c00725c0   edi: c00725c0   ebp: 00000000   esp:
c10a9f70
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 3, stackpage=c10a9000)
Stack: c0130092 c00725c0 c1076e94 c1076e78 c025eb90
00000027 c00725c0 00000003 
       c0126cb1 c1076e78 00000000 00000000 00000004
00000000 0008e000 00000000 
       00000000 00000004 00000000 0000003c c0127551
00000004 00000000 c10a8000 
Call Trace: [<c0130092>] [<c0126cb1>] [<c0127551>]
[<c01275df>] [<c0105000>] [<c
0105463>] 
Code: 89 02 c7 41 30 00 00 00 00 31 c0 66 8b 41 0a 50
51 e8 0d ffUnable to handle kernel NULL pointer
dereference at virtual address 00000004
c012db89
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012db89>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c00725c0   ecx: c00725c0   edx:
00000004
esi: c00725c0   edi: c00725c0   ebp: 00000000   esp:
c10a9f70
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 3, stackpage=c10a9000)
Stack: c0130092 c00725c0 c1076e94 c1076e78 c025eb90
00000027 c00725c0 00000003 
       c0126cb1 c1076e78 00000000 00000000 00000004
00000000 0008e000 00000000 
       00000000 00000004 00000000 0000003c c0127551
00000004 00000000 c10a8000 
Call Trace: [<c0130092>] [<c0126cb1>] [<c0127551>]
[<c01275df>] [<c0105000>] [<c
0105463>] 
Code: 89 02 c7 41 30 00 00 00 00 31 c0 66 8b 41 0a 50
51 e8 0d ff
>>EIP; c012db89 <__remove_from_queues+19/34>   <=====
Trace; c0130092 <try_to_free_buffers+76/164>
Trace; c0126cb1 <page_launder+329/810>
Trace; c0127551 <do_try_to_free_pages+1d/58>
Trace; c01275df <kswapd+53/e0>
Trace; c0105000 <prepare_namespace+0/8>
Code;  c012db89 <__remove_from_queues+19/34>
00000000 <_EIP>:
Code;  c012db89 <__remove_from_queues+19/34>   <=====
   0:   89 02                     movl   %eax,(%edx)  
<=====
Code;  c012db8b <__remove_from_queues+1b/34>
   2:   c7 41 30 00 00 00 00      movl  
$0x0,0x30(%ecx)
Code;  c012db92 <__remove_from_queues+22/34>
   9:   31 c0                     xorl   %eax,%eax
Code;  c012db94 <__remove_from_queues+24/34>
   b:   66 8b 41 0a               movw   0xa(%ecx),%ax
Code;  c012db98 <__remove_from_queues+28/34>
   f:   50                        pushl  %eax
Code;  c012db99 <__remove_from_queues+29/34>
  10:   51                        pushl  %ecx
Code;  c012db9a <__remove_from_queues+2a/34>
  11:   e8 0d ff 00 00            call   ff23
<_EIP+0xff23> c013daac <d_invalidate+44/60>>>EIP;
c012db89 <__remove_from_queues+19/34>   <=====
Trace; c0130092 <try_to_free_buffers+76/164>
Trace; c0126cb1 <page_launder+329/810>
Trace; c0127551 <do_try_to_free_pages+1d/58>
Trace; c01275df <kswapd+53/e0>
Trace; c0105000 <prepare_namespace+0/8>
Code;  c012db89 <__remove_from_queues+19/34>
00000000 <_EIP>:
Code;  c012db89 <__remove_from_queues+19/34>   <=====
   0:   89 02                     movl   %eax,(%edx)  
<=====
Code;  c012db8b <__remove_from_queues+1b/34>
   2:   c7 41 30 00 00 00 00      movl  
$0x0,0x30(%ecx)
Code;  c012db92 <__remove_from_queues+22/34>
   9:   31 c0                     xorl   %eax,%eax
Code;  c012db94 <__remove_from_queues+24/34>
   b:   66 8b 41 0a               movw   0xa(%ecx),%ax
Code;  c012db98 <__remove_from_queues+28/34>
   f:   50                        pushl  %eax
Code;  c012db99 <__remove_from_queues+29/34>
  10:   51                        pushl  %ecx
Code;  c012db9a <__remove_from_queues+2a/34>
  11:   e8 0d ff 00 00            call   ff23
<_EIP+0xff23> c013daac <d_invalidate+44/60>

Well ?


__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/
