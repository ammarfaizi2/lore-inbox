Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129106AbRBNAHP>; Tue, 13 Feb 2001 19:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129225AbRBNAHF>; Tue, 13 Feb 2001 19:07:05 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:16915 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S129106AbRBNAGw>;
	Tue, 13 Feb 2001 19:06:52 -0500
Envelope-To: <linux-kernel@vger.kernel.org>
Date: Wed, 14 Feb 2001 00:08:40 GMT
From: James Stevenson <mistral@stev.org>
Message-Id: <200102140008.f1E08e819089@stev.org>
To: linux-kernel@vger.kernel.org
Subject: [OPPS] 2.2.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 

Linux version 2.2.18
(gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release))

i got

Unable to handle kernel paging request at virtual address 74723e0a
current->tss.cr3 = 0353d000, %cr3 = 0353d000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0121c2e>]
EFLAGS: 00010816
eax: 00000000   ebx: 00000001   ecx: 00000000   edx: 00000000
esi: c0230940   edi: 00000286   ebp: 74723e0a   esp: c54a3f70
ds: 0018   es: 0018   ss: 0018
Process find (pid: 5346, process nr: 52, stackpage=c54a3000)
Stack: 0805ba70 0805ba84 00000000 00000000 00000202 00000000 c012b409 c54a2000 
       bffff980 0805ba70 bffff8b8 c012b974 0805ba84 c54a2000 bffff980 c0129a4e 
       0805ba84 00000000 c54a2000 bffff980 c0109374 0805ba84 bffff860 0805770c 
Call Trace: [<c012b409>] [<c012b974>] [<c0129a4e>] [<c0109374>] 
Code: 8b 45 00 89 06 89 70 04 89 e8 2b 05 4c 66 20 c0 8d 04 40 89 


ksymoops 2.3.4 on i686 2.2.18.  Options used
     -v /home/mistral/data/kernels/P200/vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.2.18/ (default)
     -m /boot/System.map (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 74723e0a
current->tss.cr3 = 0353d000, %cr3 = 0353d000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0121c2e>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010816
eax: 00000000   ebx: 00000001   ecx: 00000000   edx: 00000000
esi: c0230940   edi: 00000286   ebp: 74723e0a   esp: c54a3f70
ds: 0018   es: 0018   ss: 0018
Process find (pid: 5346, process nr: 52, stackpage=c54a3000)
Stack: 0805ba70 0805ba84 00000000 00000000 00000202 00000000 c012b409 c54a2000 
       bffff980 0805ba70 bffff8b8 c012b974 0805ba84 c54a2000 bffff980 c0129a4e 
       0805ba84 00000000 c54a2000 bffff980 c0109374 0805ba84 bffff860 0805770c 
Call Trace: [<c012b409>] [<c012b974>] [<c0129a4e>] [<c0109374>] 
Code: 8b 45 00 89 06 89 70 04 89 e8 2b 05 4c 66 20 c0 8d 04 40 89 

>>EIP; c0121c2e <__get_free_pages+102/2b4>   <=====
Trace; c012b409 <getname+19/94>
Trace; c012b974 <__namei+c/58>
Trace; c0129a4e <sys_newlstat+e/60>
Trace; c0109374 <system_call+34/38>
Code;  c0121c2e <__get_free_pages+102/2b4>
00000000 <_EIP>:
Code;  c0121c2e <__get_free_pages+102/2b4>   <=====
   0:   8b 45 00                  mov    0x0(%ebp),%eax   <=====
Code;  c0121c31 <__get_free_pages+105/2b4>
   3:   89 06                     mov    %eax,(%esi)
Code;  c0121c33 <__get_free_pages+107/2b4>
   5:   89 70 04                  mov    %esi,0x4(%eax)
Code;  c0121c36 <__get_free_pages+10a/2b4>
   8:   89 e8                     mov    %ebp,%eax
Code;  c0121c38 <__get_free_pages+10c/2b4>
   a:   2b 05 4c 66 20 c0         sub    0xc020664c,%eax
Code;  c0121c3e <__get_free_pages+112/2b4>
  10:   8d 04 40                  lea    (%eax,%eax,2),%eax
Code;  c0121c41 <__get_free_pages+115/2b4>
  13:   89 00                     mov    %eax,(%eax)

