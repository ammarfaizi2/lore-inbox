Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265916AbTLaAuw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 19:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265917AbTLaAuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 19:50:52 -0500
Received: from [24.35.117.106] ([24.35.117.106]:34944 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265916AbTLaAuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 19:50:51 -0500
Date: Tue, 30 Dec 2003 19:50:24 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
In-Reply-To: <Pine.LNX.4.58.0312301318540.2065@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0312301938060.3193@localhost.localdomain>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
 <Pine.LNX.4.58.0312291420370.1586@home.osdl.org>
 <Pine.LNX.4.58.0312291755080.5835@localhost.localdomain>
 <Pine.LNX.4.58.0312291502210.1586@home.osdl.org>
 <Pine.LNX.4.58.0312300903170.2825@localhost.localdomain>
 <20031230143929.GN27687@holomorphy.com> <Pine.LNX.4.58.0312301524220.3152@localhost.localdomain>
 <Pine.LNX.4.58.0312301318540.2065@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Dec 2003, Linus Torvalds wrote:
> Ok. This looks much closer to the 2.4.x numbers you reported:
> 
> 	real    13m50.198s
> 	user    0m33.780s
> 	sys     0m15.390s
> 
> so I assume that we can consider this problem largely solved? There's 
> still some difference, that could be due to just VM tuning.. 
> 
> I suspect that what happened is:
>  - slab debugging adds a heavy CPU _and_ it also makes all the slab caches 
>    much less dense.
>  - as a result, you see much higher system times, and you also end up 
>    needing much more memory for things like the dentry cache, so your 
>    memory-starved machine ended up swapping a lot more too.

So you are telling me that I am paying the price for running development 
kernels and enabling all the debugging.  I enjoy running the development 
stuff and testing new stuff.  I enabled all the kernel hacking and 
debugging options with the idea it might be useful for testing purposes.  

Disabling all the debugging stuff brings the numbers down, but things 
still "feel" worse.  It's subjective, but there you are.  I'll continue to 
test with whatever provides the most useful data.
