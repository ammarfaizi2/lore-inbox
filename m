Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWINBXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWINBXe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 21:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWINBXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 21:23:34 -0400
Received: from smtp-out.google.com ([216.239.45.12]:57316 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751317AbWINBXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 21:23:33 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=gTBAXW6pTNMGp94K2TUjgxMpTtrZ7t/7chDQ58AK9B/ZBQCtnJ/ij/c3i1dgUhPuB
	2vodnAKkNaT/VeUgvAucQ==
Subject: Re: [ckrm-tech] [PATCH] BC:
	resource	beancounters	(v4)	(added	user	memory)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: sekharan@us.ibm.com
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
In-Reply-To: <1158186046.18927.7.camel@linuxchandra>
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
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 13 Sep 2006 18:22:28 -0700
Message-Id: <1158196948.20211.90.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-13 at 15:20 -0700, Chandra Seetharaman wrote:
> On Tue, 2006-09-12 at 18:25 -0700, Rohit Seth wrote:
> > On Tue, 2006-09-12 at 18:10 -0700, Chandra Seetharaman wrote:
> > > On Tue, 2006-09-12 at 17:39 -0700, Rohit Seth wrote:
> > > <snip>
> > > > > yes, it would be there, but is not heavy, IMO.
> > > > 
> > > > I think anything greater than 1% could be a concern for people who are
> > > > not very interested in containers but would be forced to live with them.
> > > 
> > > If they are not interested in resource management and/or containers, i
> > > do not think they need to pay.
> > > > 
> > 
> > Think of a single kernel from a vendor that has container support built
> > in.
> 
> Ok. Understood.
> 
> Here are results of some of the benchmarks we have run in the past
> (April 2005) with CKRM which showed no/negligible performance impact in
> that scenario.
> http://marc.theaimsgroup.com/?l=ckrm-tech&m=111325064322305&w=2
> http://marc.theaimsgroup.com/?l=ckrm-tech&m=111385973226267&w=2
> http://marc.theaimsgroup.com/?l=ckrm-tech&m=111291409731929&w=2
> > 


These are good results.  But I still think the cost will increase over a
period of time as more logic gets added.  Any data on microbenchmarks
like lmbench.
 
> <snip>
> 
> > > Not at all. If the container they are interested in is guaranteed, I do
> > > not see how apps running outside a container would affect them.
> > > 
> > 
> > Because the kernel (outside the container subsystem) doesn't know of
> 
> The core resource subsystem (VM subsystem for memory) would know about
> the guarantees and don't cares, and it would handle it appropriately.
> 

...meaning hooks in the generic kernel reclaim algorithm.  Getting
something like that in mainline will be at best tricky.


-rohit

