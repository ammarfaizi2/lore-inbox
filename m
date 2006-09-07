Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWIGT3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWIGT3W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 15:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWIGT3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 15:29:22 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:54250 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751049AbWIGT3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 15:29:20 -0400
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user
	memory)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Pavel Emelianov <xemul@openvz.org>
Cc: Kirill Korotaev <dev@sw.ru>, Dave Hansen <haveblue@us.ibm.com>,
       Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Hugh Dickins <hugh@veritas.com>, Matt Helsley <matthltc@us.ibm.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <44FFCA4D.9090202@openvz.org>
References: <44FD918A.7050501@sw.ru>
	 <1157478392.3186.26.camel@localhost.localdomain>  <44FED3CA.7000005@sw.ru>
	 <1157579641.31893.26.camel@linuxchandra>  <44FFCA4D.9090202@openvz.org>
Content-Type: text/plain
Organization: IBM
Date: Thu, 07 Sep 2006 12:29:15 -0700
Message-Id: <1157657355.19884.44.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-07 at 11:29 +0400, Pavel Emelianov wrote:
<snip>

> >> BUT: I remind you the talks at OKS/OLS and in previous UBC discussions.
> >> It was noted that having a separate interfaces for CPU, I/O bandwidth
> >>     
> >
> > But, it will be lot simpler for the user to configure/use if they are
> > together. We should discuss this also.
> >   
> IMHO such unification may only imply that one syscall is used to pass
> configuration info into kernel.
> Each controller has specific configurating parameters different from the
> other ones. E.g. CPU controller must assign a "weight" to each group to
> share CPU time accordingly, but what is a "weight" for memory controller?
> IO may operate on "bandwidth" and it's not clear what is a "bandwidth" in
> Kb/sec for CPU controller and so on.

CKRM/RG handles this by eliminating the units from the interface and
abstracting them to be "shares". Each resource controller converts the
shares to its own units and handles properly. 

User can specify the quantities simply as a percentage. CPU controller
would treat it as cycles/ticks (within a time), memory controller would
treat it as number of pages, and I/O controller would treat it as
bandwidth, and so on...

<snip>
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


