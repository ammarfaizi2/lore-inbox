Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269577AbRHGA21>; Mon, 6 Aug 2001 20:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269595AbRHGA2R>; Mon, 6 Aug 2001 20:28:17 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:10248 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269577AbRHGA2H>; Mon, 6 Aug 2001 20:28:07 -0400
Date: Mon, 6 Aug 2001 19:58:53 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Anton Blanchard <anton@samba.org>
Cc: Andrew Tridgell <tridge@valinux.com>, lkml <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: 2.4.8preX VM problems
In-Reply-To: <20010804131744.A32213@krispykreme>
Message-ID: <Pine.LNX.4.21.0108061954001.11203-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Aug 2001, Anton Blanchard wrote:

> 
> > > The patch below allowed us to get close to 4G of page cache before
> > > things slowed down again and kswapd took over.
> > 
> > How much memory do you have on the box ?
> 
> It has 15G, so 512M of lowmem and 14.5G of highmem.

Can you please use readprofile to find out where kswapd is spending its
time when you reach 4G of pagecache ?

I've never seen kswapd burn CPU time except cases where a lot of memory is
anonymous and there is a need for lots of swap space allocations.
(scan_swap_map() is where kswapd spends "all" of its time in such
workloads)

