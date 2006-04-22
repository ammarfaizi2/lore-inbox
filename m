Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWDVT1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWDVT1Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWDVT1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:27:06 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:45243 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751035AbWDVT0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:26:40 -0400
Date: Sat, 22 Apr 2006 16:11:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [PATCH] 'make headers_install' kbuild target.
Message-ID: <20060422141134.GC5010@stusta.de>
References: <1145672241.16166.156.camel@shinybook.infradead.org> <20060422093328.GM19754@stusta.de> <1145707384.16166.181.camel@shinybook.infradead.org> <20060422123835.GA5010@stusta.de> <1145710123.11909.241.camel@pmac.infradead.org> <20060422132032.GB5010@stusta.de> <1145712964.11909.258.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145712964.11909.258.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2006 at 02:36:04PM +0100, David Woodhouse wrote:
> On Sat, 2006-04-22 at 15:20 +0200, Adrian Bunk wrote:
>...
> > Assume you have a header include/linux/foo.h:
> > - Add an #include <kabi/linux/foo.h> at the top.
> > - Move the part of the contents that is part of the userspace ABI to 
> >   include/kabi/linux/foo.h.
> 
> Absolutely. That's what I've done with MTD headers already, although the
> directory names are different. The directory names don't _matter_
> either, because important part was that the files themselves are cleaned
> up.
> 
> Linus isn't keen on splitting it into a new directory, and I don't want
> to start off by demanding that. As I said, the important part of the
> above is the bit where one of us goes to the file with an editor and
> identifies the public parts vs. the private parts, then splits them up
> -- possibly with #ifdef __KERNEL__, but _preferably_ into separate
> files. And it doesn't _matter_ which directories we put those files
> into, for now. I don't want to talk about it _yet_ because it's just
> taking attention away from the real problem.
> 
> The more we screw around with such minutiae, the less likely we are to
> get traction with Linus -- despite the fact that almost everyone who's
> expressed an opinion is _agreeing_ with you about where we want to end
> up.
> 
> We need to keep it simple and unintrusive to start with. Concentrate on
> the _contents_ and then we can deal with the less important details
> later.

Sorry, but I'm not a fan of doing much more work than required instead 
of getting a consensus first and then implementing the solution.

Let's agree on the way to go first, give me two weeks, and I can submit 
a first batch of the header splitting that will both not break any 
kernel code and be enough for compiling most of the userspace.

Perhaps two weeks are too optimistic for some parts considering the 
state of our headers, but getting it done before OLS seems realistic.

But otherwise, I think I have better things to do in the part of my 
spare time I'm devoting to Linux kernel development.

> dwmw2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

