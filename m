Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282619AbRKZW3e>; Mon, 26 Nov 2001 17:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282613AbRKZW3Y>; Mon, 26 Nov 2001 17:29:24 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31251 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282610AbRKZW3N>; Mon, 26 Nov 2001 17:29:13 -0500
Date: Mon, 26 Nov 2001 14:23:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Scalable page cache
In-Reply-To: <3C02ADF2.E505E672@zip.com.au>
Message-ID: <Pine.LNX.4.33.0111261421320.10706-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Nov 2001, Andrew Morton wrote:
>
> We've called block_prepare_write(), which has done the kmap.
> But even though block_prepare_write() returned success, this
> call to the filesystem's ->prepare_write() is about to fail.

That's _way_ too intimate knowledge of how block_prepare_write() works (or
doesn't work).

How about sending me a patch that removes all the kmap/kunmap crap from
_both_ ext3 and block_prepare/commit_write.

> There have been a number of mistakes made over this particular kmap()
> operation.  NFS client had it wrong for a while. I think sct had
> some proposal for making it more robust.

It _is_ more robust. You are only battling remnants from an older age when
it wasn't.

		Linus

