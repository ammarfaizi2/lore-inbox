Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318162AbSIAXfG>; Sun, 1 Sep 2002 19:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318165AbSIAXfF>; Sun, 1 Sep 2002 19:35:05 -0400
Received: from dsl-213-023-021-067.arcor-ip.net ([213.23.21.67]:49794 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318162AbSIAXfF>;
	Sun, 1 Sep 2002 19:35:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [RFC] [PATCH] Include LRU in page count
Date: Mon, 2 Sep 2002 01:19:38 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
References: <3D644C70.6D100EA5@zip.com.au> <E17ld5N-0004cg-00@starship> <3D729DD3.AE3681C9@zip.com.au>
In-Reply-To: <3D729DD3.AE3681C9@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17le0J-0004d1-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 September 2002 01:08, Andrew Morton wrote:
> Daniel Phillips wrote:
> It would be great to make presence on the LRU contribute to page->count, because
> that would permit the removal of a ton of page_cache_get/release operations inside
> the LRU lock, perhaps doubling throughput in there.

It's pretty much done, it just needs some torture testing:

   http://people.nl.linux.org/~phillips/patches/lru.race-2.4.19

The handy /proc/mmstat ad hoc statistics are still in there.  The patch supports
both zero and one-flavors of lru contribution to page count for the time being,
with the latter as the default.

> Guess I should get off my
> lazy butt and see what you've done (will you for heaven's sake go and buy an IDE
> disk and compile up a 2.5 kernel? :))

I was just thinking about that, time to go poke at the DAC960 again.  Yes I do
remember Jens and Bill offered to help :-)

-- 
Daniel
