Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315806AbSFJTPS>; Mon, 10 Jun 2002 15:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315808AbSFJTPR>; Mon, 10 Jun 2002 15:15:17 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:45007
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S315806AbSFJTPQ>; Mon, 10 Jun 2002 15:15:16 -0400
Date: Mon, 10 Jun 2002 12:14:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roland Dreier <roland@topspin.com>
Cc: Oliver Neukum <oliver@neukum.name>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Message-ID: <20020610191434.GI14252@opus.bloom.county>
In-Reply-To: <52d6v19r9n.fsf@topspin.com> <523cvv9laj.fsf@topspin.com> <20020610170309.GC14252@opus.bloom.county> <200206101922.26985.oliver@neukum.name> <20020610172909.GE14252@opus.bloom.county> <52ptyz7y88.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 12:03:19PM -0700, Roland Dreier wrote:
> >>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:
> 
>     Tom> No.  We should just make it come out to a nop for arches that
>     Tom> don't need it.  Otherwise we'll end up with ugly things like:
>     Tom> #ifdef CONFIG_NOT_CACHE_COHERENT ...  #else ...  #endif
>     Tom> All over things like USB...
> 
> Good point.  How about the following: add a file to each arch named
> say, <asm/dma_buffer.h>, that defines a macro __dma_buffer.  This
> macro would be used as follows to mark DMA buffers (example taken from
> <linux/usb.h>):
[snip]
> Comments?

SMP_CACHE_BYTES is non-sensical on 4xx (and 8xx) since they don't do
SMP..

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
