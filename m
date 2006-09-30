Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWI3Je1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWI3Je1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 05:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWI3Je0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 05:34:26 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:16044 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751192AbWI3Je0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 05:34:26 -0400
Date: Sat, 30 Sep 2006 12:34:21 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Jim Paradis <jparadis@redhat.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, jdmason@kudzu.us
Subject: Re: [PATCH] x86[-64] PCI domain support
Message-ID: <20060930093421.GP22787@rhun.haifa.ibm.com>
References: <20060926191508.GA6350@havoc.gtf.org> <20060928093332.GG22787@rhun.haifa.ibm.com> <451B99C5.7080809@garzik.org> <20060928224550.GJ22787@rhun.haifa.ibm.com> <451C54C0.6080402@garzik.org> <20060928233116.GK22787@rhun.haifa.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928233116.GK22787@rhun.haifa.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 02:31:16AM +0300, Muli Ben-Yehuda wrote:
> On Thu, Sep 28, 2006 at 07:03:28PM -0400, Jeff Garzik wrote:
> 
> > hmmmm.  What kernels did you test?
> 
> mainline as of today + several unrelated Calgary patches I'll post
> shortly + your PCI domains patch + my Calgary patch. I'll test with
> iommu=off next.
> 
> > That should narrow down the problems.  A problem with aic94xx sorta 
> > sounds like something unrelated.
> 
> Not necessarily - Calgary is an isolating IOMMU, meaning that if we
> set up a mapping for aic94xx in the wrong IO space due to a Calgary
> bug, aic94xx will fall over and die. Usually however this happens a
> lot sooner. Also, we have code in Calgary to detect when an errant DMA
> happens and it hasn't triggered in this case.

Ok, turns out it's neither a PCI domains nor Calgary issue, since I
can reproduce it on mainline with iommu=off. Must be an aic94xx
issue, I'll send the details to linux-scsi in a bit.

Cheers,
Muli
