Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317471AbSHCAMA>; Fri, 2 Aug 2002 20:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317472AbSHCAMA>; Fri, 2 Aug 2002 20:12:00 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:54281 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317471AbSHCAL7>; Fri, 2 Aug 2002 20:11:59 -0400
Date: Fri, 2 Aug 2002 21:14:52 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
cc: Daniel Phillips <phillips@arcor.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Rmap speedup
In-Reply-To: <3D4AE995.DFD862EF@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0208022113440.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2002, Andrew Morton wrote:
> Daniel Phillips wrote:
> >
> > This patch eliminates about 35% of the raw rmap setup/teardown overhead by
> > adopting a new locking interface that allows the add_rmaps to be batched in
> > copy_page_range.
>
> Well that's fairly straightforward, thanks.  Butt-ugly though ;)

It'd be nice if the code would be a bit more beautiful and the
reverse mapping scheme more modular.

Remember that we're planning to go to an object-based scheme
later on, turning the code into a big monolithic mesh really
makes long-term maintenance a pain...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

