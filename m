Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWI3KDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWI3KDb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 06:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWI3KDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 06:03:31 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:52176 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750700AbWI3KDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 06:03:30 -0400
Message-ID: <451E40DF.30406@garzik.org>
Date: Sat, 30 Sep 2006 06:03:11 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Muli Ben-Yehuda <muli@il.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Jim Paradis <jparadis@redhat.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, jdmason@kudzu.us
Subject: Re: [PATCH] x86[-64] PCI domain support
References: <20060926191508.GA6350@havoc.gtf.org> <20060928093332.GG22787@rhun.haifa.ibm.com> <451B99C5.7080809@garzik.org> <20060928224550.GJ22787@rhun.haifa.ibm.com> <451C54C0.6080402@garzik.org> <20060928233116.GK22787@rhun.haifa.ibm.com> <20060930093421.GP22787@rhun.haifa.ibm.com>
In-Reply-To: <20060930093421.GP22787@rhun.haifa.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda wrote:
> On Fri, Sep 29, 2006 at 02:31:16AM +0300, Muli Ben-Yehuda wrote:
>> On Thu, Sep 28, 2006 at 07:03:28PM -0400, Jeff Garzik wrote:
>>
>>> hmmmm.  What kernels did you test?
>> mainline as of today + several unrelated Calgary patches I'll post
>> shortly + your PCI domains patch + my Calgary patch. I'll test with
>> iommu=off next.
>>
>>> That should narrow down the problems.  A problem with aic94xx sorta 
>>> sounds like something unrelated.
>> Not necessarily - Calgary is an isolating IOMMU, meaning that if we
>> set up a mapping for aic94xx in the wrong IO space due to a Calgary
>> bug, aic94xx will fall over and die. Usually however this happens a
>> lot sooner. Also, we have code in Calgary to detect when an errant DMA
>> happens and it hasn't triggered in this case.
> 
> Ok, turns out it's neither a PCI domains nor Calgary issue, since I
> can reproduce it on mainline with iommu=off. Must be an aic94xx
> issue, I'll send the details to linux-scsi in a bit.

Would you also make sure that Andrew has the necessary bits to keep 
Calgary going under PCI domains?  If it's a patch that sits on top of 
linux-2.6.git + my patch, I can merge it into misc-2.6.git#pciseg (which 
automatically goes into -mm).  Otherwise, make sure -mm has the stack of 
patches necessary.

	Jeff



