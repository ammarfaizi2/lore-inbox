Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWIHV2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWIHV2b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 17:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWIHV2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 17:28:31 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:199 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751167AbWIHV23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 17:28:29 -0400
Message-ID: <4501E077.3030702@watson.ibm.com>
Date: Fri, 08 Sep 2006 17:28:23 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: rohitseth@google.com
CC: Rik van Riel <riel@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@sw.ru>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Pavel Emelianov <xemul@openvz.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       devel@openvz.org, Andi Kleen <ak@suse.de>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4)	(added	user
 memory)
References: <44FD918A.7050501@sw.ru>	<1157478392.3186.26.camel@localhost.localdomain>	<1157501878.11268.77.camel@galaxy.corp.google.com>	<1157729450.26324.44.camel@localhost.localdomain>	<1157735437.1214.32.camel@galaxy.corp.google.com>	<4501A7DD.8040305@watson.ibm.com> <1157750135.1214.94.camel@galaxy.corp.google.com>
In-Reply-To: <1157750135.1214.94.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth wrote:

>> Memory resources, by their very nature, will be tougher to account when a
>> single database/app server services multiple clients and we can essentially
>> give up on that (taking the approach that only limited recharging can ever
>> be achieved). 
> 
> What exactly you mean by limited recharging?  
> 

Memory allocated (and hence charged) by a task belonging to one container
being (re)charged to another container to which task moves. Can be done but at
too high a cost so not worth it most of the time.


> As said earlier, if there is big shared segment on a server then that
> can be charged to any single container.  And in this case moving a task
> to different container may not fetch anything useful from memory
> accounting pov.
> 
>> But cpu atleast is easy to charge correctly and since that will
>> also indirectly influence the requests for memory & I/O, its useful to allow
>> middleware to change the accounting base for a thread/task.
>>
> 
> That is not true.   It depends on IO size, memory foot print etc. etc.
> You can move a task to different container, but it will not be cheap.
> 
For cpu time & I/O bandwidth I disagree. Accounting to a multiplicity of
containers/BC over time shouldn't be costly.

Anyway, lets see how the implementation evolves.

> -rohit

