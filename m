Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267244AbTBLPag>; Wed, 12 Feb 2003 10:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267247AbTBLPag>; Wed, 12 Feb 2003 10:30:36 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25834 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267244AbTBLPad>; Wed, 12 Feb 2003 10:30:33 -0500
Date: Wed, 12 Feb 2003 16:40:17 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Guennadi Liakhovetski <gl@dsa-ac.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.60 linking error with IDE-DMA disabled
Message-ID: <20030212154017.GN17128@fs.tum.de>
References: <Pine.LNX.4.33.0302111207080.1173-100000@pcgl.dsa-ac.de> <1044968542.12907.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1044968542.12907.7.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 01:02:23PM +0000, Alan Cox wrote:
> On Tue, 2003-02-11 at 11:12, Guennadi Liakhovetski wrote:
> > Hello
> > 
> > If I try to compile the kernel with IDE bus-mastering disabled (which,
> > IIRC, worked on 2.4.x), I get the following error:
> > 
> 
> Looks like the 2.5 makefile is broken. If you didnt include any IDE DMA
> support them ide-dma.c should not have been linked into the kernel. 2.4.x
> seems to get this right (though I have to fix modular IDE there yet). 
> I'll have a look at the rest when I try and get 2.5.60 IDE back in sync
> with the newer 2.4 code.

It isn't ide-dma.c. The error messages talk about the functions
init_dma_generic and ide_hwif_setup_dma and these are in pci/generic.c
and setup-pci.c, respectively.

These are included since he has CONFIG_BLK_DEV_IDEPCI and 
CONFIG_BLK_DEV_GENERIC enabled.

> Alan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

