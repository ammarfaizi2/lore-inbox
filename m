Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129478AbRBXCVh>; Fri, 23 Feb 2001 21:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129384AbRBXCV1>; Fri, 23 Feb 2001 21:21:27 -0500
Received: from p108.usnyc3.stsn.com ([199.106.218.108]:41994 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129159AbRBXCVS>; Fri, 23 Feb 2001 21:21:18 -0500
Date: Fri, 23 Feb 2001 21:22:44 -0500 (EST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@localhost.localdomain>
To: Adam Sampson <azz@gnu.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VM balancing problems under 2.4.2-ac1
In-Reply-To: <87vgq1p3um.fsf@cartman.azz.net>
Message-ID: <Pine.LNX.4.31.0102232120531.8568-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Feb 2001, Adam Sampson wrote:

> The VM balancing updates in the recent ac kernels seem to have caused
> some interesting performance problems on my desktop machine. I've got
> 160Mb of RAM, and 2.4.2-ac1 appears to be using excessively large
> amounts of it for buffers and cache while pushing stuff out to
> swap. This means that Mozilla, for instance, runs significantly worse
> than under 2.4.0, since bits of it are being swapped in and out.

This is a known problem which I'll fix as soon as I have a
solution.

The problem is that we still have no good way to balance
how much memory we take from the cache and how much memory
we take from processes.

This means that for some workloads we'll be evicting too
much cache while for other workloads we'll be evicting too
much process pages...

If anybody as a good idea to make this code auto-balancing,
please let me know.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

