Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTEUOdA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 10:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbTEUOdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 10:33:00 -0400
Received: from pcp02462394pcs.chrchv01.md.comcast.net ([68.33.20.149]:52230
	"EHLO mail.jettisonnetworks.com") by vger.kernel.org with ESMTP
	id S262115AbTEUOc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 10:32:58 -0400
From: "David Lewis" <dlewis@vnxsolutions.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Erin Britz" <ebritz@vnxsolutions.com>
Subject: [OOPS] kswapd 2.4.20
Date: Wed, 21 May 2003 10:45:54 -0400
Message-ID: <EMEOIBCHEHCPNABJGHGOCEJBCNAA.dlewis@vnxsolutions.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 1 (Highest)
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: High
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fourth one sent to list.. Please advise if any other information is needed.
A reply would be appreciated even if it is to say that this is the wrong
place.

May 21 03:23:50 nicebox kernel: Unable to handle kernel paging request at
virtual address 938a909e
May 21 03:23:50 nicebox kernel: c013670c
May 21 03:23:50 nicebox kernel: *pde = 00000000
May 21 03:23:50 nicebox kernel: Oops: 0002
May 21 03:23:50 nicebox kernel: CPU:    1
May 21 03:23:50 nicebox kernel: EIP:    0010:[<c013670c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
May 21 03:23:50 nicebox kernel: EFLAGS: 00210046
May 21 03:23:50 nicebox kernel: eax: 938a909a   ebx: d7d0b000   ecx:
0000000a   edx: da851000
May 21 03:23:50 nicebox kernel: esi: c1577268   edi: c1577268   ebp:
00000954   esp: df6d5f08
May 21 03:23:50 nicebox kernel: ds: 0018   es: 0018   ss: 0018
May 21 03:23:50 nicebox kernel: Process kswapd (pid: 5, stackpage=df6d5000)
May 21 03:23:50 nicebox kernel: Stack: 0000003d df6df304 c01359b2 c1577268
d7d0b600 df6df000 00200292 da687900
May 21 03:23:50 nicebox kernel:        c0135a94 c1577268 df6df200 0000007e
c602ab80 c67f8100 c602ab80 c015507a
May 21 03:23:50 nicebox kernel:        c1577268 c602ab80 0000000c 000001d0
00000020 00000006 c0155444 0000169c
May 21 03:23:50 nicebox kernel: Call Trace:    [<c01359b2>] [<c0135a94>]
[<c015507a>] [<c0155444>] [<c01370a7>]
May 21 03:23:50 nicebox kernel:   [<c0137106>] [<c013721c>] [<c0137298>]
[<c01373cd>] [<c0105000>] [<c01058ce>]
May 21 03:23:50 nicebox kernel:   [<c0137330>]
May 21 03:23:50 nicebox kernel: Code: 89 50 04 8b 46 08 8d 56 08 89 58 04 89
03 89 53 04 89 5e 08


>>EIP; c013670c <kmem_cache_free_one+6c/a5>   <=====

>>eax; 938a909a Before first symbol
>>ebx; d7d0b000 <_end+179a4a28/1fea4a88>
>>edx; da851000 <_end+1a4eaa28/1fea4a88>
>>esi; c1577268 <_end+1210c90/1fea4a88>
>>edi; c1577268 <_end+1210c90/1fea4a88>
>>ebp; 00000954 Before first symbol
>>esp; df6d5f08 <_end+1f36f930/1fea4a88>

Trace; c01359b2 <free_block+32/50>
Trace; c0135a94 <kmem_cache_free+64/90>
Trace; c015507a <prune_dcache+10a/1a0>
Trace; c0155444 <shrink_dcache_memory+24/40>
Trace; c01370a7 <shrink_caches+77/a0>
Trace; c0137106 <try_to_free_pages_zone+36/50>
Trace; c013721c <kswapd_balance_pgdat+5c/b0>
Trace; c0137298 <kswapd_balance+28/40>
Trace; c01373cd <kswapd+9d/c0>
Trace; c0105000 <_stext+0/0>
Trace; c01058ce <kernel_thread+2e/40>
Trace; c0137330 <kswapd+0/c0>

Code;  c013670c <kmem_cache_free_one+6c/a5>
00000000 <_EIP>:
Code;  c013670c <kmem_cache_free_one+6c/a5>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c013670f <kmem_cache_free_one+6f/a5>
   3:   8b 46 08                  mov    0x8(%esi),%eax
Code;  c0136712 <kmem_cache_free_one+72/a5>
   6:   8d 56 08                  lea    0x8(%esi),%edx
Code;  c0136715 <kmem_cache_free_one+75/a5>
   9:   89 58 04                  mov    %ebx,0x4(%eax)
Code;  c0136718 <kmem_cache_free_one+78/a5>
   c:   89 03                     mov    %eax,(%ebx)
Code;  c013671a <kmem_cache_free_one+7a/a5>
   e:   89 53 04                  mov    %edx,0x4(%ebx)
Code;  c013671d <kmem_cache_free_one+7d/a5>
  11:   89 5e 08                  mov    %ebx,0x8(%esi)

David Lewis
Senior Security Engineer
VNX Solutions, Inc
dlewis@vnxsolutions.com
410-459-7428 Cell


