Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267549AbUH0Uhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267549AbUH0Uhu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267568AbUH0Udk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:33:40 -0400
Received: from omx3-ext.SGI.COM ([192.48.171.20]:31977 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267561AbUH0U2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 16:28:20 -0400
Message-ID: <412F989B.1020703@sgi.com>
Date: Fri, 27 Aug 2004 13:24:59 -0700
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Peter Williams <pwil3058@bigpond.net.au>, jh@sgi.com, jlan@engr.sgi.com,
       linux-kernel@vger.kernel.org, erikj@dbear.engr.sgi.com,
       limin@engr.sgi.com, lse-tech@lists.sourceforge.net,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [Lse-tech] Re: [PATCH] new CSA patchset for 2.6.8
References: <412D2E10.8010406@engr.sgi.com>	<20040825221842.72dd83a4.akpm@osdl.org>	<20040826183834.GA11393@sgi.com>	<412EADBC.60607@bigpond.net.au> <20040826205349.0582d38e.akpm@osdl.org>
In-Reply-To: <20040826205349.0582d38e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My proposed patchset includes three accounting data collection
patches and one CSA loadable module that make use of the
collected data. The three data collection patches (in the area
of io, mm and end-of-process) do not conflict with BSD accounting
or ELSA. They can be viewed as "enhancement" to both BSD and
ELSA as Guillaume, the maintainer of ELSA put it:

    Therefore the solution could be to enhance BSD accounting with data
    collection from CSA and provide per job accounting with a userspace
    mechanism. Sounds great to me...

It would be then up to BSD, ELSA or CSA to decide how to process
the collected data and present it to users.

All response so far seems to favor this unified data collection
method proposal.

The ELSA approach appears to make changes to kernel/acct.c while
CSA will provide its own loadable module.

Of the three data collection patches, csa_io and csa_eop are very
much CSA-independent. I certainly can make csa_mm more so as well.

I think it is a everyone-win situation for all three projects. :)

Regards,
  - jay


Andrew Morton wrote:
> Thanks, guys.  So we now know that there are three potential
> implementations which do much the same thing, yes?
> 
> I didn't get a sense of a preferred direction, but at least nobody is
> flaming anybody else yet ;)
> 
> It strikes me that CSA is the most actively developed and is the furthest
> along.  But that enhancing BSD accounting might be the least intrusive and
> most back-compatible approach.
> 
> Is that a fair summary?  If not, what should I have said?
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
> 100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
> Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
> http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech

