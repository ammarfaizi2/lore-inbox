Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263980AbRFIGII>; Sat, 9 Jun 2001 02:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263996AbRFIGH7>; Sat, 9 Jun 2001 02:07:59 -0400
Received: from www.wen-online.de ([212.223.88.39]:27921 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S263980AbRFIGHm>;
	Sat, 9 Jun 2001 02:07:42 -0400
Date: Sat, 9 Jun 2001 08:07:06 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: Zlatko Calusic <zlatko.calusic@iskon.hr>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: Comment on patch to remove nr_async_pages limit
In-Reply-To: <Pine.LNX.4.21.0106090008110.10415-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0106090758530.748-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Jun 2001, Rik van Riel wrote:

> On 5 Jun 2001, Zlatko Calusic wrote:
> > Marcelo Tosatti <marcelo@conectiva.com.br> writes:
> >
> > [snip]
> > > Exactly. And when we reach a low watermark of memory, we start writting
> > > out the anonymous memory.
> >
> > Hm, my observations are a little bit different. I find that writeouts
> > happen sooner than the moment we reach low watermark, and many times
> > just in time to interact badly with some read I/O workload that made a
> > virtual shortage of memory in the first place.
>
> I have a patch that tries to address this by not reordering
> the inactive list whenever we scan through it. I'll post it
> right now ...

Excellent.  I've done some of that (crude but effective) and have had
nice encouraging results.  If the dirty list is long enough, this
most definitely improves behavior under heavy load.

	-Mike

