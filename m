Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbRBDQr7>; Sun, 4 Feb 2001 11:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131206AbRBDQrt>; Sun, 4 Feb 2001 11:47:49 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:14473 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129078AbRBDQri>; Sun, 4 Feb 2001 11:47:38 -0500
Date: Sun, 4 Feb 2001 16:46:30 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Steve Underwood <steveu@coppice.org>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Better battery info/status files
In-Reply-To: <3A7D8116.CA16340B@coppice.org>
Message-ID: <Pine.SOL.4.21.0102041641170.7886-100000@green.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2001, Steve Underwood wrote:
> James Sutherland wrote:
> > On Sun, 4 Feb 2001, Ben Ford wrote:
> > > David Woodhouse wrote:
> > > > On Sun, 4 Feb 2001, James Sutherland wrote:
> > > >
> > > > > For the end-user, the ability to see readings in other units would be
> > > > > useful - how many people on this list work in litres/metres/kilometres,
> > > > > and how many in gallons/feet/miles? Probably enough in both groups that
> > > > > neither could count as universal...
> > > >
> > > > Yeah. We can have this as part of the locale settings, changable by
> > > > echoing the desired locale string to /proc/sys/kernel/lc_all.
> > >
> > > Just an idea, . .  but isn't this something better done in userland?
> > >
> > > (ben@Deacon)-(06:49am Sun Feb  4)-(ben)
> > > $ date  +%s
> > > 981298161
> > > (ben@Deacon)-(06:49am Sun Feb  4)-(ben)
> > > $ date  +%c
> > > Sun Feb  4 06:49:24 2001
> > 
> > That's what I'd do, anyway - /dev/pieceofstring would return the length of
> > said piece of string in some units, explicityly stated. (e.g. "5m" or
> > "15ft").
> > 
> > "uname -s" ("how long's a piece of string on this system") would then
> > convert the length into feet, metres or fathoms, depending on what the
> > user prefers.
> 
> Don't get carried away. In the present context we are only talking about
> time and electrical measurements. Whilst most of the human race can't
> read the English labels in /proc, they all use the same measurements for
> electrical units and time (unless the time exceeds 24 hours, where dates
> get a bit screwed up). In this case even the US in in line with the rest
> of humanity............. or would you like to be able to express battery
> capacity in BTUs?

Personally, I'd prefer a percentage and/or estimated time remaining
anyway... However, from the kernel's PoV, the rule is just "KISS". Print
in something consistent, let userspace do any conversions you
want. Probably seconds for time (simplest - scripts can compare "if
est_batterylife_remaining < 300 do something", UI things can convert to
H:M:S or whatever), watts for power.

What is measured, BTW - battery voltage, presumably, and drain
current?


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
