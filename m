Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276266AbRI1Tmt>; Fri, 28 Sep 2001 15:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276263AbRI1Tma>; Fri, 28 Sep 2001 15:42:30 -0400
Received: from ct786287-a.lafayt1.in.home.com ([24.253.106.47]:5760 "EHLO
	blorp.plorb.com") by vger.kernel.org with ESMTP id <S276261AbRI1TmW>;
	Fri, 28 Sep 2001 15:42:22 -0400
Date: Fri, 28 Sep 2001 14:42:46 -0500 (EST)
From: Jeff DeFouw <defouwj@purdue.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.10 oops through usb-uhci
Message-ID: <Pine.LNX.4.21.0109281436100.961-100000@blorp.plorb.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guaranteed oops in 2.4.10 every time I try to access my ov511 usb
webcam.  I copied down the Oops message with paper and pen, hopefully
there aren't any errors.

ksymoops 2.4.3 on i686 2.4.10.

Unable to handle kernel paging request at virtual address ffffffdc
d08c6bf2
*pde = 00003063
Oops: 0000
CPU: 1
EIP: 0010:[<d08c6bf2>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: cf61a120 ebx: cff36ca0 ecx: 00000040 edx: 00000000
esi: 00000000 edi: ffffffd8 edp: 00000000 esp: c140beb8
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 0, stackpage=c140b000)
Stack: cff368a8 cff369a0 00000000 cff36ca0 00000010 cff369fc c01e970e 00000000
       cf61a120 00000000 00000001 008c6f69 cff36ca0 cff369a0 00000000 cff368a8
       cff36ea0 00000000 00000000 cff67a40 0138e040 c01e9b1d 00000000 a08c72ca
Call Trace: [<c01e970e>] [<d08c6f69>] [<c01e9b1d>] [<d08c72ca>] [<c0108a65>]
   [<c01059ec>] [<c01059ec>] [<c010aef8>] [<c01059ec>] [<c01059ec>] [<c0105a18>]
   [<c0105912>] [<c0117954>]
Code: 8b 42 dc a9 00 00 80 00 0f 84 e0 00 00 00 25 ff ff 7f ff 89

>>EIP; d08c6bf2 <[usb-uhci]process_iso+7e/38c>   <=====
Trace; c01e970e <start_request+272/3e4>
Trace; d08c6f68 <[usb-uhci]process_urb+68/2ec>
Trace; c01e9b1c <ide_do_request+29c/2f4>
Trace; d08c72ca <[usb-uhci]uhci_interrupt+de/1a4>
Trace; c0108a64 <do_IRQ+f0/16c>
Trace; c01059ec <default_idle+0/38>
Trace; c01059ec <default_idle+0/38>
Trace; c010aef8 <call_do_IRQ+6/e>
Trace; c01059ec <default_idle+0/38>
Trace; c01059ec <default_idle+0/38>
Trace; c0105a18 <default_idle+2c/38>
Trace; c0105912 <cpu_idle+42/58>
Trace; c0117954 <printk+270/28c>
Code;  d08c6bf2 <[usb-uhci]process_iso+7e/38c>
00000000 <_EIP>:
Code;  d08c6bf2 <[usb-uhci]process_iso+7e/38c>   <=====
   0:   8b 42 dc                  mov    0xffffffdc(%edx),%eax   <=====
Code;  d08c6bf4 <[usb-uhci]process_iso+80/38c>
   3:   a9 00 00 80 00            test   $0x800000,%eax
Code;  d08c6bfa <[usb-uhci]process_iso+86/38c>
   8:   0f 84 e0 00 00 00         je     ee <_EIP+0xee> d08c6ce0 <[usb-uhci]process_iso+16c/38c>
Code;  d08c6c00 <[usb-uhci]process_iso+8c/38c>
   e:   25 ff ff 7f ff            and    $0xff7fffff,%eax
Code;  d08c6c04 <[usb-uhci]process_iso+90/38c>
  13:   89 00                     mov    %eax,(%eax)

--
Jeff DeFouw <defouwj@purdue.edu>

