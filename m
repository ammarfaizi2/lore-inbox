Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271108AbRHOJL7>; Wed, 15 Aug 2001 05:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271107AbRHOJLt>; Wed, 15 Aug 2001 05:11:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16256 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271108AbRHOJLg>;
	Wed, 15 Aug 2001 05:11:36 -0400
Date: Wed, 15 Aug 2001 02:11:33 -0700 (PDT)
Message-Id: <20010815.021133.71088933.davem@redhat.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] zero-bounce highmem I/O
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010815095018.B545@suse.de>
In-Reply-To: <20010815095018.B545@suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jens Axboe <axboe@suse.de>
   Date: Wed, 15 Aug 2001 09:50:18 +0200
   
   Dave, comments on that?

I think the new-style sg_list is slightly overkill, too much
stuff.  You need much less, in fact, especially on x86.

Take include/linux/skbuff.h:skb_frag_struct, rename it to
sg_list and add a dma_addr_t.  You should need nothing else.
The bounce page, for example, is superfluous.

If you bounce, the bounce page can be determined later via the
dma_addr_t right?

   And Dave, should I add the 64-bit stuff I started again? :-)

Let me draft something up, and meanwhile you can think about
the changes I suggest above.  Ok?

Later,
David S. Miller
davem@redhat.com
