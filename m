Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315544AbSFJRW4>; Mon, 10 Jun 2002 13:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315546AbSFJRWz>; Mon, 10 Jun 2002 13:22:55 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:16283 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315544AbSFJRWy> convert rfc822-to-8bit; Mon, 10 Jun 2002 13:22:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Tom Rini <trini@kernel.crashing.org>, Roland Dreier <roland@topspin.com>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Mon, 10 Jun 2002 19:22:26 +0200
X-Mailer: KMail [version 1.4]
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <52d6v19r9n.fsf@topspin.com> <523cvv9laj.fsf@topspin.com> <20020610170309.GC14252@opus.bloom.county>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206101922.26985.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > So is the consensus now that in general drivers should make sure any
> > buffers passed to pci_map/unmap are aligned to SMP_CACHE_BYTES (and a
> > multiple of SMP_CACHE_BYTES in size)?  In other words if a driver uses
> > an unaligned buffer it should be fixed unless we can prove (and
> > document in a comment :) that it won't cause problems on an arch
> > without cache coherency and with a writeback cache.
>
> And how about we don't call it SMP_CACHE_BYTES too?  The processors
> where this matters certainly aren't doing SMP...

Definitely we should call it something different so we can limit it to 
architectures that need it.

	Regards
		Oliver

