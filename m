Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290573AbSAYGOR>; Fri, 25 Jan 2002 01:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290576AbSAYGOI>; Fri, 25 Jan 2002 01:14:08 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:50948 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S290573AbSAYGNy>; Fri, 25 Jan 2002 01:13:54 -0500
Subject: OOPS in 2.5.3-pre5 -- kernel BUG at slab.c:1101!  -- >>EIP;
	c012b1e6 <kmem_cache_grow+26/250>=?ISO-8859-1?Q?=A0=A0?= <=====
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 24 Jan 2002 22:12:41 -0800
Message-Id: <1011939163.1540.18.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ksymoops 2.4.3 on i686 2.5.1-pre11.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.3-pre5/ (specified)
     -m /boot/System.map-2.5.3-pre5 (specified)

No modules in ksyms, skipping objects
        16892197 for miles@megapathdsl.net; Thu, 24 Jan 2002 21:29:44 -0800
kernel BUG at slab.c:1101!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012b1e6>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001b   ebx: c13c7270   ecx: 00000001   edx: 000032fa
esi: c13c7270   edi: 000009f0   ebp: c13c7270   esp: c13d7e90
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c13d7000)
Stack: c02a35c0 0000044d 00000018 00000018 ffffff00 c01c31b3 000f4182 c01c80b1 
       00000286 c13c7270 00000246 c13c7278 c13c7270 c012b5dc c13c7270 000009f0 
       c02f9900 c0115c76 c0365bc0 00000001 00000000 c02ee3b0 000001ff 00000000 
Call Trace: [<c01c31b3>] [<c01c80b1>] [<c012b5dc>] [<c0115c76>] [<c02194db>] 
   [<c024a785>] [<c024ca12>] [<c0242066>] [<c0217f5e>] [<c0217fd7>] [<c0105000>] 
   [<c0241460>] [<c02413d0>] [<c010502b>] [<c0105000>] [<c0107246>] [<c0105020>] 
Code: 0f 0b 5a 59 f7 c7 00 10 00 00 74 0e 31 c0 83 c4 1c 5b 5e 5f 

>>EIP; c012b1e6 <kmem_cache_grow+26/250>   <=====
Trace; c01c31b2 <serial_in+12/30>
Trace; c01c80b0 <serial_console_write+1e0/1f0>
Trace; c012b5dc <kmalloc+dc/140>
Trace; c0115c76 <__call_console_drivers+46/60>
Trace; c02194da <pci_pool_create+4a/e0>
Trace; c024a784 <ohci_mem_init+44/70>
Trace; c024ca12 <ohci_start+62/110>
Trace; c0242066 <usb_hcd_pci_probe+296/400>
Trace; c0217f5e <pci_announce_device+2e/50>
Trace; c0217fd6 <pci_register_driver+56/60>
Trace; c0105000 <_stext+0/0>
Trace; c0241460 <usb_hub_init+20/70>
Trace; c02413d0 <usb_hub_thread+0/70>
Trace; c010502a <init+a/140>
Trace; c0105000 <_stext+0/0>
Trace; c0107246 <kernel_thread+26/30>
Trace; c0105020 <init+0/140>
Code;  c012b1e6 <kmem_cache_grow+26/250>
00000000 <_EIP>:
Code;  c012b1e6 <kmem_cache_grow+26/250>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012b1e8 <kmem_cache_grow+28/250>
   2:   5a                        pop    %edx
Code;  c012b1e8 <kmem_cache_grow+28/250>
   3:   59                        pop    %ecx
Code;  c012b1ea <kmem_cache_grow+2a/250>
   4:   f7 c7 00 10 00 00         test   $0x1000,%edi
Code;  c012b1f0 <kmem_cache_grow+30/250>
   a:   74 0e                     je     1a <_EIP+0x1a> c012b200 <kmem_cache_grow+40/250>
Code;  c012b1f2 <kmem_cache_grow+32/250>
   c:   31 c0                     xor    %eax,%eax
Code;  c012b1f4 <kmem_cache_grow+34/250>
   e:   83 c4 1c                  add    $0x1c,%esp
Code;  c012b1f6 <kmem_cache_grow+36/250>
  11:   5b                        pop    %ebx
Code;  c012b1f8 <kmem_cache_grow+38/250>
  12:   5e                        pop    %esi
Code;  c012b1f8 <kmem_cache_grow+38/250>
  13:   5f                        pop    %edi

 <0>Kernel panic: Attempted to kill init!

