Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030271AbWIRXst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWIRXst (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 19:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWIRXss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 19:48:48 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:53199 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030271AbWIRXss
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 19:48:48 -0400
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added	user
	memory)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Pavel Emelianov <xemul@openvz.org>
Cc: Rik van Riel <riel@redhat.com>, Srivatsa <vatsa@in.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, balbir@in.ibm.com,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Kirill Korotaev <dev@sw.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       devel@openvz.org
In-Reply-To: <450A5325.6090803@openvz.org>
References: <44FD918A.7050501@sw.ru>	<44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru>	<44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra>	<45011CAC.2040502@openvz.org>
	 <1157730221.26324.52.camel@localhost.localdomain>
	 <4501B5F0.9050802@in.ibm.com> <450508BB.7020609@openvz.org>
	 <4505161E.1040401@in.ibm.com> <45051AC7.2000607@openvz.org>
	 <1158000590.6029.33.camel@linuxchandra> <45069072.4010007@openvz.org>
	 <1158105488.4800.23.camel@linuxchandra> <4507BC11.6080203@openvz.org>
	 <1158186664.18927.17.camel@linuxchandra> <45090A6E.1040206@openvz.org>
	 <1158277364.6357.33.camel@linuxchandra>  <450A5325.6090803@openvz.org>
Content-Type: text/plain
Organization: IBM
Date: Mon, 18 Sep 2006 16:48:42 -0700
Message-Id: <1158623322.6536.2.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-15 at 11:15 +0400, Pavel Emelianov wrote:
> Chandra Seetharaman wrote:
> > On Thu, 2006-09-14 at 11:53 +0400, Pavel Emelianov wrote:
> >
> > <snip>
> >
> >   
> >>> What if I have 40 containers each with 2% guarantee ? what do we do
> >>> then ? and many other different combinations (what I gave was not the
> >>> _only_ scenario).
> >>>   
> >>>       
> >> Then you need to solve a set of 40 equations. This sounds weird, but
> >> don't afraid - sets like these are solved lightly.
> >>     
> >
> > extrapolate that to a varying # of permutations and real time changes in
> > the system workload. Won't it be complex ?
> >   
> I have a C program that computes limits to obtain desired guarantees
> in a single 'for (i = 0; i < n; n++)' loop for any given set of guarantees.
> With all error handling, beautifull output, nice formatting etc it weights
> only 60 lines.
> > Wouldn't it be a lot simpler if we have the guarantee support instead ?
> > Why you do not like guarantee ? :)
> >   
> I do not 'do not like guarantee'. I'm just sure that there are two ways
> for providing guarantee (for unreclaimable resorces):
> 1. reserving resource for group in advance
> 2. limit resource for others
> Reserving is worse as it is essentially limiting (you cut off 100Mb from
> 1Gb RAM thus limiting the other groups by 900Mb RAM), but this limiting
> is too strict - you _have_ to reserve less than RAM size. Limiting in
> run-time is more flexible (you may create an overcommited BC if you
> want to) and leads to the same result - guarantee.

I do not agree with, "it will limit the efficient usage of resource,
hence lets not provide the feature".

We should provide the feature to the user and the user decide how they
want the resources to be used.

If they decide to use guarantees, they do know what is the cost.

> > <snip>
> >   
> [snip]
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


