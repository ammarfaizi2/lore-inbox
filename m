Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131911AbRBAXzC>; Thu, 1 Feb 2001 18:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131987AbRBAXyx>; Thu, 1 Feb 2001 18:54:53 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:32825 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S131831AbRBAXyj>; Thu, 1 Feb 2001 18:54:39 -0500
Message-ID: <3A79F707.FD9629E6@linux.com>
Date: Thu, 01 Feb 2001 15:53:43 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Jasen <jjasen1@umbc.edu>
CC: Peter Samuelson <peter@cadcamlab.org>, "Michael J. Dikkema" <mjd@moot.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.1 - can't read root fs (devfs maybe?)
In-Reply-To: <Pine.SGI.4.31L.02.0102011349410.71788-100000@irix2.gl.umbc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Jasen wrote:

> On Thu, 1 Feb 2001, Peter Samuelson wrote:
>
> >   [Michael J. Dikkema]
> > > > I went from 2.4.0 to 2.4.1 and was surprised that either the root
> > > > filesystem wasn't mounted, or it couldn't be read. I'm using devfs.. I'm
> > > > thinking there might have been a change with regards to the devfs
> > > > tree.. is the legacy /dev/hda1 still /dev/discs/disc0/part1?
> > > >
> > > > I can't even get a shell with init=/bin/bash..
> >
> > [John Jasen]
> > > Sounds like a lack of devfsd, which handles backwards compatibility
> > > for /dev entries.
> >
> > devfsd does not start up until after the root filesystem is mounted, so
> > that's not it.
>
> Errrr .... upon careful reading of the devfs/devfsd documentation, you'll
> find that it says to put /sbin/devfsd /dev in amongst the first lines in
> rc.sysinit.
>
> In looking through rc.sysinit, / is not mounted rw until much later.

Logic suggests that the root filesystem must be mounted before init runs.  If
init=/bin/bash, no boot scripts are run, devfs should have populated /dev before
the init was spawned.  devfs doesn't depend on the write state of the filesystem.

I am running devfs on 2.4.1, automatically mounted.  I am having no problems.

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
