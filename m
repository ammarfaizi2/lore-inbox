Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275064AbRIYQNm>; Tue, 25 Sep 2001 12:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275067AbRIYQNc>; Tue, 25 Sep 2001 12:13:32 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:17680 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S275064AbRIYQNT>; Tue, 25 Sep 2001 12:13:19 -0400
Date: Tue, 25 Sep 2001 13:13:37 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10 VM: what avoids from having lots of unwriteable inactive
 pages
In-Reply-To: <Pine.LNX.4.33.0109250849480.7353-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0109251311340.26091-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, Linus Torvalds wrote:
> On Tue, 25 Sep 2001, Rik van Riel wrote:
> > >
> > > swap_out() will deactivate everything it finds to be not-recently used,
> > > and that's how the inactive list ends up getting replenished.
> >
> > mlock()
>
> Hey, if you've mlock'ed more than your available memory, there's nothing
> the VM layer can do. Except maybe a nice printk("Kiss your *ss goodbye");

But if you've mlock()ed enough to clog up the inactive
list, the VM could just move the pages it cannot free
back to the active list and it will come across those
pages which are freeable eventually.

Note that the maximum amount of mlock()ed memory is way
higher than the maximum amount of pages the system puts
on the inactive list.

(at least, it was last I looked at the maximum number
of mlocked pages)

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

