Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284239AbRLRQpU>; Tue, 18 Dec 2001 11:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284220AbRLRQpK>; Tue, 18 Dec 2001 11:45:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:42504 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S284218AbRLRQox>;
	Tue, 18 Dec 2001 11:44:53 -0500
Date: Tue, 18 Dec 2001 17:44:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Peter Rival <frival@zk3.dec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug in 2.5.1
Message-ID: <20011218174445.H32511@suse.de>
In-Reply-To: <8A43C34093B3D5119F7D0004AC56F4BCC3441C@difpst1a.dif.dk> <3C1F305C.9030702@t-online.de> <3C1F5311.2070407@t-online.de> <20011218155357.G32511@suse.de> <3C1F6E8D.6070704@zk3.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C1F6E8D.6070704@zk3.dec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18 2001, Peter Rival wrote:
> Jens Axboe wrote:
> 
> >On Tue, Dec 18 2001, Hans-Otto Ahl wrote:
> >
> >>Hans-Otto Ahl wrote:
> >>
> >>
> >>>Jesper Juhl wrote:
> >>>
> >>>
> >>>>> Hi chaps, sorry to inform you about a problem in 'ide-floppy' drivers
> >>>>> and in the module as well.
> >>>>
> >
> >Apply this patch
> >
> >*.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.1/bio-251-1.bz2
> >
> >and ide-floppy should work again.
> >
> >
> Anyone have any patches for DAC960?  It doesn't compile, and I made the
> 
> "seemingly" obvious changes, but when I insmod, it sits in 
> "(initializing)".  This is on an Alpha AS1200 that I'm trying to use for 
> SPECsfs97 regression work...  Any ideas?

DAC960 will require some non-trivial work. I would do it, but reading
DAC960.[ch] makes my stomache bubble.

Note that it's not just buffer_head -> bio translation, it's also
walking the multi-page bios on your own (or better yet, transition it to
use blk_rq_map_sg) and adapting it to the pci dma mapping api.

-- 
Jens Axboe

