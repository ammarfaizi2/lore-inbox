Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271558AbRHPL4t>; Thu, 16 Aug 2001 07:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271559AbRHPL4j>; Thu, 16 Aug 2001 07:56:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40074 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271558AbRHPL4c>;
	Thu, 16 Aug 2001 07:56:32 -0400
Date: Thu, 16 Aug 2001 04:56:42 -0700 (PDT)
Message-Id: <20010816.045642.116348743.davem@redhat.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [patch] zero-bounce highmem I/O
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010816135150.X4352@suse.de>
In-Reply-To: <20010815.070204.39155321.davem@redhat.com>
	<20010815.072548.48531893.davem@redhat.com>
	<20010816135150.X4352@suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jens Axboe <axboe@suse.de>
   Date: Thu, 16 Aug 2001 13:51:50 +0200

[ Hopefully this mail won't be encoded in Chinese-BIG5 :-)  sorry
  about that ]

   The only difference between your and my tree now is the PCI_MAX_DMA32
   flag. Would you consider this? I already use this flag in the block
   stuff, I just updated the two references you had. Maybe
   PCI_MAX_DMA32_MASK is a better name.
   
I didn't put it into my patch becuase there is no way you can
use such a value in generic code.

What if my scsi controller's pci DMA mask is 0x7fffffff or something
like this?  You don't know at the generic layer, and you must provide
some way for the block device to indicate stuff like this to you.

That is why PCI_MAX_DMA32, or whatever you would like to name it, does
not make any sense.  It can be a shorthand for drivers themselves, but
that is it and personally I'd rather they just put the bits there
explicitly.

I am just finishing up the "death of alt_address" patch right now.

Later,
David S. Miller
davem@redhat.com
