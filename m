Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266935AbRGHRQ7>; Sun, 8 Jul 2001 13:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbRGHRQt>; Sun, 8 Jul 2001 13:16:49 -0400
Received: from www.wen-online.de ([212.223.88.39]:3332 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S264849AbRGHRQh>;
	Sun, 8 Jul 2001 13:16:37 -0400
Date: Sun, 8 Jul 2001 19:15:40 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33L.0107081241280.22014-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0107081856590.318-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jul 2001, Rik van Riel wrote:

> On Sun, 8 Jul 2001, Mike Galbraith wrote:
>
> > is very oom with no disk activity.  It _looks_ (xmm and vmstat) like
> > it just ran out of cleanable dirty pages.  With or without swap,
>
> ... Bingo.  You hit the infamous __wait_on_buffer / ___wait_on_page
> bug. I've seen this for quite a while now on our quad xeon test
> machine, with some kernel versions it can be reproduced in minutes,
> with others it won't trigger at all.
>
> And after a recompile it's usually gone ...
>
> I hope there is somebody out there who can RELIABLY trigger
> this bug, so we have a chance of tracking it down.

Well, my box seems to think I'm a somebody.  If it changes it's mind,
I'll let you know.  I'll throw whatever rocks I can find at it to get
it all angry and confused.  You sneak up behind it and do the stake and
mallot number.

tar -rvf /dev/null /usr/local (10 gig of.. mess) with X/KDE running
seems 100% repeatable here.

'scuse me while I go recompile again and hope it just goes away ;-)

	-Mike

