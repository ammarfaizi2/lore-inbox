Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311475AbSDXJMI>; Wed, 24 Apr 2002 05:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311483AbSDXJMH>; Wed, 24 Apr 2002 05:12:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S311475AbSDXJMF>;
	Wed, 24 Apr 2002 05:12:05 -0400
Date: Wed, 24 Apr 2002 11:11:51 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Miles Lane <miles@megapathdsl.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.9 -- OOPS in IDE code (symbolic dump and boot log included)
Message-ID: <20020424091151.GD812@suse.de>
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net> <3CC51494.8040309@evision-ventures.com> <1019583551.1392.5.camel@turbulence.megapathdsl.net> <1019584497.1393.8.camel@turbulence.megapathdsl.net> <3CC66794.5040203@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24 2002, Martin Dalecki wrote:
> U?ytkownik Miles Lane napisa?:
> >On Tue, 2002-04-23 at 10:39, Miles Lane wrote:
> >
> >>On Tue, 2002-04-23 at 01:00, Martin Dalecki wrote:
> >>
> >>>Miles Lane wrote:
> >>>
> >>>>I should probably add the /proc/ksyms snapshotting stuff to 
> >>>>get the module information for you as well.  I hope this 
> >>>>current batch of info helps, for starters.
> >>>>
> >>>>ksymoops 2.4.4 on i686 2.4.7-10.  Options used
> >>>>    -v /usr/src/linux/vmlinux (specified)
> >>>>    -K (specified)
> >>>>    -L (specified)
> >>>>    -o /lib/modules/2.5.9/ (specified)
> >>>>    -m /boot/System.map-2.5.9 (specified)
> >>>
> >>>
> >>>Looks like the oops came from module code.
> >>>Which modules did you use: ide-flappy and ide-scsi are still
> >>>in need of the same medication ide-cd got.
> >>
> >>CONFIG_BLK_DEV_IDESCSI=m
> >>CONFIG_SCSI=m
> >>CONFIG_BLK_DEV_SD=m
> >>CONFIG_BLK_DEV_SR=m
> >>CONFIG_CHR_DEV_SG=m
> >
> >
> >Hmm.  You probably need this, too.  Sorry for not sending this
> >in the first reply.
> 
> 
> OK I assume that the oops happens inside the ide-scsi module.
> This will be fixed in one of the forthcomming patch sets.

Are you sure this isn't just due to ->special being set, and
ide_end_request() assuming it's an ar? From ide-cd, that is.

-- 
Jens Axboe

