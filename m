Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317534AbSFEC6J>; Tue, 4 Jun 2002 22:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317535AbSFEC6I>; Tue, 4 Jun 2002 22:58:08 -0400
Received: from dsl-213-023-043-246.arcor-ip.net ([213.23.43.246]:52150 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317534AbSFEC6H>;
	Tue, 4 Jun 2002 22:58:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Oliver Xymoron <oxymoron@waste.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Date: Wed, 5 Jun 2002 04:57:36 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206042132450.2614-100000@waste.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17FQzQ-0001T2-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 June 2002 04:40, Oliver Xymoron wrote:
> On Wed, 5 Jun 2002, Daniel Phillips wrote:
> 
> > On Tuesday 04 June 2002 21:29, Oliver Xymoron wrote:
> > > On Mon, 3 Jun 2002, Daniel Phillips wrote:
> > >
> > > > traditional IT.  Not to mention that I can look forward to a sound
> > > > system where I can be *sure* my mp3s won't skip.
> > >
> > > Not unless you're loading your entire MP3 into memory, mlocking it down,
> > > and handing it off to a hard RT process. And then your control of the
> > > playback of said song through a non-RT GUI could be arbitrarily coarse,
> > > depending on load.
> >
> > Thanks for biting :-)
> >
> > First, these days it's no big deal to load an entire mp3 into memory.
> >
> > Second, and of more interest to broadcasting industry professionals and the
> > like, it's possible to write a real-time filesystem that bypasses all the
> > normal non-realtime facilities of the operating system, and where the latency
> > of every operation is bounded according to the amount of data transferred.
> > Such a filesystem could use its own dedicated disk, or, more practically, the
> > RTOS (or realtime subsystem) could operate the disk's block queue.
> >
> > If I recall correctly, XFS makes an attempt to provide such realtime
> > guarantees, or at least the Solaris version does.  However, the operating
> > system must be able to provide true realtime guarantees in order for the
> > filesystem to provide them, and I doubt that the combination of XFS and
> > Solaris can do that.
> 
> Nope, it can't.
> 
> Just bear in mind that it's next to impossible to avoid throwing the baby
> out with the bathwater here. Ok, so you've got an RT kernel playing your
> MP3 alongside your UNIX system - how do you control it? How do you switch
> tracks? All the latency that you were struggling with in the player is
> still there in the user interface.

I'm not sure that I, personally, am a realtime device anyway ;-)

In the context of an mp3 playback system, worrying about whether the
controls are realtime seems a little excessive.  But it's not too hard to
do.  Just allow the RTOS to take control of the input devices, or at least
to insert itself ahead of the general purpose operating system in the
interrupt pipeline.

As for a GUI with realtime response characteristics, that's more
challenging, but it has been done.  It's also less important I'd say.  You
can always fall back on dedicated hardware for the realtime display.

Such concerns become very practical matters when you get into the world of
industrial control systems.

> What you really want for an MP3 player is _not_ hard RT, what you want is
> very reliable low-latency. Which we can do without throwing away most of
> UNIX.

I think that depends on whether you are an audiophile or not.  Or a
broadcaster.  If you're a broadcaster, how many mp3 skips will you tolerate
a year?  By way of analogy, if you're a network administrator, how many
unplanned reboots will you tolerate a year, if you know that by merely
changing the software, you will have none?  There's something to be said
for reliability that is *provable*.

And who said anything about throwing away most of Unix?

-- 
Daniel
