Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315540AbSEHGrX>; Wed, 8 May 2002 02:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315541AbSEHGrW>; Wed, 8 May 2002 02:47:22 -0400
Received: from mail.uklinux.net ([80.84.72.21]:10765 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S315540AbSEHGrV>;
	Wed, 8 May 2002 02:47:21 -0400
Envelope-To: <linux-kernel@vger.kernel.org>
From: Mark Hindley <mark@hindley.uklinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15576.1294.426229.887627@titan.home.hindley.uklinux.net>
Date: Tue, 7 May 2002 17:47:10 +0100 (BST)
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Oops in 2.4.17
X-Mailer: VM 6.72 under 21.1 (patch 10) "Capitol Reef" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this today with 2.4.17

I am just about to try 2.4.18. Apologies if this is a known issue.

Let me know if you want any more info. 

Mark

ksymoops 2.3.7 on i586 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /boot/System.map-2.4.17 (specified)

May  7 17:19:14 titan kernel: invalid operand: 0000
May  7 17:19:14 titan kernel: CPU:    0
May  7 17:19:15 titan kernel: EIP:    0010:[add_page_to_hash_queue+26/40]    Not tainted
May  7 17:19:15 titan kernel: EFLAGS: 00013286
May  7 17:19:15 titan kernel: eax: c106ffc0   ebx: c106ffc0   ecx: c100f140   edx: c106ffd0
May  7 17:19:15 titan kernel: esi: 00000001   edi: c1128d18   ebp: 00354d00   esp: c3099e5c
May  7 17:19:15 titan kernel: ds: 0018   es: 0018   ss: 0018
May  7 17:19:15 titan kernel: Process X (pid: 20413, stackpage=c3099000)
May  7 17:19:15 titan kernel: Stack: c011e45f 00354d00 c106ffc0 c01fada0 c0124e43 c106ffc0 c01fada0 00354d00 
May  7 17:19:15 titan kernel:        c1128d18 c106ffc0 00000000 06364a6d c0124fd7 c106ffc0 00354d00 00000000 
May  7 17:19:15 titan kernel:        00000005 00000008 c2e683c0 c011c412 00354d00 00354b00 00000000 c20ee858 
May  7 17:19:15 titan kernel: Call Trace: [add_to_page_cache_unique+95/120] [add_to_swap_cache+99/160] [read_swap_cache_async+103/160] [swapin_readahead+62/76] [do_swap_page+48/232] 
May  7 17:19:15 titan kernel: Code: 0f 0b 8d 74 26 00 ff 05 c0 ab 1f c0 c3 90 8b 4c 24 04 8b 41 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  00000006 Before first symbol
   6:   ff 05 c0 ab 1f c0         incl   0xc01fabc0
Code;  0000000c Before first symbol
   c:   c3                        ret    
Code;  0000000d Before first symbol
   d:   90                        nop    
Code;  0000000e Before first symbol
   e:   8b 4c 24 04               mov    0x4(%esp,1),%ecx
Code;  00000012 Before first symbol
  12:   8b 41 00                  mov    0x0(%ecx),%eax

