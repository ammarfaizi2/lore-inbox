Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264893AbRF0SCN>; Wed, 27 Jun 2001 14:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbRF0SCD>; Wed, 27 Jun 2001 14:02:03 -0400
Received: from w146.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.146]:43173 "EHLO
	windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S264893AbRF0SBv>; Wed, 27 Jun 2001 14:01:51 -0400
Date: Wed, 27 Jun 2001 10:59:23 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@heat.gghcwest.com>
To: Jens Axboe <axboe@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: How to change DVD-ROM speed?
In-Reply-To: <20010627194127.H17905@suse.de>
Message-ID: <Pine.LNX.4.33.0106271056360.32012-100000@heat.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Jun 2001, Jens Axboe wrote:

> On Wed, Jun 27 2001, Jeffrey W. Baker wrote:
> > I am trying to change the spin rate of my IDE DVD-ROM drive.  My system is
> > an Apple PowerBook G4, and I am using kernel 2.4.  I want the drive to
> > spin at 1X when I watch movies.  Currently, it spins at its highest speed,
> > which is very loud and a large power load.
> >
> > /proc/sys/dev/cdrom/info indicates that the speed of the drive can be
> > changed.  I use hdparm -E 1 /dev/dvd to attempt to set the speed, and it
> > reports success.  However, the drive continues to spin at its highest
> > speed.
>
> Linux still uses the old-style SET_SPEED command, which is probably not
> supported correctly by your newer drive. Just checking, I see latest Mt
> Fuji only lists it for CD-RW. For DVD, we're supposed to do
> SET_STREAMING to specify such requirements.
>
> Feel free to implement it :-)

I will be happy to :)  Should I hang conditional code off the existing
ioctl (CDROM_SELECT_SPEED, ide_cdrom_select_speed) or use a new one?

Best,
Jeffrey

