Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932688AbVKYPCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688AbVKYPCe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 10:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932689AbVKYPCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 10:02:34 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:46493 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932688AbVKYPCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 10:02:33 -0500
Date: Fri, 25 Nov 2005 16:02:26 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Rob Landley <rob@landley.net>
cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] make miniconfig (take 2)
In-Reply-To: <200511250218.56755.rob@landley.net>
Message-ID: <Pine.LNX.4.61.0511251337240.1609@scrub.home>
References: <200511170629.42389.rob@landley.net> <200511241145.24037.rob@landley.net>
 <Pine.LNX.4.61.0511250022330.1609@scrub.home> <200511250218.56755.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 25 Nov 2005, Rob Landley wrote:

> > I don't really disagree, a proper implementation of the concept would also
> > be technically quite different.
> 
> But would the user interface?

It would be a bit different from what you propose.

> Uh-huh.  So doing this requires a complete rewrite of kconfig.  And how long 
> is this rewrite expected to take?  (Will it be in python and called CML2?)

Rob, if you want me to just ignore you, then please continue like this.

> Meanwhile, I have a small patch that provides this (from a user perspective) 
> now.  Working today.

The point is that it's close enough to allnoconfig, so that it's IMO not 
worth it. I'm trying to explain, what would be needed to do it properly, 
but either I failed to make myself understandable or you're not listening.

> > > However, you seem to be forgetting that .config is read by the kernel
> > > build infrastructure.  The tools are generating what _used_ to be a human
> > > editable file.
> >
> > Oh, really?
> 
> This is a slightly vague.  Is this "Oh, really?" arguing that it didn't used 
> to be a human readable format?

At this point I was just wondering, whether you realize that I wrote the 
new kconfig stuff.

> > > I don't personally _care_ about the other config targets.
> >
> > Well, that's the problem, I do care about them.
> 
> I think you're too focused on the implementation to see the users.  What I'm 
> trying to document is miniconfig, and as such any kallsyms target allnoconfig 
> is not _useful_.

I'm actually quite interested in the needs of the users, but OTOH users 
have to realize that they are not always _exactly_ get what they want. 
Users often have very specific wishes and I try to provide a generic 
framework, which not only solves specific problems but also a broad range 
of problems, which often means to compromise as user needs can be very 
contradictory.

> > I want to keep it working without obfuscating it with thousands little
> > features, so we have to figure out how to integrate it properly into the big
> > picture. 
> 
> Do you have a suggestion that does not involve a complete rewrite of kbuild 
> over the next year or more?  I just posted one, and I've just started work on 
> another.
> 
> I'm still not entirely certain you understand what I'm trying to accomplish, 
> and I'm sorry I can't make you understand why I need this.  I'm not convinced 
> that your "new config format" will be at all useful.

I think I understand you quite well. Again, the basic functionality you 
want is already provided by allnoconfig and the advanced features need a 
bit more work than the few hacks you added to conf.c.
I like the idea of a minimum config, which e.g. users can send to 
developers or they can use for upgrading kernels, but this has to work not
just for you, but also for the majority of users and this requires a 
better specification of how this feature should work in various 
situations.

bye, Roman
