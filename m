Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282615AbRKZWtq>; Mon, 26 Nov 2001 17:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282613AbRKZWtg>; Mon, 26 Nov 2001 17:49:36 -0500
Received: from mail209.mail.bellsouth.net ([205.152.58.149]:34612 "EHLO
	imf09bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S282604AbRKZWt2>; Mon, 26 Nov 2001 17:49:28 -0500
Message-ID: <3C02C6F2.71A581AB@mandrakesoft.com>
Date: Mon, 26 Nov 2001 17:49:22 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.15-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Scalable page cache
In-Reply-To: <Pine.LNX.4.33.0111261421320.10706-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 26 Nov 2001, Andrew Morton wrote:
> >
> > We've called block_prepare_write(), which has done the kmap.
> > But even though block_prepare_write() returned success, this
> > call to the filesystem's ->prepare_write() is about to fail.
> 
> That's _way_ too intimate knowledge of how block_prepare_write() works (or
> doesn't work).
> 
> How about sending me a patch that removes all the kmap/kunmap crap from
> _both_ ext3 and block_prepare/commit_write.

FWIW Al Viro pointed out to me yesterday that block_xxx are really
nothing but helpers...  Depending on them doing or not doing certain
things is IMHO ok... 

If the behavior of the helpers is not what is desired, you are free to
ignore them and roll your own... or wrap them as it appears ext3 is
doing here.

	Jeff



-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

