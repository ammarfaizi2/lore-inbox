Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129360AbRA3LtS>; Tue, 30 Jan 2001 06:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbRA3LtH>; Tue, 30 Jan 2001 06:49:07 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:20476 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129360AbRA3Ls7>; Tue, 30 Jan 2001 06:48:59 -0500
Date: Tue, 30 Jan 2001 09:48:33 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: alex@foogod.com
cc: Alan Olsen <alan@clueserver.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Recommended swap for 2.4.x.
In-Reply-To: <20010129152335.H11411@draco.foogod.com>
Message-ID: <Pine.LNX.4.21.0101300945500.1321-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2001 alex@foogod.com wrote:
> On Mon, Jan 29, 2001 at 02:57:44PM -0800, Alan Olsen wrote:
> > 
> > What is the recommended amount of swap with the 2.4.x kernels?
> 
> AFAIK, swap requirements for applications running under a 2.4
> kernel have not changed significantly from 2.2 kernels

It has. We now leave dirty pages swapcached, which means that
for certain workloads Linux 2.4 eats up much more swap space
than Linux 2.2.

On the other hand, if you almost never used swap under Linux
2.2, you probably won't be using it under 2.4 either.

> 2) Subtract the amount of RAM you have (believe it or not, the more RAM you 
>    have, the less swap you need.  Imagine that).

For Linux 2.4, it may be better to substract a bit less,
because of the issue above.

If you have a very swap-intensive workload, you may end
up with 90% of your memory being "duplicated" in swap, in
which case this rule doesn't work.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
