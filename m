Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315856AbSFJT13>; Mon, 10 Jun 2002 15:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315862AbSFJT12>; Mon, 10 Jun 2002 15:27:28 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:57039
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S315856AbSFJT12>; Mon, 10 Jun 2002 15:27:28 -0400
Date: Mon, 10 Jun 2002 12:26:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roland Dreier <roland@topspin.com>
Cc: Oliver Neukum <oliver@neukum.name>, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Message-ID: <20020610192654.GK14252@opus.bloom.county>
In-Reply-To: <52d6v19r9n.fsf@topspin.com> <523cvv9laj.fsf@topspin.com> <20020610170309.GC14252@opus.bloom.county> <200206101922.26985.oliver@neukum.name> <20020610172909.GE14252@opus.bloom.county> <52ptyz7y88.fsf@topspin.com> <20020610191434.GI14252@opus.bloom.county> <52fzzv7xdj.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 12:21:44PM -0700, Roland Dreier wrote:
> >>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:
> 
>     Tom> SMP_CACHE_BYTES is non-sensical on 4xx (and 8xx) since they
>     Tom> don't do SMP..
> 
> True but <asm/cache.h> defines it anyway...

Right, to L1_CACHE_BYTES even. :)  So we should probably use that
directly.

> of course it would be no
> problem to use L1_CACHE_BYTES and in fact that probably makes sense
> because we're talking about PPC-only macros (other arches would have
> their own definition).

Well, ARM (whom we (PPC)) borrowed some ideas from will set it to
L1_CACHE_BYTES too, from the sound of rmk.  So it might even be
consistent among the non coherent processors. :)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
