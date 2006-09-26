Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWIZXjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWIZXjK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 19:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWIZXjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 19:39:10 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44817 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932312AbWIZXjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 19:39:09 -0400
Date: Wed, 27 Sep 2006 01:39:03 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>, Stefan Seyfried <seife@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode"))
Message-ID: <20060926233903.GK4547@stusta.de>
References: <20060925071338.GD9869@suse.de> <20060926223146.GI4547@stusta.de> <1159311915.7485.37.camel@nigel.suspend2.net> <200609270131.46686.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609270131.46686.rjw@sisk.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 01:31:46AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, 27 September 2006 01:05, Nigel Cunningham wrote:
> > On Wed, 2006-09-27 at 00:31 +0200, Adrian Bunk wrote:
> > > On Wed, Sep 27, 2006 at 07:38:31AM +1000, Nigel Cunningham wrote:
> > > > Hi.
> > > > 
> > > > On Tue, 2006-09-26 at 22:35 +0200, Rafael J. Wysocki wrote:
> > > > > On Tuesday, 26 September 2006 22:14, Adrian Bunk wrote:
> > > > > > On Tue, Sep 26, 2006 at 12:45:00AM +0200, Pavel Machek wrote:
> > > > > > >...
> > > > > > > solid)
> > > > > > > 	apart from HIGHMEM64G fiasco, and related agpgart fiasco long
> > > > > > > 	time before that... these are driver problems...
> > > > > > >...
> > > > > > 
> > > > > > One point that seems to be a bit forgotten is that driver problems do 
> > > > > > actually matter a lot:
> > > > > > 
> > > > > > I for one do not care much whether I can abort suspending (I can always 
> > > > > > resume) or whether dancing penguins are displayed during suspending - 
> > > > > > but the fact that my saa7134 card only outputs the picture but no sound 
> > > > > > after resuming from suspend-to-disk is a real show-stopper for me.
> > > > 
> > > > Agreed that some things are more important than others. But to some
> > > > people, user interface does matter. After all, we want (well I want)
> > > > people considering converting from Windows to see that free software can
> > > > be better than proprietary stuff, not just imitate what they're doing. 
> > > > 
> > > > Suspend2 doesn't actually provide dancing penguins while suspending -
> > > > it's a simple progress bar in either pure text or overlayed on an image
> > > > of your choosing.
> > > > 
> > > > The support for aborting is really just fall out from the work on
> > > > debugging and testing failure paths.
> > > >...
> > > 
> > > Sorry if this sounded as if I was against improvements of suspend.
> > > That was not my intention.
> > > 
> > > But as long as there are driver problems, suspend as a whole can not be 
> > > called solid. The core itself might be solid or not, but without working 
> > > drivers this doesn't buy users much.
> > > 
> > > A user might be impressed by a progress bar on a nifty image, but if one 
> > > or more of his drivers have problems with suspend the user won't get a 
> > > good impression of Linux.
> > > 
> > > How many driver problems with suspend are buried in emails and
> > > Bugzillas (will problems like kernel Bugzilla #6035 ever be debugged?)?
> > 
> > I fully agree. One of the largest issues I'm regularly dealing with is
> > people reporting problems with drivers.
> 
> Well, can we please have these reports forwarded to LKML or placed
> in the bugzilla?

The main question is:

Who will track these bugs, debug them (who is e.g. responsible for 
kernel Bugzilla #6035?) and repeatingly poke maintainers to fix such 
issues?

If you are saying you will do this job, I can try to redirect such bug 
reports to the kernel Bugzilla, create a "suspend driver problems" meta 
bug there, assign it to you and create the dependencies that it tracks 
the already existing bugs in the kernel Bugzilla.

> Greetings,
> Rafael

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

