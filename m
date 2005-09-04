Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbVIDO1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbVIDO1b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 10:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbVIDO1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 10:27:31 -0400
Received: from nevyn.them.org ([66.93.172.17]:42398 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1750850AbVIDO1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 10:27:30 -0400
Date: Sun, 4 Sep 2005 10:27:28 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Frank van Maarseveen <frankvm@frankvm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13 SMP on Athlon X2: nanosleep returning waay to soon, clock_gettime(CLOCK_REALTIME...) proceeding too fast
Message-ID: <20050904142728.GA32691@nevyn.them.org>
Mail-Followup-To: Frank van Maarseveen <frankvm@frankvm.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.63.0508182351460.6338@claven.physics.ucsb.edu> <20050830134743.GA26890@janus> <20050904113915.GA13954@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050904113915.GA13954@janus>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 01:39:15PM +0200, Frank van Maarseveen wrote:
> After replacing the kernel on a fresh FC4 install with a stock 2.6.13
> (using gcc 3.2) and my own config it appears that the clock is going too
> fast: it gains at least an hour every 12 hours or so. FC4 kernel (rpm:
> kernel-2.6.11-1.1369_FC4) seems ok

Mind sticking this information in bugzilla.kernel.org, bug 5105?

> annotated output:
> 
>       CPU0 CPU1   Total
> -----------------------
>      1  0 + 251 = 251
>      2  0 + 251 = 251
>      3  0 + 251 = 251
>      4  0 + 251 = 251
>      5  0 + 251 = 251
>      6  52 + 196 = 248		<== (?)
>      7  251 + 0 = 251
>      8  251 + 0 = 251
>      9  251 + 0 = 251
>     10  251 + 0 = 251
>     11  251 + 0 = 251
>     12  251 + 0 = 251
>     13  251 + 0 = 251
>     14  251 + 0 = 251
>     15  251 + 0 = 251
>     16  147 + 1 = 148		<==
>     17  0 + 252 = 252

Hmmmmmmmmmmmmmmmmmmmmmm, very interesting.


-- 
Daniel Jacobowitz
CodeSourcery, LLC
