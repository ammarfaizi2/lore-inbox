Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266106AbUBCTZa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 14:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbUBCTYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 14:24:31 -0500
Received: from h24-76-142-122.wp.shawcable.net ([24.76.142.122]:4626 "HELO
	signalmarketing.com") by vger.kernel.org with SMTP id S266128AbUBCTJN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 14:09:13 -0500
Date: Tue, 3 Feb 2004 13:09:45 -0600 (CST)
From: Derek Foreman <manmower@signalmarketing.com>
X-X-Sender: manmower@uberdeity
To: John Bradford <john@grabjohn.com>
cc: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org, xpovolny@aurora.fi.muni.cz
Subject: Re: 2.6.0, cdrom still showing directories after being erased
In-Reply-To: <200402031635.i13GZJ9Q002866@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.58.0402031251000.495@uberdeity>
References: <20040203131837.GF3967@aurora.fi.muni.cz> <Pine.LNX.4.53.0402030839380.31203@chaos>
 <401FB78A.5010902@zvala.cz> <Pine.LNX.4.53.0402031018170.31411@chaos>
 <200402031602.i13G2NFi002400@81-2-122-30.bradfords.org.uk> <yw1xsmhsf882.fsf@kth.se>
 <200402031635.i13GZJ9Q002866@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Feb 2004, John Bradford wrote:

> Quote from mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=):
> > John Bradford <john@grabjohn.com> writes:
> >
> > >> That's not what he said and, I assure you that if he unmounted
> > >> it there would not be any buffers to flush. Execute `man umount`.
> > >
> > > I think the original poster was referring to the cache on the device.
> > >
> > > I.E.
> > >
> > > mount disc
> > > view contents
> > > unmount disc
> > > erase disc - but don't erase the CD-R drive's cache of the media
> > > mount disc
> > > view old contents of the media from the CD-R drive's cache
> >
> > If that's the case, the drive is broken.  We can't help that.
>
> Is it actually a requirement for drives to support anything other than
> a full erase properly?  Is the 'fast' erase valid per spec, or does it
> just happen to work on 99% of devices?  Is this problem reproducable
> if a full erase is done instead of a fast erase?
>
> I've added the original poster to the CC list.

"Blank" is a single scsi command, 3 bits of the command specify what type
of blanking to perform.  So cdrecord isn't doing something devious, it's
well defined in the MMC standard.

Just making cdrecord -eject at the end of the process will probably
workaround what is almost certainly a hardware bug.  or just eject the
disc by hand before attempting to re-use it.

I had an old writer that did much the same thing.  After burning a disc,
it would still see it as blank until you ejected and reloaded.

to Martin:
Does cdrecord -toc still show a valid toc after you blank the disc?
(definately buggy hardware)

And does ejecting and reloading the disc make things work as expected?
