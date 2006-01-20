Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWATJtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWATJtS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 04:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWATJtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 04:49:18 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:57218
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750771AbWATJtR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 04:49:17 -0500
Subject: Re: [PATCH 7/7] [hrtimers] Set correct initial expiry time for
	relative SIGEV_NONE timers
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, mingo@elte.hu,
       george@wildturkeyranch.net, rostedt@goodmis.org
In-Reply-To: <20060119211126.0ed279c2.akpm@osdl.org>
References: <20060120021336.134802000@tglx.tec.linutronix.de>
	 <20060120021343.296071000@tglx.tec.linutronix.de>
	 <20060119211126.0ed279c2.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 10:49:54 +0100
Message-Id: <1137750595.28034.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 21:11 -0800, Andrew Morton wrote:
> Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > 
> > The expiry time for relative timers with SIGEV_NONE set was never
> > updated to the correct value.
> > 
> 
> Ahem.
> 
> > +		if (mode == HRTIMER_REL)
> > +			timer->expires = ktime_add(timer-expires,
> > +						   timer->base->get_time());
> 
> doesn't compile, hence isn't tested.

Oh well, I wanted to add quilt autorefresh mode since long :(

	tglx


