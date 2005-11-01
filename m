Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbVKAQ76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbVKAQ76 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 11:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbVKAQ76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 11:59:58 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:434 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750911AbVKAQ75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 11:59:57 -0500
Message-ID: <43679EE6.7000706@jp.fujitsu.com>
Date: Wed, 02 Nov 2005 01:59:18 +0900
From: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
CC: Ingo Molnar <mingo@elte.hu>, Dave Hansen <haveblue@us.ibm.com>,
       Mel Gorman <mel@csn.ul.ie>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au> <Pine.LNX.4.58.0511011014060.14884@skynet> <20051101135651.GA8502@elte.hu> <1130854224.14475.60.camel@localhost> <20051101142959.GA9272@elte.hu> <1130856555.14475.77.camel@localhost> <20051101150142.GA10636@elte.hu> <43679C69.6050107@jp.fujitsu.com>
In-Reply-To: <43679C69.6050107@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kamezawa Hiroyuki wrote:
> Ingo Molnar wrote:
> 
>> so it's all about expectations: _could_ you reasonably remove a piece 
>> of RAM? Customer will say: "I have stopped all nonessential services, 
>> and free RAM is at 90%, still I cannot remove that piece of faulty 
>> RAM, fix the kernel!". No reasonable customer will say: "True, I have 
>> all RAM used up in mlock()ed sections, but i want to remove some RAM 
>> nevertheless".
>>
> Hi, I'm one of men in -lhms
> 
> In my understanding...
> - Memory Hotremove on IBM's LPAR? approach is
>   [remove some amount of memory from somewhere.]
>   For this approach, Mel's patch will work well.
>   But this will not guaranntee a user can remove specified range of
>   memory at any time because how memory range is used is not defined by 
> an admin
>   but by the kernel automatically. But to extract some amount of memory,
>   Mel's patch is very important and they need this.
> 
One more consideration...
Some cpus which support virtialization will be shipped by some vendor in near future.
If someone uses vitualized OS, only problem is *resizing*.
Hypervisor will be able to remap semi-physical pages anyware with hardware assistance
but system resizing needs operating system assistance.
To this direction, [remove some amount of memory from somewhere.] is important approach.

-- Kame


