Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267751AbUBTJSZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 04:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267748AbUBTJSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 04:18:25 -0500
Received: from [194.243.27.136] ([194.243.27.136]:52492 "HELO
	venere.pandoraonline.it") by vger.kernel.org with SMTP
	id S267751AbUBTJSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 04:18:22 -0500
Subject: Again oops with kernel 2.4.22
From: Carlo <devel@integra-sc.it>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077268506.6151.8.camel@atena>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 20 Feb 2004 10:15:20 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
on my Red HAt 7.3 kernel 2.4.22 I received another Oops with an anxious
prhase: kernel BUG at dcache.c:345! . I passed it throw ksymoops and
this is the resul:


Feb 19 19:38:39 webeye kernel: kernel BUG at dcache.c:345!
Feb 19 19:38:39 webeye kernel: invalid operand: 0000
Feb 19 19:38:39 webeye kernel: CPU:    0
Feb 19 19:38:39 webeye kernel: EIP:    0010:[<c014626d>]    Not tainted
Feb 19 19:38:39 webeye kernel: EFLAGS: 00010286
Feb 19 19:38:39 webeye kernel: eax: c57ea2e8   ebx: ca2c48d8   ecx:
c720b000   edx: c720bf58
Feb 19 19:38:39 webeye kernel: esi: ca2c48c0   edi: c12c5f18   ebp:
00001e67   esp: cff2ff30
Feb 19 19:38:39 webeye kernel: ds: 0018   es: 0018   ss: 0018
Feb 19 19:38:39 webeye kernel: Process kswapd (pid: 4,
stackpage=cff2f000)
Feb 19 19:38:39 webeye kernel: Stack: c012e878 00000000 cff2e000
ffffffff 000001d0 c03280d0 c12c5198 cfe63e40 
Feb 19 19:38:39 webeye kernel:        00000015 000001d0 00000006
00000020 c0146610 000023de c012ea57 00000006 
Feb 19 19:38:39 webeye kernel:        000001d0 c03280d0 00000006
000001d0 c03280d0 00000000 c012eaac 00000020 
Feb 19 19:38:39 webeye kernel: Call Trace:    [<c012e878>] [<c0146610>]
[<c012ea57>] [<c012eaac>] [<c012ebbf>]
Feb 19 19:38:39 webeye kernel:   [<c012ec36>] [<c012ed71>] [<c012ecd0>]
[<c0105000>] [<c0107116>] [<c012ecd0>]
Feb 19 19:38:39 webeye kernel: Code: 0f 0b 59 01 a5 af 2d c0 8d 56 10 8b
4a 04 8b 46 10 89 48 04 

>>EIP; c014626d <prune_dcache+6d/150>   <=====
Trace; c012e878 <shrink_cache+298/310>
Trace; c0146610 <shrink_dcache_memory+20/30>
Trace; c012ea57 <shrink_caches+67/80>
Trace; c012eaac <try_to_free_pages_zone+3c/60>
Trace; c012ebbf <kswapd_balance_pgdat+4f/a0>
Trace; c012ec36 <kswapd_balance+26/40>
Trace; c012ed71 <kswapd+a1/c0>
Trace; c012ecd0 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0107116 <arch_kernel_thread+26/30>
Trace; c012ecd0 <kswapd+0/c0>
Code;  c014626d <prune_dcache+6d/150>
00000000 <_EIP>:
Code;  c014626d <prune_dcache+6d/150>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c014626f <prune_dcache+6f/150>
   2:   59                        pop    %ecx
Code;  c0146270 <prune_dcache+70/150>
   3:   01 a5 af 2d c0 8d         add    %esp,0x8dc02daf(%ebp)
Code;  c0146276 <prune_dcache+76/150>
   9:   56                        push   %esi
Code;  c0146277 <prune_dcache+77/150>
   a:   10 8b 4a 04 8b 46         adc    %cl,0x468b044a(%ebx)
Code;  c014627d <prune_dcache+7d/150>
  10:   10 89 48 04 00 00         adc    %cl,0x448(%ecx)


This is my HW:

- Biostar M7VIP-PRO Socket A ATX MB w/the KT333 Chipset
- AMD Athlon(tm) XP 2700+
- Socket A Motherboard
- VIA KT333 North Bridge
- VIA 8235 South Bridge
- 200/266/333MHz FSB
- Integrated AC'97 audio
- Integrated 10/100 Ethernet
- 10/100 Ethernet (RealTek)
- 2 Videograbber (bttv)
- VGA ATI RADEON 7000
- Maxtor 6Y120L0, ATA DISK drive

The numbers from boot are (no bios upgrade are made):
Phoenix-AwardBIOS v.6.00PG

01/17/2003-kt333cf-8235-6A6LYB09C-00

I hope this can Help.
Saluti Carlo!

