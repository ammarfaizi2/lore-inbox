Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWHYLJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWHYLJn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 07:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWHYLJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 07:09:43 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:40783 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964861AbWHYLJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 07:09:43 -0400
Message-ID: <44EEDB23.9050006@sw.ru>
Date: Fri, 25 Aug 2006 15:12:35 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: sekharan@us.ibm.com
CC: rohitseth@google.com, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
References: <44E33893.6020700@sw.ru>	 <1155929992.26155.60.camel@linuxchandra>  <44E9B3F5.3010000@sw.ru>	 <1156196721.6479.67.camel@linuxchandra>	 <1156211128.11127.37.camel@galaxy.corp.google.com>	 <1156272902.6479.110.camel@linuxchandra>	 <1156383881.8324.51.camel@galaxy.corp.google.com>	 <1156385072.7154.59.camel@linuxchandra>	 <1156440461.14648.26.camel@galaxy.corp.google.com> <1156463572.19702.46.camel@linuxchandra>
In-Reply-To: <1156463572.19702.46.camel@linuxchandra>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman wrote:
> On Thu, 2006-08-24 at 10:27 -0700, Rohit Seth wrote:
> 
> <snip>
> 
>>>What do you mean by "resource management part for non-container world
>>>already exist ?
>>>
>>>It does not. CKRM/Resource Groups is trying to do that, but is not in
>>>Linus's tree.
>>>
>>
>>Please, non-container is the environment that exist today in Linux.
>>Actually cpuset does provide some part of it.  But beyond that no.  
> 
> 
> cpuset provides resource _isolation_, not necessarily resource
> management.
> 
> 
>>But then we are all using different terminology like beancounters,
>>containers, resource groups and now non-containers...
>>
> 
> 
> <snip>
> 
>>>>I'm sure when container support gets in then for the above scenario it
>>>>will read -1 ...
>>>
>>>So, how can one get the list of tasks belonging to a resource group in
>>>that case ?
>>>
>>...and that brings to the starting question...why do you need it?
> 
> 
> Like I said earlier, there is _no_ other way to get the list of tasks
> belonging to a resource group.
> 
> 
>>Commands like ps and top will show appropriate container number for each
>>task.
> 
> 
> There is _no_ container number in the non-container environment (or it
> will be same for _all_ tasks).

Chandra, virtual container number is essentially the same as user id
in non-container environment. UBC were desgined for _users_ first.
Containers were just the first environment which started to use it widely.

And I really disagree when you say that non-container usecase is
a superset of container usecase. I believe it is vice versa, since
in container usecase you have a _full_ environment with root user and need
more resources to be taken into account.

Thanks,
Kirill

