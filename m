Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265388AbRF0Til>; Wed, 27 Jun 2001 15:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265390AbRF0Tic>; Wed, 27 Jun 2001 15:38:32 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:16201 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S265388AbRF0TiR>; Wed, 27 Jun 2001 15:38:17 -0400
Date: Wed, 27 Jun 2001 14:38:02 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200106271938.OAA78951@tomcat.admin.navo.hpc.mil>
To: axboe@suse.de, "Jeffrey W. Baker" <jwbaker@acm.org>
Subject: Re: How to change DVD-ROM speed?
Cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Wed, Jun 27 2001, Jeffrey W. Baker wrote:
> > > On Wed, Jun 27 2001, Jeffrey W. Baker wrote:
> > > > I am trying to change the spin rate of my IDE DVD-ROM drive.  My system is
> > > > an Apple PowerBook G4, and I am using kernel 2.4.  I want the drive to
> > > > spin at 1X when I watch movies.  Currently, it spins at its highest speed,
> > > > which is very loud and a large power load.
> > > >
> > > > /proc/sys/dev/cdrom/info indicates that the speed of the drive can be
> > > > changed.  I use hdparm -E 1 /dev/dvd to attempt to set the speed, and it
> > > > reports success.  However, the drive continues to spin at its highest
> > > > speed.
> > >
> > > Linux still uses the old-style SET_SPEED command, which is probably not
> > > supported correctly by your newer drive. Just checking, I see latest Mt
> > > Fuji only lists it for CD-RW. For DVD, we're supposed to do
> > > SET_STREAMING to specify such requirements.
> > >
> > > Feel free to implement it :-)
> > 
> > I will be happy to :)  Should I hang conditional code off the existing
> > ioctl (CDROM_SELECT_SPEED, ide_cdrom_select_speed) or use a new one?
> 
> Excellent. I'd say use the same ioctl if you can, but default to using
> SET_STREAMING for DVD drives.

As long as it still works for the combo drives - CD/CD-RW/DVD
Sony VIAO high end laptops, Toshiba has one, maybe others by now.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
