Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281192AbRKHAmY>; Wed, 7 Nov 2001 19:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281202AbRKHAmQ>; Wed, 7 Nov 2001 19:42:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27915 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281192AbRKHAmA>;
	Wed, 7 Nov 2001 19:42:00 -0500
Date: Thu, 8 Nov 2001 01:41:51 +0100
From: Jens Axboe <axboe@suse.de>
To: bartscgr@studbox.uni-stuttgart.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: DVD_LU_SEND_AGID slow since 2.4.10
Message-ID: <20011108014151.A27093@suse.de>
In-Reply-To: <Pine.LNX.4.40.0111080054480.26201-100000@goofy.disney.gb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0111080054480.26201-100000@goofy.disney.gb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08 2001, Guenter Bartsch wrote:
> Hallo list,
> 
> ever since 2.4.10 the SEND_AGID DVD_AUTH control seems to be very slow
> (used in libdvdcss, freezes xine for up to 30sec). The code that's
> executed seems to be:
> 
>     dvd_authinfo auth_info;
> 
>     memset( &auth_info, 0, sizeof( auth_info ) );
>     auth_info.type = DVD_LU_SEND_AGID;
>     auth_info.lsa.agid = *pi_agid;
> 
>     i_ret = ioctl( i_fd, DVD_AUTH, &auth_info );
> 
> anybody here have any idea what might cause this? could this really be
> just a caching problem caused by the new vm or is this something
> completely different I observe here? The -ac kernel series doesn't seem to
> have this problem on the same machine.
> 
> Any comments apreciated, please cc as I'm not subscribed to the list

Seems to have infested other (cdrom) ioctls as well. I'll take a look.

-- 
Jens Axboe

