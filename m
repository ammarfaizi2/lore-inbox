Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272184AbRHWBlI>; Wed, 22 Aug 2001 21:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272180AbRHWBk6>; Wed, 22 Aug 2001 21:40:58 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:60166 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S272179AbRHWBks>; Wed, 22 Aug 2001 21:40:48 -0400
Message-Id: <200108230140.f7N1etY22587@aslan.scsiguy.com>
To: "David S. Miller" <davem@redhat.com>
cc: kevin.vanmaren@unisys.com, linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch 
In-Reply-To: Your message of "Wed, 22 Aug 2001 18:31:09 PDT."
             <20010822.183109.34763266.davem@redhat.com> 
Date: Wed, 22 Aug 2001 19:40:55 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I do not want to even go into the abuse I took in my email when I
>added the original APIs because people had to keep track of the
>damn mappings at all!  These people would strangle me if they learnt
>that in HIGHMEM kernels twice as much space was needed to do this
>DMA address tracking.

You have to keep track of the significant bits in the dma_addr_t
regardless of its size, so you put it into your TX descriptor's (or
what have you) native format that doesn't waste any space.  You don't
need to keep the full dma_addr_t around.  Perhaps this is just sloppy
programming?

>I at least comfort myself that those who maintain drivers on several
>platforms, and have an open mind, such as Gerard, for the most part
>support the API I have designed.

If you don't want to take part in technical discussions, you should
work in closed source. 8-)

--
Justin
