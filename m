Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261965AbREZQmR>; Sat, 26 May 2001 12:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261978AbREZQmH>; Sat, 26 May 2001 12:42:07 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:42505 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261965AbREZQmA>;
	Sat, 26 May 2001 12:42:00 -0400
Date: Sat, 26 May 2001 12:18:07 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <Pine.LNX.4.21.0105260806430.3648-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0105261217080.30264-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Linus Torvalds wrote:
> On Sat, 26 May 2001, Rik van Riel wrote:
> > 
> > O, that part is fixed by the patch that Linus threw away
> > yesterday ;)
> 
> Rik, I threw away the parts of the patch that were bad and obvious
> band-aids, and it was hard to tell whether any of your patch was a
> "real" fix as opposed to just making more reservations.

1) Remove GFP_BUFFER and HIGHMEM related deadlocks, by letting
   these allocations fail instead of looping forever in
   __alloc_pages() when they cannot make any progress there.

It's the changes to __alloc_pages(), where we don't loop forever
but fail the allocation.

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


