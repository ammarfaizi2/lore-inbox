Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbVL3U7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVL3U7P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 15:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVL3U7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 15:59:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6409 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750770AbVL3U7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 15:59:12 -0500
Date: Fri, 30 Dec 2005 21:59:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       torvalds@osdl.org, arjan@infradead.org, linux-kernel@vger.kernel.org,
       mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051230205911.GZ3811@stusta.de>
References: <20051228114637.GA3003@elte.hu> <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <1135956480.28365.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135956480.28365.16.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 03:28:00PM +0000, Alan Cox wrote:
> On Mer, 2005-12-28 at 20:11 -0800, Andrew Morton wrote:
> > If no-forced-inlining makes the kernel smaller then we probably have (yet
> > more) incorrect inlining.  We should hunt those down and fix them.  We did
> > quite a lot of this in 2.5.x/2.6.early.  Didn't someone have a script which
> > would identify which functions are a candidate for uninlining?
> 
> There is a tool that does this quite well. Its called "gcc" ;)
> 
> More seriously we need to seperate "things Andrew thinks are good inline
> candidates" and "things that *must* be inlined". That allows 'build for
> size' to do the equivalent of "-Dplease_inline" and the other build to
> do "-Dplease_inline=inline". Gcc's inliner isn't aware of things cross
> module so isn't going to make all the decisions right, but will make the
> tedious local decisions.
>...

I'm not getting the point:

Shouldn't "static" versus not "static" already give gcc everything it 
needs for making the decision?

If stuff is cross-module (more exactly: cross-objects) it's not static 
and I doubt there are many (if any) cases of non-static code we want 
inline'd when used inside the file it's in.

> Alan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

