Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbUCGK3v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 05:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbUCGK3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 05:29:51 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:40910 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261797AbUCGK3t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 05:29:49 -0500
Message-ID: <404AF991.9040709@cyberone.com.au>
Date: Sun, 07 Mar 2004 21:29:37 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrea Arcangeli <andrea@suse.de>, Peter Zaitsev <peter@mysql.com>,
       Andrew Morton <akpm@osdl.org>, riel@redhat.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
References: <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143210.GA11897@elte.hu> <20040305145837.GZ4922@dualathlon.random> <20040305152622.GA14375@elte.hu> <20040305155317.GC4922@dualathlon.random> <20040307084120.GB17629@elte.hu>
In-Reply-To: <20040307084120.GB17629@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:

>* Andrea Arcangeli <andrea@suse.de> wrote:
>
>
>>[...] but I'm quite confortable to say that up to 16G (included) 4:4
>>is worthless unless you've to deal with the rmap waste IMHO. [...]
>>
>
>i've seen workloads on 8G RAM systems that easily filled up the ~800 MB
>lowmem zone. (it had to do with many files and having them as a big
>dentry cache, so yes, it's unfixable unless you start putting inodes
>into highmem which is crazy. And yes, performance broke down unless most
>of the dentries/inodes were cached in lowmem.)
>
>

If you still have any of these workloads around, they would be
good to test on the memory management changes in Andrew's mm tree
which should correctly balance slab on highmem systems. Linus'
tree has a few problems here.

But if you really have a lot more than 800MB of active dentries,
then maybe 4:4 would be a win?

