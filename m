Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265840AbUHALiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265840AbUHALiS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 07:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265825AbUHALiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 07:38:18 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:24035 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265823AbUHALiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 07:38:15 -0400
Date: Sun, 1 Aug 2004 13:38:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: jgarzik@pobox.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [2.6 patch] net/hamachi.c: remove bogus inline at function prototype (fwd)
Message-ID: <20040801113809.GM2746@fs.tum.de>
References: <20040729140535.GU2349@fs.tum.de> <Pine.LNX.4.60.0408011314480.2535@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0408011314480.2535@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2004 at 01:21:22PM +0200, Jesper Juhl wrote:
>...
> Wouldn't it make sense to also un-inline hamachi_tx? both the _rx and _tx 

My primary goal was to fix the compilation with gcc 3.4, not to evaluate 
all inlines (which is also a good thing to do).

> functions are quite big - are they really suitable to be inlined?

Each of thamachi_{tx,rx} has exacly one caller, which might be a reason 
in favor of inlining.

> Here's a proposed patch against 2.6.8-rc2-mm1
>...

Looks good.

> /Jesper Juhl

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

