Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286279AbRLJPF7>; Mon, 10 Dec 2001 10:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286281AbRLJPFt>; Mon, 10 Dec 2001 10:05:49 -0500
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:6877 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S286279AbRLJPFk>; Mon, 10 Dec 2001 10:05:40 -0500
Date: Mon, 10 Dec 2001 10:03:47 -0500 (EST)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: mm question
In-Reply-To: <E16DR5n-00028k-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.20.0112101001220.17259-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Dec 2001, Alan Cox wrote:

> > It does not have to be contiguous. I was thinking of simply starting with 
> > the smallest address and trying to free the pages until the needed amount 
> > is available. But I have no idea how to properly do locking or force the
> > page to be swapped out or something. 
> 
> You can simply get_free_page() 300K of pages. However you can't land them
> in a given band other than the existing "below 16Mb" "below 4Gb" "anywhere"
> bands.

Right, but then my card refuses to dma into anything with address smaller
than 04000000.

I have thought of doing get_free_page until I have enough of pages with
large addresses (and then free all the small ones as 64mb is a finite
amount) but this would place a big load on the system during buffer
allocation.

I was hoping for something more elegant, but I am not adverse to writing
my own get_free_page_from_range().

                            Vladimir Dergachev

> 
> Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

