Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131353AbRCSDak>; Sun, 18 Mar 2001 22:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131354AbRCSDaa>; Sun, 18 Mar 2001 22:30:30 -0500
Received: from zeus.kernel.org ([209.10.41.242]:33245 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131353AbRCSDaV>;
	Sun, 18 Mar 2001 22:30:21 -0500
Date: Sun, 18 Mar 2001 18:23:11 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andries.Brouwer@cwi.nl, axboe@suse.de, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, p_gortmaker@yahoo.com
Subject: Re: [PATCH] off-by-1 error in ide-probe (2.4.x)
In-Reply-To: <Pine.LNX.4.31.0103181723160.2981-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10103181815490.17416-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Mar 2001, Linus Torvalds wrote:

> 
> 
> On Mon, 19 Mar 2001 Andries.Brouwer@cwi.nl wrote:
> >
> >     Agreed. That would be a trivially easy bug in the firmware, limiting to
> >     255 sectors seems safer.
> >
> >             Linus
> >
> > Yes, possibly.
> > I checked old standards, and see that "0 means 256 as a sector count"
> > is already in ATA-1.
> 
> Yes. But we could have some silly bug in the Linux drivers too, if some
> part of the driver reads back the sector count and doesn't do the 0==256
> conversion. So let's not blame the disk quite yet. Although it would be
> interesting to hear if the problem only happens for a specific disk or
> manufacturer...

LT,

This is why I want to standardize the data-phase rules, but we have agreed
to postpone for 2.5.  Since the glue for the main loops is spread like hot
butter, it covers up a lot of issues and threads get messy.  I had all but
given up on chasing them down and then resolved to start from scratch.


Andre Hedrick
Linux ATA Development

