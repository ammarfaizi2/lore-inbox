Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316182AbSEWHKc>; Thu, 23 May 2002 03:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316185AbSEWHKb>; Thu, 23 May 2002 03:10:31 -0400
Received: from khms.westfalen.de ([62.153.201.243]:2750 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S316182AbSEWHKb>; Thu, 23 May 2002 03:10:31 -0400
Date: 23 May 2002 09:01:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8PRYRufXw-B@khms.westfalen.de>
In-Reply-To: <3CEB4084.90806@evision-ventures.com>
Subject: Re: [PATCH] 2.5.17 IDE 65
X-Mailer: CrossPoint v3.12d.kh9 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dalecki@evision-ventures.com (Martin Dalecki)  wrote on 22.05.02 in <3CEB4084.90806@evision-ventures.com>:

> Uz.ytkownik Linus Torvalds napisa?:
> > On Tue, 21 May 2002, Vojtech Pavlik wrote:
> >
> >>>They aren't there to be respected by the ll_rw_blk layer - if some layer
> >>>above it has created a request larger than the hard sector size, THAT is
> >>>the problem, and there is nothing ll_rw_blk can do (except maybe BUG() on
> >>>it, but I don't think we've ever really seen those kinds of bugs).
> >>
> >>Hum, I'm confused here - shouldn't that be "if some layer above it has
> >>created a request SMALLER than the hard sector size"? Or better a
> >>request that is not a multiple of hard sector size?
> >
> >
> > Yes, yes, you're obviously right, and I just had a brainfart when writing
> > it. It should be basically: "higher levels must make sure on their own
> > that all requests are nice integer multiples of the hw sector-size", and
> > ll_rw_blk should never have to care.
>
> Please add the following to the bag:
> "We never saw a filesystem with less then 512 byte sectors,
> so let's assume this is our request size unit." (CP/M uses 256...)
> Not that pretty at all.

That's why Alan said 512-byte FAT on 2k MO needs loop.

Of course, way back when, I used 2k FAT on MO and it "just worked" ... no  
idea if that would still work today, but FAT *can* at least in principle  
do larger sizes.

MfG Kai
