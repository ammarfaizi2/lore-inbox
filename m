Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbRBSQ1O>; Mon, 19 Feb 2001 11:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129599AbRBSQ1E>; Mon, 19 Feb 2001 11:27:04 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:20516 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129393AbRBSQ0w>; Mon, 19 Feb 2001 11:26:52 -0500
Date: Mon, 19 Feb 2001 10:26:44 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [LONG RANT] Re: Linux stifles innovation... 
In-Reply-To: <Pine.LNX.3.96.1010219162217.20451A-100000@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.3.96.1010219102055.17842O-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001, Mikulas Patocka wrote:

> > > I suspect part of the problem with commercial driver support on Linux is that
> > > the Linux driver API (such as it is) is relatively poorly documented
> > 
> > In-kernel documentation, agreed.
> > 
> > _Linux Device Drivers_ is a good reference for 2.2 and below.
> 
> And do implementators of generic kernel functions and developers of device
> drivers respect it? And how can they respect it if it's a commercial book?

_Linux Device Drivers_ documents the 2.2 (and previous) API, and
thus refutes the argument that the kernel API is poorly documented.
Since the publication of the book -succeeds- the publication of the
APIs, your questions are not applicable.


> > > and seems
> > > to change almost on a week-by-week basis anyway. I've done my share of chasing
> > > the current kernel revision with drivers that aren't part of the kernel tree:
> > > by the time you update the driver to work with the current kernel revision,
> > > there's a new one out, and the driver doesn't compile with it.
> > 
> > This is entirely in your imagination.  Driver APIs are stable across the
> > stable series of kernels: 2.0.0 through 2.0.38, 2.2.0 through 2.2.18,
> > 2.4.0 through whatever.
> 
> No true. Do you remember for example the mark_buffer_dirty change in some
> 2.2.x that triggered ext2 directory corruption? (mark_buffer_dirty was
> changed so that it could block). 
> 
> Another example of bug that comes from the lack of specification is
> calling of get_free_pages by non-running processes that caused lockups on
> all kernels < 2.2.15. And it is still not cleaned up - see tcp_recvmsg(). 
> 
> Having documentation could prevent this kind of bugs.

Hardly.  No documentation is often -better- than bad documentation.

> You don't need too
> long texts, just a brief description: "this function may be called from
> process/bh/interrupt context, it may/may not block, it may/may not be
> called in TASK_[UN]INTERURPTIBLE state, it may take these locks."
> 
> With documentation developers would be able to change implementation of
> kernel functions without the need to recheck all drivers that use them. 

Anytime you change implementation, you gotta check all drivers that use
them.  I know, I'm one of the grunts that does such reviews and changes.

> Saying "code is the specification" is not good.

I'm not arguing against documentation.  That is dumb.  But the code is
ALWAYS canonical.  Not docs.

	Jeff





