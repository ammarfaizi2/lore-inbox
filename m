Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273037AbRIIU0Z>; Sun, 9 Sep 2001 16:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273033AbRIIU0J>; Sun, 9 Sep 2001 16:26:09 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:27403 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273032AbRIIUZz>; Sun, 9 Sep 2001 16:25:55 -0400
Date: Sun, 9 Sep 2001 17:26:01 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Purpose of the mm/slab.c changes
In-Reply-To: <E15g7jk-0007Rb-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0109091725070.21049-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Sep 2001, Alan Cox wrote:

> > > doesn't matter which free page is used first/last.
> >
> > You're full of crap.
> > LIFO is obviously superior due to cache re-use.
>
> Interersting question however. On SMP without sufficient per CPU
> slab caches is tht still the case ?

By definition, no.

If we're allocating and freeing the slabs at such a fast
speed that the slabs which are NOT in the per-CPU caches
are still in the cache, chances are our per-CPU caches
are too small.

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

