Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265607AbUBGAZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 19:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265801AbUBGAZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 19:25:27 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:10985 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265607AbUBGAZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 19:25:25 -0500
Date: Fri, 06 Feb 2004 16:25:05 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: Rick Lindsley <ricklind@us.ibm.com>, Anton Blanchard <anton@samba.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
Message-ID: <242810000.1076113505@flay>
In-Reply-To: <40242D14.6070908@cyberone.com.au>
References: <200402062311.i16NBdF14365@owlet.beaverton.ibm.com> <40242152.5030606@cyberone.com.au> <231480000.1076110387@flay> <4024261E.5070702@cyberone.com.au> <232690000.1076111266@flay> <40242D14.6070908@cyberone.com.au>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Not sure how true that turns out to be in practice ... probably depends
>> heavily on both the workload (how heavily it's using the cache) and the
>> chip (larger caches have proportionately more to lose).
>> 
>> As we go forward in time, cache warmth gets increasingly important, as
>> CPUs accelerate speeds quicker than memory. Cache sizes also get larger.
>> I'd really like us to be conservative here - the unfairness thing is 
>> really hard to hit anyway - you need a static number of processes that
>> don't ever block on IO or anything.
> 
> Can we keep current behaviour default, and if arches want to
> override it they can? And if someone one day does testing to
> show it really isn't a good idea, then we can change the default.

Well, that should be a pretty easy test to do. I'll try it.

M.

