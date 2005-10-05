Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965089AbVJEInK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbVJEInK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 04:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbVJEInK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 04:43:10 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53921 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932577AbVJEInJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 04:43:09 -0400
Date: Wed, 5 Oct 2005 10:41:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [swsusp] separate snapshot functionality to separate file
Message-ID: <20051005084141.GB22034@elf.ucw.cz>
References: <20051002231332.GA2769@elf.ucw.cz> <200510032339.08217.rjw@sisk.pl> <20051003231715.GA17458@elf.ucw.cz> <200510041711.13408.rjw@sisk.pl> <20051004205334.GC18481@elf.ucw.cz> <1128465272.6611.75.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128465272.6611.75.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Not necessary, but desirable in your eyes. I can see that you can make
> it work if you're only talking about implementing eye candy, but if
> you're serious about adding the substantial improvements from Suspend2
> (support for multiple swap partitions, swap files, block sizes != 4096,
> asynchronous I/O, readhead where I/O must be synchronous, support for
> writing to a network or a generic file (again with block size != 4096)
> etc, - let alone support for saving a full image of memory - this is
> just going to get uglier and uglier. We can see this already because
> you've already dropped swap support, obviously because it's too hard
> from userspace.

swap support needs "allocate me swap page" ioctl/syscall/whatever;
that can be arranged. Then you can have as many swap partition, swap
files and normal files as you want, and block size will not really
matter. Network and generic file writing should be possible now.

Full image of memory... No, I can't do that, but Rafael already has
some patches that get "close enough" -- they keep system responsive
after resume, without major uglyness/rewrite.

> The tidy up you're proposing is a nice step. But it seems to me to be 
> the only good thing and really useful thing to come of this so far.

Thanks. There are more nice cleanups coming, and then we may add
userspace interface.

> Pavel, at the PM summit, we agreed to work toward getting Suspend2
> merged. I've been working since then on cleaning up the code, splitting
> the patches up nicely and so on. In the meantime, you seem to have gone
> off on a completely different tangent, going right against what we
> agreed then. Can I get you to at least try to come back from that?
> I'd

Sorry about that. At pm summit, I did not know if uswsusp was
feasible. Now I'm pretty sure it is (code works and is stable).

> be more than willing to help you with cherry picking some changes and
> getting them in ahead of the rest of the code. Would you consider
> working together to do that? In particular, I'm thinking that I could
> send you the refrigerator patches as I have them at the moment, and a
> patch to remove the reliance on PageReserved, at least for a start. Any
> willingness on your part to give that a try?

I'd certainly like to understand mysqld refrigerator failure, and have
it fixed. (But that should be few lines.) Other than that, I do not
think refrigerator is broken.

PageReserved... lets see if it is small enough.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
