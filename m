Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317529AbSFECk3>; Tue, 4 Jun 2002 22:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317530AbSFECk2>; Tue, 4 Jun 2002 22:40:28 -0400
Received: from waste.org ([209.173.204.2]:55750 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S317529AbSFECk1>;
	Tue, 4 Jun 2002 22:40:27 -0400
Date: Tue, 4 Jun 2002 21:40:25 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
In-Reply-To: <E17FQPj-0001Rr-00@starship>
Message-ID: <Pine.LNX.4.44.0206042132450.2614-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002, Daniel Phillips wrote:

> On Tuesday 04 June 2002 21:29, Oliver Xymoron wrote:
> > On Mon, 3 Jun 2002, Daniel Phillips wrote:
> >
> > > traditional IT.  Not to mention that I can look forward to a sound
> > > system where I can be *sure* my mp3s won't skip.
> >
> > Not unless you're loading your entire MP3 into memory, mlocking it down,
> > and handing it off to a hard RT process. And then your control of the
> > playback of said song through a non-RT GUI could be arbitrarily coarse,
> > depending on load.
>
> Thanks for biting :-)
>
> First, these days it's no big deal to load an entire mp3 into memory.
>
> Second, and of more interest to broadcasting industry professionals and the
> like, it's possible to write a real-time filesystem that bypasses all the
> normal non-realtime facilities of the operating system, and where the latency
> of every operation is bounded according to the amount of data transferred.
> Such a filesystem could use its own dedicated disk, or, more practically, the
> RTOS (or realtime subsystem) could operate the disk's block queue.
>
> If I recall correctly, XFS makes an attempt to provide such realtime
> guarantees, or at least the Solaris version does.  However, the operating
> system must be able to provide true realtime guarantees in order for the
> filesystem to provide them, and I doubt that the combination of XFS and
> Solaris can do that.

Nope, it can't.

Just bear in mind that it's next to impossible to avoid throwing the baby
out with the bathwater here. Ok, so you've got an RT kernel playing your
MP3 alongside your UNIX system - how do you control it? How do you switch
tracks? All the latency that you were struggling with in the player is
still there in the user interface.

What you really want for an MP3 player is _not_ hard RT, what you want is
very reliable low-latency. Which we can do without throwing away most of
UNIX.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

