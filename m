Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129042AbRBKMVi>; Sun, 11 Feb 2001 07:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129047AbRBKMV3>; Sun, 11 Feb 2001 07:21:29 -0500
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:21521 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129042AbRBKMVQ>; Sun, 11 Feb 2001 07:21:16 -0500
Date: Sun, 11 Feb 2001 12:14:39 +0000
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <andrewm@uow.edu.au>, Hacksaw <hacksaw@hacksaw.org>,
        Tom Eastep <teastep@seattlefirewall.dyndns.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Major Clock Drift
Message-ID: <20010211121439.A1039@colonel-panic.com>
Mail-Followup-To: pdh, Pavel Machek <pavel@suse.cz>,
	Andrew Morton <andrewm@uow.edu.au>, Hacksaw <hacksaw@hacksaw.org>,
	Tom Eastep <teastep@seattlefirewall.dyndns.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0102040908320.877-100000@wookie.seattlefirewall.dyndns.org> <200102041804.f14I4br22433@habitrail.home.fools-errant.com> <3A7EA9B3.3507DC8D@uow.edu.au>, <3A7EA9B3.3507DC8D@uow.edu.au>; <20010210225851.G7877@bug.ucw.cz> <3A8671FF.C390FDCC@uow.edu.au> <20010211120614.E23048@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010211120614.E23048@atrey.karlin.mff.cuni.cz>; from pavel@suse.cz on Sun, Feb 11, 2001 at 12:06:14PM +0100
From: Peter Horton <pdh@colonel-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2001 at 12:06:14PM +0100, Pavel Machek wrote:
> 
> > > > > >I've discovered that heavy use of vesafb can be a major source of clock
> > > > > >drift on my system, especially if I don't specify "ypan" or "ywrap". On my
> > > > >
> > > > > This is extremely interesting. What version of ntp are you using?
> > > >
> > > > Is vesafb one of the drivers which blocks interrupts for (many) tens
> > > > of milliseconds?
> > > 
> > > Vesafb is happy to block interrupts for half a second.
> > 
> > And has this been observed to cause clock drift?
> 
> YEs. I've seen time running 3 times slower. Just do cat /etc/termcap
> with loaded PCI bus. Yesterday I lost 20 minutes during 2 hours -- I
> have been using USB (load PCI) and framebuffer.
> 								Pavel

Is it not possible to save/check TSC in timer interrupt to correct for
dropped interrupts ? (obviously only on machines that have a TSC ...)

P.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
