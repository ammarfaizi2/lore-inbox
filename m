Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265336AbRF0Rqm>; Wed, 27 Jun 2001 13:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265337AbRF0Rqc>; Wed, 27 Jun 2001 13:46:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63496 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265336AbRF0RqY>;
	Wed, 27 Jun 2001 13:46:24 -0400
Date: Wed, 27 Jun 2001 19:41:27 +0200
From: Jens Axboe <axboe@suse.de>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to change DVD-ROM speed?
Message-ID: <20010627194127.H17905@suse.de>
In-Reply-To: <Pine.LNX.4.33.0106271018000.32012-100000@heat.gghcwest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0106271018000.32012-100000@heat.gghcwest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27 2001, Jeffrey W. Baker wrote:
> I am trying to change the spin rate of my IDE DVD-ROM drive.  My system is
> an Apple PowerBook G4, and I am using kernel 2.4.  I want the drive to
> spin at 1X when I watch movies.  Currently, it spins at its highest speed,
> which is very loud and a large power load.
> 
> /proc/sys/dev/cdrom/info indicates that the speed of the drive can be
> changed.  I use hdparm -E 1 /dev/dvd to attempt to set the speed, and it
> reports success.  However, the drive continues to spin at its highest
> speed.

Linux still uses the old-style SET_SPEED command, which is probably not
supported correctly by your newer drive. Just checking, I see latest Mt
Fuji only lists it for CD-RW. For DVD, we're supposed to do
SET_STREAMING to specify such requirements.

Feel free to implement it :-)

-- 
Jens Axboe

