Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWIRX5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWIRX5t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 19:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWIRX5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 19:57:49 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:1685 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030280AbWIRX5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 19:57:48 -0400
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added	user
	memory)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Rik van Riel <riel@redhat.com>, Srivatsa <vatsa@in.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, balbir@in.ibm.com,
       Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <450A6B06.1050308@sw.ru>
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org>
	 <1157730221.26324.52.camel@localhost.localdomain>
	 <4501B5F0.9050802@in.ibm.com> <450508BB.7020609@openvz.org>
	 <1158000262.6029.26.camel@linuxchandra>  <450A6B06.1050308@sw.ru>
Content-Type: text/plain
Organization: IBM
Date: Mon, 18 Sep 2006 16:57:44 -0700
Message-Id: <1158623864.6536.7.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-15 at 12:57 +0400, Kirill Korotaev wrote:
> > CKRM/RG handles it this way:
> > 
> > Amount of a resource a child RG gets is the ratio of its share value to
> > the parent's total # of shares. Children's resource allocation can be
> > changed just by changing the parent's total # of shares.
> > 
> > If you case about initial situation would be:
> >   Total memory in the system 100MB 
> >   parent's total # of shares: 100 (1 share == 1MB)
> >   10 children with # of shares: 10 (i.e each children has 10MB)
> > 
> > When I want to add another child, just change parent's total # of shares
> > to be say 125:
> >   Total memory in the system 100MB
> >   parent's total # of shares: 125 (1 share == 0.8MB)
> >   10 children with # of shares: 10 (i.e each children has 8MB)
> > Now you are left with 25 shares (or 20MB) that you can assign to new
> > child(ren) as you please.
> 
> setting memory in "shares" doesn't look user friendly at all...

in RG, the user can set the root level shares to be the "total # of
pages", and then the shares will simply reflect the number of pages.

> 
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


