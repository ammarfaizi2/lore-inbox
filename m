Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRATPRf>; Sat, 20 Jan 2001 10:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129729AbRATPRZ>; Sat, 20 Jan 2001 10:17:25 -0500
Received: from mout1.freenet.de ([194.97.50.132]:58344 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S129444AbRATPRN>;
	Sat, 20 Jan 2001 10:17:13 -0500
From: mkloppstech@freenet.de
Message-Id: <200101201347.OAA00225@john.epistle>
Subject: oops, continued
To: linux-kernel@vger.kernel.org
Date: Sat, 20 Jan 2001 14:47:18 +0100 (CET)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=ELM979998438-198-0_
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ELM979998438-198-0_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Sorry, but  it seems to be hardware. More conservative  memory settings
let the system live longer, but after some time the same errors occur.
Now the oopses seem to be just random oopses.

Mirko Kloppstech, please cc to mkloppstech@freenet.de

--ELM979998438-198-0_
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: attachment; filename=tmp2.oops
Content-Description: /tmp/tmp2.oops
Content-Transfer-Encoding: 7bit

ksymoops 2.3.7 on i686 2.4.0.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0/ (default)
     -m /boot/System.map (specified)

kernel BUG at page_alloc.c:190!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012b46d>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010092
eax: 00000020   ebx: c12bd09c   ecx: 00000000   edx: 00000007
esi: c01ed9e0   edi: c01ed9b8   ebp: 00000000   esp: caa73e44
ds: 0018   es: 0018   ss: 0018
Process cpp (pid: 22337, stackpage=caa73000)
Stack: c01c6865 c01c69f3 000000be c01ed9b8 c01edb90 00000001 ca79b398 00000005 
       c01edb34 c01edb30 00000286 00000000 c01ed9b8 c012b80b cc75ce40 cc75ce40 
       ccddbcc0 ca79b398 00000000 cfcdca04 00000005 00000001 c01edb8c c012185f 
Call Trace: [<c012b80b>] [<c012185f>] [<c01218e0>] [<c0121a58>] [<c0111fc7>] [<c0111e70>] [<c0122768>] 
       [<c0122a8a>] [<c0121c6b>] [<c0109040>] 
Code: 0f 0b 83 c4 0c 89 f6 8b 53 04 8b 03 89 50 04 89 02 89 5c 24 

>>EIP; c012b46d <rmqueue+6d/260>   <=====
Trace; c012b80b <__alloc_pages+eb/300>
Trace; c012185f <do_anonymous_page+2f/80>
Trace; c01218e0 <do_no_page+30/c0>
Trace; c0121a58 <handle_mm_fault+e8/160>
Trace; c0111fc7 <do_page_fault+157/420>
Trace; c0111e70 <do_page_fault+0/420>
Trace; c0122768 <do_munmap+58/290>
Trace; c0122a8a <do_brk+aa/160>
Trace; c0121c6b <sys_brk+bb/e0>
Trace; c0109040 <error_code+34/3c>
Code;  c012b46d <rmqueue+6d/260>
00000000 <_EIP>:
Code;  c012b46d <rmqueue+6d/260>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012b46f <rmqueue+6f/260>
   2:   83 c4 0c                  addl   $0xc,%esp
Code;  c012b472 <rmqueue+72/260>
   5:   89 f6                     movl   %esi,%esi
Code;  c012b474 <rmqueue+74/260>
   7:   8b 53 04                  movl   0x4(%ebx),%edx
Code;  c012b477 <rmqueue+77/260>
   a:   8b 03                     movl   (%ebx),%eax
Code;  c012b479 <rmqueue+79/260>
   c:   89 50 04                  movl   %edx,0x4(%eax)
Code;  c012b47c <rmqueue+7c/260>
   f:   89 02                     movl   %eax,(%edx)
Code;  c012b47e <rmqueue+7e/260>
  11:   89 5c 24 00               movl   %ebx,0x0(%esp,1)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
c012a6c9
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012a6c9>]
EFLAGS: 00010282
eax: c02486a8   ebx: c12bc6e4   ecx: 00000001   edx: 00000000
esi: c12bc6c8   edi: 00000015   ebp: 00000000   esp: c147ffc8
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 3, stackpage=c147f000)
Stack: 00010f00 c01c6631 c147e239 0008e000 c012aaf6 00000006 00000000 c1449fbc 
       c0105000 ffffff9c c01074f3 00000000 c022c48c c01fbfc4 
