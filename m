Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267812AbRHJM7o>; Fri, 10 Aug 2001 08:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267836AbRHJM7d>; Fri, 10 Aug 2001 08:59:33 -0400
Received: from gear.torque.net ([204.138.244.1]:33032 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S267812AbRHJM7N>;
	Fri, 10 Aug 2001 08:59:13 -0400
Message-ID: <3B73D9F0.8BE1B0D1@torque.net>
Date: Fri, 10 Aug 2001 08:56:16 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFT] #2 Support for ~2144 SCSI discs, scsi_debug
In-Reply-To: <200108020642.f726g0L15715@mobilix.ras.ucalgary.ca>
		<3B735FCF.E197DD5B@torque.net> <200108100431.f7A4VkG01068@mobilix.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> Douglas Gilbert writes:

> > $ ls -l /devfs/scsi/host46/bus0/target0/lun0/*
> > brw-------    1 root     root     114,  16 Dec 31  1969
> >                         /devfs/scsi/host46/bus0/target0/lun0/disc
> > brw-------    1 root     root     114,  17 Dec 31  1969
> >                         /devfs/scsi/host46/bus0/target0/lun0/part1
> > brw-------    1 root     root     114,  18 Dec 31  1969
> >                         /devfs/scsi/host46/bus0/target0/lun0/part2
> > brw-------    1 root     root     114,  19 Dec 31  1969
> >                         /devfs/scsi/host46/bus0/target0/lun0/part3
> >
> > Note the large major device number that devfs is pulling
> > from the unused pool. Devfs makes some noise when
> > 'rmmod scsi_debug' is executed but otherwise things looked
> > ok.
> 
> What was the message?

After several seconds of silence, lots of these appeared:
 devfs_dealloc_unique_number(): number 128 was already free
 devfs_dealloc_unique_number(): number 128 was already free


By the way, that scsi_debug_many_disks.tgz tarball contains:
  drivers/scsi/scsi_debug.h
  drivers/scsi/scsi_debug.c
This driver is valid for any kernel in the lk 2.4 series.
If the tarball is unzipped in /usr/src/linux it would 
replace the originals (which is no great loss but you 
may like to keep copies of them).
Also my .config contains: CONFIG_SCSI_DEBUG=m
(for GUI users it is the last SCSI adapter listed).

Doug Gilbert
