Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbUKHNNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbUKHNNa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 08:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbUKHNNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 08:13:30 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:10909 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261578AbUKHNN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 08:13:26 -0500
From: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Organization: -ENOENT
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.20
Date: Mon, 8 Nov 2004 14:13:21 +0100
User-Agent: KMail/1.7
References: <20041020094508.GA29080@elte.hu> <20041108091619.GA9897@elte.hu> <20041108095048.GA11920@elte.hu>
In-Reply-To: <20041108095048.GA11920@elte.hu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411081413.21939.l_allegrucci@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 November 2004 10:50, you wrote:
> 
> i have released the -V0.7.20 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/

At boot time:

BUG: sleeping function called from invalid context modprobe(1782) at kernel/rt.c:1322
in_atomic():1 [00000001], irqs_disabled():1
 [dump_stack+35/48] dump_stack+0x23/0x30 (20)
 [__might_sleep+194/224] __might_sleep+0xc2/0xe0 (36)
 [__spin_lock+56/96] __spin_lock+0x38/0x60 (24)
 [_spin_lock+29/32] _spin_lock+0x1d/0x20 (16)
 [kmem_cache_alloc+71/272] kmem_cache_alloc+0x47/0x110 (32)
 [use_module+164/320] use_module+0xa4/0x140 (32)
 [resolve_symbol+171/192] resolve_symbol+0xab/0xc0 (48)
 [simplify_symbols+178/288] simplify_symbols+0xb2/0x120 (44)
 [load_module+1395/2704] load_module+0x573/0xa90 (160)
 [sys_init_module+107/576] sys_init_module+0x6b/0x240 (32)
 [syscall_call+7/11] syscall_call+0x7/0xb (-4028)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [resolve_symbol+33/192] .... resolve_symbol+0x21/0xc0
.....[simplify_symbols+178/288] ..   ( <= simplify_symbols+0xb2/0x120)
.. [print_traces+29/144] .... print_traces+0x1d/0x90
.....[dump_stack+35/48] ..   ( <= dump_stack+0x23/0x30)


-- 
I route therefore you are
