Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWJARp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWJARp6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 13:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWJARp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 13:45:58 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6407 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932125AbWJARp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 13:45:57 -0400
Date: Sun, 1 Oct 2006 19:45:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Randy Dunlap <rdunlap@xenotime.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Announce: gcc bogus warning repository
Message-ID: <20061001174555.GC3278@stusta.de>
References: <451FC657.6090603@garzik.org> <20061001100747.d1842273.rdunlap@xenotime.net> <451FF8ED.9080507@garzik.org> <200610011827.29732.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610011827.29732.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2006 at 06:27:29PM +0100, Alistair John Strachan wrote:
> On Sunday 01 October 2006 18:20, Jeff Garzik wrote:
> > Randy Dunlap wrote:
> [snip]
> > >> This repository will NEVER EVER be pushed upstream.  It exists solely
> > >> for those who want to decrease their build noise, thereby exposing true
> > >> bugs.
> > >>
> > >> The audit has already uncovered several minor bugs, lending credence to
> > >> my theory that too many warnings hides bugs.
> > >
> > > I usually build with must_check etc. enabled then grep them
> > > away if I want to look for other messages.  I think that the situation
> > > is not so disastrous.
> >
> > I think it's both sad, and telling, that the high level of build noise
> > has trained kernel hackers to tune out warnings, and/or build tools of
> > ever-increasing sophistication just to pick out the useful messages from
> > all the noise.
> >
> > If you have to grep useful stuff out of the noise, you've already lost.
> 
> The question is whether the GCC guys are actually doing anything about the 
> problem. If they are, we should do nothing. If they aren't, maybe it's time 
> for "x = x" hacks like Steven's.
>...

Let's be fair to gcc:

gcc correctly tells it "may be used uninitialized" - that's different 
from cases where gcc tells "is used uninitialized".

Sometimes, it requires _much_ context seeing that a condition is 
actually not possible.

And there are even cases where it's technically impossible for a 
compiler to figure out itself that a condition is not possible.

> Cheers,
> Alistair.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

