Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWB1GcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWB1GcR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 01:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbWB1GcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 01:32:17 -0500
Received: from thunk.org ([69.25.196.29]:34007 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750890AbWB1GcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 01:32:16 -0500
Date: Tue, 28 Feb 2006 01:32:07 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Benjamin LaHaise <bcrl@kvack.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060228063207.GA12502@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Greg KH <greg@kroah.com>,
	Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
	Benjamin LaHaise <bcrl@kvack.org>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
	Kay Sievers <kay.sievers@vrfy.org>
References: <20060227190150.GA9121@kroah.com> <20060227193654.GA12788@kvack.org> <20060227194623.GC9991@suse.de> <Pine.LNX.4.64.0602271216340.22647@g5.osdl.org> <20060227234525.GA21694@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227234525.GA21694@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 03:45:25PM -0800, Greg KH wrote:
> > So I just don't see any upsides to documenting anything private or 
> > unstable. I see only downsides: it's an excuse to hide behind for 
> > developers.
> 
> So should we just not even document anything we consider "unstable"?
> The first trys at things are usually really wrong, and that only can be
> detected after we've tried it out for a while and have a few serious
> users.  Should we brand anything new as "testing" if the developer feels
> it is ready to go?

How about "we don't let anything into mainline that we consider
'unstable' from an interface point of view"?

There seems to be a fetish going on today that everything possible
should be mindlessly pushed out into userspace regardless of whether
or not it makes sense.  What folks don't seem to understand is that
there is a tradeoff between implementational complexity (in terms of
lines of code in /usr/src/linux) and interface complexity (see Rusty's
talk about designing good interfaces and how hard that can be).

If we're not sure we can get the interface right, then maybe it's a
sign it needs to stay in -mm longer, or maybe we were trying to push
the wrong thing out into userspace.  If the interface isn't easy to
understand, and we aren't confident that we can promise to never
change it once we put it out there (although of course we can always
add additional interfaces as we add new features), then maybe the
mistake was in trying to create the interface in the first place.

Don't get me wrong; I'm a big fan of pushing policy out of the kernel;
but only if the interface that we use to expose the kernel
functionality has been very carefully designed.


Another alternative, as a few people including myself have noted, is to
shipping that part of the userspace with the kernel sources, so that
it is part of the kernel sources from a release management point of
view, even if it lives in userspace.  

							- Ted
