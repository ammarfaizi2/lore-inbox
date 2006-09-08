Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWIHS30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWIHS30 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 14:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWIHS30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 14:29:26 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:2709 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751162AbWIHS3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 14:29:24 -0400
Message-ID: <4501B5F0.9050802@in.ibm.com>
Date: Fri, 08 Sep 2006 23:56:56 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Pavel Emelianov <xemul@openvz.org>, Rik van Riel <riel@redhat.com>,
       Srivatsa <vatsa@in.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sekharan@us.ibm.com, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Andi Kleen <ak@suse.de>, Kirill Korotaev <dev@sw.ru>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added	user
 memory)
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>	<44FEC7E4.7030708@sw.ru>  <44FF1EE4.3060005@in.ibm.com>	<1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org> <1157730221.26324.52.camel@localhost.localdomain>
In-Reply-To: <1157730221.26324.52.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Fri, 2006-09-08 at 11:33 +0400, Pavel Emelianov wrote:
>> I'm afraid we have different understandings of what a "guarantee" is.
> 
> It appears so.
> 
>> Don't we?
>> Guarantee may be one of
>>
>>   1. container will be able to touch that number of pages
>>   2. container will be able to sys_mmap() that number of pages
>>   3. container will not be killed unless it touches that number of pages
> 
> A "death sentence" guarantee?  I like it. :)
> 
>>   4. anything else
>>
>> Let's decide what kind of a guarantee we want.

I think of guarantees w.r.t resources as the lower limit on the resource.
Guarantees and limits can be thought of as the range (guarantee, limit]
for the usage of the resource.

> 
> I think of it as: "I will be allowed to use this many total pages, and
> they are guaranteed not to fail."  (1), I think.  The sum of all of the
> system's guarantees must be less than or equal to the amount of free
> memory on the machine.  
> 

Yes, totally agree.

> If we knew to which NUMA node the memory was going to go, we might as
> well take the pages out of the allocator.
> 
> -- Dave
> 
-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
