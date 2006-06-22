Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751814AbWFVPqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbWFVPqE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 11:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbWFVPqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 11:46:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:42300 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751814AbWFVPqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 11:46:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=otCyTGRLxXVoBcetLWQGtEgMO4pLmT7qgtljen91LLIpycKypgfnF9Ve7qnwf89eWpTvubzYJRCfxtjzfV8WmHCUQnLM37Ji6A0DoioM+0OVvweVYFHOXU7Cxq4H+a5OI4BuPeVZf80liBMgeiA5ZTYEAxyVScMYgKJnUaKcagc=
Message-ID: <449ABC3E.5070609@innova-card.com>
Date: Thu, 22 Jun 2006 17:50:22 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: Franck <vagabon.xyz@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1
References: <20060621034857.35cfe36f.akpm@osdl.org> <449AB01A.5000608@innova-card.com> <Pine.LNX.4.64.0606221617420.5869@skynet.skynet.ie>
In-Reply-To: <Pine.LNX.4.64.0606221617420.5869@skynet.skynet.ie>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <fbh.work@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:
> On Thu, 22 Jun 2006, Franck Bui-Huu wrote:
>>
>> Should ARCH_PFN_OFFSET macro be used instead in order to make pfn/page
>> convertions work when node 0 start offset do not start at 0 ?
>>
> 
> What happens if you have ARCH_PFN_OFFSET as
> 
> #define ARCH_PFN_OFFSET (0UL)
> 
> ?

It's the default value (see memory_model.h). It means that pfn start
for node 0 is 0, therefore your physical memory address starts at 0.

> 
> What arch is this?
> 

well I'm working on MIPS, but you can take a look at ARM that does the
same thing better...

>> My physical memory start at 0x20000000. So node 0 starts at an offset
>> different from 0. I setup ARCH_PFN_OFFSET this way
>>
>>     #define ARCH_PFN_OFFSET    (0x20000000 << PAGE_SHIFT)
>>
> 
> If physical memory starts at 0x20000000, why is the PFN not
> 0x20000000 >> PAGE_SHIFT ?
> 

It is a typo... 

		Franck

