Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268884AbUJEIhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268884AbUJEIhQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 04:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268878AbUJEIhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 04:37:16 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:60086 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S268889AbUJEIg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 04:36:59 -0400
Message-Id: <200410050836.i958atFM000889@rumms.uni-mannheim.de>
Date: Tue, 5 Oct 2004 10:36:19 +0200
From: Matthias Bernges <mbernges@rumms.uni-mannheim.de>
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.6.x maybe r8169
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

since I use the Realtek 8169 Network card I get a kernel Oops
after which the kernel hangs completly.
I tried Kernel 2.6.6, 2.6.7 and 2.6.8.1. It appears randomly but
only if the machine has high load and high network traffic.
I've attached the output of the Oops with Kernel 2.6.8.1 (using
ksymoops) with kernel 2.6.7 I don't get a oops the PC just hangs.
2.6.6 gives me a veery long output which I can't catch (completly)
because I don't have a null modem cable.



Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0271498>]    Not tainted
EFLAGS: 00010206    (2.6.8.1)
eax: 20000100   ebx: 0002bc49   ecx: 00000090   edx: 0000003c
esi: 00000000   edi: c15eb220   ebp: 00000009   esp: c0497f80
ds: 007b   es: 007b  ss: 0068
Stack: dff2c800 c15eb3d0 decde080 00000202 decde000 fffd4440 00000004
e0807e00       00000014 c0497000 c0271901 c15eb000 c15eb220 e0807e00
00000001 c15eb220       deceb460 04000001 00000000 df3af8d4 c0105a3a
00000005 c15eb000 df3af8d4 Call Trace:
Code: 8b 46 60 ba 3c 00 00 00 83 f8 3b 0f 46 c2 ff 47 0c 01 47 14


>>EIP; c0271498 <SELECT_DRIVE+18/50>   <=====

>>edi; c15eb220 <pg0+113d220/3fb50000>
>>esp; c0497f80 <per_cpu__tvec_bases+ec0/1008>

Code;  c0271498 <SELECT_DRIVE+18/50>
00000000 <_EIP>:
Code;  c0271498 <SELECT_DRIVE+18/50>   <=====
   0:   8b 46 60                  mov    0x60(%esi),%eax   <=====
Code;  c027149b <SELECT_DRIVE+1b/50>
   3:   ba 3c 00 00 00            mov    $0x3c,%edx
Code;  c02714a0 <SELECT_DRIVE+20/50>
   8:   83 f8 3b                  cmp    $0x3b,%eax
Code;  c02714a3 <SELECT_DRIVE+23/50>
   b:   0f 46 c2                  cmovbe %edx,%eax
Code;  c02714a6 <SELECT_DRIVE+26/50>
   e:   ff 47 0c                  incl   0xc(%edi)
Code;  c02714a9 <SELECT_DRIVE+29/50>
  11:   01 47 14                  add    %eax,0x14(%edi)

<0>Kernel panic: Fatal exception in interrupt
