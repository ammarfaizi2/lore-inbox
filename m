Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262540AbRENWrP>; Mon, 14 May 2001 18:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262545AbRENWrF>; Mon, 14 May 2001 18:47:05 -0400
Received: from sloth.wcug.wwu.edu ([140.160.176.172]:54154 "HELO
	sloth.wcug.wwu.edu") by vger.kernel.org with SMTP
	id <S262540AbRENWqw>; Mon, 14 May 2001 18:46:52 -0400
Date: Mon, 14 May 2001 15:46:51 -0700 (PDT)
From: Josh Logan <josh@wcug.wwu.edu>
To: Juan Pablo Abuyeres <jpabuyer@tecnoera.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Adaptec RAID SCSI 2100S
In-Reply-To: <Pine.LNX.4.33.0105141745020.4694-100000@baltazar.tecnoera.com>
Message-ID: <Pine.BSO.4.21.0105141536430.10091-100000@sloth.wcug.wwu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What makes you think /dev/sda is the raid?  For me cat /proc/scsi/scsi
lists all 4 drives which, to me, implies that it is raw.

fdisk could not partition the raid by default.  I needed to use sfdisk the
first time.  After that fdisk worked fine.

If I have both modules loaded I can mount /dev/i2o/hd/dics0/part1 but not
/dev/sda1 (no filesystem).

I was hoping i2o_scsi would make it appear as a "normal" scsi device, but
I don't think that is happening with the current driver.

If you are having a different scsi setup I would be interested in trying
to set my system up the same way.  Thanks!

							Later, JOSH


On Mon, 14 May 2001, Juan Pablo Abuyeres wrote:

> > > Then When I tried to fdisk /dev/sda (/dev/sda is a RAID1 of two
> > > Quantum disks) syslog shows this:
> >
> > is /dev/sda the raid or the disks raw ?
> 
> /dev/sda is the RAID1
> 
> > > So, I don't know if I'm doing something wrong or what, but I haven't been
> > > able to get it working on 2.4.4 yet... please help.
> >
> > Ok I need to put mroe disks and newer firmware on my card when I have some
> > time
> 
> my /dev/dsa is a RAID1 made of two quantum atlas 10K II 18.xGb.
> Unfortunately I have to get this RAID running this week (maybe on
> wednesday) and after that I won't be able to do tests... so.. maybe
> I would have to use 2.2.19 instead of 2.4.4  :-(...
> 
> Juan Pablo Abuyeres
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

