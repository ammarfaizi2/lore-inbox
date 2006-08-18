Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWHRItY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWHRItY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 04:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWHRItY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 04:49:24 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:54796 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751217AbWHRItY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 04:49:24 -0400
Message-ID: <44E57FA4.1080809@sw.ru>
Date: Fri, 18 Aug 2006 12:51:48 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: rohitseth@google.com
CC: Dave Hansen <haveblue@us.ibm.com>, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Pavel Emelianov <xemul@openvz.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andi Kleen <ak@suse.de>
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory	accounting	(core)
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>	<1155754029.9274.21.camel@localhost.localdomain>	<1155755729.22595.101.camel@galaxy.corp.google.com>	<1155758369.9274.26.camel@localhost.localdomain>	<1155774274.15195.3.camel@localhost.localdomain>	<1155824788.9274.32.camel@localhost.localdomain> <1155835003.14617.45.camel@galaxy.corp.google.com>
In-Reply-To: <1155835003.14617.45.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth wrote:
> On Thu, 2006-08-17 at 07:26 -0700, Dave Hansen wrote:
> 
>>On Thu, 2006-08-17 at 01:24 +0100, Alan Cox wrote:
>>
>>>Ar Mer, 2006-08-16 am 12:59 -0700, ysgrifennodd Dave Hansen:
>>>
>>>>relationship between processes and mm's.  We could also potentially have
>>>>two different threads of a process in two different accounting contexts.
>>>>But, that might be as simple to fix as disallowing things that share mms
>>>>from being in different accounting contexts, unless you unshare the mm.
>>>
>>>At the point I have twenty containers containing 20 copies of glibc to
>>>meet your suggestion it would be *far* cheaper to put it in the page
>>>struct.
>>
>>My main thought is that _everybody_ is going to have to live with the
>>entry in the 'struct page'.  Distros ship one kernel for everybody, and
>>the cost will be paid by those not even using any kind of resource
>>control or containers.
>>
>>That said, it sure is simpler to implement, so I'm all for it!
> 
> 
> 
> hmm, not sure why it is simpler.
because introducing additonal lookups/hashes etc. is harder and
adds another source for possible mistakes.
we can always optimize it out if people insist.

Kirill

