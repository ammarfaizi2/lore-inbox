Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312447AbSDNTk6>; Sun, 14 Apr 2002 15:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312449AbSDNTk5>; Sun, 14 Apr 2002 15:40:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47880 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S312447AbSDNTk4>; Sun, 14 Apr 2002 15:40:56 -0400
Date: Sun, 14 Apr 2002 21:40:58 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: faster boots?
Message-ID: <20020414194058.GA4269@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200204080057.g380vbO00868@vindaloo.ras.ucalgary.ca> <3CB0EF0B.14D48619@zip.com.au> <20020408095717.GB27999@atrey.karlin.mff.cuni.cz> <20020408174333.A28116@kushida.apsleyroad.org> <20020408124803.A14935@redhat.com> <20020409015657.A28889@kushida.apsleyroad.org> <20020409222214.GK5148@atrey.karlin.mff.cuni.cz> <20020412114422.A24021@kushida.apsleyroad.org> <20020412114252.GB1893@atrey.karlin.mff.cuni.cz> <20020412152918.A24356@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >     while :; do cat /proc/stat; sleep 1; done
> > > 
> > > Then I see a few writes have occurred at nearly every iteration.  I
> > > think that is due to the atime updates, because using "noatime" there
> > > are no writes at most iterations.
> > 
> > Well, that's no problem. noflushd stops kflushd, so it should work
> > even with atime. [It works for me with atimes!]
> > 
> > > But more interesting: I only see those few-per-second atime writes while
> > > noflushd is running.  If I kill noflushd then they go away.
> > 
> > ?
> 
> Another curious thing: even if the regular writes were caused by atime
> updates, there is no reason for them to be flushed every second, is
> there?
> 
> Yet the hard disk light flashes about once per second when (a) running
> the above shell line and (b) running noflushd, and (c) _not_ using
> "noatime" (just "nodiratime").  (Remove any of those and it stops).  And
> /proc/stat shows writes happening.
> 
> This is on ext3.  I wonder if journalling is causing a problem.  Pavel,
> are you running ext3?

No, plain old ext2. Yep, ext3 could have some strange interactions
with noflushd.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
