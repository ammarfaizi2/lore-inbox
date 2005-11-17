Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbVKQQeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbVKQQeE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 11:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbVKQQeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 11:34:04 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:37595 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932409AbVKQQeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 11:34:03 -0500
Date: Thu, 17 Nov 2005 22:11:55 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, david singleton <dsingleton@mvista.com>
Subject: Re: PI BUG with -rt13
Message-ID: <20051117164155.GA3974@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20051117161817.GA3935@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117161817.GA3935@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I also get this sometimes when running the same test

	-Dinakar

BUG: Unable to handle kernel NULL pointer dereference at virtual address 00000286
 printing eip:
c012220c
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP
Modules linked in:
CPU:    3
EIP:    0060:[<c012220c>]    Not tainted VLI
EFLAGS: 00010287   (2.6.14-rt13)
EIP is at run_timer_softirq+0x174/0x385
eax: 00000282   ebx: 00000282   ecx: f63bde54   edx: f7f33f70
esi: c3070fe8   edi: 00000000   ebp: c3070fe0   esp: f7f33f58
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process softirq-timer/3 (pid: 31, threadinfo=f7f32000 task=f7f268d0 stack_left=7972 worst_left=-1)
Stack: c3070fe0 c3071840 0000000f f7f32000 c307100c f7f32000 f63bde54 f63c1e54
       0000007b f7f32000 f7f32000 c04a3380 f7f32000 c011e70a c0450788 00000001
       f7f33fa8 fffffffd c04a3380 00000002 00000001 f7f32000 f7f4bedc c3070f8c
Call Trace:
 [<c011e70a>] ksoftirqd+0xea/0x160 (56)
 [<c011e620>] ksoftirqd+0x0/0x160 (44)
 [<c012cda1>] kthread+0xa3/0xcd (4)
 [<c012ccfe>] kthread+0x0/0xcd (28)
 [<c0100ebd>] kernel_thread_helper+0x5/0xb (16)
Code: 04 8b 44 24 18 8d 7c 24 18 89 79 04 89 4c 24 18 89 50 04 89 02 89 5b 04 89 5e 60 eb 7f 8b 59 14 8b 79 10 89 4d 28 8b 51
 <0>Fatal exception: panic in 5 seconds


