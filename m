Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310337AbSCADR1>; Thu, 28 Feb 2002 22:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310332AbSCADPX>; Thu, 28 Feb 2002 22:15:23 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:24073 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S310336AbSCADN0>;
	Thu, 28 Feb 2002 22:13:26 -0500
Date: Fri, 1 Mar 2002 00:13:08 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the
 tree
In-Reply-To: <Pine.LNX.3.96.1020228215025.3310A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.33L.0203010009510.2801-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2002, Bill Davidsen wrote:

> On Thu, 28 Feb 2002, Rik van Riel wrote:

> > or (c) have proponents of the inclusion of the O(1) scheduler
> > fix all drivers before having the O(1) scheduler considered
> > for inclusion.
> >
> > Adding a yield() function to 2.4's scheduler and fixing all
> > the drivers to use it isn't that hard. Now all that's needed
> > are some O(1) fans willing to do the grunt work.
>
> That sounds very nice, but in practice it means it would never happen,
> and you know it.

If you send the patch, it'll happen.  If you don't have the
motivation to send the patch and nobody else has either, then
it won't happen.

> First you have to patch the existing scheduler.

Not at all. The yield() function would just be a define to
the code which no longer works with the new scheduler, ie:

#define yield()				\
	current->policy |= SCHED_YIELD;	\
	schedule();

> Aside from the work on something which we are about to discard, the
> patch would have to go through the maintainer, and the the submitter,

> If we could get a dispensation from Linus to submit one patch combining
> the scheduler and all the drivers, it could be done (almost mechanically).

You can send marcelo such a patch (without the scheduler) right
now.

You're making absolutely no sense when you're saying that a patch
without the O(1) scheduler would have to go through the maintainers
while a patch with the O(1) scheduler included could go into the
kernel directly.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

