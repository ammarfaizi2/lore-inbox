Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVAGNEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVAGNEo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 08:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVAGNEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 08:04:44 -0500
Received: from [213.146.154.40] ([213.146.154.40]:48828 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261401AbVAGNER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 08:04:17 -0500
Date: Fri, 7 Jan 2005 13:04:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       Chris Wright <chrisw@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Jack O'Quin" <joq@io.com>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107130407.GA8119@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paul Davis <paul@linuxaudiosystems.com>,
	Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
	Chris Wright <chrisw@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jack O'Quin <joq@io.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>
References: <1104938472.8589.8.camel@krustophenia.net> <200501071256.j07Cu24a017948@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501071256.j07Cu24a017948@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 07:56:02AM -0500, Paul Davis wrote:
> 2) this is *not* only about scheduling. Realtime tasks need
> mlockall() and/or mlock as well. even the man page for mlock
> recognizes this, yet almost all the discussion here has focused on
> scheduling. 

RLIMIT_MEMLOCK is your friend.

> 3) christoph claims that using uid/gid to define priviledge scope
> is a bad idea. but that is the *desired* method. uid/gid corresponds exactly
> to what the users of these systems want. they don't want priviledge
> accorded to specific applications - its the *users* not the
> applications that have the right to get RT scheduling, lock down
> memory and so on. these applications will run without RT priviledges,
> just not very well (in general, so badly that they are unusable for
> their intended purpose).

it doesn't really matter what you want, but how we can implement
something that fits in the kernel design.

> 4) christoph's claims about OS X are nothing but ridiculous. whatever
> the internals of Darwin may or may not be (and they certainly include
> some of the best ideas about media-friendly kernels from the last 20
> years, unlike our favorite OS), professional people are using OS X

professional people are also using Windows or Solaris.  That doesn't
mean we have to copy every bad idea from them.

> 5) setuid wrappers don't work for this, because even though you can
> change the scheduling class of another process, you cannot "grant" it
> the ability to use mlock. at least not without capabilities, so back
> to (1) above ...

See above (RLIMIT_MEMLOCK).

> I've spent probably burnt through to $250,000 supporting myself and my
> family over the last 5 years while I develop pro-level audio software
> for Linux. I don't expect to see any of that back. So when Christoph
> chimes in with the "I'm not paid, I don't have to tell you why I don't
> like it, I just don't" ... that really, really, really irritates me in
> a way that few other comments do.

I think you're taking things totally out of context here.  Lee complained
I didn't review his patch earlier.  I only have a limited time available
so I'll select patches that I'm gonna review - and that means thet have
to either be very interesting or be proposed for inclusion.  If you want
me to review other things you'll have to either pay me or ask me really
nicely offlist.

> We (Jack, Lee and now myself) have tried to explain what the problem
> with the kernel is, how LSM makes a solution possible, acknowledged
> issues and attempted to address them, and finally have offered up a
> working patch that makes life easier for a bunch of people who don't
> want to run webservers or compile kernels all day.

And we have told you that this solution is not okay.  You can spend
more time whining which won't do anything or you could help brainstorming
how to implement a workable solution.

