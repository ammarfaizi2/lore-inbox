Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQL1Nvw>; Thu, 28 Dec 2000 08:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129568AbQL1Nvn>; Thu, 28 Dec 2000 08:51:43 -0500
Received: from server0011.freedom2surf.net ([194.106.56.14]:8544 "EHLO
	server0011.freedom2surf.net") by vger.kernel.org with ESMTP
	id <S129228AbQL1Nv3>; Thu, 28 Dec 2000 08:51:29 -0500
From: chris@freedom2surf.net
To: linux-kernel@vger.kernel.org
Subject: Repeatable Oops in 2.4t13p4ac2
Message-ID: <978009656.3a4b3e38c7455@www.freedom2surf.net>
Date: Thu, 28 Dec 2000 13:20:56 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.1
X-Originating-IP: 194.106.48.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi - we are seeing the following repeatable Oops in 2.4t13p4ac2 compiled using 
gcc 2.95.2 for PIII running on IDE disks. Occurs whilst copying lots of files 
to/from remote filesystems.

Thank you

Chris

Unable to handle kernel paging request at virtual address 00040000
c0131891
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0131891>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: d8702d80     ecx: d8702d80       edx: 00040000
esi: d8702d80   edi: d8702d80     ebp: 00000003       esp: c1893f88
ds: 0018        es: 0018       ss: 0018
Process bdflush (pid: 5, stackpage=c1893000)
Stack: c01344e3 d8702d80 c167db44 c167db60 00000000 0001bbca 00000018 00000000
       c0129918 c167db44 00000000 c1892000 0000005a c1892332 0008e000 00000000
       00000000 00000000 00000016 00000000 c0134ad4 00000003 00000000 00010f00
Call Trace: [<c01344e3>] [<c0129918>] [<c0134ad4>] [<c0107480>]
Code: 89 02 c7 41 30 00 00 00 00 0f b7 41 0a 50 51 e8 0f ff ff ff

>>EIP; c0131891 <__remove_from_queues+19/34>   <=====
Trace; c01344e3 <try_to_free_buffers+b3/1e0>
Trace; c0129918 <page_launder+3a8/8bc>
Trace; c0134ad4 <bdflush+94/e8>
Trace; c0107480 <kernel_thread+28/38>
Code;  c0131891 <__remove_from_queues+19/34>
00000000 <_EIP>:
Code;  c0131891 <__remove_from_queues+19/34>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c0131893 <__remove_from_queues+1b/34>
   2:   c7 41 30 00 00 00 00      movl   $0x0,0x30(%ecx)
Code;  c013189a <__remove_from_queues+22/34>
   9:   0f b7 41 0a               movzwl 0xa(%ecx),%eax
Code;  c013189e <__remove_from_queues+26/34>
   d:   50                        push   %eax
Code;  c013189f <__remove_from_queues+27/34>
   e:   51                        push   %ecx
Code;  c01318a0 <__remove_from_queues+28/34>
   f:   e8 0f ff ff ff            call   ffffff23 <_EIP+0xffffff23> c01317b4 
<__remove_from_lru_list+0/68>



-------------------------------------------------
Everyone should have http://www.freedom2surf.net/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
