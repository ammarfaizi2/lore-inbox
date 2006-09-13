Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030408AbWIMACS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbWIMACS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 20:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030409AbWIMACS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 20:02:18 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:46545 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030408AbWIMACR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 20:02:17 -0400
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4)
	(added	user	memory)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: rohitseth@google.com
Cc: vatsa@in.ibm.com, Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, balbir@in.ibm.com,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Kirill Korotaev <dev@sw.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1158081752.20211.12.camel@galaxy.corp.google.com>
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org>
	 <1157743424.19884.65.camel@linuxchandra>
	 <1157751834.1214.112.camel@galaxy.corp.google.com>
	 <1157999107.6029.7.camel@linuxchandra>
	 <1158001831.12947.16.camel@galaxy.corp.google.com>
	 <20060912104410.GA28444@in.ibm.com>
	 <1158081752.20211.12.camel@galaxy.corp.google.com>
Content-Type: text/plain
Organization: IBM
Date: Tue, 12 Sep 2006 17:02:12 -0700
Message-Id: <1158105732.4800.26.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-12 at 10:22 -0700, Rohit Seth wrote:
> On Tue, 2006-09-12 at 16:14 +0530, Srivatsa Vaddagiri wrote:
> > On Mon, Sep 11, 2006 at 12:10:31PM -0700, Rohit Seth wrote:
> > > It seems that a single notion of limit should suffice, and that limit
> > > should more be treated as something beyond which that resource
> > > consumption in the container will be throttled/not_allowed.
> > 
> > The big question is : are containers/RG allowed to use *upto* their
> > limit always? In other words, will you typically setup limits such that
> > sum of all limits = max resource capacity? 
> > 
> 
> If a user is really interested in ensuring that all scheduled jobs (or
> containers) get what they have asked for (guarantees) then making the
> sum of all container limits equal to total system limit is the right
> thing to do.
> 
> > If it is setup like that, then what you are considering as limit is
> > actually guar no?
> > 
> Right.  And if we do it like this then it is up to sysadmin to configure
> the thing right without adding additional logic in kernel.

It won't be a complete solution, as the user won't be able to
 - set both guarantee and limit for a resource group
 - use limit on some and guarantee on some
 - optimize the usage of available resources 
> 
> -rohit
> 
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


