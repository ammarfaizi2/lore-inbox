Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282702AbRLOPI6>; Sat, 15 Dec 2001 10:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282728AbRLOPIt>; Sat, 15 Dec 2001 10:08:49 -0500
Received: from f62.law7.hotmail.com ([216.33.237.62]:8205 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S282702AbRLOPIj>;
	Sat, 15 Dec 2001 10:08:39 -0500
X-Originating-IP: [216.117.88.41]
From: "Edward Killips" <etkillips@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Netfilter Oops more info
Date: Sat, 15 Dec 2001 10:08:33 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F62gvjDrzzyCx91MjVM0000410c@hotmail.com>
X-OriginalArrivalTime: 15 Dec 2001 15:08:33.0325 (UTC) FILETIME=[5CD805D0:01C1857A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a netfilter Oops like the one below unless I comment out the follwoing 
rule.
iptables -t mangle -A PREROUTING -m multiport -p tcp --sport 80,21,23 -j TOS 
--set-tos 16

ksymoops 2.4.3 on i586 2.4.17-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-rc1/ (default)
     -m /boot/System.map (specified)

c0216e84
*pde = 00000000
Oops:  0000
CPU: 0
EIP: 0010:[c0216e84>] Not tainted
EFLAGS: 00010202
eax: 00000000 ebx: 5a5a5a5a ecx: 00000000 eds: 00000010
esi: 00000010 edi: c899c53c ebp: 00000000 esp: c02bfe58
ds: 0018 es: 0018 ss: 0018
Stack: 00000000 00000000 c899c53c 00000000 c899c53c c899c53c 00000000 
c02193ca
       c899c53c 5a5a5a5a 5a5a5a5a 00000050 00000000 00000000 c02193a0 
c020f696
       c032f240 00000000 00000000 00000000 c02193a0 c020f6c8 c899c53c 
00000000
Call Trace: [<c02193ca>] [<c02193a0>] [<c020f696>] [<c01293a0>] [<c020f6c8>]
[<c01291f9>] [<c02193a0>] [<d88919e9>] [<c020a1d8>] [<c011902b>] 
[<co118f40>]
[<c0118d6c>] [<c0108681>] [<c01053c0>] [<c01053c0>] [<c01053e3>] 
[<c010544e>]
[<c0105000>]
Code: 8b 78 3c 89 d8 89 da 25 f0 f0 f0 f0 81 e2 0f 0f 0f 0f c1 e8
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; c02193ca <ip_rcv_finish+2a/1e0>
Trace; c02193a0 <ip_rcv_finish+0/1e0>
Trace; c020f696 <nf_hook_slow+b6/140>
Trace; c01293a0 <kmem_cache_destroy+20/e0>
Trace; c020f6c8 <nf_hook_slow+e8/140>
Trace; c01291f8 <kmem_cache_create+308/3b0>
Trace; c02193a0 <ip_rcv_finish+0/1e0>
Trace; d88919e8 <[lt_modem]UART_CopyDteTxData+44/dc>
Trace; c020a1d8 <net_rx_action+138/210>
Trace; c011902a <bh_action+1a/40>
Trace; c0118d6c <do_softirq+4c/90>
Trace; c0108680 <do_IRQ+90/a0>
Trace; c01053c0 <default_idle+0/30>
Trace; c01053c0 <default_idle+0/30>
Trace; c01053e2 <default_idle+22/30>
Trace; c010544e <cpu_idle+3e/60>
Trace; c0105000 <_stext+0/0>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 78 3c                  mov    0x3c(%eax),%edi
Code;  00000002 Before first symbol
   3:   89 d8                     mov    %ebx,%eax
Code;  00000004 Before first symbol
   5:   89 da                     mov    %ebx,%edx
Code;  00000006 Before first symbol
   7:   25 f0 f0 f0 f0            and    $0xf0f0f0f0,%eax
Code;  0000000c Before first symbol
   c:   81 e2 0f 0f 0f 0f         and    $0xf0f0f0f,%edx
Code;  00000012 Before first symbol
  12:   c1 e8 00                  shr    $0x0,%eax

<0>Kernel panic: Aiee, killing interrupt handler!


_________________________________________________________________
Join the world’s largest e-mail service with MSN Hotmail. 
http://www.hotmail.com

