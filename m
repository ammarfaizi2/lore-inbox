Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262108AbSI3Pyt>; Mon, 30 Sep 2002 11:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbSI3Pyt>; Mon, 30 Sep 2002 11:54:49 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:3491 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S262108AbSI3Pyt>;
	Mon, 30 Sep 2002 11:54:49 -0400
Message-ID: <3D9874E7.70805@colorfullife.com>
Date: Mon, 30 Sep 2002 17:59:35 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: lse-tech@lists.sourceforge.net, akpm@digeo.com, tomlins@cam.org,
       "Kamble, Nitin A" <nitin.a.kamble@intel.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATH] slab cleanup
References: <3D96F559.2070502@colorfullife.com> <732392454.1033343702@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>Could someone test that it works on real SMP?
> 
> 
> Tested on 16-way NUMA-Q (shows up races quicker than anything ;-)). 
> Boots, compiles the kernel 5 times OK. That's good enough for me. 
> No performance regression, in fact was marginally faster (within 
> experimental error though).
> 
Thanks for the test. NUMA is on my TODO list, after figuring out 
where/how to drain cpu caches and the free list.

I've found one stupid bug with debugging enabled: the new debug code 
tries to poison NULL pointers, with limited success :-(

And one limitation might be important for arch specific code: 
kmem_cache_create() during mem_init() is not possible anymore.

--
	Manfred

