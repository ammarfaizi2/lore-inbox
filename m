Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131501AbRACPDW>; Wed, 3 Jan 2001 10:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131658AbRACPDN>; Wed, 3 Jan 2001 10:03:13 -0500
Received: from windsormachine.com ([206.48.122.28]:5638 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S131135AbRACPDF>; Wed, 3 Jan 2001 10:03:05 -0500
Message-ID: <3A5337EB.56172C60@windsormachine.com>
Date: Wed, 03 Jan 2001 09:32:11 -0500
From: Mike Dresser <mdresser@windsormachine.com>
Organization: Windsor Machine & Stamping
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: quintaq@yahoo.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Fw: UDMA on 815e chipset
In-Reply-To: <20010103121218Z130812-439+8159@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Even though I see the error message, I think that UDMA 4 / ATA 66 must actually have been set, because hdparm now reports cache reads at 143.82 MB/sec and disk reads at 15.76 MB/Ssec. hdparm also reports that the HDD is in UDMA mode 4.

This seems low, I have a pair of IBM DJNA-352030 20 gig's in a machine at home, that cache reads at 86.49(celeron 300@450, probably a slower machine than yours, would account for the lower numbers), disk reads score at 14.78, in Ultra/33 mode.(my mb
doesn't support ultra/66).
 It's been so long since i bought the hard drives, that i can't remember if they're 5400 rpm or 7200.  Either way, it's doing better than that controller is running your 7200 rpm 30'er.

> Much the same thing happens if I try for ATA 100 / UDMA 5 by substituting -X69.  hdparm now reports that the drive is in UDMA mode 5, but I do not see any improvement in transfer speeds, from which I assume that my kernel cannot go higher than ATA 66.

Don't forget that no IDE drive out there, at this time, can saturate even Ultra/66.  Unless you've got the newest and greatest, even Ultra/33 is wide enough for a single drive, unless you take into account the fact the cache can dump that whole
512k/2048k/whathaveyou at double the speed.
Granted, once you get two drives on the channel, Ultra/66 and 100 start making a difference, if they can share the channel efficiently.

Mike


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
