Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265929AbRF1OFF>; Thu, 28 Jun 2001 10:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265930AbRF1OEz>; Thu, 28 Jun 2001 10:04:55 -0400
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:5380 "EHLO
	boris.prodako.se") by vger.kernel.org with ESMTP id <S265929AbRF1OEq>;
	Thu, 28 Jun 2001 10:04:46 -0400
Date: Thu, 28 Jun 2001 16:04:34 +0200 (CEST)
From: Tobias Ringstrom <tori@unhappy.mine.nu>
X-X-Sender: <tori@boris.prodako.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <mike_phillips@urscorp.com>, <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
In-Reply-To: <E15Fbyy-0006xF-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106281558250.1258-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2001, Alan Cox wrote:

> > > That isnt really down to labelling pages, what you are talking qbout is what
> > > you get for free when page aging works right (eg 2.0.39) but don't get in
> > > 2.2 - and don't yet (although its coming) quite get right in 2.4.6pre.
> >
> > Correct, but all pages are not equal.
>
> That is the whole point of page aging done right. The use of a page dictates
> how it is aged before being discarded. So pages referenced once are aged
> rapidly, but once they get touched a couple of times then you know they arent
> streaming I/O. There are other related techniques like punishing pages that
> are touched when streaming I/O is done to pages further down the same file -
> FreeBSD does this one for example

Are you saying that classification of pages will not be useful?

Only looking at the page access patterns can certainly reveal a lot, but
tuning how to punish different pages is useful.

> > The problem with updatedb is that it pushes all applications to the swap,
> > and when you get back in the morning, everything has to be paged back from
> > swap just because the (stupid) OS is prepared for yet another updatedb
> > run.
>
> Updatedb is a bit odd in that it mostly sucks in metadata and the buffer to
> page cache balancing is a bit suspect IMHO.

In 2.4.6-pre, the buffer cache is no longer used for metata, right?

/Tobias

