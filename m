Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131712AbRCTEi1>; Mon, 19 Mar 2001 23:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131714AbRCTEiH>; Mon, 19 Mar 2001 23:38:07 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:45574 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131712AbRCTEh6>; Mon, 19 Mar 2001 23:37:58 -0500
Date: Tue, 20 Mar 2001 01:37:15 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 3rd version of R/W mmap_sem patch available
In-Reply-To: <Pine.LNX.4.31.0103191529530.967-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0103200135570.2830-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Mar 2001, Linus Torvalds wrote:
> On Mon, 19 Mar 2001, Linus Torvalds wrote:
> >
> > Excellent point. We used to do all the looping and re-trying, but it got
> > ripped out a long time ago (and in any case, it historically didn't do
> > SMP, so the old code doesn't really work).
>
> Actually, funnily enough, I see that the old thread-safe stuff is still
> there in get_pte_kernel_slow(). The only thing that breaks it is that we
> don't hold any locks, so it's only UP-safe, not SMP-safe.
>
> However, it definitely looks like we should just un-inline that thing
> completely, and make a lot of it architecture-independent anyway.

Also, because lots of architectures seem to have exactly
the same code, we might as well remove the duplicates and
put them in the same place...

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

