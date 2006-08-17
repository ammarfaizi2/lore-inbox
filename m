Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWHQT4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWHQT4H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 15:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbWHQT4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 15:56:06 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:36831 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030232AbWHQT4D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 15:56:03 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Kirill Korotaev <dev@sw.ru>
Cc: vatsa@in.ibm.com, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44E47547.8030702@sw.ru>
References: <44E33893.6020700@sw.ru> <20060817110237.GA19127@in.ibm.com>
	 <44E47547.8030702@sw.ru>
Content-Type: text/plain
Organization: IBM
Date: Thu, 17 Aug 2006 12:55:43 -0700
Message-Id: <1155844543.26155.10.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 17:55 +0400, Kirill Korotaev wrote:
> > On Wed, Aug 16, 2006 at 07:24:03PM +0400, Kirill Korotaev wrote:
> > 
> >>As the first step we want to propose for discussion
> >>the most complicated parts of resource management:
> >>kernel memory and virtual memory.
> > 
> > Do you have any plans to post a CPU controller? Is that tied to UBC
> > interface as well?
> 
> Not everything at once :) To tell the truth I think CPU controller
> is even more complicated than user memory accounting/limiting.
> 
> No, fair CPU scheduler is not tied to UBC in any regard.

Not having the CPU controller on UBC doesn't sound good for the
infrastructure. IMHO, the infrastructure (for resource management) we
are going to have should be able to support different resource
controllers, without each controllers needing to have their own
infrastructure/interface etc.,

> As we discussed before, it is valuable to have an ability to limit
> different resources separately (CPU, disk I/O, memory, etc.).

Having ability to limit/control different resources separately not
necessarily mean we should have different infrastructure for each.

> For example, it can be possible to place some mission critical
> kernel threads (like kjournald) in a separate contanier.

I don't understand the comment above (in this context).
> 
> This patches are related to kernel memory and nothing more :)
> 
> Thanks,
> Kirill
> 
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


