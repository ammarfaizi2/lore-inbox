Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbUCHFPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 00:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUCHFPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 00:15:24 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:60307 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261646AbUCHFPW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 00:15:22 -0500
Message-ID: <404C0162.5090304@cyberone.com.au>
Date: Mon, 08 Mar 2004 16:15:14 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Ingo Molnar <mingo@elte.hu>, Peter Zaitsev <peter@mysql.com>,
       Andrew Morton <akpm@osdl.org>, riel@redhat.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
References: <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143210.GA11897@elte.hu> <20040305145837.GZ4922@dualathlon.random> <20040305152622.GA14375@elte.hu> <20040305155317.GC4922@dualathlon.random> <20040307084120.GB17629@elte.hu> <404AF991.9040709@cyberone.com.au> <20040307173352.GC4922@dualathlon.random>
In-Reply-To: <20040307173352.GC4922@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrea Arcangeli wrote:

>On Sun, Mar 07, 2004 at 09:29:37PM +1100, Nick Piggin wrote:
>
>>
>>Ingo Molnar wrote:
>>
>>
>>>* Andrea Arcangeli <andrea@suse.de> wrote:
>>>
>>>
>>>
>>>>[...] but I'm quite confortable to say that up to 16G (included) 4:4
>>>>is worthless unless you've to deal with the rmap waste IMHO. [...]
>>>>
>>>>
>>>i've seen workloads on 8G RAM systems that easily filled up the ~800 MB
>>>lowmem zone. (it had to do with many files and having them as a big
>>>dentry cache, so yes, it's unfixable unless you start putting inodes
>>>into highmem which is crazy. And yes, performance broke down unless most
>>>of the dentries/inodes were cached in lowmem.)
>>>
>>>
>>>
>>If you still have any of these workloads around, they would be
>>
>
>I also have workloads that would die with 4:4 and rmap.
>
>

I don't doubt that, and of course no amount of tinkering with
reclaim will help where you are dying due to pinned lowmem.

Ingo's workload sounded like slab cache reclaim improvements in
recent mm kernels might possibly help. I was purely interested
in this for testing the reclaim changes.

