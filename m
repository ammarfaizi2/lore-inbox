Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271162AbRHOMLD>; Wed, 15 Aug 2001 08:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271163AbRHOMKx>; Wed, 15 Aug 2001 08:10:53 -0400
Received: from fe040.worldonline.dk ([212.54.64.205]:56331 "HELO
	fe040.worldonline.dk") by vger.kernel.org with SMTP
	id <S271162AbRHOMKn>; Wed, 15 Aug 2001 08:10:43 -0400
Date: Wed, 15 Aug 2001 14:07:40 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [patch] zero-bounce highmem I/O
Message-ID: <20010815140740.A4352@suse.de>
In-Reply-To: <20010815112621.F545@suse.de> <20010815.032218.55508716.davem@redhat.com> <20010815131335.H545@suse.de> <20010815.044757.112624116.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010815.044757.112624116.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15 2001, David S. Miller wrote:
>    From: Jens Axboe <axboe@suse.de>
>    Date: Wed, 15 Aug 2001 13:13:35 +0200
> 
>    Looks fine to me, exactly the interface I've used/wanted. But you want
>    to add the extra page/offset to the existing scatterlist, and not scrap
>    that one completely?
> 
> The idea is that address/alt_address disappear sometime in 2.5.
> Something like this right?

Ok so you just want to turn scatterlist into what I call sg_list in 2.5
time, fine with me too. Depends on whether we want to keep the
pci_map_sg and struct scatterlist interface intact, or just break it and
tell driver authors they must fix their stuff regardless of whether they
want to support highmem. As I write this sentence, it's clear to me
which way is the superior :-)

> BTW, on x86 we can ifdef the dma64_address to u32 or u64 based
> upon CONFIG_HIGHMEM if we wish.

Yep. Want me to add in the x86 parts of your patch?

-- 
Jens Axboe

