Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270975AbUJVDlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270975AbUJVDlk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 23:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270974AbUJVDht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 23:37:49 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:53666 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S271013AbUJVDfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 23:35:31 -0400
Message-ID: <41787FFF.9060502@yahoo.com.au>
Date: Fri, 22 Oct 2004 13:35:27 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: andrea@novell.com, linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
References: <20041021011714.GQ24619@dualathlon.random>	<417728B0.3070006@yahoo.com.au>	<20041020213622.77afdd4a.akpm@osdl.org>	<417837A7.8010908@yahoo.com.au>	<20041021224533.GB8756@dualathlon.random>	<41785585.6030809@yahoo.com.au>	<20041022011057.GC14325@dualathlon.random>	<20041021182651.082e7f68.akpm@osdl.org>	<417879FB.5030604@yahoo.com.au> <20041021202656.08788551.akpm@osdl.org>
In-Reply-To: <20041021202656.08788551.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>Andrew Morton wrote:
>>

>>I think they probably should be turned on. A system with a gig of ram
>>shouldn't be able to use up all of ZONE_DMA on pagecache. It seems like
>>a small price to pay... same goes for very big highmem systems and ZONE_NORMAL.
> 
> 
> Problem is, how much lower zone memory do you reserve?  If someone is
> really getting hit by this in real life then the answer for their workload
> is probably "lots".  If they are not getting hit then the answer is "none".
> 

Yeah you might be right... although the ZONE_NORMAL can still be used
for other things like slab caches.

> Any halfway setting will screw everyone.
> 
> 


I guess what we really need to do is find someone who is getting hit by it.
Andrea do you have any pointers?
