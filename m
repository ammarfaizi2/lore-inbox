Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279190AbRKRKvZ>; Sun, 18 Nov 2001 05:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279201AbRKRKvQ>; Sun, 18 Nov 2001 05:51:16 -0500
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:52097 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S279190AbRKRKvN>;
	Sun, 18 Nov 2001 05:51:13 -0500
Date: Sun, 18 Nov 2001 02:51:02 -0800
From: Simon Kirby <sim@netnation.com>
To: Jens Axboe <axboe@suse.de>
Cc: bartscgr@studbox.uni-stuttgart.de, linux-kernel@vger.kernel.org
Subject: Re: DVD_LU_SEND_AGID slow since 2.4.10
Message-ID: <20011118025102.A7651@netnation.com>
In-Reply-To: <Pine.LNX.4.40.0111080054480.26201-100000@goofy.disney.gb> <20011108014151.A27093@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011108014151.A27093@suse.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 01:41:51AM +0100, Jens Axboe wrote:

> > ever since 2.4.10 the SEND_AGID DVD_AUTH control seems to be very slow
> > (used in libdvdcss, freezes xine for up to 30sec). The code that's
> > executed seems to be:
> > 
> >     dvd_authinfo auth_info;
> > 
> >     memset( &auth_info, 0, sizeof( auth_info ) );
> >     auth_info.type = DVD_LU_SEND_AGID;
> >     auth_info.lsa.agid = *pi_agid;
> > 
> >     i_ret = ioctl( i_fd, DVD_AUTH, &auth_info );
> > 
> > anybody here have any idea what might cause this? could this really be
> > just a caching problem caused by the new vm or is this something
> > completely different I observe here? The -ac kernel series doesn't seem to
> > have this problem on the same machine.
> > 
> > Any comments apreciated, please cc as I'm not subscribed to the list
> 
> Seems to have infested other (cdrom) ioctls as well. I'll take a look.

Any conclusion?  It's quite annoying.  It now takes around 30 seconds
before xine can even start playing a DVD.

Thinking it was the block device changes, I tried holding open /dev/hdd
and /dev/scd0, but it doesn't seem to make any difference.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
