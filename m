Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbTJQXVQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 19:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbTJQXVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 19:21:16 -0400
Received: from dyn-ctb-210-9-245-184.webone.com.au ([210.9.245.184]:23044 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261234AbTJQXVO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 19:21:14 -0400
Message-ID: <3F907960.90007@cyberone.com.au>
Date: Sat, 18 Oct 2003 09:21:04 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Unbloating the kernel, was: :mem=16MB laptop testing
References: <Pine.LNX.4.44.0310141813320.1776-100000@gaia.cela.pl> <200310141733.h9EHXnYg002262@81-2-122-30.bradfords.org.uk> <20031015124314.GD20846@lug-owl.de> <3F8D46D7.1020105@cyberone.com.au> <20031017115047.GE20846@lug-owl.de>
In-Reply-To: <20031017115047.GE20846@lug-owl.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jan-Benedict Glaw wrote:

>On Wed, 2003-10-15 23:08:39 +1000, Nick Piggin <piggin@cyberone.com.au>
>wrote in message <3F8D46D7.1020105@cyberone.com.au>:
>
>>Jan-Benedict Glaw wrote:
>>
>>>On Tue, 2003-10-14 18:33:49 +0100, John Bradford <john@grabjohn.com>
>>>wrote in message 
>>><200310141733.h9EHXnYg002262@81-2-122-30.bradfords.org.uk>:
>>>
>
>>>Achtually, with HZ at around 100 (or oven 70..80), an old i386 or i486
>>>will *start* just fine, at least at 8MB. However, over some days /
>>>weeks, the machine gets slower and slower (my testdrive: my 90MHz
>>>P-Classic with 16MB). Even with that "much" RAM, I get hit by whatever
>>>slows down the machine. I *think* that it's the MM subsystem, but I'm
>>>really not skilled enough with it to blame it:)
>>>
>>>
>>Thats interesting. Its probably a memory leak I guess. Make sure to rule out
>>memory leaks in userspace applications, then get /proc/meminfo, 
>>/proc/slabinfo
>>on the box after it is getting slow, and also, after the box is newly 
>>booted.
>>
>
>Well, the box is still fine useable, but it's only rebooted some days
>ago. However, I see size-64 (non-DMA) is going sloooowly up... What do I
>do with the box? minicom (it's kind of a console server:), NATting, IPv6
>gw. No X11, normally no local access at all.
>
>On my Athlon (dual), I've already reached 319780 allocations in size-64,
>but it seems to be currently stable, though...
>
>I do _not_ see a leak in he size-4k region.
>

Maybe you could try Manfred's recent patch (in this thread) to find out
what is kmallocing all that memory.


