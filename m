Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288594AbSBDGcY>; Mon, 4 Feb 2002 01:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288595AbSBDGcN>; Mon, 4 Feb 2002 01:32:13 -0500
Received: from squeaker.ratbox.org ([63.216.218.7]:31749 "EHLO
	squeaker.ratbox.org") by vger.kernel.org with ESMTP
	id <S288594AbSBDGcF>; Mon, 4 Feb 2002 01:32:05 -0500
Date: Mon, 4 Feb 2002 01:39:00 -0500 (EST)
From: Aaron Sethman <androsyn@ratbox.org>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Dan Kegel <dank@kegel.com>, Kev <klmitch@MIT.EDU>,
        Arjen Wolfs <arjen@euro.net>, <coder-com@undernet.org>,
        <feedback@distributopia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Coder-Com] Re: PROBLEM: high system usage / poor SMPnetwork 
 performance
In-Reply-To: <20020204062429Z16034-10748+186@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.44.0202040133161.3086-100000@simon.ratbox.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2002, Daniel Phillips wrote:

> On February 4, 2002 07:26 am, Aaron Sethman wrote:
> > On Mon, 4 Feb 2002, Daniel Phillips wrote:
> > > In an effort to somehow control the mushrooming number of IO interface
> > > strategies, why not take a look at the work Ben and Suparna are doing in aio,
> > > and see if there's an interface mechanism there that can be repurposed?
> >
> > When AIO no longer sucks on pretty much every platform on the face of the
> > planet I think people will reconsider.
>
> What is the hang, as you see it?
Well on many platforms its implemented via pthreads, which in general
isn't terribly acceptable when you need to deal with 5000 connections in
one process.  I would like to see something useful that works well, and
performs well.  I think the FreeBSD guys had the right idea with their
kqueue interface, shame they couldn't have written it around the posix aio
interface.  But I suppose it would be trivial to write a wrapper around
it.

But the real issue is, that the standard interfaces, select() and poll()
are inadequate in the face of current requirements.   Posix AIO seems like
its heading down the right path, but it just isn't ready in any mature
implementation yet, thus pushing people away from it, making the problem
worse.


> > In the mean time, we've got to
> > deal with that is there.  That leaves us writing for at least 6 very
> > similiar, I/O models with varying attributes.
>
> This is really an unfortunate situation.

I agree with you 150% on that statement.  Lots of wasted time reinventing
tires for the latest and greatest wheel.

Regards,

Aaron

