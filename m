Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262924AbSKMXDd>; Wed, 13 Nov 2002 18:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263589AbSKMXDd>; Wed, 13 Nov 2002 18:03:33 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:23814 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262924AbSKMXDc>; Wed, 13 Nov 2002 18:03:32 -0500
Date: Wed, 13 Nov 2002 18:09:02 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: make distclean and make dep??
In-Reply-To: <20021113205844.GB2822@mars.ravnborg.org>
Message-ID: <Pine.LNX.3.96.1021113180357.31924C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2002, Sam Ravnborg wrote:

> On Wed, Nov 13, 2002 at 02:32:27PM -0500, Bill Davidsen wrote:
> > When I do a "make distclean" in a tree, should not that roll it back to a 
> > clean empty tree? I noticed that when I did that no work was done by "make 
> > dep" in the rebuild.
> With the recent module related changes CONFIG_MODVERSIONS has disappeared.
> Therefore make dep became a noop.
> 
> > Distclean is supposed to be even cleaner than mrproper (to build a clean
> > tree for distribution) and this behaviour is new.
> distclean and mrproper has been merged as of 2.44 IIRC.
> So mrproper and distclean behave in the same way.

So neither of them actually cleans the source tree to release a
distribution anymore? The difference between them was useful, distclean
got rid of version headers and some other assorted cruft you don't want in
a distribution.
 
> > Also noted, somewhere between 2.5.45 and 2.5.46 distclean vanished from 
> > "make help." It's really useful to have distclean work to build patched 
> > kernels for distribution, hopefully this is an oversight and not a new 
> > policy.
> Since they are equal I removed the help for the less used version.

Thanks for the explanation, but I wonder if it was really worth having
people write their own clean scripts to avoid maintaining a few lines of
Makefile which haven't changed in ages.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

