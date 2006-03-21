Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWCUGrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWCUGrk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 01:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWCUGrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 01:47:40 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:25611 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750920AbWCUGrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 01:47:40 -0500
Date: Tue, 21 Mar 2006 07:47:23 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Mike Galbraith <efault@gmx.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>
Subject: Re: interactive task starvation
Message-ID: <20060321064723.GH21493@w.ods.org>
References: <200603081013.44678.kernel@kolivas.org> <20060307152636.1324a5b5.akpm@osdl.org> <cone.1141774323.5234.18683.501@kolivas.org> <200603090036.49915.kernel@kolivas.org> <20060317090653.GC13387@elte.hu> <1142592375.7895.43.camel@homer> <1142615721.7841.15.camel@homer> <1142838553.8441.13.camel@homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142838553.8441.13.camel@homer>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Mon, Mar 20, 2006 at 08:09:13AM +0100, Mike Galbraith wrote:
(...) 
> For those interested in these kind of things, here are the numbers for
> 2.6.16-rc6-mm2 with my [tarball] throttle patches applied...
> 
> [root]:# time netstat|grep :81|wc -l
>    1681
> 
> real    0m1.525s
> user    0m0.141s
> sys     0m0.136s
> [root]:# time netstat|grep :81|wc -l
>    1491
> 
> real    0m0.356s
> user    0m0.130s
> sys     0m0.114s
> [root]:# time netstat|grep :81|wc -l
>    1527
> 
> real    0m0.343s
> user    0m0.129s
> sys     0m0.114s
> [root]:# time netstat|grep :81|wc -l
>    1568
> 
> real    0m0.512s
> user    0m0.112s
> sys     0m0.138s
> 
> ...while running with the same apache loadavg of over 10, and tunables
> set to server mode (0,0).
> 
> <plug>
> Even a desktop running with these settings is so interactive that I
> could play a game of Maelstrom (asteroids like thing) while doing a make
> -j30 in slow nfs mount and barely feel it.  In a local filesystem, I
> could't feel it at all, so I added a thud 3, irman2 and a bonnie -s 2047
> for good measure.  Try that with stock :)
> </plug>

Very good job !
I told Grant in a private email that I felt confident the problem would
quickly be solved now that someone familiar with the scheduler could
reliably reproduce it. Your numbers look excellent, I'm willing to test.
Could you remind us what kernel and what patches we need to apply to
try the same, please ?

Cheers,
Willy

