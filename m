Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316589AbSGLPDW>; Fri, 12 Jul 2002 11:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316591AbSGLPDV>; Fri, 12 Jul 2002 11:03:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4007 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316589AbSGLPDU>;
	Fri, 12 Jul 2002 11:03:20 -0400
Date: Fri, 12 Jul 2002 17:05:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Thunder from the hill <thunder@ngforever.de>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020712150553.GI22858@suse.de>
References: <Pine.SOL.4.30.0207121611170.14389-100000@mion.elka.pw.edu.pl> <3D2EE7BA.8080805@evision-ventures.com> <20020712144145.GH22858@suse.de> <3D2EEF17.8070408@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D2EEF17.8070408@evision-ventures.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12 2002, Martin Dalecki wrote:
> U?ytkownik Jens Axboe napisa?:
> >On Fri, Jul 12 2002, Martin Dalecki wrote:
> >
> >>Workarounds in ide-cd - none.
> >
> >
> >you must be kidding?
> >
> 
> OK OK.
> 
> 
> 	} else  if (ireason == 1) {
> 		/* Some drives (ASUS) seem to tell us that status
> 		 * info is available. just get it and ignore.
> 		 */
> 		ata_status(drive, 0, 0);
> 		return 0;
> 	} else {
> 		/* Drive wants a command packet, or invalid ireason... */
> 		printk ("%s: cdrom_read_intr: bad interrupt reason %d\n",
> 			drive->name, ireason);
> 	}

There are more, the BCD stuf, etc. I'm just saying there are quite a few
work-arounds buried here and there in ide-cd, saying 'none' is a bit
simplified.

> Long time not enabled one:
> 
> #if !STANDARD_ATAPI
>         /* the Sanyo 3 CD changer uses byte 7 of TEST_UNIT_READY to
>            switch CDs instead of supporting the LOAD_UNLOAD opcode   */
> 
>         cmd[7] = cdi->sanyo_slot % 3;
> #endif

Not enabled per-default, but possible. Dunno if anyone actually uses it,
though. That kind of stuff you only find out when it's too late :/

-- 
Jens Axboe

