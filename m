Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313947AbSEWWho>; Thu, 23 May 2002 18:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317034AbSEWWhn>; Thu, 23 May 2002 18:37:43 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:36770 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313947AbSEWWhm>;
	Thu, 23 May 2002 18:37:42 -0400
Date: Fri, 24 May 2002 00:37:22 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Gryaznova E." <grev@namesys.botik.ru>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: IDE problem: linux-2.5.17
Message-ID: <20020524003722.B27005@ucw.cz>
In-Reply-To: <3CECF59B.D471F505@namesys.botik.ru> <3CECFA15.8040707@evision-ventures.com> <3CED2B73.ABA3C95F@namesys.botik.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 09:48:35PM +0400, Gryaznova E. wrote:

> I have 40 wires cable. When ide=nodma is passed to 2.5.17 kernel - kernel boots.

Can you supply the contents of /proc/ide/amd74xx? That'd tell us whether
the cable type is detected correctly, etc.

> Am I correct that it is not possible to have DMA on with such cable?

It is possible, though only up to UDMA33.

> Is there any reason for doing that?
> 
> Note that bus speed is 33 MHz when kernel fails to boot. I mean - how do I specify slower bus speed: 22 MHz?

The bus speed IS 33 MHz and it cannot be changed (unless you
overclock(ed) the processor. If you specify a faster speed (eg. 40 MHz),
the IDE controller will be set up for slower operation to compensate,
while the true speed will stay the same.

> 
> Thanks.
> Lena.
> 
> Martin Dalecki wrote:
> 
> > Uz.ytkownik Gryaznova E. napisa?:
> > > Hello.
> > >
> > > Kernel starting from 2.5.8 can not boot my Suse 6.4. Booting on those
> > > kernels (tested 2.5.8, 2.5.9 and 2.5.17) I am always getting
> > >
> > > { dma_intr }
> > > hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> > > hda: recalibrating!
> > >
> > > and system either hangs or falls into endless loop.
> > >
> > > Kernel 2.5.7 boots and works just fine.
> > > The boot log containing information about hardware is attached.
> > >
> > > Badblock does not see any bad blocks.
> > >
> > > Thanks for any clue on the problem.
> > > Lena.
> >
> 
> [skipped]
> 
> > >
> > > ------------------------------------------------------------------------
> > You just have cabling problems which where previously hidden by
> > the driver resorting to slower operation modes.
> >
> > So please first have a look at the cabling inside your system.
> > (First of all plase make sure of course that you are using
> > a 80 wirde cable.) Or have a look in to the host chip driver
> > and penalize the transfer mode supported to lower speeds.
> > You can achieve basically a similar effect by setting
> > the busspeed kernel parameter to some artificially high value
> > as well.
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
