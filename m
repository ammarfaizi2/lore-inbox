Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267085AbSLDVJ4>; Wed, 4 Dec 2002 16:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267086AbSLDVJ4>; Wed, 4 Dec 2002 16:09:56 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:17093 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S267085AbSLDVJz>; Wed, 4 Dec 2002 16:09:55 -0500
Message-ID: <3DEE70C4.5D74A8B3@attbi.com>
Date: Wed, 04 Dec 2002 16:16:52 -0500
From: "George G. Davis" <davis_g@attbi.com>
Reply-To: davis_g@attbi.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-17.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Jim Van Zandt <jrv@vanzandt.mv.com>, device@lanana.org,
       linux-kernel@vger.kernel.org
Subject: Re: Why does the Comtrol Rocketport card not have a major assigned?
References: <20021204205525.GE2544@fs.tum.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> 
> Perhaps it's a silly question but I'd like to know why it is the way it
> is:
> 
> The 2.2, 2.4 and 2.5 kernels include a driver for the Comtrol Rocketport
> card (drivers/char/dtlk.c) which uses a local major (it does a
>   "register_chrdev(0, "dtlk", &dtlk_fops);
> ). Is there a reason why it doesn't have a fixed major assigned?

Huh?:

	dtlk.c - DoubleTalk PC driver for Linux

That doesn't look like the Comtrol Rocketport (drivers/char/rocket.c)
driver to me. : )

Meanwhile 2.4.19 Documentation/devices.txt shows:

 46 char        Comtrol Rocketport serial card
                  0 = /dev/ttyR0        First Rocketport port
                  1 = /dev/ttyR1        Second Rocketport port
                    ...

--
Regards,
George

> TIA
> Adrian
> 
> --
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
