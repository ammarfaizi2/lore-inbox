Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315451AbSFEO0A>; Wed, 5 Jun 2002 10:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSFEOZ7>; Wed, 5 Jun 2002 10:25:59 -0400
Received: from dsl-213-023-039-098.arcor-ip.net ([213.23.39.98]:10432 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315451AbSFEOZ6>;
	Wed, 5 Jun 2002 10:25:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Oliver Xymoron <oxymoron@waste.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Date: Wed, 5 Jun 2002 16:25:25 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206050800140.2614-100000@waste.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Fbj3-0001YS-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 June 2002 15:51, Oliver Xymoron wrote:
> On Wed, 5 Jun 2002, Daniel Phillips wrote:
> > On Wednesday 05 June 2002 04:40, Oliver Xymoron wrote:
> > > Just bear in mind that it's next to impossible to avoid throwing the baby
> > > out with the bathwater here. Ok, so you've got an RT kernel playing your
> > > MP3 alongside your UNIX system - how do you control it? How do you switch
> > > tracks? All the latency that you were struggling with in the player is
> > > still there in the user interface.
> 
> > In the context of an mp3 playback system, worrying about whether the
> > controls are realtime seems a little excessive.
> 
> Perhaps you've never been a DJ..

Good point.  Quake deathmatch is another place where you worry a lot
about your controls being realtime.

> > But it's not too hard to do.  Just allow the RTOS to take control of the
> > input devices, or at least to insert itself ahead of the general purpose
> > operating system in the interrupt pipeline.
> >
> > As for a GUI with realtime response characteristics, that's more
> > challenging, but it has been done.  It's also less important I'd say.  You
> > can always fall back on dedicated hardware for the realtime display.
> 
> Of course, but then it's no longer part of a general-purpose operating
> system. Baby, bathwater. It's easier to tape a Rio onto the side of your
> machine.

Not at all.  You can still run a web browser and a download in parallel
with the realtime process, that's the beauty of it.  As for the realtime
gui, if you're determined to build one it doesn't have to be the whole
desktop.  It can just be one window, much like a video overlay.

I'm don't see any fundamental roadblock here.

> > > What you really want for an MP3 player is _not_ hard RT, what you want is
> > > very reliable low-latency. Which we can do without throwing away most of
> > > UNIX.
> >
> > I think that depends on whether you are an audiophile or not.  Or a
> > broadcaster.  If you're a broadcaster, how many mp3 skips will you tolerate
> > a year?
> 
> If the number is zero, you can't use the facilities of a non-RT operating
> system for anything except (possibly lossily) monitoring the output of
> such a system.

That doesn't follow.  I ought to be able to do an apt-get dist-upgrade
without the realtime application ever skipping a beat, just to pick one
example off the top of the pile.

> If you feed an RT system with data or control from a non-RT
> system, it becomes a non-RT system. If you try to losslessly queue output
> from an RT system to a non-RT system, it becomes a non-RT system.

If it hurts, don't do that.  I thought we'd invoked the concept of a
realtime filesystem?  You can log to that, and you ought to be able to
run queries against it in non-realtime.  You don't have to suck the
entire world into your realtime application.

> > And who said anything about throwing away most of Unix?
> 
> You did, by insisting on absolutes. Hard realtime places many restrictions
> on what you can do - it's like having your entire system inside an
> interrupt context or a signal handler.

This is precisely the sort of design limitation we're tearing down with
these hybrid realtime/non-realtime systems.  Your mistake is assuming
that every form of communication between the two has to be tightly
coupled.  It's true that the entire realtime system has to operate
within the strictures of some formalism, but that's what formalisms
are for.  It's no more shocking a limitation than the fact that regular
users aren't allowed to do all the things the superuser can do.

--
Daniel
