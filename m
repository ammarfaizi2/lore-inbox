Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271283AbRHOQqH>; Wed, 15 Aug 2001 12:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271285AbRHOQp5>; Wed, 15 Aug 2001 12:45:57 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:266 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271283AbRHOQpo>; Wed, 15 Aug 2001 12:45:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Comparison between 2.4.8-ac4-new-zoned and 2.4.9pre3 VM perf
Date: Wed, 15 Aug 2001 18:52:21 +0200
X-Mailer: KMail [version 1.3]
Cc: Mike Galbraith <mikeg@wen-online.de>, lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.21.0108150723000.26179-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0108150723000.26179-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010815164556Z16428-1231+1061@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 15, 2001 04:10 pm, Marcelo Tosatti wrote:
> I've compared 2.4.8-ac4 performance with 2.4.9pre3 using postmark. I used
> this specific benchmark because it allows me to set read/write ratio of IO
> transactions.
>
> [...]
>
> The tests have shown that the 2.4.9pre is a bit slower than
> 2.4.8ac4+newzone.

I reaarranged the results to clarify...

> bias read 10 (approx 10/1 read/write ratio)
>
> 2.4.8-ac4-newzoned
>         45000.00 megabytes read (19.87 megabytes per second)
>         25230.00 megabytes written (11.14 megabytes per second)
> 
> 2.9.4-pre3
>         45000.00 megabytes read (19.88 megabytes per second)
>         25230.00 megabytes written (11.14 megabytes per second)

The read-heavy results are virtually identical.

> bias read 1 (approx 1/10 read/write ratio)
>
> 2.4.8-ac4-newzoned
>         4380.00 megabytes read (6.75 megabytes per second)
>         25230.00 megabytes written (38.88 megabytes per second)
> 
> 2.9.4-pre3
>         4380.00 megabytes read (6.35 megabytes per second)
>         25230.00 megabytes written (36.57 megabytes per second)

For even read/write balancing ac4-newzoned is 6% faster.  It's still
anybody's race ;-)

--
Daniel
