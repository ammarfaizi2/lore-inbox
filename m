Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131773AbRAJIFo>; Wed, 10 Jan 2001 03:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131512AbRAJIFd>; Wed, 10 Jan 2001 03:05:33 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:53773 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131773AbRAJIF3>; Wed, 10 Jan 2001 03:05:29 -0500
Date: Wed, 10 Jan 2001 00:05:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: migo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <20010110084235.A365@caldera.de>
Message-ID: <Pine.LNX.4.10.10101100003560.3520-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Jan 2001, Christoph Hellwig wrote:
> 
> Simple.  Because I stated before that I DON'T even want the networking
> to use kiobufs in lower layers.  My whole argument is to pass a kiovec
> into the fileop instead of a page, because it makes sense for other
> drivers to use multiple pages, and doesn't hurt networking besides
> the cost of one kiobuf (116k) and the processor cycles for creating
> and destroying it once per sys_sendfile.

Fair enough.

My whole argument against that is that I think kiovec's are incredibly
ugly, and the less I see of them in critical regions, the happier I am.

And that, I have to admit, is really mostly a matter of "taste". 

De gustibus non disputandum.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
