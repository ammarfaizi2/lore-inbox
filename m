Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281623AbRKPWxN>; Fri, 16 Nov 2001 17:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281633AbRKPWxD>; Fri, 16 Nov 2001 17:53:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:38673 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281623AbRKPWw6>;
	Fri, 16 Nov 2001 17:52:58 -0500
Date: Fri, 16 Nov 2001 23:52:42 +0100
From: Jens Axboe <axboe@suse.de>
To: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] block-highmem-all-18
Message-ID: <20011116235242.E11826@suse.de>
In-Reply-To: <20011116093927.E27010@suse.de> <20011116193057.O1825-100000@gerard>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011116193057.O1825-100000@gerard>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16 2001, Gérard Roudier wrote:
> Just to make things clear about how DMA width can be configured on the
> driver at the moment and will ever be:
> 
> 1) The 3 DMA addressing modes (32 bit, 40 bit and 64 bit limited to 16*4Gb
>    are compiled options. The handshaking with other kernel parts is based
>    on the pci_set_dma_mask() interface.
> 
> 2) This DMA adressing mode will probably be auto-configurable on some
>    further driver version, but I donnot want any useless code to be
>    neither compiled nor executed by the driver for the 99,9.. % of
>    real machines  that only need legacy 32 bit DMA addressing (i.e.
>    Mode 0 in the driver context).
>    Other DMA modes will only apply to the few configurations that
>    can be probed as needing larger DMA addressing, even if larger DMA
>    addressing will not harm on machines that donnot need the feature.
>    As a result the DMA addressing mode will stay a compilation option,
>    optionnally auto-probed at 'make kernel|module' time.
> 
> Now that things are hopefully clearer:), I donnot see any relevance about
> having any additionnal flag related to DMA addressing, at least as far as
> the sym-2 driver is concerned.

The can_dma_32 flag is purely a case of being very cautious and _only_
enabling highmem I/O to drivers that have been tested as good! In a
perfect world with perfect device drivers, it would not be needed and I
would happily be using just the pci dma mask while the lions and lambs
drink milk from the river. In the real world most drivers suck badly and
the lambs turn bloody :-)

BTW, I never expected sym2 to cause problems, at least the part I looked
at handled this perfectly as I've stated before.

> Thanks a lot for your work (despite the odd 'may_dma_somewhat' flag I seem
> not to like that much.:) )

Hope I've cleared up the misunderstanding there.

-- 
Jens Axboe

