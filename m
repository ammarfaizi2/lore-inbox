Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265437AbSJSBGl>; Fri, 18 Oct 2002 21:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265439AbSJSBGl>; Fri, 18 Oct 2002 21:06:41 -0400
Received: from mta01bw.bigpond.com ([139.134.6.78]:59901 "EHLO
	mta01bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S265437AbSJSBGj> convert rfc822-to-8bit; Fri, 18 Oct 2002 21:06:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.20pre11aa1
Date: Sat, 19 Oct 2002 11:21:19 +1000
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
References: <20021018145204.GG23930@dualathlon.random> <29723.1034955246@ocs3.intra.ocs.com.au> <20021018160031.GI23930@dualathlon.random>
In-Reply-To: <20021018160031.GI23930@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210191121.20062.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

On Saturday 19 October 2002 02:00, Andrea Arcangeli wrote:
> the corrupted module tables rings a bell. I fixed the wrong locking in
> the module code that could corrupt these tables (they were relying on
> the bkl but the bkl means nothing if you copy_user in the middle of the
> loop like the module code does, so I replaced the bkl with a semaphore
> and that should fix things), but I wonder if I broken something else
> with these fixes.
>
> Here's the patch that I'm talking about, you may want to start the
> binary search backing this out and see if the problem goes away. if it
> goes away I clearly need to double check it ;)

Unfortunately removing that change off kernel/module.c did not help.

I may be wrong but considering in my case the kernel is crashing whether 
agpgart/radeon are compiled as modules or built-in, I suspect that this issue 
is larger than just modules sub-system.

Anyway I will start applying the patches from 00* on-wards from your tree to 
see if I can reliably prove where the problem is.

Thanks.
-- 
Hari
harisri@bigpond.com

