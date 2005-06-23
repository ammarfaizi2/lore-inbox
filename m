Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262455AbVFWM6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbVFWM6l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 08:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVFWM6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 08:58:40 -0400
Received: from THUNK.ORG ([69.25.196.29]:54171 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262455AbVFWM61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 08:58:27 -0400
Date: Thu, 23 Jun 2005 08:58:14 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Mike Bell <kernel@mikebell.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Message-ID: <20050623125814.GA29398@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Mike Bell <kernel@mikebell.org>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20050621062926.GB15062@kroah.com> <20050620235403.45bf9613.akpm@osdl.org> <20050621151019.GA19666@kroah.com> <20050623010031.GB17453@mikebell.org> <20050623045959.GB10386@kroah.com> <20050623062842.GE17453@mikebell.org> <20050623064847.GC11638@kroah.com> <20050623082859.GD955@mikebell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050623082859.GD955@mikebell.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 01:29:00AM -0700, Mike Bell wrote:
> On Wed, Jun 22, 2005 at 11:48:47PM -0700, Greg KH wrote:
> > No, plan for it.  Speak up.  Complain sometime a while ago instead of
> > right when it happens.
> 
> Did so. Raised the same points I'm doing now. Said at the time I was
> going to wait and see if udev evolved to meet my needs before devfs got
> removed. That time has arrived, and it hasn't, hence this. Seems
> sensible to me.

So send patches to udev.  You seem to be complaining, but not doing
any of the work to help the situation.  Views expressed in that
fashion generally don't get much consideration.  (Some, but not much.)

> Debian? Their installer even relies on devfs instead of udev. 

Debian's installer relies of devfs for historical reasons (it was too
hard to change without having sarge slip again for another year or
two); the system which is installed definitely does _not_ have to use
devfs, and _does_ ship with udev.  And the next version of Debian
(whenever it ships) will use something else.  See this URL in a
discussion filed regarding a _bug_ that was filed complaining that the
Debian installer was using devfs.

	http://lists.debian.org/debian-cd/2004/10/msg00012.html

> > But it was unmaintained clutter and mess.
> 
> Which people have attempted to maintain. Presumably, had it not been
> marked OBSOLETE and thus useless to bother maintaining in the eyes of
> most, said patches would have gone in just like any other cleanup, and
> just like devfs cleanups had been doing until that point.

Not many.  If someone had been willing to put in the _concerted_,
long-term effort that has been put in by people like Greg K-H to
develop an alternative system, including submitting a patch to remove
the racy bits of devfs (not clear if anything would be left :-), then
we would be in a different place.  But we haven't, so we're not.  One
or two proposals to do work, without followup patches (and fixes to
the patches after people complain/criticize them) means that whoever
claimed they were willing to do maintainance work weren't serious.

> Wouldn't disagree with this. In fact, I'll come right out and say that
> given the complete stagnation of devfs (which, I would argue, is not
> entirely its own fault as you claim) and udev's rapid advances (based to
> some degree I would argue on the attention it gained from things like
> the marking of devfs obsolete) udev is the better solution today
> (ignoring the migration headache and pretending both were completely new
> systems introduced today, the features it offers that devfs doesn't are
> worth much more than those devfs offers and udev doesn't, and it has a
> much stronger community behind it).
> ...
> So in closing, while I disagree with the whole way this has gone about,
> in terms of things that can be done /now/ all I'm asking is that kernel
> developers reevaluate the assumption that devfs is truly obsolete rather
> than merely depricated, based on the fact that even after all this time
> and energy udev is still not seen as a complete replacement by everyone.

Is waiting another year really going to help?  If devfs is doomed,
then might as well make a clean break now.  Otherwise we'll wait
another year, and then more people will come out of the woodwork,
whining and whining for another stay of execution....

						- Ted

