Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130998AbRAJIee>; Wed, 10 Jan 2001 03:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132209AbRAJIeY>; Wed, 10 Jan 2001 03:34:24 -0500
Received: from ns.caldera.de ([212.34.180.1]:3091 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130998AbRAJIeR>;
	Wed, 10 Jan 2001 03:34:17 -0500
Date: Wed, 10 Jan 2001 09:33:08 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: migo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010110093308.A4508@caldera.de>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>, migo@elte.hu,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010110084235.A365@caldera.de> <Pine.LNX.4.10.10101100003560.3520-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.10.10101100003560.3520-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Jan 10, 2001 at 12:05:01AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 12:05:01AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 10 Jan 2001, Christoph Hellwig wrote:
> > 
> > Simple.  Because I stated before that I DON'T even want the networking
> > to use kiobufs in lower layers.  My whole argument is to pass a kiovec
> > into the fileop instead of a page, because it makes sense for other
> > drivers to use multiple pages, and doesn't hurt networking besides
> > the cost of one kiobuf (116k) and the processor cycles for creating
> > and destroying it once per sys_sendfile.
> 
> Fair enough.
> 
> My whole argument against that is that I think kiovec's are incredibly
> ugly, and the less I see of them in critical regions, the happier I am.
> 
> And that, I have to admit, is really mostly a matter of "taste". 

Ok.

This is a statement that makes all the kiobuf efforts currently look
no more as interesting as before.

IHMO is time to find a generic interface for IO that is acceptable by
you and widely usable.

As you stated before that seems to be s.th. with page,offset,length
tuples.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
