Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266615AbUHIOVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266615AbUHIOVW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266617AbUHIOVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:21:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:62411 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266613AbUHIORw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:17:52 -0400
Date: Mon, 9 Aug 2004 16:17:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040809141723.GO10418@suse.de>
References: <200408091336.i79DaDBo010343@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408091336.i79DaDBo010343@burner.fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09 2004, Joerg Schilling wrote:
> 
> >From: Jens Axboe <axboe@suse.de>
> 
> >On Mon, Aug 09 2004, Joerg Schilling wrote:
> >> >From axboe@suse.de  Fri Aug  6 17:10:35 2004
> >> 
> >> >> Let me give you a short answer: If DMA creates so many problem on Linux,
> >> >> how about imlementing a generic DMA abstraction layer like Solaris does?
> >> 
> >> >We do have that. But suddenly changing the alignment and length
> >> >restrictions on issuing dma to a device in the _end_ of a stable series
> >> >does not exactly fill me with joyful expectations. It's simply that,
> >> >not lack of infrastructure.
> >> 
> >> If you _really_ _had_ a DMA abstraction layer, then ide-scsi would use
> >> DMA for all sector sizes a CD may have. The fact that ide-scsi does
> >> not use DMA easily proves that you are wrong.
> 
> >For someone who apparently doesn't even bother to look at the source,
> >it's hard to discuss these things. "DMA abstraction layer" continues
> >your fine history of being deliberatly vague in that it can mean
> >basically anything or nothing.
> 
> In case you don't know what DMA abstraction is:

Translation from shillyness to english: In case I didn't know what Joerg
regards as DMA abstraction.

> DMA abstraction includes everything that is going to be done to set up
> DMA after the buffer address and the size is known.
> 
> If you were true and Linux would include _and_ use DMA abstraction, then
> we would have DMA with ide-scsi for all CD sector sizes.

Just because we have an api for helping drivers map data for dma,
doesn't necessarily mean that they all use it. In 2.6.8 ide-scsi will
use dma for all transfers. As I've already stated, I wont be fixing 2.4.
I've also included reasons for this. You seem to think that a 'DMA
abstraction layer' means there will be no hardware bugs, I only wish
that was so.

> >> AGAIN: if you believe you did invent a better method, _describe_ it.
> >> As you did not describe a _working_ method different from the one I
> >> request, you need to agree that you are wrong - as long as your
> >> description is missing.
> 
> >I did not invent a better method, but one exists - in Linux this is the
> >device special file.
> 
> Interesting: tell us more about how Linux handles kernel user
> interfaces by using a device special file instead of including the
> same include file in the kernel code as well as in the applicatin
> code?

We were talking about device addressing, right? Or are you ramblinb on
about API stability again?

> >> I am able to distinct between something that only looks like a kernel
> >> problem and something that really is a kernel problem. As long as you
> 
> >You've already shown that statement to be false many times in this
> >thread.
> 
> YOu have only shown that you in many caes try to ignoore the truth ;-(

I'm surprised an ego of your size can even be contained inside a
normally sized (I'm assuming, having never met you) human body. I guess
in your opinion, anything oozing from your brain is by definition the
truth? That's the only way that I can see your above sentence making
sense to you.

> >Listen, you silly little man: if you want things fixed in the kernel,
> >you provide a patch. Understand that concept?
> 
> Listen arrogant little man: I have enough to to with writing free
> software.  I report bugs and if you are the author, you fix your bugs
> or I need to tell the users of your software that you are unwilling to
> maintain your software.

Yet you refuse to do the same yourself.

-- 
Jens Axboe

