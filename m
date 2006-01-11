Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161166AbWAKDJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161166AbWAKDJN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 22:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161177AbWAKDJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 22:09:13 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:56782 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161166AbWAKDJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 22:09:13 -0500
Subject: Re: 2.6.15-rt1
From: Steven Rostedt <rostedt@goodmis.org>
To: Esben Stien <b0ef@esben-stien.name>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <87hd8bk9sy.fsf@esben-stien.name>
References: <20060103094720.GA16497@elte.hu>
	 <87hd8bk9sy.fsf@esben-stien.name>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 22:09:01 -0500
Message-Id: <1136948941.6197.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 23:17 +0100, Esben Stien wrote:
> Ingo Molnar <mingo@elte.hu> writes:
> 
> > i have released the 2.6.15-rt1 tree
> 
> Didn't see any release announcement for 2.6.15-rt3, so I post here. 

If you want Ingo to see this, then please CC him (as I added him).

> 
> I've booted up rt3 and got this: 
> 
> [drm] Loading R200 Microcode
> check_monotonic_clock: monotonic inconsistency detected!
>         from      157c03cbfc9 (1476398989257) to      157c03ca8f6 (1476398983414).
> softirq-hrtimer/8[CPU#0]: BUG in check_monotonic_clock at kernel/time/timeofday.c:160
>  [<c0112555>] __WARN_ON+0x40/0x5f (8)
>  [<c012701a>] check_monotonic_clock+0x64/0x9a (48)
>  [<c01273c7>] get_monotonic_clock+0xb5/0xe8 (32)
>  [<c0124d95>] hrtimer_forward+0x2b/0xd6 (64)
>  [<c011ae6a>] group_send_sig_info+0xb1/0xd3 (12)
>  [<c0114e88>] it_real_fn+0x0/0x42 (40)
>  [<c0114ec2>] it_real_fn+0x3a/0x42 (4)
>  [<c01253c2>] run_hrtimer_softirq+0x7d/0xe8 (24)
>  [<c01161e3>] ksoftirqd+0xce/0x139 (32)
>  [<c0116115>] ksoftirqd+0x0/0x139 (40)
>  [<c01223f2>] kthread+0x79/0xa3 (4)
>  [<c0122379>] kthread+0x0/0xa3 (24)
>  [<c0100db9>] kernel_thread_helper+0x5/0xb (16)

Is this AMD or Intel?

> 
> I'm also, for some reason, unable to get my Logitech MX1000 mouse to
> work in xorg-6.8.1 here, through evdev. I changed my config file to
> use normal /dev/psaux as a temporary solution. I'm coming from
> linux-2.6.14-rt22 where everything related is working fine. No
> software has changed.

Does vanilla 2.6.15 (without -rt) work?

> 
> I run my own distro. 

Cool.

-- Steve


