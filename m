Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265815AbSKOFvD>; Fri, 15 Nov 2002 00:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbSKOFvD>; Fri, 15 Nov 2002 00:51:03 -0500
Received: from mail1.csc.albany.edu ([169.226.1.133]:30867 "EHLO
	smtp.albany.edu") by vger.kernel.org with ESMTP id <S265815AbSKOFvC> convert rfc822-to-8bit;
	Fri, 15 Nov 2002 00:51:02 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Justin A <ja6447@albany.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.5.47-ac4 panic on boot.
Date: Fri, 15 Nov 2002 00:59:51 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211150059.51743.ja6447@albany.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My thinkpad 760e starts to boot but panics while running depmod -a:
(unfortunately the top is cut off...it doesn't fit:))

...
CPU:	0
EIP:	0060:[<c012b914>]	Not tainted
EFLAGS: 00010006
EIP is at reap_timer_fnc+0x104/0x40c
eax: 00000002	ebx: c47ffab4	ecx: c47fe8a0	edx: 00000003
esi: 00000002	edi: c4742414	ebp: c47ffa98	esp: c031df8c
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 0, threadinfo=c031c000 task=c02da3e0)
Stack: same as call trace...

Call trace:
 [<c012b810>] reap_timer_fnc+0x0/0x40c
 [<c011ae47>] run_timer_tasklet+0xb7/0xe8
 [<c0117f39>] tasklet_hi_action+0x3d/0x60
 [<c0117d5a>] do_softirq+0x5a/0xac
 [<c010a268>] do_IRQ+0xc8/0xd4
 [<c0105000>] stext+0x0/0x1c
 [<c0108b03>] common_interrupt+0x43/x060

Code: 0f 0b fb 07 a8 fe 21 c0 8d 74 26 00 8b 41 04 8b 11 89 42 04

I tried it a few times...the last few change, but its always in 
reap_timer_fnc.

I haven't tried any other 2.5 kernels, but 2.4.18/19 work.
-- 
-Justin

