Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261814AbTCGVzN>; Fri, 7 Mar 2003 16:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261808AbTCGVzJ>; Fri, 7 Mar 2003 16:55:09 -0500
Received: from packet.digeo.com ([12.110.80.53]:35227 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261812AbTCGVy4>;
	Fri, 7 Mar 2003 16:54:56 -0500
Date: Fri, 7 Mar 2003 14:01:03 -0800
From: Andrew Morton <akpm@digeo.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] protect 'action' in show_interrupts
Message-Id: <20030307140103.00221e7e.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.50.0303071124440.18716-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303062358130.17080-100000@montezuma.mastecende.com>
	<20030306222328.14b5929c.akpm@digeo.com>
	<Pine.LNX.4.50.0303070221470.18716-100000@montezuma.mastecende.com>
	<20030306233517.68c922f9.akpm@digeo.com>
	<Pine.LNX.4.50.0303070502400.18716-100000@montezuma.mastecende.com>
	<20030307022829.7868dda2.akpm@digeo.com>
	<Pine.LNX.4.50.0303071030500.18716-100000@montezuma.mastecende.com>
	<20030307154643.L17492@flint.arm.linux.org.uk>
	<Pine.LNX.4.50.0303071124440.18716-100000@montezuma.mastecende.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2003 22:05:24.0283 (UTC) FILETIME=[A72F98B0:01C2E4F5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>
> On Fri, 7 Mar 2003, Russell King wrote:
> 
> > We don't have a per-irq_desc spinlock on ARM - it's a global
> > irq_controller_lock.
> > 
> > Thanks.
> 
> Ok thanks for spotting that. Andrew here it is rediffed.

Thanks, Zwane.  Looks good.

I made some adjustments down in mips land - they weren't initialising the
irq_desc_t locks on startup.

That's pretty academic, but doing spin_lock_irqsave() is as good a way as any
of saying "preempt_disable()", and it keeps all the code looking the same.




