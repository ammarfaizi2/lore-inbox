Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261345AbTCOC6O>; Fri, 14 Mar 2003 21:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261347AbTCOC6O>; Fri, 14 Mar 2003 21:58:14 -0500
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:54445
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S261345AbTCOC6M>; Fri, 14 Mar 2003 21:58:12 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
Subject: Fwd: Re: [BUG][2.5.64bk4] Weird problem with 2 PCs - OUTPUT OF PANIC
Date: Fri, 14 Mar 2003 22:13:37 -0500
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200303142213.37477.spstarr@sh0n.net>
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep01-mail.bloor.is.net.cable.rogers.com from [24.114.185.204] using ID <shawn.starr@rogers.com> at Fri, 14 Mar 2003 22:08:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an ongoing conversation and finally the output of the panic.

----------  Forwarded Message  ----------

Subject: Re: [BUG][2.5.64bk4] Weird problem with 2 PCs - OUTPUT OF PANIC
Date: Friday 14 March 2003 10:07 pm
From: Shawn Starr <spstarr@sh0n.net>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>

Unable to handle kernel paging request at virtual address 6b6b6b6f
 printing eip:
c012e940
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c012e940>]    Not tainted
EFLAGS: 00010016
EIP is at run_timer_softirq+0xd0/0x3f0
eax: 6b6b6b6b   ebx: c5195150   ecx: 0000006f   edx: c0418d7c
esi: 6b6b6b6b   edi: 6b6b6b6b   ebp: c04189e0   esp: c117fe64
ds: 007b   es: 007b   ss: 0068
Process init (pid: 1, threadinfo=c117e000 task=c117c000)
Stack: c71ea660 c117fee8 c01302a8 c7efc4a0 00000096 00000011 00000011
 c117e000 c117e000 00000001 c04c5c48 fffffffd 00000046 c012965a c04c5c48
 c117e000 c117e000 00000000 c0417520 c010cd05 00000000 c117fee8 c0417520
 c7ffa8f0 Call Trace:
 [<c01302a8>] __dequeue_signal+0x108/0x180
 [<c012965a>] do_softirq+0x9a/0xa0
 [<c010cd05>] do_IRQ+0x235/0x370
 [<c010abf8>] common_interrupt+0x18/0x20
 [<c0125698>] release_task+0x108/0x1a0
[<c0127e72>] wait_task_zombie+0x142/0x1a0
 [<c01282d9>] sys_wait4+0x249/0x290
 [<c011dfa0>] default_wake_function+0x0/0x20
 [<c011dfa0>] default_wake_function+0x0/0x20
 [<c010a28b>] syscall_call+0x7/0xb

Code: 89 50 04 89 02 c7 43 30 00 00 00 00 81 3d e0 89 41 c0 3c 4b
 kernel/timer.c:295: spin_lock(kernel/timer.c:c04189e0) already locked by
kernel/timer
.c/423
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

What's also interesting is when i turned off the A7M266-D before, i got a
spurious 8259A interrupt: IRQ7 spewage, when i turned it back ON the IBM
paniced (as above).

Russel, the patch DID work but you cant use minicom under X to use sysrq (i
could use the command from the IBM console and it did dump the output over
serial so it worked).

Shawn.

-------------------------------------------------------

