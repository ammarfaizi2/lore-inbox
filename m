Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbWHYSrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWHYSrd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbWHYSrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:47:33 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:3234 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964916AbWHYSrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:47:31 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, rohitseth@google.com,
       hugh@veritas.com, Ingo Molnar <mingo@elte.hu>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44EEDB23.9050006@sw.ru>
References: <44E33893.6020700@sw.ru>
	 <1155929992.26155.60.camel@linuxchandra> <44E9B3F5.3010000@sw.ru>
	 <1156196721.6479.67.camel@linuxchandra>
	 <1156211128.11127.37.camel@galaxy.corp.google.com>
	 <1156272902.6479.110.camel@linuxchandra>
	 <1156383881.8324.51.camel@galaxy.corp.google.com>
	 <1156385072.7154.59.camel@linuxchandra>
	 <1156440461.14648.26.camel@galaxy.corp.google.com>
	 <1156463572.19702.46.camel@linuxchandra>  <44EEDB23.9050006@sw.ru>
Content-Type: text/plain
Organization: IBM
Date: Fri, 25 Aug 2006 11:47:24 -0700
Message-Id: <1156531644.1196.26.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 15:12 +0400, Kirill Korotaev wrote:
<snip>
> > 
> > 
> > Like I said earlier, there is _no_ other way to get the list of tasks
> > belonging to a resource group.
> > 
> > 
> >>Commands like ps and top will show appropriate container number for each
> >>task.
> > 
> > 
> > There is _no_ container number in the non-container environment (or it
> > will be same for _all_ tasks).
> 
> Chandra, virtual container number is essentially the same as user id
> in non-container environment. UBC were desgined for _users_ first.
> Containers were just the first environment which started to use it widely.

I am not denying any of the above :)

I think my original point is getting lost in the discussion, which is,
there should be way (for the sysadmin) to get a list of tasks belonging
to a resource group (in a non-container environment).
> 
> And I really disagree when you say that non-container usecase is
> a superset of container usecase. I believe it is vice versa, since

I meant _only_ w.r.t resource management. My earlier replies were
pointing quite a few of those. here are a few:

- ability for the sysadmin to move a task to a resource group.
- assignment of task to a resource group should be transparent to the 
  app.
- a resource group could exist with no tasks associated.

Containers can work without these features (and as OpenVZ proves it does
work). But, for a QoS type of resource management framework these are
mandatory.

> in container usecase you have a _full_ environment with root user and need
> more resources to be taken into account.

Support for different resources is a different topic. Users (of the two
models) can decide to control as many (or as few) resources as they
want. What I am talking here is about the ability of the framework.

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


