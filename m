Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271126AbRHOJj3>; Wed, 15 Aug 2001 05:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271124AbRHOJjT>; Wed, 15 Aug 2001 05:39:19 -0400
Received: from fe010.worldonline.dk ([212.54.64.195]:16651 "HELO
	fe010.worldonline.dk") by vger.kernel.org with SMTP
	id <S271120AbRHOJjG>; Wed, 15 Aug 2001 05:39:06 -0400
Date: Wed, 15 Aug 2001 11:17:48 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] zero-bounce highmem I/O
Message-ID: <20010815111748.E545@suse.de>
In-Reply-To: <20010815095018.B545@suse.de> <20010815.021133.71088933.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010815.021133.71088933.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15 2001, David S. Miller wrote:
>    From: Jens Axboe <axboe@suse.de>
>    Date: Wed, 15 Aug 2001 09:50:18 +0200
>    
>    Dave, comments on that?
> 
> I think the new-style sg_list is slightly overkill, too much
> stuff.  You need much less, in fact, especially on x86.
> 
> Take include/linux/skbuff.h:skb_frag_struct, rename it to
> sg_list and add a dma_addr_t.  You should need nothing else.
> The bounce page, for example, is superfluous.

Ok agreed, fine with me.

> If you bounce, the bounce page can be determined later via the
> dma_addr_t right?

That's true.

>    And Dave, should I add the 64-bit stuff I started again? :-)
> 
> Let me draft something up, and meanwhile you can think about
> the changes I suggest above.  Ok?

Ok done from my side :)

-- 
Jens Axboe

