Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314283AbSEFIul>; Mon, 6 May 2002 04:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314284AbSEFIuk>; Mon, 6 May 2002 04:50:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:11279 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314283AbSEFIui>;
	Mon, 6 May 2002 04:50:38 -0400
Date: Mon, 6 May 2002 10:50:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: william stinson <wstinsonfr@yahoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: vanilla 2.5.13 severe file system corruption experienced follozing e2fsck ...
Message-ID: <20020506085033.GD820@suse.de>
In-Reply-To: <5.1.0.14.2.20020505200138.00b2d660@pop.cus.cam.ac.uk> <20020505183451.98763.qmail@web14102.mail.yahoo.com> <5.1.0.14.2.20020505200138.00b2d660@pop.cus.cam.ac.uk> <5.1.0.14.2.20020506093027.00aca720@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06 2002, Anton Altaparmakov wrote:
> At 06:55 06/05/02, Jens Axboe wrote:
> >On Sun, May 05 2002, Anton Altaparmakov wrote:
> >> Note even with that fix IDE (at least TCQ) is really easy to crash when 
> >you
> >> put the system under heavier I/O (at least on my via box)...
> >
> >If you have stumpled upon a tcq bug, I'd like to know more about it.
> 
> Back trace (sorry didn't have ckermit running so didn't catch the whole 
> output and was too lazy to write it all down): blk_queue_invalidate_tags, 
> tcq_invalidate_queue, ide_dmaq_complete, ide_dmaq_intr, ata_irq_request, 
> ide_dmaq_intr, handle_IRQ_event, do_IRQ, ideprobe_init.

Same problem as Sebastian I'm sure, in which case the backtrace holds no
info for me, the IDE messages printed _before_ the panic would be
helpful though :-)

> At the moment I try to not use 2.5.x as much as possible and only boot into 
> it to test ntfs or other changes I make, so when I do that next I will make 
> sure I am capturing on the serial console and send you details if I 
> experince the panic again...

Sure, I understand. Just hang on, I'll be releasing a tcq backport for
2.4.19-pre8 today that you can test instead.

-- 
Jens Axboe

