Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136310AbRAMCrn>; Fri, 12 Jan 2001 21:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136376AbRAMCrd>; Fri, 12 Jan 2001 21:47:33 -0500
Received: from client1209.sedona.net ([208.48.157.156]:42500 "EHLO
	toltec.metran.cx") by vger.kernel.org with ESMTP id <S136310AbRAMCrO>;
	Fri, 12 Jan 2001 21:47:14 -0500
From: Jay Ts <jay@toltec.metran.cx>
Message-Id: <200101130245.TAA02910@toltec.metran.cx>
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
To: andrewm@uow.edu.au (Andrew Morton)
Date: Fri, 12 Jan 2001 19:45:43 -0700 (MST)
Cc: linux-kernel@vger.kernel.org (lkml),
        linux-audio-dev@ginette.musique.umontreal.ca (lad), xpert@xfree86.org,
        mcrichto@mpp.ecs.umass.edu (mcrichto@mpp.ecs.umass.edu)
In-Reply-To: <3A5D994A.1568A4D5@uow.edu.au> from "Andrew Morton" at Jan 11, 2001 10:30:18 PM
Reply-To: jayts@bigfoot.com
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Jay Ts wrote:
> > 
> > Now about the only thing left is to get it included
> > in the standard kernel.  Do you think Linus Torvalds is more likely
> > to accept these patches than Ingo's?  I sure hope this one works out.
> 
> We (or "he") need to decide up-front that Linux is to become
> a low latency kernel. Then we need to decide the best way of
> doing that.
> 
> Making the kernel internally preemptive is probably the best way of
> doing this.  But it's a *big* task

Ouch.  Yes, I agree that the ideal path is for Linus and the other
kernel developers and ... well, just about everyone ... is to create
a long-range strategy and 'roadmap' that includes support for low-latency.

And making the kernel preemptive might be the best way to do that
(and I'm saying "might"...).

But all that can take years, if it happens at all, and we may have
a short-term approach that will satisfy almost everyone, at least for
now, and maybe even allow for the development and maybe even (?) commercial
distribution ("shrink wrap") of audio software for Linux.  (Er, assuming
that the ALSA drivers become the standard audio drivers.  Mustn't forget
that.)

As for actually desiring a preemptive kernel, I'm not a complete expert
in this area, but I will say that no one has ever managed to explain to
me why the extra complexity is vital, necessary, or just worth the 
bother.  Sure, it would help with the implementation and OS support of
the multithreaded and realtime code that I'm developing.  So far, I haven't
run into any major limitations yet related to lack of a preemtive kernel,
but maybe I will later. (?)

> I could propose a simple patch for 2.4 (say, the ten most-needed
> scheduling points).  This would get us down to maybe 5-10 milliesconds
> under heavy load (10-20x improvement).

5-10 ms wouldn't be great, but would at least be better than nothing.
It would be a good start, perhaps, especially if it were understood that
things will get better later on.  As with the development of SMP support
for Linux.

> That would probably be a great and sufficient improvement for [...]
> people who are only interested in audio record and playback - I'd need advice
> from the audio experts for that.

Well, call me an audio expert, then. :)  What sort of advice do you
want?  You can send your comments to the LAD (linux audio development)
mailing list, and there are a bunch of smart audio/music programmers
who I'm pretty sure will be happy to comment.

One thing I'd like to say is that simple recording and playback of audio
is hardly the complete picture!  Try recording and playback of *many*
channels of audio, while at the same time running multiple software
synthesizers and effects plugins, and recording and playing back MIDI
sequences.  And other things, too.  One thing I ask of anyone who's developing
Linux is to please think in an open-ended manner regarding audio/music.
This is really still a pretty new and immature field, and the software
(when the Real Stuff gets to Linux, that is) will be happy to absorb
whatever hardware resources are thrown at it for years to come.

> I hope that one or more of the desktop-oriented Linux distributors
> discover that hosing HTML out of gigE ports is not really the
> One True Appplication of Linux,

I agree approximately 110.111%. :)  Really, I find servers to be
pretty boring.  "Linux is supposed to be fun", right? :)

> > What's the prob with XF86 4.0?
>   [snipped longish explanation] 
> So,  we need to talk to the xfree team.
> 
> Whoops!  I accidentally Cc'ed them :-)

Thank you.  A low-latency kernel would be meaningless if the X server
creates delays of 20ms!  This just plain needs to be fixed.

- Jay Ts
jayts@bigfoot.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
