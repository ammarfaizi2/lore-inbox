Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWHCV0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWHCV0v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 17:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWHCV0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 17:26:51 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:65506 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932304AbWHCV0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 17:26:50 -0400
Date: Thu, 3 Aug 2006 16:25:37 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: "Duran, Leo" <leo.duran@amd.com>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: IOMMU (Calgary) patches
Message-ID: <20060803212537.GB14059@us.ibm.com>
References: <20060803072352.GE4736@rhun.haifa.ibm.com> <84EA05E2CA77634C82730353CBE3A84307E83E88@SAUSEXMB1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84EA05E2CA77634C82730353CBE3A84307E83E88@SAUSEXMB1.amd.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 04:10:55PM -0500, Duran, Leo wrote:
> Andi, Jon, Muli,
> 
> I'm trying to build with the latest IOMMU patches for x86_64, so, I've
> pulled down 2.6.17, and the 2.6.18-rc3 patches... But, that's obviously
> lagging behind a bit.
> 
> Is there a source tree that you guys work from?
Hey Leo,

I personally use the mercurial tree hosted on kernel.org
(http://www.kernel.org/hg/linux-2.6).  Alternatively, you can use git to
access the latest tree.

> (I'm hoping that there's a better mechanism than keeping track of
> patches as they are submitted here).

Andrew Morton is good about pulling in the IOMMU patches as soon as we
push them.  So the -mm kernel is an option.  Andi also queues up the
patches in his firstfloor repository.  So you can pull the patches from
there.

So, if you can't wait for the latest kernel and don't want to
get the latest kernel and patch it with Andi's patches on firstfloor,
then the mm kernel will be the best option.  But, the mercurial tree I
mentioned above should be sufficient.

Thanks,
Jon

> Leo Duran.
> 
> -----Original Message-----
> From: Muli Ben-Yehuda [mailto:muli@il.ibm.com] 
> Sent: Thursday, August 03, 2006 2:24 AM
> To: Rolf Eike Beer
> Cc: Andrew Morton; linux-kernel@vger.kernel.org; Andi Kleen;
> discuss@x86-64.org
> Subject: [discuss] Re: [PATCH] Move valid_dma_direction() from x86_64 to
> generic code
> 
> On Thu, Aug 03, 2006 at 08:25:19AM +0200, Rolf Eike Beer wrote:
> 
> > > ./arch/x86_64/kernel/pci-swiotlb.c:6:#include <asm/dma-mapping.h>
> > > ./drivers/net/fec_8xx/fec_main.c:40:#include <asm/dma-mapping.h>
> > > ./drivers/net/fs_enet/fs_enet.h:11:#include <asm/dma-mapping.h>
> > > ./include/asm-x86_64/swiotlb.h:5:#include <asm/dma-mapping.h>
> > 
> > I suspect it to be a bug anyway that every of this files ever included
> 
> > asm/dma-mapping.h.
> 
> Agreed wrt the fs_enet and fec_8xx; the swiotlb stuff I dimly recall I
> had a reason for. I'll take a look in bit to verify akpm's fix works.
> 
> > > ./include/linux/dma-mapping.h:27:#include <asm/dma-mapping.h>
> > 
> > This is perfectly valid, isn't it :)
> 
> :-)
> 
> Cheers,
> Muli
> 
> 
> 
> 
