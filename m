Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130604AbRBARto>; Thu, 1 Feb 2001 12:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130766AbRBARte>; Thu, 1 Feb 2001 12:49:34 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:49682 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130604AbRBARtT>; Thu, 1 Feb 2001 12:49:19 -0500
Date: Thu, 1 Feb 2001 11:48:48 -0600
To: John Jasen <jjasen1@umbc.edu>
Cc: "Michael J. Dikkema" <mjd@moot.ca>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.1 - can't read root fs (devfs maybe?)
Message-ID: <20010201114848.A4161@cadcamlab.org>
In-Reply-To: <Pine.LNX.4.21.0101312258190.227-100000@sliver.moot.ca> <Pine.SGI.4.31L.02.0102011058520.71788-100000@irix2.gl.umbc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.SGI.4.31L.02.0102011058520.71788-100000@irix2.gl.umbc.edu>; from jjasen1@umbc.edu on Thu, Feb 01, 2001 at 11:00:05AM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Michael J. Dikkema]
> > I went from 2.4.0 to 2.4.1 and was surprised that either the root
> > filesystem wasn't mounted, or it couldn't be read. I'm using devfs.. I'm
> > thinking there might have been a change with regards to the devfs
> > tree.. is the legacy /dev/hda1 still /dev/discs/disc0/part1?
> >
> > I can't even get a shell with init=/bin/bash..

[John Jasen]
> Sounds like a lack of devfsd, which handles backwards compatibility
> for /dev entries.

devfsd does not start up until after the root filesystem is mounted, so
that's not it.

I don't think you can use the /dev/discs/ link for "root=".  It was a
long time ago that I ran into this issue -- but as I recall, links with
'..' in them do not work before the vfs is fully operational.  When I
brought it up with Richard he basically said "don't do that then".

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
