Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268317AbTBMXVM>; Thu, 13 Feb 2003 18:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268319AbTBMXVM>; Thu, 13 Feb 2003 18:21:12 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:35857 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S268317AbTBMXVL>; Thu, 13 Feb 2003 18:21:11 -0500
Date: Thu, 13 Feb 2003 18:27:45 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@digeo.com>
cc: larry@minfin.bg, linux-kernel@vger.kernel.org
Subject: Re: Strange TCP with 2.5.60
In-Reply-To: <20030212102418.3a15b4a8.akpm@digeo.com>
Message-ID: <Pine.LNX.3.96.1030213182617.13463A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2003, Andrew Morton wrote:

> Could you pelase retest with this patch, and tell us how many of these
> problems go away?
> 
> diff -puN net/ipv4/fib_hash.c~a net/ipv4/fib_hash.c
> --- 25/net/ipv4/fib_hash.c~a	2003-02-12 10:23:55.000000000 -0800
> +++ 25-akpm/net/ipv4/fib_hash.c	2003-02-12 10:24:00.000000000 -0800
> @@ -941,7 +941,7 @@ static __inline__ struct fib_node *fib_g
>  
>  			if (!iter->zone)
>  				goto out;
> -			if (iter->zone->fz_next)
> +			if (iter->zone->fz_next);
>  				break;
>  		}
>  		
> 
> _

is that patch reversed, I hope? The if doesn't do a great deal.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

