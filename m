Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315471AbSFEPtN>; Wed, 5 Jun 2002 11:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315479AbSFEPtM>; Wed, 5 Jun 2002 11:49:12 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37599 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315471AbSFEPtL>;
	Wed, 5 Jun 2002 11:49:11 -0400
Date: Wed, 5 Jun 2002 17:48:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.20 IDE 85
Message-ID: <20020605154853.GF16600@suse.de>
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com> <3CFE0C16.1020203@evision-ventures.com> <20020605141717.GB16257@suse.de> <3CFE1974.9080509@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05 2002, Martin Dalecki wrote:
> Jens Axboe wrote:
> >On Wed, Jun 05 2002, Martin Dalecki wrote:
> >
> >AFAICS, you just introduced some nasty list races in the interrupt
> >handlers. You must hold the queue locks when calling
> >blkdev_dequeue_request() and end_that_request_last(), for instance.
> >
> 
> No. Please be more accurate. Becouse:
> 
> 1. If anything I have made existing races only "obvious".

If anything, you've made a race you introduced earlier more obvious.

> 2. It is called in the context of do_ide_request or ide_raw_taskfile
>    where we already have the lock.

?? Both tcq and ata_special_intr look like interrupt handlers to me.

-- 
Jens Axboe

