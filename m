Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270881AbSISJk3>; Thu, 19 Sep 2002 05:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270889AbSISJk3>; Thu, 19 Sep 2002 05:40:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:41946 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S270881AbSISJk3>;
	Thu, 19 Sep 2002 05:40:29 -0400
Date: Thu, 19 Sep 2002 11:45:20 +0200
From: Jens Axboe <axboe@suse.de>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ide double init? + Re: BUG: Current 2.5-BK tree dies on boot!
Message-ID: <20020919094520.GB31033@suse.de>
References: <E17rlgP-0006wL-00@storm.christs.cam.ac.uk> <E17rlgP-0006wL-00@storm.christs.cam.ac.uk> <5.1.0.14.2.20020919102432.0438bec0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020919102432.0438bec0@pop.cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19 2002, Anton Altaparmakov wrote:
> At 09:47 19/09/02, Jens Axboe wrote:
> >On Wed, Sep 18 2002, Anton Altaparmakov wrote:
> >> This is without preempt. I tried both with and without SMP, with and 
> >without
> >> large TLB pages, with and without pte highmem, all die in the same place.
> >
> >You have highmem, and bouncing does not get correctly enabled on the ide
> >drives. This, in combination with broken bouncing (woops), will probably
> >make it die fairly quickly.
> >
> >I attach two patches, one fixes the bouncing, the other fixes IDE bounce
> >enable.
> 
> BK as of this morning already contains the bounce patch, so I only applied 
> the IDE bounce enable and it worked fine. - Thanks!

Good

> Note there is something odd wrt IDE initialization. The driver seems to be 
> trying to initialize twice and there quite a few messages output which 
> don't reflect reality (probably a consequence of the double init). For 
> example it says DMA disabled but checking with hdparm and in /proc/ide/via 
> DMA is enabled just fine. And it says neither IDE port enabled (BIOS) which 
> isn't true either.

Yes you are right, it does seem to try and init twice. Wonder why. I'll
take a look at that.

-- 
Jens Axboe

