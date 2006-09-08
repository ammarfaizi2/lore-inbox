Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWIHTKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWIHTKu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 15:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWIHTKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 15:10:50 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:1514 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751072AbWIHTKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 15:10:48 -0400
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user
	memory)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Pavel Emelianov <xemul@openvz.org>
Cc: Rik van Riel <riel@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Kirill Korotaev <dev@sw.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, devel@openvz.org
In-Reply-To: <45011B2A.6000102@openvz.org>
References: <44FD918A.7050501@sw.ru>
	 <1157478392.3186.26.camel@localhost.localdomain> <44FED3CA.7000005@sw.ru>
	 <1157579641.31893.26.camel@linuxchandra> <44FFCA4D.9090202@openvz.org>
	 <1157657355.19884.44.camel@linuxchandra>  <45011B2A.6000102@openvz.org>
Content-Type: text/plain
Organization: IBM
Date: Fri, 08 Sep 2006 12:10:41 -0700
Message-Id: <1157742641.19884.52.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-08 at 11:26 +0400, Pavel Emelianov wrote:
> Chandra Seetharaman wrote:
> > On Thu, 2006-09-07 at 11:29 +0400, Pavel Emelianov wrote:
> > <snip>
> >
> >   
> >>>> BUT: I remind you the talks at OKS/OLS and in previous UBC discussions.
> >>>> It was noted that having a separate interfaces for CPU, I/O bandwidth
> >>>>     
> >>>>         
> >>> But, it will be lot simpler for the user to configure/use if they are
> >>> together. We should discuss this also.
> >>>   
> >>>       
> >> IMHO such unification may only imply that one syscall is used to pass
> >> configuration info into kernel.
> >> Each controller has specific configurating parameters different from the
> >> other ones. E.g. CPU controller must assign a "weight" to each group to
> >> share CPU time accordingly, but what is a "weight" for memory controller?
> >> IO may operate on "bandwidth" and it's not clear what is a "bandwidth" in
> >> Kb/sec for CPU controller and so on.
> >>     
> >
> > CKRM/RG handles this by eliminating the units from the interface and
> > abstracting them to be "shares". Each resource controller converts the
> > shares to its own units and handles properly. 
> >   
> That's what I'm talking about - common syscall/ioct/etc and each controller
> parses its input itself. That's OK for us.

Yes, we can eliminate the "units"(KBs, cycles/ticks, pages etc.,) from
the interface and use a (unitless) number to specify the amount of
resource a resource group/container uses.
> 
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


