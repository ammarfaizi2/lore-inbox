Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129233AbRBOPjV>; Thu, 15 Feb 2001 10:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129596AbRBOPjO>; Thu, 15 Feb 2001 10:39:14 -0500
Received: from ldhb041.lss.emc.com ([168.159.59.41]:7684 "EHLO
	mobilix.atnf.CSIRO.AU") by vger.kernel.org with ESMTP
	id <S129233AbRBOPi7>; Thu, 15 Feb 2001 10:38:59 -0500
Date: Thu, 15 Feb 2001 08:20:42 +1100
Message-Id: <200102142120.f1ELKgd00416@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: David Ford <david@linux.com>
Cc: "Michael J. Dikkema" <mjd@moot.ca>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.1 - can't read root fs (devfs maybe?)
In-Reply-To: <3A79F812.D52B17B1@linux.com>
In-Reply-To: <Pine.LNX.4.21.0101312258190.227-100000@sliver.moot.ca>
	<3A79F812.D52B17B1@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford writes:
> "Michael J. Dikkema" wrote:
> 
> > I went from 2.4.0 to 2.4.1 and was surprised that either the root
> > filesystem wasn't mounted, or it couldn't be read. I'm using devfs.. I'm
> > thinking there might have been a change with regards to the devfs
> > tree.. is the legacy /dev/hda1 still /dev/discs/disc0/part1?
> 
> This symlink doesn't exist/isn't usable for boot.  Use the qualified
> pathname.

Actually, the /dev/ide/hd/... name is available for the root device.

Also, the kernel has special init code to parse /dev/hda1 and similar
names, so they should work too (as long as you don't have "devfs=only"
on your boot line). That's actually very old code (predates devfs).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
