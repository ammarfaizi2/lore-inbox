Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131478AbRBASwB>; Thu, 1 Feb 2001 13:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131578AbRBASvl>; Thu, 1 Feb 2001 13:51:41 -0500
Received: from mx3out.umbc.edu ([130.85.253.53]:1443 "EHLO mx3out.umbc.edu")
	by vger.kernel.org with ESMTP id <S131536AbRBASvj>;
	Thu, 1 Feb 2001 13:51:39 -0500
Date: Thu, 1 Feb 2001 13:51:35 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Peter Samuelson <peter@cadcamlab.org>
cc: "Michael J. Dikkema" <mjd@moot.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1 - can't read root fs (devfs maybe?)
In-Reply-To: <20010201114848.A4161@cadcamlab.org>
Message-ID: <Pine.SGI.4.31L.02.0102011349410.71788-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001, Peter Samuelson wrote:

>   [Michael J. Dikkema]
> > > I went from 2.4.0 to 2.4.1 and was surprised that either the root
> > > filesystem wasn't mounted, or it couldn't be read. I'm using devfs.. I'm
> > > thinking there might have been a change with regards to the devfs
> > > tree.. is the legacy /dev/hda1 still /dev/discs/disc0/part1?
> > >
> > > I can't even get a shell with init=/bin/bash..
>
> [John Jasen]
> > Sounds like a lack of devfsd, which handles backwards compatibility
> > for /dev entries.
>
> devfsd does not start up until after the root filesystem is mounted, so
> that's not it.

Errrr .... upon careful reading of the devfs/devfsd documentation, you'll
find that it says to put /sbin/devfsd /dev in amongst the first lines in
rc.sysinit.

In looking through rc.sysinit, / is not mounted rw until much later.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
