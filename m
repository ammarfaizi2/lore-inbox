Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285394AbRLSQpc>; Wed, 19 Dec 2001 11:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285395AbRLSQpW>; Wed, 19 Dec 2001 11:45:22 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:271 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S285394AbRLSQpB>;
	Wed, 19 Dec 2001 11:45:01 -0500
Date: Wed, 19 Dec 2001 17:44:56 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Brendan Pike <spike@superweb.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE Harddrive Performance
Message-ID: <20011219174456.A27487@suse.cz>
In-Reply-To: <20011219153233.GA3424@leukertje.hitnet.rwth-aachen.de> <01121911444703.31762@spikes> <20011219160143.GA8658@gondor.com> <01121912181304.31762@spikes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01121912181304.31762@spikes>; from spike@superweb.ca on Wed, Dec 19, 2001 at 12:18:13PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 12:18:13PM -0400, Brendan Pike wrote:
> On Wednesday 19 December 2001 12:01 pm, Jan Niehusmann wrote:
> > On Wed, Dec 19, 2001 at 11:44:47AM -0400, Brendan Pike wrote:
> > > I dont really know, I dont think its possible to get higher then that
> > > from a 5400 RPM disk. Heres mine,
> >
> > /dev/hda:
> >  Timing buffered disk reads:  64 MB in  2.32 seconds = 27.59 MB/sec
> >
> > bash-2.05a# cat /proc/ide/hda/model
> > Maxtor 98196H8
> >
> > This is a 5400rpm drive, too.
> >
> > Jan
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> wowie, that is quite slow then. well udma33 mode is probebly why. if getting 
> an ata100 offboard card (since i have an ata100 drive) would make such a big 
> differance, im all for it. would there be any others reasons for such 
> slowness? is udma33 capible of more then 9MB/sec ??

Yes. Reaching up to 16 MB/sec with udma33 is quite possible.

> [root@spikes spike]# cat /proc/ide/via
> ----------VIA BusMastering IDE Configuration----------------
> Driver Version:                     3.29
> South Bridge:                       VIA vt82c586b
> Revision:                           ISA 0x47 IDE 0x6
> Highest DMA rate:                   UDMA33
> BM-DMA base:                        0xe000
> PCI clock:                          33MHz
> Master Read  Cycle IRDY:            1ws
> Master Write Cycle IRDY:            1ws
> BM IDE Status Register Read Retry:  yes
> Max DRDY Pulse Width:               No limit
> -----------------------Primary IDE-------Secondary IDE------
> Read DMA FIFO flush:          yes                 yes
> End Sector FIFO flush:         no                  no
> Prefetch Buffer:              yes                 yes
> Post Write Buffer:            yes                  no
> Enabled:                      yes                 yes
> Simplex only:                  no                  no
> Cable Type:                   40w                 40w
> -------------------drive0----drive1----drive2----drive3-----
> Transfer Mode:       UDMA       PIO       PIO       PIO
> Address Setup:       30ns     120ns      30ns     120ns
> Cmd Active:          90ns      90ns      90ns      90ns
> Cmd Recovery:        30ns      30ns      30ns      30ns
> Data Active:         90ns     330ns      90ns     330ns
> Data Recovery:       30ns     270ns      30ns     270ns
> Cycle Time:          90ns     600ns     120ns     600ns
> Transfer Rate:   22.0MB/s   3.3MB/s  16.5MB/s   3.3MB/s
> 
> dont know if that info would help much but there it is. also uses the via 
> kernel driver.

But for some reason your drive is running at udma22 (udma1). 

-- 
Vojtech Pavlik
SuSE Labs
