Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271651AbRHUNGy>; Tue, 21 Aug 2001 09:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271652AbRHUNGn>; Tue, 21 Aug 2001 09:06:43 -0400
Received: from fepE.post.tele.dk ([195.41.46.137]:17311 "EHLO
	fepE.post.tele.dk") by vger.kernel.org with ESMTP
	id <S271651AbRHUNGg>; Tue, 21 Aug 2001 09:06:36 -0400
Date: Tue, 21 Aug 2001 15:09:38 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: "David S. Miller" <davem@redhat.com>, Peter Wong <wpeter@us.ibm.com>,
        lse-tech@lists.sourceforge.net
Subject: [patch] zero-bounce highmem I/O, 2.4.9
Message-ID: <20010821150938.A1579@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've put up an updated patch for 2.4.9, which incorporates the PCI DMA
changes made by davem and me. Changes since the last version:

- bh_bus -> bh_phys (davem)
- Merge davem's pci64 patch (me, davem)
- IPS highmem update (Peter Wong, me)
- Megaraid highmem flag addition (me)
- Debug print queue I/O bounce settings
- blk_seg_merge_ok -- always make sure that a segment doesn't cross
  a 4GB boundary.
- Set queue bounce based on PCI DMA mask
- qlogicfc converted to pci64 DMA interface (davem)
- SCSI alt_address gone for good (davem)

Maybe some more stuff, I forget...

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.9/block-highmem-all-9

cciss needs to incremental cciss-bh_phys-1 on top to compile, obvious
bug discovered after patch upload...

-- 
Jens Axboe

