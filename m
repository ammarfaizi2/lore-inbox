Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274633AbRIYLHv>; Tue, 25 Sep 2001 07:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274639AbRIYLHk>; Tue, 25 Sep 2001 07:07:40 -0400
Received: from femail27.sdc1.sfba.home.com ([24.254.60.17]:24223 "EHLO
	femail27.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S274633AbRIYLHZ>; Tue, 25 Sep 2001 07:07:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
Date: Tue, 25 Sep 2001 04:07:47 -0700
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <B0005839269@gollum.logi.net.au> <20010925044949.JNOU8313.femail42.sdc1.sfba.home.com@there> <20010925124231.A1390@emma1.emma.line.org>
In-Reply-To: <20010925124231.A1390@emma1.emma.line.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010925110746.SOTR2356.femail27.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 September 2001 03:42 am, Matthias Andree wrote:
> On Mon, 24 Sep 2001, Nicholas Knight wrote:
> > It's a very remote possability of failure, like most instances
> > where write-cache would cause problems. Catastrophic failure of the
> > IDE cable in mid-write will cause problems. If write cache is
> > enabled, the write stands a higher chance of having made it to the
> > drive before the cable died, with it off, it stands a higher chance
> > of NOT having made it entirely to the drive.
>
> Cables don't suddenly die without the help of e. g. your CPU fan.

I explained in another message the situation I was thinking of, 
accidental pulling of the cable.

>
> > For most drives, I don't know for sure if they'd finish the write
> > that's now sitting in their cache, but I expect higher quality
> > drives (such as our IBM drives) definitely would. Infact I may even
> > be willing to test this later (my swap partition looks like it
> > wants to help :)
>
> Drives would not write incomplete blocks.

Not what I ment, I ment that if a write gets to the drive completely, 
and part is still sitting in the cache, I'd think the drive would 
continue to write it out as long as it has power. I wasn't reffering to 
the write partialy being down the cable.

> >
> > Either Maxtor or Western Digital share very close designs to IBM
> > drives, I belive they had some sort of development partnership. I'm
> > not sure if it was Maxtor or WD.
>
> The Western Digital 420400D (20 GB, 5400/min) and its 7200/min
> brother with 18 GBs were IBM disk drives, supposedly, but the WD
> ...AA/BB drives and whatever else there was looked some different
> from IBM drives.
>
> > > Why are disk drives slower with their caches disabled on LINEAR
> > > writes?
> >
> > Maybe the cache isn't doing what we think it is?
>
> Maybe. A monitor software or debug mode would be good to see when
> writes are scheduled and which blocks are written (I need to ask a
> friend of mine who hacked ll_rw_blk.c on a different purpose for his
> diploma thesis, maybe his code is valuable to figure things out.)
>
> > Does anyone have contacts at IBM and/or Western Digital?
> > Something's up... The 256MB write with write-cache off was going at
> > 5.8MB/sec, and with it on it was going at 14.22MB/sec (averages).
> > One interesting thing, the timings are showing a pretty consistant
> > but tiny increase in sys time with write caching on.
>
> I also saw that here, but again, it's basically the same hardware.
