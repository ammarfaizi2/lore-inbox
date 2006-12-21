Return-Path: <linux-kernel-owner+w=401wt.eu-S964777AbWLUKvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWLUKvY (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 05:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWLUKvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 05:51:24 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:36762 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964777AbWLUKvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 05:51:23 -0500
Date: Thu, 21 Dec 2006 13:49:18 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take28-resend_1->0 0/8] kevent: Generic event handling mechanism.
Message-ID: <20061221104918.GA16744@2ka.mipt.ru>
References: <3154985aa0591036@2ka.mipt.ru> <11666924573643@2ka.mipt.ru> <20061221103539.GA4099@2ka.mipt.ru> <458A64E5.4050703@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <458A64E5.4050703@garzik.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 21 Dec 2006 13:49:23 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 05:41:41AM -0500, Jeff Garzik (jeff@garzik.org) wrote:
> Evgeniy Polyakov wrote:
> >On Thu, Dec 21, 2006 at 12:14:17PM +0300, Evgeniy Polyakov 
> >(johnpol@2ka.mipt.ru) wrote:
> >>Generic event handling mechanism.
> >>
> >>Kevent is a generic subsytem which allows to handle event notifications.
> >>It supports both level and edge triggered events. It is similar to
> >>poll/epoll in some cases, but it is more scalable, it is faster and
> >>allows to work with essentially eny kind of events.
> >>
> >>Events are provided into kernel through control syscall and can be read
> >>back through ring buffer or using usual syscalls.
> >>Kevent update (i.e. readiness switching) happens directly from internals
> >>of the appropriate state machine of the underlying subsytem (like
> >>network, filesystem, timer or any other).
> >>
> >>Homepage:
> >>http://tservice.net.ru/~s0mbre/old/?section=projects&item=kevent
> >>
> >>Documentation page:
> >>http://linux-net.osdl.org/index.php/Kevent
> >>
> >>Consider for inclusion.
> >
> >Due to this stall kevent inclusion into lighttpd CVS tree is postponed.
> >
> >The last version will be released saturday or sunday, and looking into
> >overhelming flow of feedback comments on this feature, project will not
> >be released to linux-kernel@, after this I will
> >complete netchannels support and start kevent based AIO project - mostly
> >network AIO with new design, which is based on set of entities, which
> >can describe set of tasks which should be performed
> >asynchronously (from user point of view, although read and write
> >obviously must be done after open and before close), for example syscall
> 
> kevent is being considered for inclusion, but there is no need to get 
> impatient.  Once kevent code stops getting revised rapidly, Andrew 
> Morton can pick it up for -mm, for wide dissemination, testing and 
> review.  After that phase, it can be pushed to mainline.

I do not say 'hey, include it now, or I will cry', I just want to have
_some_ progress. But I do not get _any_ feedback. What should I think?
I doubt bothering people each third day with new resend is a good idea,
so I plan to drop it.

Btw, Andrew dropped 'take23' patchset from his tree, when it was
obsoleted, but did not import later versions :)

> The feeling I get from other kernel hackers is that you are demanding 
> inclusion "now! now! now!" rather than giving all stakeholders a chance 
> to give input, and let your design sink into the collective brain.

No. I do not want immediate inclusion, I want progress, so I could setup
my plans on it - if people keep silence, I stop this and work on my own
kevent goals, since I like current state of hte kevent for my tasks.

I do not hack for inclusion.

> This isn't just an optional feature but a key new addition to the 
> kernel.  So we should intentionally take more time and consideration 
> than normal.  We don't want to go back and have to change fundamental 
> kevent details due to design flaws, we want to get it right.

So comment on its bugs, its design, implementation, ask questions,
request features, show interest (even with 'I have no time right now,
but will loko at it after in a week after vacations').

No one does it, so no one cares, so my behaviour.

> 	Jeff

-- 
	Evgeniy Polyakov
