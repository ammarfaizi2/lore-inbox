Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129065AbRBWNhf>; Fri, 23 Feb 2001 08:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129243AbRBWNh0>; Fri, 23 Feb 2001 08:37:26 -0500
Received: from p3.usnyc4.stsn.com ([199.106.219.3]:39177 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129065AbRBWNhU>; Fri, 23 Feb 2001 08:37:20 -0500
Date: Fri, 23 Feb 2001 10:38:17 -0300 (EST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@localhost.localdomain>
To: Chris Evans <chris@scary.beasts.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1 under heavy network load - more info
In-Reply-To: <Pine.LNX.4.30.0102231247300.9832-100000@ferret.lmh.ox.ac.uk>
Message-ID: <Pine.LNX.4.31.0102231033270.5517-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2001, Chris Evans wrote:
> On Wed, 21 Feb 2001, Rik van Riel wrote:
>
> > I'm really interested in things which make Linux 2.4 break
> > performance-wise since I'd like to have them fixed before the
> > distributions start shipping 2.4 as default.
>
> With kernel 2.4.1, I found that caching is way too aggressive. I
> was running konqueror in 32Mb (the quest for a lightwieght
> browser!) Unfortunately, the system seemed to insist on keeping
> 16Mb used for caches, with 15Mb given to the application and X.

Wrong.

Cache and processes are INCLUSIVE. Konquerer and your other
applications will share a lot of memory with the cache. More
precisely, everything which is backed by a file or has been
swapped out once (and swapped back in later) will SHARE memory
with both cache and processes.

In 2.4.1-pre<something> the kernel swaps out cache 32 times more
agressively than it scans pages in processes. Until we find a way
to auto-balance these things, expect them to be wrong for at least
some workloads ;(

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

