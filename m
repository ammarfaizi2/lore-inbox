Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129878AbRARAj2>; Wed, 17 Jan 2001 19:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130287AbRARAjI>; Wed, 17 Jan 2001 19:39:08 -0500
Received: from [129.94.172.186] ([129.94.172.186]:9711 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S130077AbRARAi7>; Wed, 17 Jan 2001 19:38:59 -0500
Date: Thu, 18 Jan 2001 01:05:43 +1100 (EST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@localhost.localdomain>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: Linus Torvalds <torvalds@transmeta.com>, <migo@elte.hu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <20010110084235.A365@caldera.de>
Message-ID: <Pine.LNX.4.31.0101180104050.31432-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, Christoph Hellwig wrote:

> Simple.  Because I stated before that I DON'T even want the
> networking to use kiobufs in lower layers.  My whole argument is
> to pass a kiovec into the fileop instead of a page, because it
> makes sense for other drivers to use multiple pages,

Now wouldn't it be great if we had one type of data
structure that would work for both the network layer
and the block layer (and v4l, ...)  ?

If we constantly need to convert between zerocopy
metadata type, I'm sure we'll lose most of the performance
gain we started this whole idea for in the first place.

cheers,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
