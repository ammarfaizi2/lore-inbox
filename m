Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311710AbSE0EML>; Mon, 27 May 2002 00:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314223AbSE0EMK>; Mon, 27 May 2002 00:12:10 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:50828 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S311710AbSE0EMI>;
	Mon, 27 May 2002 00:12:08 -0400
Date: Mon, 27 May 2002 00:12:09 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Robert Schwebel <robert@schwebel.de>, <linux-kernel@vger.kernel.org>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <Pine.LNX.4.44.0205251025010.6515-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33L2.0205270006540.24180-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 May 2002, Linus Torvalds wrote:

> On Sat, 25 May 2002, Robert Schwebel wrote:
> > >
> > > Which is, in my opinion, the only sane way to handle hard realtime. No
> > > confusion about priority inversions, no crap. Clear borders between what
> > > is "has to happen _now_" and "this can do with the regular soft realtime".
> >
> > ... which in turn results in the situation that applications must be
> > implemented as kernel modules.
>
> That's a load of bull.
>
> It results in the fact that you need to have a _clear_interface_ between
> the hard realtime parts, and the stuff that isn't.

No, a lot of the time, the entire application is the algorithm -- in
Kernel space, as a module, very close to the driver. For further
clarification, see Robert's post regarding the layout of a typical
realtime application in RTLinux or RTAI.

>
> Yes, that does imply a certain amount of good design. And it requires you
> to understand which parts are time-critical, and which aren't.
>
> > This is only correct for open-loop applications. Most real life apps are
> > closed-loop.
>
> Most real life apps have nothing to do with hard-RT.

Can you clarify this?  Most computing in general has nothing to do with
hard RT?  Or are you saying that most real life engineers that use an RTOS
are simply doing overkill?



