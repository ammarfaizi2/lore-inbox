Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWE2GHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWE2GHd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 02:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWE2GHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 02:07:33 -0400
Received: from smtp.enter.net ([216.193.128.24]:59655 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751215AbWE2GHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 02:07:32 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: Neil Brown <neilb@suse.de>
Subject: Re: OpenGL-based framebuffer concepts
Date: Mon, 29 May 2006 02:07:21 +0000
User-Agent: KMail/1.8.1
Cc: "Jon Smirl" <jonsmirl@gmail.com>, "Dave Airlie" <airlied@gmail.com>,
       "Pavel Machek" <pavel@ucw.cz>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605290025.50100.dhazelton@enter.net> <17530.32657.869302.621952@cse.unsw.edu.au>
In-Reply-To: <17530.32657.869302.621952@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605290207.22585.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 May 2006 04:58, Neil Brown wrote:
> On Monday May 29, dhazelton@enter.net wrote:
> > > There is plenty of work to do on graphics and lots of flame wars too.
> >
> > Not by me. I give up - nothing I might do stands a smowballs chance in
> > hell of surviving in a recognizable form  through the web of kernel
> > politics.
>
> I must say I find that quite disappointing.
> It seemed like you had the background knowledge, the enthusiasm and
> the time to make something happen here, and I think everyone agrees
> that something needs to happen.

Yes, it seems everyone does agree that it needs to happen. However, nobody can 
give me a *sane* reason why there should be two drivers for a piece of 
hardware in the kernel when, like my original proposal, those drivers could 
exist in userspace and a small core of functionality could sit in the kernel.

And since I've had DaveA and several others insult me in various rather 
diplomatic ways (Sorry, Dave, but it is true) I see no reason why I should 
waste my time doing work that is just going to be rejected whether I do it 
their way or not.

> You seem to be caught at an impasse between Jon and Dave without a
> clear idea who is "right" - I know I have no clear idea!  I suspect
> that they are both right and are both wrong, but figuring which bit is
> which will be tricky.  Very.

Where I'm caught at is my personal ethic when it comes to code and the 
requirement, stated through Dave, that a broken model must be maintained.

> And we really have no tie-breaker mechanism in the kernel - I know
> Linus is very loathe to play that role.  Negotiation, compromise, and
> persistence are what is needed.

I've tried to compromise. I dropped my arguments about having 90% of the 
driver out of the kernel except in a rhetorical sense, agreed that a new 
lower or middle layer that could mediate between fbdev and DRM is needed and 
found a way to implement it by creating a common base of code shared between 
the two. From that common base I could then implement the mediation 
functionality.

Unfortunately I was told "No, that's not the way we want it done" - even 
though it does exactly what Dave originally told me had to be done.

> I suspect that to make progress you will have to start out by doing
> something that you don't completely agree with.  But that doesn't need
> to be a loss.  It will be both a learning experience and a credibility
> earning exercise.

I don't completely agree with what I started doing. To me there should never 
be more than one active driver for any given device in a system. Yet the code 
I was working on when I finally gave up would have allowed any number of 
drivers to use the same piece of hardware at the same time.

> Maybe if you are really genuine about putting effort into this we
> should see if something can be arranged to get you to the
> kernel-summit so that you, Jon, and Dave can yell at each other for a
> while and come to some understanding:-)

That would be nice. But I'm afraid I'd just wind up walking out and leaving. 
Jon doesn't strike me as the type to compromise about anything, Dave seems to 
think he's right about everything no matter what and I've spent my life 
avoiding having discussions with people like that.

If I hadn't already deleted the work I'd finished I'd attach a patch of what 
I'd finished to this mail. But it's not in my nature to hang onto code for 
projects I've abandoned.

> Anyway, while I personal cannot offer you any incentives I would
> implore you: don't give up.  At least not yet.

Neil, Thank you for the vote of confidence, but I can tell when my help isn't 
wanted. 

DRH
