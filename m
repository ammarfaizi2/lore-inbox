Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311599AbSCTNpD>; Wed, 20 Mar 2002 08:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311600AbSCTNo4>; Wed, 20 Mar 2002 08:44:56 -0500
Received: from web12905.mail.yahoo.com ([216.136.174.72]:8369 "HELO
	web12905.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S311599AbSCTNod>; Wed, 20 Mar 2002 08:44:33 -0500
Message-ID: <20020320134432.49401.qmail@web12905.mail.yahoo.com>
Date: Wed, 20 Mar 2002 14:44:32 +0100 (CET)
From: =?iso-8859-1?q?Jim=20MacBaine?= <jmacbaine@yahoo.de>
Subject: [OOPS] 2.4.19-pre2-ac4 possibly kswapd
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello everybody, 

I got the following oops under X. The machine froze
completely, neither SYSRQ nor remote login worked.

This box is a P3-866 VIA chipset, 768MB RAM+1,5GB
SWAP running 2.4.19-pre2-ac4+loop_aes+alsa. At the
time it oopsed almost no swap was in use.

Regards, 
Jim MacBaine

ksymoopsed oops follows: 

Mar 20 13:19:57 leonov kernel: invalid operand: 0000
Mar 20 13:19:57 leonov kernel: CPU:    0
Mar 20 13:19:57 leonov kernel: EIP:   
0010:[<c012b1d2>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Mar 20 13:19:57 leonov kernel: EFLAGS: 00210286
Mar 20 13:19:57 leonov kernel: eax: 0100000d   ebx:
c186fd80   ecx: c0210cbc   edx: c0210b60
Mar 20 13:19:57 leonov kernel: esi: 00000000   edi:
c0210ce4   ebp: 000001e3   esp: c19fff64
Mar 20 13:19:57 leonov kernel: ds: 0018   es: 0018  
ss: 0018
Mar 20 13:19:57 leonov kernel: Process kswapd (pid: 5,
stackpage=c19ff000)
Mar 20 13:19:57 leonov kernel: Stack: c186fd80
c186fd9c c0210ce4 000001e3 c0134cdb c186fd80 00000030
c0210ce4 
Mar 20 13:19:57 leonov kernel:        000001e3
c01332c7 c186fd80 00000030 c186fd80 c012ba03 c01292b8
c186fd80 
Mar 20 13:19:57 leonov kernel:        00000030
c186fd80 c186fd9c c012a323 00008882 c0210cbc 00002d29
0008e000 
Mar 20 13:19:57 leonov kernel: Call Trace:
[<c0134cdb>] [<c01332c7>] [<c012ba03>] [<c01292b8>]
[<c012a323>] 
Mar 20 13:19:57 leonov kernel:    [<c012ac0a>]
[<c01057af>] [<c01057b8>] 
Mar 20 13:19:57 leonov kernel: Code: 0f 0b 89 d8 2b 05
ec 67 26 c0 69 c0 c5 4e ec c4 c1 f8 02 3b 

>>EIP; c012b1d2 <__free_pages_ok+42/22c>   <=====
Trace; c0134cdb <try_to_free_buffers+87/d4>
Trace; c01332c7 <try_to_release_page+3f/48>
Trace; c012ba03 <__free_pages+1b/1c>
Trace; c01292b8 <drop_page+30/1a4>
Trace; c012a323 <refill_inactive_zone+1df/290>
Trace; c012ac0a <kswapd+262/2a8>
Trace; c01057af <kernel_thread+1f/38>
Trace; c01057b8 <kernel_thread+28/38>
Code;  c012b1d2 <__free_pages_ok+42/22c>
00000000 <_EIP>:
Code;  c012b1d2 <__free_pages_ok+42/22c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012b1d4 <__free_pages_ok+44/22c>
   2:   89 d8                     mov    %ebx,%eax
Code;  c012b1d6 <__free_pages_ok+46/22c>
   4:   2b 05 ec 67 26 c0         sub   
0xc02667ec,%eax
Code;  c012b1dc <__free_pages_ok+4c/22c>
   a:   69 c0 c5 4e ec c4         imul  
$0xc4ec4ec5,%eax,%eax
Code;  c012b1e2 <__free_pages_ok+52/22c>
  10:   c1 f8 02                  sar    $0x2,%eax
Code;  c012b1e5 <__free_pages_ok+55/22c>
  13:   3b 00                     cmp    (%eax),%eax



__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Ihre E-Mail noch individueller? - http://domains.yahoo.de
