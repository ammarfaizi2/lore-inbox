Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283528AbRK3HLl>; Fri, 30 Nov 2001 02:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283529AbRK3HLc>; Fri, 30 Nov 2001 02:11:32 -0500
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:50072 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S283528AbRK3HLU>;
	Fri, 30 Nov 2001 02:11:20 -0500
Date: Thu, 29 Nov 2001 23:11:19 -0800
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: Oops: 2.4.15pre1
Message-ID: <20011129231119.A12873@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same SMP box and kernel as before.  Clean boot, no Oopses or BUG()s or
anything before.

Unable to handle kernel paging request at virtual address 8a1327f8
c012309f
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c012309f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 8a1327f8   ebx: d81fec60   ecx: d81fec60   edx: d81fec60
esi: d81fec60   edi: 00000000   ebp: 40a6d000   esp: cbecdcf0
ds: 0018   es: 0018   ss: 0018
Process httpd (pid: 19651, stackpage=cbecd000)
Stack: c3bc4e60 d81fec60 00000000 40a6d000 c0111b64 d81fec60 c3bc4e60 40a6d000 
       00000000 cbecc000 00000000 c01119ec 00000000 ca055a00 d81fec7c cbecc000 
       ca055a00 00000246 00030002 c2df4000 0000001a 00000040 00000002 ffffffff 
Call Trace: [<c0111b64>] [<c01119ec>] [<c01124c7>] [<c0106eac>] [<c0258775>] 
   [<c02285f7>] [<c021169c>] [<c0230bea>] [<c0242a26>] [<c020e575>] [<c020e8bd>] 
   [<c020e93b>] [<c0132413>] [<c010b737>] [<c0132575>] [<c0106dbb>] 
Code: 8b 10 f6 c2 81 75 2a 85 d2 75 16 50 57 56 55 53 e8 78 fe ff 
>>EIP; c012309f <handle_mm_fault+47/bc>   <=====
Trace; c0111b64 <do_page_fault+178/4b4>
Trace; c01119ec <do_page_fault+0/4b4>
Trace; c01124c7 <schedule_timeout+17/9c>
Trace; c0106eac <error_code+34/3c>
Trace; c0258775 <csum_partial_copy_generic+3d/f8>
Trace; c02285f7 <tcp_sendmsg+46b/1130>
Trace; c021169c <kfree_skbmem+c/68>
Trace; c0230bea <tcp_rcv_established+376/77c>
Trace; c0242a26 <inet_sendmsg+3a/40>
Trace; c020e575 <sock_sendmsg+69/88>
Trace; c020e8bd <sock_readv_writev+9d/a8>
Trace; c020e93b <sock_writev+37/40>
Trace; c0132413 <do_readv_writev+167/234>
Trace; c010b737 <old_mmap+11b/12c>
Trace; c0132575 <sys_writev+41/54>
Trace; c0106dbb <system_call+33/38>
Code;  c012309f <handle_mm_fault+47/bc>
00000000 <_EIP>:
Code;  c012309f <handle_mm_fault+47/bc>   <=====
   0:   8b 10                     mov    (%eax),%edx   <=====
Code;  c01230a1 <handle_mm_fault+49/bc>
   2:   f6 c2 81                  test   $0x81,%dl
Code;  c01230a4 <handle_mm_fault+4c/bc>
   5:   75 2a                     jne    31 <_EIP+0x31> c01230d0 <handle_mm_fault+78/bc>
Code;  c01230a6 <handle_mm_fault+4e/bc>
   7:   85 d2                     test   %edx,%edx
Code;  c01230a8 <handle_mm_fault+50/bc>
   9:   75 16                     jne    21 <_EIP+0x21> c01230c0 <handle_mm_fault+68/bc>
Code;  c01230aa <handle_mm_fault+52/bc>
   b:   50                        push   %eax
Code;  c01230ab <handle_mm_fault+53/bc>
   c:   57                        push   %edi
Code;  c01230ac <handle_mm_fault+54/bc>
   d:   56                        push   %esi
Code;  c01230ad <handle_mm_fault+55/bc>
   e:   55                        push   %ebp
Code;  c01230ae <handle_mm_fault+56/bc>
   f:   53                        push   %ebx
Code;  c01230af <handle_mm_fault+57/bc>
  10:   e8 78 fe ff 00            call   fffe8d <_EIP+0xfffe8d> c1122f2c <_end+da1d70/204c5ea4>

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
