Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267725AbRGRBxS>; Tue, 17 Jul 2001 21:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267708AbRGRBxJ>; Tue, 17 Jul 2001 21:53:09 -0400
Received: from 209-6-16-34.c3-0.frm-ubr1.sbo-frm.ma.cable.rcn.net ([209.6.16.34]:12416
	"EHLO newyork.psind.com") by vger.kernel.org with ESMTP
	id <S267725AbRGRBwx>; Tue, 17 Jul 2001 21:52:53 -0400
Message-ID: <3B54E4FA.DE090D0D@psind.com>
Date: Tue, 17 Jul 2001 21:23:06 -0400
From: "David J. Picard" <dave@psind.com>
Reply-To: dpicard@rcn.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [Fwd: PATCH for Corrupted IO on all block devices]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David J. Picard" wrote:
> 
> This is happening on an e2fs file system, I haven't tried it with
> others, but the code is pretty clear in elevator.c about putting the
> reads ahead of the write if they are pushed into the queue close enough
> to each other.
> 
> Linus Torvalds wrote:
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
> >                 Linus
> 
> --
> David J. Picard
>   dave@psind.com
> 
> If you can keep your head when all about you are losing theirs,
>   then you clearly don't understand the situation.

-- 
David J. Picard
  dave@psind.com

If you can keep your head when all about you are losing theirs,
  then you clearly don't understand the situation.
