Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129538AbRAEVKB>; Fri, 5 Jan 2001 16:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129790AbRAEVJz>; Fri, 5 Jan 2001 16:09:55 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:63750 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129538AbRAEVJp>; Fri, 5 Jan 2001 16:09:45 -0500
Date: Fri, 5 Jan 2001 17:17:59 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andreas Dilger <adilger@turbolinux.com>
cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>
Subject: Re: swapin readahead pre-patch (what about the code?)
In-Reply-To: <200101052102.f05L2T420212@webber.adilger.net>
Message-ID: <Pine.LNX.4.21.0101051715060.2882-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Jan 2001, Andreas Dilger wrote:

> I suppose the other area to look at is how pages are layed out when
> they are swapped to disk.  If you go from medium memory pressure (where
> unused pages have been swapped already) to thrashing, then if you can
> put the remaining pages of each program to swap contiguously, then swap
> read-ahead will be a net win, because you are likely to need all of them
> again to run the program.

Swap space preallocation should help on that issue. 

I hope to try out that soon after I've finished and benchmarked the swapin
readahead patch.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
