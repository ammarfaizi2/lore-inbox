Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSFETkw>; Wed, 5 Jun 2002 15:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316023AbSFETkv>; Wed, 5 Jun 2002 15:40:51 -0400
Received: from dsl-213-023-039-098.arcor-ip.net ([213.23.39.98]:22723 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315946AbSFETku>;
	Wed, 5 Jun 2002 15:40:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Oliver Xymoron <oxymoron@waste.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Date: Wed, 5 Jun 2002 21:40:07 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Mark Mielke <mark@mark.mielke.cc>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206051330060.2614-100000@waste.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Fgdc-0001dt-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 June 2002 21:13, Oliver Xymoron wrote:
> On Wed, 5 Jun 2002, Daniel Phillips wrote:
> 
> > On Wednesday 05 June 2002 20:06, Mark Mielke wrote:
> > > On Wed, Jun 05, 2002 at 07:32:34PM +0200, Daniel Phillips wrote:
> > > > On Wednesday 05 June 2002 17:37, Oliver Xymoron wrote:
> > > > > No, the mistake is assuming that loosely coupling UNIX to RT lets you
> > > > > leverage much of anything from UNIX.
> > > >    - Compiler
> > > >    - Debugger
> > > >    - Editor
> > > >    - GUI
> > > >    - IPC
> > > >    - Any program that doesn't require realtime response
> > > >    - Memory protection
> > > >    - Physical hardware can be shared
> > > >    - I could go on...
> > >
> > > So... an RT .mp3 player task that receives asynchronous signals from a
> > > non-RT .mp3 player GUI front-end? So, we assume that the .mp3 data
> > > gets sent from the non-RT file system to the RT task (via the non-RT
> > > GUI front-end) in its entirety before it begins playing...
> > >
> > > Other than as a play RT project, seems like a waste of effort to me... :-)
> >
> > Your opinion is noted, however it's also noted that you didn't support it in
> > any way.
> 
> Neither have you, at least aside from hand-waving.

Err.  Skipless.  Need I say more?

> I've actually built a
> bunch of systems that were originally spec'ed to be hybrids. Wouldn't be
> surprised if Mark had too, given his Nortel address.

I hope that's not an invitation to a resume war.  I built, or was instrumental
in building, a system that not only replaced a number of horribly expensive
motor regulators with software running closed loops over a realtime network,
but ran a gui, database, report generator, ladder logic, sensor inputs and
two-way network interface over serial lines, all on a 486.  So I know what
it's like to do it all with a realtime system.  I'd rather not, thankyou, not
the parts that don't need it.

> > Also, it appears you didn't read the post you responded to.  Two alternatives
> > were presented:
> >
> >   1) Load the whole mp3 into memory before playing it

I'll leave that to people who appreciate quality mp3 playback to decide.

> And that alternative sucks. Think scalability.
> 
> >   2) Implement a filesystem with realtime response
> 
> And your shared fs alternative sucks. Think abysmal disk throughput for
> the rest of the system. Think starvation. Think all the reasons we've been
> trying to clean up the elevator code times ten. And that's just for the
> device queue, never mind the deadlock avoidance problems. See "priority
> inversion".

What kind of argument is that?  It sounds like: because our current block
interface sucks, all block interfaces suck, and always will.  On the
contrary, I believe our current interface sucks precisely because it is
not built according to sound principles of realtime design.

You seem to be all in favor of giving up before you start.  That's not
how Linux was built.

> > Both approaches have their uses.  The second is the one I'm interested in,
> > if that isn't already obvious.  The first is just a quick hack that will
> > give you guaranteed-skipless audio playback, something that Linux is
> > currently unable to do.
> 
> Umm, neither can your CD player. But if you take the proper precautions to
> avoid it being jostled, clean your discs, and give it decent buffering, it
> will be more than satisfactory. Can we bring Linux up to the same
> standard with the pre-empt and low-latency approaches?

No you can't.  Grief.

-- 
Daniel
