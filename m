Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755530AbWKVHlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530AbWKVHlJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 02:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755533AbWKVHlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 02:41:09 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:63167 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1755530AbWKVHlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 02:41:06 -0500
Message-ID: <4563FED4.10000@us.ibm.com>
Date: Tue, 21 Nov 2006 23:40:04 -0800
From: Vara Prasad <prasadav@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, SystemTAP <systemtap@sources.redhat.com>
Subject: Re: [2.6.19 patch] i386/x86_64: remove the unused	EXPORT_SYMBOL(dump_trace)
References: <20061121194138.GF5200@stusta.de> <200611212047.30192.ak@suse.de>	<20061121201844.GA7099@infradead.org> <20061121210622.6cea428f@localhost.localdomain>
In-Reply-To: <20061121210622.6cea428f@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:

>On Tue, 21 Nov 2006 20:18:44 +0000
>Christoph Hellwig <hch@infradead.org> wrote:
>
>  
>
>>On Tue, Nov 21, 2006 at 08:47:30PM +0100, Andi Kleen wrote:
>>    
>>
>>>On Tuesday 21 November 2006 20:41, Adrian Bunk wrote:
>>>      
>>>
>>>>This patch removes the unused EXPORT_SYMBOL(dump_trace) added on i386
>>>>and x86_64 in 2.6.19-rc.
>>>>
>>>>By removing them before the final 2.6.19 we avoid the possibility of
>>>>people later whining that we removed exports they started using.
>>>>        
>>>>
>>>I exported it for systemtap so that they can stop using the broken
>>>hack they currently use as unwinder.
>>>      
>>>
>>Nack, dump_trace is nothing that should be export for broken out of tree
>>junk.
>>    
>>
>
>It is exported for systemtap not random broken out of tree junk, and the
>result is a good deal prettier. Systemtap guys really ought to get their
>stuff merged too, although how we merge a dynamic module writing tool I'm
>not so sure ?
>
>  
>
As you all know SystemTap uses kprobes and relayfs as the basis which 
are already merged into the mainline.
We are looking at all the other pieces of SystemTap that can be merged 
to mainline but as Alan mentioned it is not easy and obvious. We think 
we can merge transport part of the runtime, here is the initial patch 
under review in this thread
http://sources.redhat.com/ml/systemtap/2006-q4/msg00031.html
http://sources.redhat.com/ml/systemtap/2006-q4/msg00030.html

We are open for other suggestions as well.

bye,
Vara Prasad

>Alan
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


