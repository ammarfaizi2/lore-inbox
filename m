Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWBBXPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWBBXPW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 18:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWBBXPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 18:15:22 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:48021 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751195AbWBBXPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 18:15:20 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [ 00/10] [Suspend2] Modules support.
Date: Fri, 3 Feb 2006 00:10:36 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, nigel@suspend2.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060202152316.GC8944@ucw.cz> <20060202132708.62881af6.akpm@osdl.org>
In-Reply-To: <20060202132708.62881af6.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200602030010.36918.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 02 February 2006 22:27, Andrew Morton wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
> >
> > > I don't want to argue Pavel. I want to give users the best suspend to disk 
> > > implementation they can get. If you want to argue, you can do so with 
> > 
> > I want to create best suspen that can be still merged into kernel; I
> > guess thats the difference. Anyway I believe that most of suspend
> > should be done in userspace -- most of it can. But I guess you need to
> > hear it from Linus/Andrew, so...
> 
> You're unlikely to hear anything dispositive from either of us on this. 
> You three guys know far more than us about suspend, so it would be silly
> for us to be making the technical decisions.  When cornered, we're more
> likely to come out with general kernel platitudes such as "doing it in
> userspace:good" and "crashing the kernel:bad" and "incremental development
> with early merges:good" and "mucking up the kernel source:bad".
> 
> What we hope and expect is that you'll come up with an agreed path in
> accordance with general kernel coding and development principles.  Linus
> and I don't want to have to make tiebreak decisions - if we have to do
> that, the system has failed.
> 
> Random thoughts:
> 
> - swsusp has been a multi-year ongoing source of churn and bug reports. 
>   It hasn't been a big success and we have a way to go yet.

Surely. :-)

> - People seem to be doing too much development on the swsusp core and not
>   enough development out where the actual problems are: drivers which don't
>   suspend and resume correctly.

I haven't had any problems with drivers wrt suspend to disk recently, but
s2ram vs video is a different story.  AFAICT, Pavel is working on it.
Unfortunately I can't help here, because I'm not a driver expert, so I do
what I can ie. improve the swsusp core.

Still, the driver problems are common to both swsusp and suspend2.

> - suspend2 is at a disadvantage because swsusp was merged first.  If
>   neither of the solutions had been merged and if we were evaluating them
>   side-by-side, suspend2 would have a much better chance.  This is a
>   problem.
> 
> - If you want my cheerfully uninformed opinion, we should toss both of
>   them out and implement suspend3, which is based on the kexec/kdump
>   infrastructure.  There's so much duplication of intent here that it's not
>   funny.  And having them separate like this weakens both in the area where
>   the real problems are: drivers.

Well, I started to work on swsusp, because it was in the kernel and it didn't
work on my box.  Now I'm almost satisfied with how it works for me, but
I'm all for further improvements.

> - Justifying the inclusion of a feature by the appearance and usefulness
>   of the end result doesn't really work in this world.  There are numerous
>   unmerged kernel features out there which work well and look great.  But
>   we will look under the hood, and that's when problems start.
> 
> 
> So, as promised, there's nothing useful here.  What we'd most like to see
> is for Nigel to start working on in-kernel swsusp, merging up the good bits
> from suspend2 in some evolutionary incremental manner under which the
> kernel continually improves.

That is exactly what I'd like to happen.

> If, at the end of the day, that ends up with us having a complete
> implementation of suspend2, well, Mission Accomplished?

Most probably we'll end up with something else, maybe better? ;-)

Greetings,
Rafael

