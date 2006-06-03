Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751695AbWFCP3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbWFCP3Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 11:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbWFCP3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 11:29:16 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:50651 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750798AbWFCP3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 11:29:15 -0400
Date: Sat, 3 Jun 2006 16:29:12 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Andrew Morton <akpm@osdl.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2
In-Reply-To: <20060602115911.bcfe2654.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606031558160.1610@skynet.skynet.ie>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
 <Pine.LNX.4.64.0606021902340.31071@skynet.skynet.ie> <20060602115911.bcfe2654.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2006, Andrew Morton wrote:

> On Fri, 2 Jun 2006 19:38:36 +0100 (IST)
> Mel Gorman <mel@csn.ul.ie> wrote:
>
>> This reliably goes kablam on an x86_64 machine with a tg3 network card
>> which was also happening for 2.6.17-rc5-mm1. A patch bisect found that
>> reversing git-net.patch and git-net-git-klibc-fixup.patch on top of
>> the -mm3 got rid of the problem. Don't ask me why.
>>
>> The console log I have of the most common oops is below and the .config
>> used is attached. The oops happens reliably but at varying times and not
>> always the same oops either. Usually sshing into the machine and compiling
>> the kernel is enough. On at least one occasion, sshing to the machine
>> triggered it.
>
> Yeah, sorry.  I _knew_ LLC was buggy but I forgot to mention it in the
> release notes and wasted heaps of lots of people's time. Feel free to 
> bill me :(

Nah, it gave me something handy to do on a Friday :)

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/hot-fixes/git-net-llc-fix.patch
>
> should fix.
>

Confirmed. The machine passed some fairly basic tests it was failing on 
before.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
