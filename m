Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263294AbRFGV7c>; Thu, 7 Jun 2001 17:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263338AbRFGV7W>; Thu, 7 Jun 2001 17:59:22 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:59786 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S263294AbRFGV7Q>;
	Thu, 7 Jun 2001 17:59:16 -0400
Date: Thu, 7 Jun 2001 14:59:12 -0700
From: Richard Henderson <rth@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jens Axboe <axboe@suse.de>, Patrick Mochel <mochel@transmeta.com>,
        Alan Cox <alan@redhat.com>, "David S. Miller" <davem@redhat.com>,
        MOLNAR Ingo <mingo@chiara.elte.hu>,
        Kanoj Sarcar <kanoj@google.engr.sgi.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 32-bit dma memory zone
Message-ID: <20010607145912.B2286@redhat.com>
In-Reply-To: <20010607153119.H1522@suse.de> <Pine.LNX.4.21.0106071402480.6604-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0106071402480.6604-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Jun 07, 2001 at 02:22:10PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2001 at 02:22:10PM -0700, Linus Torvalds wrote:
> For example, what's the difference between ZONE_HIGHMEM and ZONE_NORMAL
> on a sane 64-bit architecture (right now I _think_ the 64-bit architectures
> actually make ZONE_NORMAL be what we call ZONE_DMA32 on x86, because they
> already need to be able to distinguish between memory that can be PCI-DMA'd
> to, and memory that needs bounce-buffers. Or maybe it's ZONE_DMA that they
> use for the DMA32 stuff?).

On most alphas we use only one zone -- ZONE_DMA.  The iommu makes it
possible to do 32-bit pci to the entire memory space.

For those alphas without an iommu, we also set up ZONE_NORMAL.


r~
