Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWHRT4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWHRT4u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 15:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWHRT4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 15:56:50 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:39596 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932312AbWHRT4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 15:56:49 -0400
Subject: Re: [ckrm-tech] [PATCH 4/7] UBC: syscalls (user interface)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, riel@redhat.com, Linux@sc8-sf-spam2-b.sourceforge.net,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, dev@sw.ru, hch@infradead.org, saw@sw.ru,
       devel@openvz.org, rohitseth@google.com, hugh@veritas.com,
       Christoph@sc8-sf-spam2-b.sourceforge.net, ak@suse.de, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, xemul@openvz.org
In-Reply-To: <20060818115624.fd875624.pj@sgi.com>
References: <44E33893.6020700@sw.ru> <44E33C3F.3010509@sw.ru>
	 <1155752277.22595.70.camel@galaxy.corp.google.com>
	 <1155755069.24077.392.camel@localhost.localdomain>
	 <1155756170.22595.109.camel@galaxy.corp.google.com>
	 <44E45D6A.8000003@sw.ru> <20060817084033.f199d4c7.akpm@osdl.org>
	 <20060818120809.B11407@castle.nmd.msu.ru>
	 <1155912348.9274.83.camel@localhost.localdomain>
	 <20060818094248.cdca152d.akpm@osdl.org>
	 <1155925065.26155.17.camel@linuxchandra>
	 <20060818115624.fd875624.pj@sgi.com>
Content-Type: text/plain
Organization: IBM
Date: Fri, 18 Aug 2006 12:48:24 -0700
Message-Id: <1155930504.26155.69.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 11:56 -0700, Paul Jackson wrote:
> Chandra wrote:
> > In order to minimize this effect, resource controllers should be
> > providing both minimum and maximum amount of resources available for a
> > resource group.
> 
> No - not "should be."  Rather "could also be."
> 
> The fair sharing model (such as in CKRM) that strives for maximum
> utilization of resources respecting priorities and min/max limits is
> (I suppose) quite useful for certain workloads and customers.
> 
> The hardwall NUMA placement model (such as in cpusets) that strives
> for maximum processor and memory isolation between jobs, preferring
> to leave allocated resources unused rather than trying to share them,
> is also quite useful for some.  Customers with 256 thread, one or
> two day long run time, -very- tightly coupled huge OpenMP Fortran
> jobs that need to complete within a few percent of the same time,
> every runtime, demand it.
> 
> Don't presume that fair sharing -should- always be preferred to
> hardwall NUMA placement.

Not at all. During our prior discussions on the topic we have concluded
that resource management (CKRM\b\b\b\bResource Groups, UBC) and resource
isolation (cpuset) are totally orthogonal and have their own values from
the customer point of view. I still stand by that :).
 
> 
> Just not so.
> 
> Besides -- what benefit would CKRM gain from Andrew's latest
> brainstorm?  Doesn't CKRM already have whatever means it needs to
> define and share pools of memory?

Yes, we do. That implementation is deemed complex, intrusive and it also
increases maintenance burden. So, the object here (in this thread) is to
get a simple memory controller that does resource management (not
resource isolation).

> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


