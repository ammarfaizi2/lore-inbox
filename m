Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130681AbRARSFG>; Thu, 18 Jan 2001 13:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130541AbRARSE4>; Thu, 18 Jan 2001 13:04:56 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:47625 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130029AbRARSEn>; Thu, 18 Jan 2001 13:04:43 -0500
Date: Thu, 18 Jan 2001 10:04:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: Rik van Riel <riel@conectiva.com.br>, mingo@elte.hu,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <20010118185023.A23381@caldera.de>
Message-ID: <Pine.LNX.4.10.10101181002440.18287-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Jan 2001, Christoph Hellwig wrote:
> > 
> > Remove this. I don't think it's valid to lock the pages. Who wants to use
> > this anyway?
> 
> E.g. in the block IO pathes the pages have to be locked.
> It's also used by free_kiovec to see wether to do unlock_kiovec before.

This is all MUCH higher level functionality, and probably bogus anyway.

> > That's kind of the minimal set. That should be one level of abstraction in
> > its own right. 
> 
> Ok. Then we need an additional more or less generic object that is used for
> passing in a rw_kiovec file operation (and we really want that for many kinds
> of IO). I thould mostly be used for communicating to the high-level driver.

That's fine.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
