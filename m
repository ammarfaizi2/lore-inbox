Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315923AbSFETN2>; Wed, 5 Jun 2002 15:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSFETN1>; Wed, 5 Jun 2002 15:13:27 -0400
Received: from waste.org ([209.173.204.2]:39390 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S315923AbSFETNX>;
	Wed, 5 Jun 2002 15:13:23 -0400
Date: Wed, 5 Jun 2002 14:13:19 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Mark Mielke <mark@mark.mielke.cc>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
In-Reply-To: <E17FfU7-0001dP-00@starship>
Message-ID: <Pine.LNX.4.44.0206051330060.2614-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002, Daniel Phillips wrote:

> On Wednesday 05 June 2002 20:06, Mark Mielke wrote:
> > On Wed, Jun 05, 2002 at 07:32:34PM +0200, Daniel Phillips wrote:
> > > On Wednesday 05 June 2002 17:37, Oliver Xymoron wrote:
> > > > No, the mistake is assuming that loosely coupling UNIX to RT lets you
> > > > leverage much of anything from UNIX.
> > >    - Compiler
> > >    - Debugger
> > >    - Editor
> > >    - GUI
> > >    - IPC
> > >    - Any program that doesn't require realtime response
> > >    - Memory protection
> > >    - Physical hardware can be shared
> > >    - I could go on...
> >
> > So... an RT .mp3 player task that receives asynchronous signals from a
> > non-RT .mp3 player GUI front-end? So, we assume that the .mp3 data
> > gets sent from the non-RT file system to the RT task (via the non-RT
> > GUI front-end) in its entirety before it begins playing...
> >
> > Other than as a play RT project, seems like a waste of effort to me... :-)
>
> Your opinion is noted, however it's also noted that you didn't support it in
> any way.

Neither have you, at least aside from hand-waving. I've actually built a
bunch of systems that were originally spec'ed to be hybrids. Wouldn't be
surprised if Mark had too, given his Nortel address.

> Also, it appears you didn't read the post you responded to.  Two alternatives
> were presented:
>
>   1) Load the whole mp3 into memory before playing it

And that alternative sucks. Think scalability.

>   2) Implement a filesystem with realtime response

And your shared fs alternative sucks. Think abysmal disk throughput for
the rest of the system. Think starvation. Think all the reasons we've been
trying to clean up the elevator code times ten. And that's just for the
device queue, never mind the deadlock avoidance problems. See "priority
inversion".

> Both approaches have their uses.  The second is the one I'm interested in,
> if that isn't already obvious.  The first is just a quick hack that will
> give you guaranteed-skipless audio playback, something that Linux is
> currently unable to do.

Umm, neither can your CD player. But if you take the proper precautions to
avoid it being jostled, clean your discs, and give it decent buffering, it
will be more than satisfactory. Can we bring Linux up to the same
standard with the pre-empt and low-latency approaches? Yes. Is this a
better approach than grafting quixotic kernels onto the side of the box?
Definitely.

There is a place for hard realtime. But desktop MP3 playing is not it.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

