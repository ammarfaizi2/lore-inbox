Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262399AbSJDQVk>; Fri, 4 Oct 2002 12:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262400AbSJDQVj>; Fri, 4 Oct 2002 12:21:39 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:12693 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262399AbSJDQVi>; Fri, 4 Oct 2002 12:21:38 -0400
Date: Fri, 4 Oct 2002 10:27:07 -0600
Message-Id: <200210041627.g94GR7M08781@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: Greg KH <greg@kroah.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] minor devfs cleanup for 2.5.40
In-Reply-To: <20021004172457.A3390@infradead.org>
References: <20021003213908.GB1388@kroah.com>
	<200210041617.g94GHY008334@vindaloo.ras.ucalgary.ca>
	<20021004172457.A3390@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
> On Fri, Oct 04, 2002 at 10:17:34AM -0600, Richard Gooch wrote:
> > Greg KH writes:
> > > Here's a changeset from Christoph Hellwig that removes some unneeded
> > > code from the kernel core.  This was leftover from before devfs became
> > > part of the main kernel tree, and was trying to do some naming fixups in
> > > kernelspace.  If anyone still has machines using these names, their
> > > startup scripts should be modified to use the "standard" devfs names.
> > > 
> > > Please pull from:  http://linuxusb.bkbits.net/devfs-2.5
> > 
> > NO! Dammit, you'll break everyone who is using these compact names to
> > mount the root FS. Look more closely at the code you're trying to
> > remove, and you'll see it's *not* used to avoid work in startup
> > scripts. It's only used to create the devfs entry for the root FS.
> 
> This is 2.5 and those names were never in mainline.  Use your new
> devfs names or plain linux names or just hex numbers.  Linux is
> not a place were we keep junk around.

Those names *were* in mainline. They've been there all through 2.4.x.
It's a useful feature that is *still* being used. Change this and lots
of people will get a panic at boot because there root FS is "missing".

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
