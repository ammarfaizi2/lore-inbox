Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317404AbSHCAxk>; Fri, 2 Aug 2002 20:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317405AbSHCAxk>; Fri, 2 Aug 2002 20:53:40 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:13073 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317404AbSHCAxi>; Fri, 2 Aug 2002 20:53:38 -0400
Date: Fri, 2 Aug 2002 21:56:57 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
cc: Daniel Phillips <phillips@arcor.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Rmap speedup
In-Reply-To: <3D4B2471.29EE6462@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0208022155310.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2002, Andrew Morton wrote:

> > > Well that's fairly straightforward, thanks.  Butt-ugly though ;)

> I changed it to, essentially:

> See http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.30/daniel-rmap-speedup.patch

This patch looks good.  Good enough for long-term maintainability,
even... ;)

I like it.

> We have short-term rmap problems:
>
> 1) Unexplained pte chain state with ntpd

I'll do a detailed trace of xntpd to see what's happening...

> 2) 10-20% increased CPU load in fork/exec/exit loads
> 3) system lock under heavy mmap load
> 4) ZONE_NORMAL pte_chain consumption
>
> Daniel and I are on 2), Bill is on 4) (I think).

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

