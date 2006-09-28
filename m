Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWI1XbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWI1XbW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 19:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWI1XbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 19:31:22 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:56611 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751133AbWI1XbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 19:31:21 -0400
Date: Fri, 29 Sep 2006 02:31:16 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Jim Paradis <jparadis@redhat.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, jdmason@kudzu.us
Subject: Re: [PATCH] x86[-64] PCI domain support
Message-ID: <20060928233116.GK22787@rhun.haifa.ibm.com>
References: <20060926191508.GA6350@havoc.gtf.org> <20060928093332.GG22787@rhun.haifa.ibm.com> <451B99C5.7080809@garzik.org> <20060928224550.GJ22787@rhun.haifa.ibm.com> <451C54C0.6080402@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451C54C0.6080402@garzik.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 07:03:28PM -0400, Jeff Garzik wrote:

> hmmmm.  What kernels did you test?

mainline as of today + several unrelated Calgary patches I'll post
shortly + your PCI domains patch + my Calgary patch. I'll test with
iommu=off next.

> That should narrow down the problems.  A problem with aic94xx sorta 
> sounds like something unrelated.

Not necessarily - Calgary is an isolating IOMMU, meaning that if we
set up a mapping for aic94xx in the wrong IO space due to a Calgary
bug, aic94xx will fall over and die. Usually however this happens a
lot sooner. Also, we have code in Calgary to detect when an errant DMA
happens and it hasn't triggered in this case.

Cheers,
Muli
