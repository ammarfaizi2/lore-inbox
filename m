Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVFACnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVFACnd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 22:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVFACnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 22:43:33 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:36314 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261241AbVFACn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 22:43:27 -0400
Date: Tue, 31 May 2005 19:42:07 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Esben Nielsen <simlo@phys.au.dk>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: RT patch acceptance
Message-ID: <20050601024207.GC1337@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050531143051.GL5413@g5.random> <Pine.OSF.4.05.10505311652140.1707-100000@da410.phys.au.dk> <20050531161157.GQ5413@g5.random> <20050531183627.GA1880@us.ibm.com> <20050531204544.GU5413@g5.random> <429D0C13.3000006@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429D0C13.3000006@opersys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 09:14:59PM -0400, Karim Yaghmour wrote:
> 
> [ removed a lot of interesting stuff ... ]
> 
> Andrea Arcangeli wrote:
> > The point where preempt-RT enters the hard-RT equation, is only if you need
> > syscall execution in realtime (like audio, but audio doesn't need
> > hard-RT, so preempt-RT can only do good from an audio standpoint, it
> > makes perfect sense that jack is used as argument for preempt-RT). If
> > you need syscalls with hard-RT, the whole thing gets an order of
> > magnitude more complicated and software becomes involved anyways, so
> > then one can just hope that preempt-RT will get everything right and
> > that somebody will demonstrate it.
> 
> Please have a look at RTAI-fusion. It provides deterministic
> replacements for rt-able syscalls _transparently_ to STANDARD
> Linux applications. For example, an unmodified Linux application
> can get a deterministic nanosleep() via RTAI-fusion. The way
> this works, is that rtai-fusion catches the syscalls prior to
> them reaching Linux. So even the syscall thing isn't really a
> limitation for RTAI anymore.

I -completely- misinterpreted

	http://www.fdn.fr/~brouchou/rtai/rtai-doc-prj/rtai-fusion.html

on first reading some months ago.  It looks much more interesting
on second reading.  It does not have the degree of isolation that
the pure double-kernel approaches do, since as the paper states,
Linux can "hide" tasks that are waking up from I/O events.
However, it does appear to provide a unified user-level environment.

I will add it to my list of approaches to realtime in Linux!

					Thanx, Paul

> Philippe would be in a better position to elaborate, but that's
> the essentials of it.
> 
> Karim
> -- 
> Author, Speaker, Developer, Consultant
> Pushing Embedded and Real-Time Linux Systems Beyond the Limits
> http://www.opersys.com || karim@opersys.com || 1-866-677-4546
> 
