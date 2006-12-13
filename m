Return-Path: <linux-kernel-owner+w=401wt.eu-S1750875AbWLMU6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWLMU6e (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWLMU6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:58:34 -0500
Received: from smtp.osdl.org ([65.172.181.25]:40936 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750841AbWLMU6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:58:33 -0500
Date: Wed, 13 Dec 2006 12:58:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
In-Reply-To: <20061213203113.GA9026@suse.de>
Message-ID: <Pine.LNX.4.64.0612131252300.5718@woody.osdl.org>
References: <20061213195226.GA6736@kroah.com> <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
 <20061213203113.GA9026@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2006, Greg KH wrote:
>
> It's a stupid test module for the uio core for isa devices.  It's not
> the main code, or core.

Doesn't matter.

IT IS SO FUNDAMENTALLY AND HORRIBLY WRONG THAT I REFUSE TO HAVE IT IN MY 
TREE.

As an "example", the _only_ thing it can possibly ever do is to just 
confuse people - in other words, it's an _anti_example, not a real one.

> Ok, I can pull this example module out if you want, but people seem to
> want examples these days.  If I do that, any objection to the rest?

I'm really not convinced about the user-mode thing unless somebody can 
show me a good reason for it. Not just some "wouldn't it be nice" kind of 
thing. A real, honest-to-goodness reason that we actually _want_ to see 
used.

No features just for features sake.

So please push the tree without this userspace IO driver at all. And if 
you actually have a real user, not just an example, that is worthy and 
shows why such a driver in user space is actually a good thing, _then_ we 
can push that.

In other words, I'd like to see code that uses this that is actually 
_better_ than an in-kernel driver in some way.

For USB, the user-mode thing made sense. You have tons of random devices, 
and the abstraction level is higher to begin with. Quite frankly, I simply 
don't even see the same being true for something like this.

Btw: there's one driver we _know_ we want to support in user space, and 
that's the X kind of direct-rendering thing. So if you can show that this 
driver infrastructure actually makes sense as a replacement for the DRI 
layer, then _that_ would be a hell of a convincing argument.

There may be others. Feel free to fill in the blank: ________.

		Linus
