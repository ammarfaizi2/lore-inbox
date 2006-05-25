Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbWEYEPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbWEYEPu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 00:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWEYEPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 00:15:50 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:36837 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964974AbWEYEPt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 00:15:49 -0400
Date: Wed, 24 May 2006 23:19:56 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Jon Mason <jdmason@us.ibm.com>, Muli Ben-Yehuda <muli@il.ibm.com>,
       Muli Ben-Yehuda <mulix@mulix.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/4] x86-64: Calgary IOMMU - introduce iommu_detected
Message-ID: <20060525041956.GH7720@us.ibm.com>
References: <20060525033408.GC7720@us.ibm.com> <200605250554.23534.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605250554.23534.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 05:54:23AM +0200, Andi Kleen wrote:
> On Thursday 25 May 2006 05:34, Jon Mason wrote:
> > swiotlb relies on the gart specific iommu_aperture variable to know if
> > we discovered a hardware IOMMU before swiotlb initialization.  Introduce
> > iommu_detected to do the same thing, but in a HW IOMMU neutral manner,
> > in preparation for adding the Calgary HW IOMMU.
> 
> I applied them all.

Fantastic!

> But I think you broke the aperture setup. iommu_setup really
> needs to be called early, otherwise aperture.c doesn't get
> the right parameters.  I undid that change.

I'll take a look at that, but I did boot test these patches on my
opteron system and didn't notice anything wrong.  Are the patches
available for me to look at on firstfloor?

> And please next time send against the latest tree. It required
> quite some tweaking to apply.

Sorry, I pulled a the latest mercurial tree this morning, but I guess
that one is stale (or became stale over the day).  

> -Andi
