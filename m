Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030864AbWKULHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030864AbWKULHW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 06:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934261AbWKULHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 06:07:22 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:19445 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1030864AbWKULHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 06:07:21 -0500
Message-ID: <4562DDBE.5070706@in.ibm.com>
Date: Tue, 21 Nov 2006 16:36:38 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: "Patrick.Le-Dot" <Patrick.Le-Dot@bull.net>
CC: ckrm-tech@lists.sourceforge.net, dev@openvz.org, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, rohitseth@google.com
Subject: Re: [RFC][PATCH 5/8] RSS controller task migration support
References: <20061121100150.9ECCF1B6AC@openx4.frec.bull.fr>
In-Reply-To: <20061121100150.9ECCF1B6AC@openx4.frec.bull.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick.Le-Dot wrote:
> On Fri, 17 Nov 2006 22:04:08 +0530
>> ...
>> I am not against guarantees, but
>>
>> Consider the following scenario, let's say we implement guarantees
>>
>> 1. If we account for kernel resources, how do you provide guarantees
>>    when you have non-reclaimable resources?
> 
> First, the current patch is based only on pages available in the
> struct mm.
> I doubt that these pages are "non-reclaimable"...

I am speaking of a scenario when we start supporting kernel accounting
and of-course the swapless case.

> 
> And guarantee should be ignored just because some kernel resources
> are marked "non-reclaimable" ?
> 

Ok.. but can you have a consistent guarantee definition with un-reclaimable
kernel resources? How do you define a guarantee in a consistent manner?
In my discussions earlier on lkml, I had suggested that we define guarantee
only for reclaimable resources and provide support only for them.

> 
>> 2. If a customer runs a system with swap turned off (which is quite
>>    common),
> 
> quite common, really ?

Yep, I was listening to a talk from a customer service expert and he
mentioned that it's used to boost performance.

> 
>>             then anonymous memory becomes irreclaimable. If a group
>>    takes more than it's fair share (exceeds its guarantee), you
>>    have scenario similar to 1 above.
> 
> That seems to be just a subset of the "guarantee+limit" model : if
> guarantee is not useful for you, don't use it.
> 
> I'm not saying that guarantee should be a magic piece of code working
> for everybody.
> 
> But we have to propose something for the customers who ask for a
> guarantee (ie using a system with swap turned on like me and this is
> quite common:-)
> 

Like I said I am not against guarantees, but do we have to implement
them in our first iteration?


> Patrick
>


-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
