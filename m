Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132176AbRBKLik>; Sun, 11 Feb 2001 06:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130392AbRBKLib>; Sun, 11 Feb 2001 06:38:31 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:63912 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129992AbRBKLi0>; Sun, 11 Feb 2001 06:38:26 -0500
Message-ID: <3A867BDD.54C0FF49@uow.edu.au>
Date: Sun, 11 Feb 2001 22:47:41 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Hacksaw <hacksaw@hacksaw.org>,
        Tom Eastep <teastep@seattlefirewall.dyndns.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Major Clock Drift
In-Reply-To: <Pine.LNX.4.30.0102040908320.877-100000@wookie.seattlefirewall.dyndns.org> <200102041804.f14I4br22433@habitrail.home.fools-errant.com> <3A7EA9B3.3507DC8D@uow.edu.au>, <3A7EA9B3.3507DC8D@uow.edu.au>; <20010210225851.G7877@bug.ucw.cz> <3A8671FF.C390FDCC@uow.edu.au>,
		<3A8671FF.C390FDCC@uow.edu.au>; from andrewm@uow.edu.au on Sun, Feb 11, 2001 at 10:05:35PM +1100 <20010211120614.E23048@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> > > Vesafb is happy to block interrupts for half a second.
> >
> > And has this been observed to cause clock drift?
> 
> YEs. I've seen time running 3 times slower. Just do cat /etc/termcap
> with loaded PCI bus. Yesterday I lost 20 minutes during 2 hours -- I
> have been using USB (load PCI) and framebuffer.

That's not good.  Very not good.

James Simmons has been looking into using something other
than spin_lock_irq(console_lock) to provide the
serialisation which these drivers need.  Apparently
it got messy.  I'm interested in getting involved
with this problem as well.  Sounds like it may not be
2.4 stuff though.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
