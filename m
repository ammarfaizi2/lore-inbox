Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbVJ3V0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbVJ3V0S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 16:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbVJ3V0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 16:26:17 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:21186 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932318AbVJ3V0P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 16:26:15 -0500
Date: Sun, 30 Oct 2005 13:26:19 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Michael Madore <michael.madore@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI-DMA: high address but no IOMMU
Message-ID: <20051030212619.GB30183@us.ibm.com>
References: <d4b6d3ea0510271047t413e9ea8l333a532c1a5f3d77@mail.gmail.com> <20051028015900.GB4141@us.ibm.com> <20051030142924.GA30183@us.ibm.com> <200510301559.15423.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510301559.15423.ak@suse.de>
X-Operating-System: Linux 2.6.14 (x86_64)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.10.2005 [15:59:15 +0100], Andi Kleen wrote:
> On Sunday 30 October 2005 15:29, Nishanth Aravamudan wrote:
> 
> > 
> > Ah, silly me, I set IOMMU_DEBUG to Y at some point without realizing.
> > Taking that away removed the issues and I now only get:
> > 
> > [    0.000000] Checking aperture...
> > [    0.000000] CPU 0: aperture @ 4000000 size 32 MB
> > [    0.000000] Aperture from northbridge cpu 0 too small (32 MB)
> > [    0.000000] No AGP bridge found
> > 
> > ...
> > 
> > [   47.737770] PCI-DMA: Disabling IOMMU.
> > 
> > Which makes a lot more sense.
> 
> And everything works when you disable IOMMU_DEBUG? Is that the case
> with the other reporters of this problem too?

Sorry, I realize in retrospect that my post may have been misleading. I
was only commenting that I was seeing the same messages (but not the
same "Kernel panic - not syncing: PCI-DMA: high address but no IOMMU.")
So it works with either IOMMU_DEBUG (which I guess forces the IOMMU on?
-- hence the output of "PCI-DMA: More than 4GB of RAM and no IOMMU"?) or
not. Also note that I only have 2 GB of RAM, so I believe the kernel
made the right decision in disabling the IOMMU (which is used with more
than 3 GB of RAM?) Still, if Michael has IOMMU_DEBUG enabled, it might
change things.

Thanks,
Nish
