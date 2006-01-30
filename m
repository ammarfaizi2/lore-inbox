Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWA3PdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWA3PdM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 10:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWA3PdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 10:33:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52615 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932331AbWA3PdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 10:33:11 -0500
Subject: Re: iommu_alloc failure and panic
From: Mark Haverkamp <markh@osdl.org>
To: Olof Johansson <olof@lixom.net>
Cc: "linuxppc64-dev@ozlabs.org" <linuxppc64-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060127233443.GB26653@pb15.lixom.net>
References: <1138381060.11796.22.camel@markh3.pdx.osdl.net>
	 <20060127204022.GA26653@pb15.lixom.net>
	 <1138401590.11796.26.camel@markh3.pdx.osdl.net>
	 <20060127233443.GB26653@pb15.lixom.net>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 07:32:58 -0800
Message-Id: <1138635178.5150.1.camel@markh3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-28 at 12:34 +1300, Olof Johansson wrote:
> On Fri, Jan 27, 2006 at 02:39:50PM -0800, Mark Haverkamp wrote:
> 
> > I would have thought that the npages would be 1 now.
> 
> No, npages is the size of the allocation coming from the driver, that
> won't chance. The table blocksize just says how wide the cacheline size
> is, i.e. how far it should advance between allocations.
> 
> This is a patch that should probably have been added a while ago, to
> give a bit more info. Can you apply it and give it a go?
> 
> 
> Thanks,
> 
> Olof
> 


Here are the last few lines of the log before it crashed.


Jan 30 07:29:14 linux kernel: table size 10000 used f752
Jan 30 07:29:21 linux kernel: printk: 650 messages suppressed.
Jan 30 07:29:21 linux kernel: iommu_alloc_sg failed, tbl c0000001e794dd80 vaddr c000000059424000 npages 10
Jan 30 07:29:21 linux kernel: table size 10000 used f2c9
Jan 30 07:29:25 linux kernel: printk: 590 messages suppressed.
Jan 30 07:29:25 linux kernel: iommu_alloc_sg failed, tbl c0000001e794dd80 vaddr c00000007c5f9000 npages e
Jan 30 07:29:25 linux kernel: table size 10000 used f6ae
Jan 30 07:29:29 linux kernel: printk: 705 messages suppressed.
Jan 30 07:29:29 linux kernel: iommu_alloc_sg failed, tbl c0000001e794dd80 vaddr c0000000d3c9f000 npages e
Jan 30 07:29:29 linux kernel: table size 10000 used f530
Jan 30 07:29:35 linux kernel: printk: 357 messages suppressed.
Jan 30 07:29:35 linux kernel: iommu_alloc_sg failed, tbl c0000001e794dd80 vaddr c00000010156b000 npages 10
Jan 30 07:29:35 linux kernel: table size 10000 used e69e
Jan 30 07:29:39 linux kernel: printk: 481 messages suppressed.
Jan 30 07:29:39 linux kernel: iommu_alloc_sg failed, tbl c0000001e794dd80 vaddr c00000007616b000 npages 10
Jan 30 07:29:39 linux kernel: table size 10000 used f8e2
Jan 30 07:30:02 linux kernel: printk: 366 messages suppressed.
Jan 30 07:30:02 linux kernel: iommu_alloc_sg failed, tbl c0000001e794dd80 vaddr c0000000b0f80000 npages 10
Jan 30 07:30:02 linux kernel: table size 10000 used fbf2
Jan 30 07:30:02 linux kernel: iommu_alloc_sg failed, tbl c0000001e794dd80 vaddr c0000000b43d3000 npages 10
Jan 30 07:30:02 linux kernel: table size 10000 used fc00
Jan 30 07:30:02 linux kernel: iommu_alloc_sg failed, tbl c0000001e794dd80 vaddr c0000000ac267000 npages 10
Jan 30 07:30:02 linux kernel: table size 10000 used fbf1
Jan 30 07:30:02 linux kernel: iommu_alloc_sg failed, tbl c0000001e794dd80 vaddr c0000000b7380000 npages 10
Jan 30 07:30:02 linux kernel: table size 10000 used fc66
Jan 30 07:30:04 linux kernel: printk: 417 messages suppressed.
Jan 30 07:30:04 linux kernel: iommu_alloc_sg failed, tbl c0000001e794dd80 vaddr c0000000d94be000 npages 10
Jan 30 07:30:04 linux kernel: table size 10000 used ffd2
Jan 30 07:30:09 linux kernel: printk: 957 messages suppressed.
Jan 30 07:30:09 linux kernel: iommu_alloc_sg failed, tbl c0000001e794dd80 vaddr c0000000e59c0000 npages e
Jan 30 07:30:09 linux kernel: table size 10000 used fd18
Jan 30 07:30:14 linux kernel: printk: 990 messages suppressed.
Jan 30 07:30:14 linux kernel: iommu_alloc_sg failed, tbl c0000001e794dd80 vaddr c0000001019c3000 npages 10
Jan 30 07:30:14 linux kernel: table size 10000 used fa2b
Jan 30 07:30:19 linux kernel: printk: 881 messages suppressed.
Jan 30 07:30:19 linux kernel: iommu_alloc_sg failed, tbl c0000001e794dd80 vaddr c000000066901000 npages 10
Jan 30 07:30:19 linux kernel: table size 10000 used ee58
Jan 30 07:30:24 linux kernel: printk: 1094 messages suppressed.
Jan 30 07:30:24 linux kernel: iommu_alloc_sg failed, tbl c0000001e794dd80 vaddr c00000011d110000 npages 10
Jan 30 07:30:24 linux kernel: table size 10000 used f74a
Jan 30 07:30:29 linux kernel: printk: 890 messages suppressed.
Jan 30 07:30:29 linux kernel: iommu_alloc_sg failed, tbl c0000001e794dd80 vaddr c00000007db1c000 npages 10
Jan 30 07:30:29 linux kernel: table size 10000 used f6e3
Jan 30 07:30:34 linux kernel: printk: 1020 messages suppressed.
Jan 30 07:30:34 linux kernel: iommu_alloc_sg failed, tbl c0000001e794dd80 vaddr c00000004759f000 npages 10
Jan 30 07:30:34 linux kernel: table size 10000 used f972
Jan 30 07:30:39 linux kernel: printk: 1209 messages suppressed.
Jan 30 07:30:39 linux kernel: iommu_alloc_sg failed, tbl c0000001e794dd80 vaddr c00000003a39b000 npages 10
Jan 30 07:30:39 linux kernel: table size 10000 used e358
Jan 30 07:30:44 linux kernel: printk: 608 messages suppressed.
Jan 30 07:30:44 linux kernel: iommu_alloc_sg failed, tbl c0000001e794dd80 vaddr c00000000b086000 npages 10
Jan 30 07:30:44 linux kernel: table size 10000 used ff52


-- 
Mark Haverkamp <markh@osdl.org>