Call Trace: [<c012aaf6>] [<c0105000>] [<c01074f3>] 
Code: 89 02 ff 0d b4 84 24 c0 e9 96 00 00 00 89 f6 b8 02 00 00 00 

>>EIP; c012a6c9 <refill_inactive_scan+49/100>   <=====
Trace; c012aaf6 <kswapd+96/140>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c01074f3 <kernel_thread+23/30>
Code;  c012a6c9 <refill_inactive_scan+49/100>
00000000 <_EIP>:
Code;  c012a6c9 <refill_inactive_scan+49/100>   <=====
   0:   89 02                     movl   %eax,(%edx)   <=====
Code;  c012a6cb <refill_inactive_scan+4b/100>
   2:   ff 0d b4 84 24 c0         decl   0xc02484b4
Code;  c012a6d1 <refill_inactive_scan+51/100>
   8:   e9 96 00 00 00            jmp    a3 <_EIP+0xa3> c012a76c <refill_inactive_scan+ec/100>
Code;  c012a6d6 <refill_inactive_scan+56/100>
   d:   89 f6                     movl   %esi,%esi
Code;  c012a6d8 <refill_inactive_scan+58/100>
   f:   b8 02 00 00 00            movl   $0x2,%eax

Unable to handle kernel NULL pointer dereference at virtual address 00000018
c0122f07
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0122f07>]
EFLAGS: 00010246
eax: 00000000   ebx: c12bd344   ecx: 00000001   edx: 00000001
esi: 00000000   edi: ca13d9a4   ebp: 00000000   esp: cd2fbef4
ds: 0018   es: 0018   ss: 0018
Process rm (pid: 22364, stackpage=cd2fb000)
Stack: c12bd344 c0122f6a c12bd344 c12bd344 c0123188 c12bd344 cd2fbf44 ca13d9ac 
       ca13d9a4 ca13d9b4 cc65acc0 c12bd344 cd2fbf44 c012325f ca13d900 c01f0240 
       cc63f3c0 cc6450b0 00000000 ca13d9ac 00000000 c0143e40 ca13d9a4 00000000 
Call Trace: [<c0122f6a>] [<c0123188>] [<c012325f>] [<c0143e40>] [<c014292e>] [<c013c2ce>] [<c013c3a5>] 
       [<c0108f27>] 
Code: ff 48 18 8b 53 04 8b 03 89 50 04 89 02 c7 43 08 00 00 00 00 

>>EIP; c0122f07 <__remove_inode_page+27/60>   <=====
Trace; c0122f6a <remove_inode_page+2a/30>
Trace; c0123188 <truncate_list_pages+128/1b0>
Trace; c012325f <truncate_inode_pages+4f/80>
Trace; c0143e40 <iput+90/150>
Trace; c014292e <d_delete+4e/70>
Trace; c013c2ce <vfs_unlink+fe/130>
Trace; c013c3a5 <sys_unlink+a5/120>
Trace; c0108f27 <system_call+33/38>
Code;  c0122f07 <__remove_inode_page+27/60>
00000000 <_EIP>:
Code;  c0122f07 <__remove_inode_page+27/60>   <=====
   0:   ff 48 18                  decl   0x18(%eax)   <=====
Code;  c0122f0a <__remove_inode_page+2a/60>
   3:   8b 53 04                  movl   0x4(%ebx),%edx
Code;  c0122f0d <__remove_inode_page+2d/60>
   6:   8b 03                     movl   (%ebx),%eax
Code;  c0122f0f <__remove_inode_page+2f/60>
   8:   89 50 04                  movl   %edx,0x4(%eax)
Code;  c0122f12 <__remove_inode_page+32/60>
   b:   89 02                     movl   %eax,(%edx)
Code;  c0122f14 <__remove_inode_page+34/60>
   d:   c7 43 08 00 00 00 00      movl   $0x0,0x8(%ebx)


--ELM979998438-198-0_--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
