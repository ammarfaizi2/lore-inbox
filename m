Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264669AbRHKIKI>; Sat, 11 Aug 2001 04:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266158AbRHKIJ7>; Sat, 11 Aug 2001 04:09:59 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:59396 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S264669AbRHKIJx>;
	Sat, 11 Aug 2001 04:09:53 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Sat, 11 Aug 2001 09:09:02 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: struct page to 36 (or 64) bit bus address?
Message-ID: <20010811090902.A1978@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010810.145836.41632779.davem@redhat.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2001 at 02:58:36PM -0700, David S. Miller wrote:
> 
>    I'm using the patch below (pulled out of Jens Axboe's bio
>    patches, i386 only).
> 
> Are you sure you aren't missing anything in this patch?  For example,
> one can't use the patch you've provided for 64-bit DMA unless the
> dma_addr_t type is made larger.

It only allows to use the full 32 bit address range for DMA.  Without
the patch I'm limited to direct mapped memory (i.e. < ~900MB on i386).
With the patch highmem below 4GB can be used too.

Jens's bio patches don't have support for 64-bit DMA (at least not the
version I've used to build that patch).  Because the bt848/878 chips
are 32-bit devices only I havn't even tried to fix that...

  Gerd

-- 
Damn lot people confuse usability and eye-candy.
