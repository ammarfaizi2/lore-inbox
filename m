Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317497AbSFIA5L>; Sat, 8 Jun 2002 20:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317498AbSFIA5K>; Sat, 8 Jun 2002 20:57:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60842 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317497AbSFIA5J>;
	Sat, 8 Jun 2002 20:57:09 -0400
Date: Sat, 08 Jun 2002 17:53:25 -0700 (PDT)
Message-Id: <20020608.175325.63815788.davem@redhat.com>
To: roland@topspin.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <52lm9p9tdz.fsf@topspin.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roland Dreier <roland@topspin.com>
   Date: 08 Jun 2002 17:40:24 -0700
      
   Or should we leave that usage unless it is observed causing
   problems (since we almost always get lucky and don't touch the rest
   of the cache line near the DMA)?
   
I think passing in a 4 byte chunk and assuming the rest of the
cacheline is unmodified is a valid expectation the more I think
about it.

This means what MIPS is doing is wrong.  For partial cacheline bits it
can't do the invalidate thing.
