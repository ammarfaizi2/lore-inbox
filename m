Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315835AbSEGO3s>; Tue, 7 May 2002 10:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315831AbSEGO3r>; Tue, 7 May 2002 10:29:47 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:45761 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S315837AbSEGO3o>; Tue, 7 May 2002 10:29:44 -0400
Date: Tue, 7 May 2002 16:29:14 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Christoph Hellwig <hch@infradead.org>, Osamu Tomita <tomita@cinet.co.jp>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE CD-ROM PIO mode
In-Reply-To: <3CD7AF7A.6040705@evision-ventures.com>
Message-ID: <Pine.SOL.4.30.0205071624140.14960-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


while we are here, I think that drivers shouldn't take
requests < hardsect_size, it should be handled by block layer

requests On Tue, 7 May 2002, Martin Dalecki wrote:

> Uz.ytkownik Christoph Hellwig napisa?:
> > On Tue, May 07, 2002 at 11:57:20AM +0200, Martin Dalecki wrote:
> >
> >>>@@ -962,7 +962,7 @@
> >>>
> >>> 	/* First, figure out if we need to bit-bucket
> >>> 	   any of the leading sectors. */
> >>>-	nskip = MIN(rq->current_nr_sectors - bio_sectors(rq->bio), sectors_to_transfer);
> >>>+	nskip = MIN((int)(rq->current_nr_sectors - bio_sectors(rq->bio)), sectors_to_transfer);
> >>
> >
> > What about a s/MIN/min/g in the idea driver to easily catch such bugs?
>
> Good idea partially already implemented :-).
> At least the generic code and the host chip driver code are alread
> switched to using those "chatch them" macros.

