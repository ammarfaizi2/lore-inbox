Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135711AbREBSSb>; Wed, 2 May 2001 14:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135716AbREBSSY>; Wed, 2 May 2001 14:18:24 -0400
Received: from zmailer.org ([194.252.70.162]:32519 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S135711AbREBSSO>;
	Wed, 2 May 2001 14:18:14 -0400
Date: Wed, 2 May 2001 21:18:00 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Jim Gettys <jg@pa.dec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
Message-ID: <20010502211800.X805@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.33.0104290914260.14261-100000@twinlark.arctic.org> <200104292116.f3TLGhu07016@pachyderm.pa.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200104292116.f3TLGhu07016@pachyderm.pa.dec.com>; from jg@pa.dec.com on Sun, Apr 29, 2001 at 02:16:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 02:16:43PM -0700, Jim Gettys wrote:
...
> "X is an exercise in avoiding system calls".  I think I said this around
> 1984-1985.  
> 				- Jim

I think that applies to all really high-performance servers.

Definitely it applies to ZMailer, which before did do time(2) some
1000-20000 times per second during some high activity bursts (limited
essentially by the syscall speed).  These days there is shared memory
segment into which a server process updates the time value some 2-5
times per sec, and the consumer reads that -- likely now the consumer
bursts peak beyond 100 000 reads.

I think I took the idea from Interactive IX/386, which had magic
global segment mapped to all userspaces for few fast common tasks,
including gettimeofday() data.  That was around 1990, or a bit before
(I switched to Linux soon after.)    Where they got the idea from,
that I haven't checked.

The basic algorithms and ideas we employ to do these wonders are
also described by Knuth in his "The Art of Computer Programming"
series.  And usually he is referring to some earlier publications.

> --
> Jim Gettys
> Technology and Corporate Development
> Compaq Computer Corporation
> jg@pa.dec.com

/Matti Aarnio  <matti.aarnio@zmailer.org>
