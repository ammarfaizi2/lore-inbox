Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131547AbRAHTl4>; Mon, 8 Jan 2001 14:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132227AbRAHTlm>; Mon, 8 Jan 2001 14:41:42 -0500
Received: from [194.213.32.137] ([194.213.32.137]:2564 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131547AbRAHTla>;
	Mon, 8 Jan 2001 14:41:30 -0500
Message-ID: <20010105230546.A301@bug.ucw.cz>
Date: Fri, 5 Jan 2001 23:05:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <Pine.LNX.4.30.0101031847120.11227-100000@springhead.px.uk.com> <3A544925.B9BF4241@idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A544925.B9BF4241@idb.hist.no>; from Helge Hafting on Thu, Jan 04, 2001 at 10:57:57AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Being able to shut down by hitting the power switch is a little luxury
> > > for which I've been willing to invest more than a year of my life to
> > > attain.  Clueless newbies don't know why it should be any other way, and
> > > it's essential for embedded devices.
> > 
> > Clueless newbies (and slightly less clueless less newbie) type people
> > don't think that they should HAVE to. My two interests are coping with
> > particularly pedantic people who don't want there computer to hastle them
> > about what they should or shouldn't do, and slightly embedded systems
> > (e.g. set top box/web browsery thing that you want to be able to turn off
> > like a TV but it should still be able to have a writeable disc for config
> > and stuff you download/cache etc).
> 
> Nothing wrong with a filesystem (or apps) that can handle being powered
> down.
> But I prefer to handle this kind of users with a power switch that
> merely
> acts as a "shutdown button"  instead of actually killing power.
> The os will then run the equivalent of "shutdown -h now" 
> You may not have this luxury on an ordinary pc, but you do if you design
> embedded
> devices.  You will then be free to use existing GPL software that
> not necessarily handle a power failure well.

Heck, I hate hardware like that. Power button should kill the power,
immediately. It should not sync, it should not tell system, it should
just cut off the power. There _might_ be other button telling system
to shutdown.

Why is power button important? I already had 2 situations where
softpower could be pretty fatal, and one where it _was_ fatal.

1. on times of 486, badly inserted ISA card led to explosion of one of
low-integration chips. I've actually seen blue light. You can see
that soft-power-off is just not appropriate for such situation. [But I
probably could have survived soft-power off. Chip exploded and no more
damage seemed to happen.]

2. on the same 486, one wire got short-circuited. Smoke started
comming out of the box. By powering it down I even saved the wire (its
isolation started boiling).

3. few days ago, our hot-wave owen commited suicide. Device with soft
power controlled by CPU. During one night, CPU got crazy (power
glitch? EMI?) and heating turned on itself. Fan did not. Owen
destroyed itself.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
