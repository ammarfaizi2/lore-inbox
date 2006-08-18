Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWHRIm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWHRIm0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 04:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWHRIm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 04:42:26 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:27277 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751153AbWHRImZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 04:42:25 -0400
Message-ID: <44E57E01.8070406@sw.ru>
Date: Fri, 18 Aug 2006 12:44:49 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: rohitseth@google.com
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, ckrm-tech@lists.sourceforge.net,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       hugh@veritas.com, Ingo Molnar <mingo@elte.hu>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting	(core)
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>	<1155754029.9274.21.camel@localhost.localdomain>	<1155755729.22595.101.camel@galaxy.corp.google.com>	<1155774141.15195.0.camel@localhost.localdomain> <1155832615.14617.8.camel@galaxy.corp.google.com>
In-Reply-To: <1155832615.14617.8.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth wrote:
> On Thu, 2006-08-17 at 01:22 +0100, Alan Cox wrote:
> 
>>Ar Mer, 2006-08-16 am 12:15 -0700, ysgrifennodd Rohit Seth:
>>
>>>resources will be allocated/freed in context of a user process.  And at
>>>that time we know if a allocation should succeed or not.  So we may
>>>actually not need to track kernel pages that closely.
>>
>>Quite the reverse, tracking kernel pages is critical, 
> 
> 
> Having the knowledge of how many kernel pages are getting used by each
> container is indeed very useful.  But as long as the context in which
> they are created and destroyed is identifiable, there is no need to
> really physically tag each page with container id.  And for the cases
> where we have no context, it will be worth while to see if mapping field
> could be used.
as I described in another email this field is also reused for tracking
user pages.

Kirill
