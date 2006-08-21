Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751847AbWHUKlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbWHUKlJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 06:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWHUKlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 06:41:09 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:27224 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750773AbWHUKlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 06:41:08 -0400
Message-ID: <44E98E61.2030608@sw.ru>
Date: Mon, 21 Aug 2006 14:43:45 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: rohitseth@google.com
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 5/7] UBC: kernel memory accounting (core)
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>	 <1155752693.22595.76.camel@galaxy.corp.google.com> <44E46ED3.7000201@sw.ru>	 <1155834136.14617.29.camel@galaxy.corp.google.com> <44E58A89.8040001@sw.ru> <1155920158.22899.8.camel@galaxy.corp.google.com>
In-Reply-To: <1155920158.22899.8.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>1. reclaiming user resources is not that good idea as it looks to you.
>>such solutions end up with lots of resources spent on reclaim.
>>for user memory reclaims mean consumption of expensive disk I/O bandwidth
>>which reduces overall system throughput and influences other users.
>>
> 
> 
> May be I'm overlooking something very obvious.  Please tell me, what
> happens when a user hits a page fault and the page allocator is easily
> able to give a page from its pcp list.  But container is over its limit
> of physical memory.  In your patch there is no attempt by container
> support to see if some of the user pages are easily reclaimable.  What
> options a user will have to make sure some room is created.
The patch set send doesn't control user memory!
This topic is about kernel memory...

>>2. kernel memory is mostly not reclaimable. can you reclaim vma structs or ipc ids?
> 
> 
> I'm not arguing about that at all.  If people want to talk about
> reclaiming kernel pages then that should be done independent of this
> subject.
Then why do you mess user pages accounting into this thread then?

Kirill

