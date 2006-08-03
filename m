Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWHCVLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWHCVLc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 17:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWHCVLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 17:11:32 -0400
Received: from outbound-kan.frontbridge.com ([63.161.60.23]:47661 "EHLO
	outbound1-kan-R.bigfish.com") by vger.kernel.org with ESMTP
	id S932175AbWHCVLb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 17:11:31 -0400
X-BigFish: VP
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: IOMMU (Calgary) patches
Date: Thu, 3 Aug 2006 16:10:55 -0500
Message-ID: <84EA05E2CA77634C82730353CBE3A84307E83E88@SAUSEXMB1.amd.com>
In-Reply-To: <20060803072352.GE4736@rhun.haifa.ibm.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: IOMMU (Calgary) patches
Thread-Index: Aca2zdQzdyMtFCuvTDajw/SS7kMd9gAcKmjw
From: "Duran, Leo" <leo.duran@amd.com>
To: "Muli Ben-Yehuda" <muli@il.ibm.com>, "Andi Kleen" <ak@suse.de>,
       "Jon Mason" <jdmason@us.ibm.com>
cc: ak@suse.de, linux-kernel@vger.kernel.org, discuss@x86-64.org
X-OriginalArrivalTime: 03 Aug 2006 21:10:30.0602 (UTC)
 FILETIME=[404A82A0:01C6B741]
X-WSS-ID: 68CCB9CC1NW960388-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi, Jon, Muli,

I'm trying to build with the latest IOMMU patches for x86_64, so, I've
pulled down 2.6.17, and the 2.6.18-rc3 patches... But, that's obviously
lagging behind a bit.

Is there a source tree that you guys work from?
(I'm hoping that there's a better mechanism than keeping track of
patches as they are submitted here).

Leo Duran.

-----Original Message-----
From: Muli Ben-Yehuda [mailto:muli@il.ibm.com] 
Sent: Thursday, August 03, 2006 2:24 AM
To: Rolf Eike Beer
Cc: Andrew Morton; linux-kernel@vger.kernel.org; Andi Kleen;
discuss@x86-64.org
Subject: [discuss] Re: [PATCH] Move valid_dma_direction() from x86_64 to
generic code

On Thu, Aug 03, 2006 at 08:25:19AM +0200, Rolf Eike Beer wrote:

> > ./arch/x86_64/kernel/pci-swiotlb.c:6:#include <asm/dma-mapping.h>
> > ./drivers/net/fec_8xx/fec_main.c:40:#include <asm/dma-mapping.h>
> > ./drivers/net/fs_enet/fs_enet.h:11:#include <asm/dma-mapping.h>
> > ./include/asm-x86_64/swiotlb.h:5:#include <asm/dma-mapping.h>
> 
> I suspect it to be a bug anyway that every of this files ever included

> asm/dma-mapping.h.

Agreed wrt the fs_enet and fec_8xx; the swiotlb stuff I dimly recall I
had a reason for. I'll take a look in bit to verify akpm's fix works.

> > ./include/linux/dma-mapping.h:27:#include <asm/dma-mapping.h>
> 
> This is perfectly valid, isn't it :)

:-)

Cheers,
Muli




