Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261649AbSJJQMv>; Thu, 10 Oct 2002 12:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261650AbSJJQMv>; Thu, 10 Oct 2002 12:12:51 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:18696 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261649AbSJJQMu>; Thu, 10 Oct 2002 12:12:50 -0400
Date: Thu, 10 Oct 2002 17:18:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: linux-2.5.41uc1 (MMU-less support)
Message-ID: <20021010171816.A21468@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg Ungerer <gerg@snapgear.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3DA5A42F.6030001@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DA5A42F.6030001@snapgear.com>; from gerg@snapgear.com on Fri, Oct 11, 2002 at 02:00:47AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2002 at 02:00:47AM +1000, Greg Ungerer wrote:
> Hi All,
> 
> An updated uClinux patch is available at:
> 
> http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.41uc1.patch.gz
> 
> This one has the long awaited merge of the mmnommu and mm directories.
> Went pretty smoothly really. The patches are not too bad, but there is
> still some cleaning to do. A couple of files are still heavily #ifdef'ed
> (like mm/mmap.c, mm/swap_state.c and mm/swapfile.c) but I think these
> can ironed out a bit.

Could you please merge the patches Ib sent you instead of this horrible
ifdef mess?  and yes, page_io.o, swapfile.o and swap_state.o shouldn't
be compiled at all for !CONFIG_SWAP dito for highmem.o, madvise.o, 
memory.o, mincore.o, mmap.o, mprotect.o, mremap.o, msync.o, rmap.o,
shmem.o, vmalloc.o for !CONFIG_MMU

