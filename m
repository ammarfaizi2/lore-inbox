Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316390AbSFEUy5>; Wed, 5 Jun 2002 16:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316404AbSFEUy4>; Wed, 5 Jun 2002 16:54:56 -0400
Received: from mark.mielke.cc ([216.209.85.42]:21769 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S316390AbSFEUyy>;
	Wed, 5 Jun 2002 16:54:54 -0400
Date: Wed, 5 Jun 2002 16:48:37 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Message-ID: <20020605164837.A25348@mark.mielke.cc>
In-Reply-To: <E17FfU7-0001dP-00@starship> <Pine.LNX.4.44.0206051330060.2614-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 02:13:19PM -0500, Oliver Xymoron wrote:
> On Wed, 5 Jun 2002, Daniel Phillips wrote:
> > > So... an RT .mp3 player task that receives asynchronous signals from a
> > > non-RT .mp3 player GUI front-end? So, we assume that the .mp3 data
> > > gets sent from the non-RT file system to the RT task (via the non-RT
> > > GUI front-end) in its entirety before it begins playing...
> > > Other than as a play RT project, seems like a waste of effort to me..
> > Your opinion is noted, however it's also noted that you didn't support it
> > in any way.
> Neither have you, at least aside from hand-waving. I've actually built a
> bunch of systems that were originally spec'ed to be hybrids. Wouldn't be
> surprised if Mark had too, given his Nortel address.

I haven't actually (different side of the company). I've talked to a few
people that have (in Nortel), and done a little research on the side.

The biggest peave I have against RT is that people think it is the
solution to everything. The *idea* that somebody would want an RT .mp3
player for their designer desktop machine causes this feeling I have
to be quite exaggerated. If I wanted to mock an RT-supporter I would
have joked "why don't you write a .mp3 player in RT too?" and here I
see it being presented as a valid application for RT.

RT is definately useful. This is especially true of any sort of
dedicated hardware that must serve data at close to full capacity with
almost zero chance of data loss or lag. (Such as telephone switches)

It isn't a toy. It is much harder to code an RT application, and the
fact that hardware is running an RT application ensures that overall
performance will suffer. The RT requirement is not a natural addition
to an operating system such as Linux, which is why it is very
effective to execute Linux as if it was a non-RT task.

I like the idea of Adeos, and nanokernels. I like the idea of RT, and
I like the fact that the Open Source community is interested in all of
these topics. It means that solutions such as VxWorks now have real
competition, and they will be forced to make their large price tag
purchase real value for customers, or customers will shop elsewhere.

Just... an .mp3 player for a desktop environment? This is a
joke. Maybe the RTOS can perform my compiles too? That way will be
able to accurately predict how long it will take to compile
linux-2.4.18 each and every time. A desktop environment has very few,
if *any* real time requirements, and those that do should be
implemented in dedicated hardware, and not on the main
CPU. (i.e. SCSI, hard drives, ethernet cards, ...)

> > Also, it appears you didn't read the post you responded to.  Two
> > alternatives were presented:
> >   1) Load the whole mp3 into memory before playing it
> And that alternative sucks. Think scalability.

It appears that Daniel didn't read my post that he accused me of composing
before reading the post that he thinks I didn't read. He doesn't need to
look far above to see (as quoted):

> > > non-RT .mp3 player GUI front-end? So, we assume that the .mp3 data
> > > gets sent from the non-RT file system to the RT task (via the non-RT
> > > GUI front-end) in its entirety before it begins playing...

"So, we assume that the .mp3 data gets sent from the non-RT file system
to the RT task (via the non-RT GUI front-end) in its entirety before it
begins playing..."

To me this looks a lot like "Load the whole mp3 into memory before
playing it", except I bothered to include vague details about how to
accomplish this.

The alternative still sucks, and isn't scalable (i.e. none of this
post is a disagreement with Oliver...), but more than that, it seems
like a horrible waste of effort except as a proof-of-concept demo like
"Hello World!". It is a joke that shows the exact feeling that some of
us have that people think RT solves everything in all of its glory.

> >   2) Implement a filesystem with realtime response
> And your shared fs alternative sucks. Think abysmal disk throughput for
> the rest of the system. Think starvation. Think all the reasons we've been
> trying to clean up the elevator code times ten. And that's just for the
> device queue, never mind the deadlock avoidance problems. See "priority
> inversion".

Summary: Linux + RTOS should never become VxWorks.

> > Both approaches have their uses.  The second is the one I'm interested in,
> > if that isn't already obvious.  The first is just a quick hack that will
> > give you guaranteed-skipless audio playback, something that Linux is
> > currently unable to do.
> Umm, neither can your CD player. But if you take the proper precautions to
> avoid it being jostled, clean your discs, and give it decent buffering, it
> will be more than satisfactory. Can we bring Linux up to the same
> standard with the pre-empt and low-latency approaches? Yes. Is this a
> better approach than grafting quixotic kernels onto the side of the box?
> Definitely.
> There is a place for hard realtime. But desktop MP3 playing is not it.

In fact, if fewer people thought that RT was more than a specialized
solution to a very specific problem domain, I wouldn't have such
negative feelings for the people that do.

I have a hammer in my toolbox too. That doesn't mean I use it to fix
every thing that breaks at my house.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

