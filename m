Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBGQlQ>; Wed, 7 Feb 2001 11:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129214AbRBGQlG>; Wed, 7 Feb 2001 11:41:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:21767 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129031AbRBGQk5>;
	Wed, 7 Feb 2001 11:40:57 -0500
Date: Wed, 7 Feb 2001 17:40:47 +0100
From: Jens Axboe <axboe@suse.de>
To: Paul Powell <moloch16@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ioctl CDROMRESET has no effect
Message-ID: <20010207174047.D20618@suse.de>
In-Reply-To: <20010207163432.25823.qmail@web114.yahoomail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010207163432.25823.qmail@web114.yahoomail.com>; from moloch16@yahoo.com on Wed, Feb 07, 2001 at 08:34:32AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07 2001, Paul Powell wrote:
> I'm attempting to reset a CDROM using the CDROMRESET
> ioctl.  The reset command only seems to reset the
> device if the device is not mounted.  If the device is
> mounted, the reset command seems to have no effect.
> 
> With the device unmounted, sending the reset command
> causes the drive to become active and I see the
> activity light light up.  With the device mounted, the
> activity light does nothing.  I also can't open the
> CD-ROM drive using the eject button after resetting a
> mounted CD.
> 
> It seems the reset command should work even if the OS
> thinks the device is mounted for error recovery.

There's no special code to send different reset depending
on whether the drive is mounted or not. If you drive
reacts differently to a reset if it's locked, then tough
luck.

>    result = ioctl(fd, CDROMRESET, 1);
                                    ^^

There are no valid parameters for a reset.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
