Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264602AbUBNDd2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 22:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264879AbUBNDd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 22:33:28 -0500
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:41076 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264602AbUBNDdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 22:33:20 -0500
Subject: kernel BUG at kernel/timer.c:370!
From: "Rafael D'Halleweyn (List)" <list@noduck.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1076729590.30432.4.camel@bigboy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 13 Feb 2004 22:33:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I sometimes get the following BUG (transcribed from a digital camera
snapshot, so it might contain errors). I did not copy the stack trace,
let me know if you want it.

kernel BUG at kernel/timer.c:370!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c01284f8>]    Not tainted
EFLAGS: 00010003
EIP is at cascade+0x50/0x70
eax: d0a77724   ebx: d0a77724   ecx: c04aaa28   edx: 0000001c
esi: c04aab08   edi: c04aa220   ebp: 0000001c   esp: c0457e9e
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0456000 task=c03d2de0)
Stack: ...
Call Trace:
 [<c01289e4>] update_process_times+0x44/0x50
 [<c0128b3f>] run_timer_softirq+0x12f/0x1c0
 [<c0124695>] do_softirq+0x95/0xa0
 [<c010d2fb>] do_IRQ+0xfb/0x130
 [<c010b5e8>] common_interrupt+0x18/0x20

Code: 0f 0b 72 01 92 d1 38 c0 eb d5 8d b4 26 00 00 00 00 8d bc 27
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

-- 
Rafael D'Halleweyn (List) <list@noduck.net>

