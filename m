Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131841AbRAIVOc>; Tue, 9 Jan 2001 16:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130092AbRAIVOW>; Tue, 9 Jan 2001 16:14:22 -0500
Received: from ns.caldera.de ([212.34.180.1]:25358 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129383AbRAIVOK>;
	Tue, 9 Jan 2001 16:14:10 -0500
Date: Tue, 9 Jan 2001 22:12:55 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@ns.caldera.de>, migo@elte.hu,
        linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010109221254.A10085@caldera.de>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Christoph Hellwig <hch@ns.caldera.de>, migo@elte.hu,
	linux-kernel@vger.kernel.org
In-Reply-To: <200101092036.VAA06353@ns.caldera.de> <Pine.LNX.4.10.10101091252330.2331-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.10.10101091252330.2331-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 09, 2001 at 12:55:51PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 12:55:51PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 9 Jan 2001, Christoph Hellwig wrote:
> > 
> > Also the tuple argument you gave earlier isn't right in this specific case:
> > 
> > when doing sendfile from pagecache to an fs, you have a bunch of pages,
> > an offset in the first and a length that makes the data end before last
> > page's end.
> 
> No.
> 
> Look at sendfile(). You do NOT have a "bunch" of pages.
> 
> Sendfile() is very much a page-at-a-time thing, and expects the actual IO
> layers to do it's own scatter-gather. 
> 
> So sendfile() doesn't want any array at all: it only wants a single
> page-offset-length tuple interface.

The current implementations does.
But others are possible.  I could post one in a few days to show that it is
possible.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
