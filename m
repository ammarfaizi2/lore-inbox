Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262593AbREZEc1>; Sat, 26 May 2001 00:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262594AbREZEcR>; Sat, 26 May 2001 00:32:17 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:60945 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S262593AbREZEcD>;
	Sat, 26 May 2001 00:32:03 -0400
Date: Sat, 26 May 2001 01:31:51 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <Pine.LNX.4.21.0105252107010.1520-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0105260129390.30264-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2001, Linus Torvalds wrote:

> This is why we always leave a few pages free, exactly to allow nested
> page allocators to steal the reserved pages that we keep around. If
> that deadlocks, then that's a separate issue altogether.
> 
> If people are able to trigger the "we run out of reserved pages"
> behaviour under any load, that indicates that we either have too few
> reserved pages per zone, or that we have a real thinko somewhere that
> allows eating up the reserves we're supposed to have.

This is exactly what gets fixed in the patch I sent you.
Feel free to reimplement it in a complex way if you want ;)

> But sometimes the right solution is just to have more reserves.

Won't work if the ethernet card is allocating memory
at gigabit speed. And no, my patch won't protect against
this thing either, only memory reservations can.

All my patch does is give us a 2.4 kernel now which
doesn't hang immediately as soon as you run on highmem
machines with a heavy swapping load.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

