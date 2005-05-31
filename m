Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVEaQhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVEaQhY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 12:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVEaQef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:34:35 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:59125 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261984AbVEaQbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:31:03 -0400
Subject: Re: RT patch acceptance
From: Steven Rostedt <rostedt@goodmis.org>
To: karim@opersys.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hch@infradead.org,
       dwalker@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, Andi Kleen <ak@muc.de>,
       James Bruce <bruce@andrew.cmu.edu>, kus Kusche Klaus <kus@keba.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Esben Nielsen <simlo@phys.au.dk>,
       "Bill Huey (hui)" <bhuey@lnxw.com>
In-Reply-To: <429B9E85.2000709@opersys.com>
References: <Pine.OSF.4.05.10505301934001.31148-100000@da410.phys.au.dk>
	 <429B61F7.70608@opersys.com> <20050530223434.GC9972@nietzsche.lynx.com>
	 <429B9880.1070604@opersys.com> <20050530224949.GE9972@nietzsche.lynx.com>
	 <429B9E85.2000709@opersys.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 31 May 2005 12:29:35 -0400
Message-Id: <1117556975.2569.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bill, I think you're chasing everyone off this thread ;-)

On Mon, 2005-05-30 at 19:15 -0400, Karim Yaghmour wrote:
> Bill Huey (hui) wrote:

> > Sorry, the RT patch really doesn't effect general kernel development
> > dramatically. It's just exploiting SMP work already in place to get data
> > safety and the like. It does however kill all bogus points in the kernel
> > that spin-waits for something to happen, which is a positive thing for the
> > kernel in general since it indicated sloppy code. If anything it makes the
> > kernel code cleaner.
> 
> But wasn't the same said about the existing preemption code? Yet, most
> distros ship with it disabled and some developers still feel that there
> are no added benefits. What's the use if everyone is shipping kernels
> with the feature disabled? From a practical point of view, isn't it then
> obvious that such features catter for a minority? Wouldn't it therefore
> make sense to isolate such changes from the rest of the kernel in as
> much as possible? From what I read in response elsewhere, it does indeed
> seem that there are many who feel that the changes being suggested are
> far too instrusive without any benefit for most Linux users. But again,
> I'm just another noise-maker on this list. Reading the words of those
> who actually maintain this stuff is the best indication for me as to
> what the real-time-linux community can and cannot expect to get into
> the kernel.

Karim,

I would assume that the distros would ship without PREEMPT enabled
because it was (and probably still is) considered unstable.  The distros
would prefer to have less responsive machines (not saying PREEMPT helps
the normal desktop user) than risking a machine crash.  That would be
much more noticeable to the user!

The PREEMPT is already there, and if you were to add PREEMPT_RT then I
don't think many of the developers would notice.  Now if someone found a
problem some where with PREEMPT_RT and complained to the maintainer, the
maintainer should (rightfully) tell them to complain to the RT
maintainers (Ingo and others, I'll help when I can).  But the way Ingo's
patch works now, is to not change the way the kernel looks to the
devices.  The device driver is still written the same and when a problem
occurs, that something doesn't work right with -RT, one of us fixes it,
and then submits it to the maintainer of the code.  So the only extra
work a maintainer would have is dealing with those maintaining RT.

-- Steve


