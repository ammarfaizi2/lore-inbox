Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129859AbRAIXJ1>; Tue, 9 Jan 2001 18:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRAIXJK>; Tue, 9 Jan 2001 18:09:10 -0500
Received: from kanga.kvack.org ([216.129.200.3]:63502 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id <S132419AbRAIXIv>;
	Tue, 9 Jan 2001 18:08:51 -0500
Date: Tue, 9 Jan 2001 18:06:05 -0500 (EST)
From: "Benjamin C.R. LaHaise" <blah@kvack.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Christoph Hellwig <hch@ns.caldera.de>, migo@elte.hu,
        linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <Pine.LNX.4.10.10101091252330.2331-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.96.1010109175317.7868A-100000@kanga.kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Linus Torvalds wrote:

> The _lower-level_ stuff (ie TCP and the drivers) want the "array of
> tuples", and again, they do NOT want an array of pages, because if
> somebody does two sendfile() calls that fit in one packet, it really needs
> an array of tuples.

A kiobuf simply provides that tuple plus the completion callback.  Stick a
bunch of them together and you've got a kiovec.  I don't see the advantage
of moving to simpler primatives if they don't provide needed
functionality.

> In short, the kiobuf interface is _always_ the wrong one.

Please tell me what you think the right interface is that provides a hook
on io completion and is asynchronous.

		-ben


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
