Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263583AbTKFOC7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 09:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbTKFOC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 09:02:58 -0500
Received: from ns.suse.de ([195.135.220.2]:974 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263583AbTKFOBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 09:01:31 -0500
Date: Thu, 6 Nov 2003 14:52:11 +0100
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Message-ID: <20031106135211.GB1194@suse.de>
References: <20031106130030.GC1145@suse.de> <3FAA4737.3060906@cyberone.com.au> <20031106130553.GD1145@suse.de> <3FAA4880.8090600@cyberone.com.au> <20031106131141.GE1145@suse.de> <3FAA4D48.6040709@gmx.de> <20031106133136.GA477@suse.de> <3FAA5043.8060907@gmx.de> <20031106134713.GA798@suse.de> <3FAA52A3.9030000@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAA52A3.9030000@cyberone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 07 2003, Nick Piggin wrote:
> 
> 
> Jens Axboe wrote:
> 
> >On Thu, Nov 06 2003, Prakash K. Cheemplavam wrote:
> >
> >>>>>Heh indeed, maybe because the archs I use are still at 100. Looks
> >>>>>suspiciously like it's loosing timer interrupts, which would indeed
> >>>>>point to PIO.
> >>>>>
> >>>>>
> >>>>bash-2.05b# hdparm -I /dev/hdc
> >>>>
> >>>
> >>>-i please
> >>>
> >>bash-2.05b# hdparm -i /dev/hdc
> >>
> >>/dev/hdc:
> >>
> >>Model=LITE-ON LTR-16102B, FwRev=OS0K, SerialNo=
> >>Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
> >>RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
> >>BuffType=unknown, BuffSize=0kB, MaxMultSect=0
> >>(maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
> >>IORDY=yes, tPIO={min:227,w/IORDY:120}, tDMA={min:120,rec:120}
> >>PIO modes:  pio0 pio1 pio2 pio3 pio4
> >>DMA modes:  mdma0 mdma1 *mdma2
> >>AdvancedPM=no
> >>
> >>* signifies the current active mode
> >>
> >>The same: dma is active.
> >>
> >
> >Indeed, so you are ysing multiword mode 2. Can you try and do a dd from
> >the drive, while doing a vmstat 1? Also, does that show the jerky
> >behaviour?
> >
> 
> AFAIK, Prakash cannot reproduce this bad behaviour with mm1, only mm2 (is
> this right, Prakash?). So its something there (don't forget Andrew merges
> the latest bk with his releases too).

I'm not aware of anything in that area that could explain the change.

-- 
Jens Axboe

