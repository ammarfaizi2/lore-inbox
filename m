Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267798AbRGRClm>; Tue, 17 Jul 2001 22:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267805AbRGRClc>; Tue, 17 Jul 2001 22:41:32 -0400
Received: from squeaker.ratbox.org ([63.216.218.7]:58243 "HELO
	squeaker.ratbox.org") by vger.kernel.org with SMTP
	id <S267798AbRGRCl0>; Tue, 17 Jul 2001 22:41:26 -0400
Date: Tue, 17 Jul 2001 22:41:29 -0400 (EDT)
From: Aaron Sethman <androsyn@ratbox.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <dpicard@rcn.com>, <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH for Corrupted IO on all block devices
In-Reply-To: <Pine.LNX.4.33L2.0107172237030.6255-100000@squeaker.ratbox.org>
Message-ID: <Pine.LNX.4.33L2.0107172239590.6255-100000@squeaker.ratbox.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore this one. It seems with Andrea's fix to the test program it runs
fine on reiserfs but bombs on an ext2fs.

Aaron

On Tue, 17 Jul 2001, Aaron Sethman wrote:

> I'd just like to add that the test program bombs on a reiserfs filesystem
> as well.  So if their is some sort of issue, its not just related to ext2.
>
> Regards,
>
> Aaron
>
> On Tue, 17 Jul 2001, Linus Torvalds wrote:
>
> >
> > On Tue, 17 Jul 2001, David J. Picard wrote:
> > >
> > > Basically, what is happening is the read requests are being pushed to
> > > the front of the IO queue - before the preceding write for the same
> > > sector.
> >
> > This is a bug in the USER, not in the code.
> >
> > The locking is NOT supposed to be done at the elevator level (or, indeed
> > at ANY _io_ level), but must be done by upper layers.
> >
> > If upper layers do not do this locking, then THAT is the bug.
> >
> > What filesystem do you see the bug with?
> >
> > 		Linus
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
>
>

