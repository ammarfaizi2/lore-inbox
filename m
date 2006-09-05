Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbWIES3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbWIES3Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 14:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbWIES3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 14:29:24 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:52377 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030207AbWIES3X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 14:29:23 -0400
Message-ID: <44FDC1E1.7090006@in.ibm.com>
Date: Tue, 05 Sep 2006 23:58:49 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alexey Dobriyan <adobriyan@mail.ru>, Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user
 memory)
References: <44FD918A.7050501@sw.ru> <1157478392.3186.26.camel@localhost.localdomain>
In-Reply-To: <1157478392.3186.26.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Tue, 2006-09-05 at 19:02 +0400, Kirill Korotaev wrote:
>> Core Resource Beancounters (BC) + kernel/user memory control.
>>
>> BC allows to account and control consumption
>> of kernel resources used by group of processes. 
> 
> Hi Kirill, 
> 
> I've honestly lost track of these discussions along the way, so I hope
> you don't mind summarizing a bit.
> 
> Do these patches help with accounting for anything other than memory?
> Will we need new user/kernel interfaces for cpu, i/o bandwidth, etc...?
> 
> Have you given any thought to the possibility that a task might need to
> move between accounting contexts?  That has certainly been a
> "requirement" pushed on to CKRM for a long time, and the need goes
> something like this:
> 
> 1. A system runs a web server, which services several virtual domains
> 2. that web server receives a request for foo.com
> 3. the web server switches into foo.com's accounting context
> 4. the web server reads things from disk, allocates some memory, and
>    makes a database request.
> 5. the database receives the request, and switches into foo.com's
>    accounting context, and charges foo.com for its resource use
> etc...
> 
> So, the goal is to run _one_ copy of an application on a system, but
> account for its resources in a much more fine-grained way than at the
> application level.
> 
> I think we can probably use beancounters for this, if we do not worry
> about migrating _existing_ charges when we change accounting context.
> Does that make sense?
> 
> -- Dave

This is much better stated than I did. Thanks!

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
