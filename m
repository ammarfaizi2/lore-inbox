Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWINXNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWINXNa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 19:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWINXNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 19:13:30 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:1211 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932114AbWINXN3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 19:13:29 -0400
Subject: Re: [ckrm-tech] [PATCH] BC:
	resource	beancounters	(v4)	(added	user	memory)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: rohitseth@google.com
Cc: Rik van Riel <riel@redhat.com>, Srivatsa <vatsa@in.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, balbir@in.ibm.com,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Kirill Korotaev <dev@sw.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       devel@openvz.org, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1158196948.20211.90.camel@galaxy.corp.google.com>
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org>
	 <1157743424.19884.65.camel@linuxchandra>
	 <1157751834.1214.112.camel@galaxy.corp.google.com>
	 <1157999107.6029.7.camel@linuxchandra>
	 <1158001831.12947.16.camel@galaxy.corp.google.com>
	 <1158003725.6029.60.camel@linuxchandra>
	 <1158019099.12947.102.camel@galaxy.corp.google.com>
	 <1158105253.4800.20.camel@linuxchandra>
	 <1158107948.20211.47.camel@galaxy.corp.google.com>
	 <1158109818.4800.39.camel@linuxchandra>
	 <1158110751.20211.61.camel@galaxy.corp.google.com>
	 <1158186046.18927.7.camel@linuxchandra>
	 <1158196948.20211.90.camel@galaxy.corp.google.com>
Content-Type: text/plain
Organization: IBM
Date: Thu, 14 Sep 2006 16:13:23 -0700
Message-Id: <1158275603.6357.5.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-13 at 18:22 -0700, Rohit Seth wrote:
<snip>
> > 
> > Here are results of some of the benchmarks we have run in the past
> > (April 2005) with CKRM which showed no/negligible performance impact in
> > that scenario.
> > http://marc.theaimsgroup.com/?l=ckrm-tech&m=111325064322305&w=2
> > http://marc.theaimsgroup.com/?l=ckrm-tech&m=111385973226267&w=2
> > http://marc.theaimsgroup.com/?l=ckrm-tech&m=111291409731929&w=2
> > > 
> 
> 
> These are good results.  But I still think the cost will increase over a
> period of time as more logic gets added.  Any data on microbenchmarks

IMO, overhead may not increase for a _non-user_ of the feature.

> like lmbench.

I think we have run those, but I could not find the results in the
mailing list.
>  
> > <snip>
> > 
> > > > Not at all. If the container they are interested in is guaranteed, I do
> > > > not see how apps running outside a container would affect them.
> > > > 
> > > 
> > > Because the kernel (outside the container subsystem) doesn't know of
> > 
> > The core resource subsystem (VM subsystem for memory) would know about
> > the guarantees and don't cares, and it would handle it appropriately.
> > 
> 
> ...meaning hooks in the generic kernel reclaim algorithm.  Getting
> something like that in mainline will be at best tricky.

Yes, it does mean doing something in the reclamation path.

> 
> 
> -rohit
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


