Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317508AbSHHNGu>; Thu, 8 Aug 2002 09:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317512AbSHHNGu>; Thu, 8 Aug 2002 09:06:50 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:34824
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317508AbSHHNGu>; Thu, 8 Aug 2002 09:06:50 -0400
Date: Thu, 8 Aug 2002 06:02:18 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Nick Orlov <nick.orlov@mail.ru>, B.Zolnierkiewicz@elka.pw.edu.pl,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, davidsen@tmr.com
Subject: Re: [PATCH] pdc20265 problem.
In-Reply-To: <16CF2372467@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.10.10208080549330.24560-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please go check your BIOS and search or support/boot INT19 services.
That is how the mainboard selects ordering from the bios.

Go read e01125r0 and the e01133r0's related sections.

There are mainboard out there designed specifically to boot off the third
party host.  I have one with the pdc20265 on it.  So if you mainboard is
produced by some lame OEM who is trying to grant first access to the addon
host chip by playing silly devfn/bus ordering games you get what you
bought.  Yeah there are cheesy crap-mainboard oem's that play this game.

Regards,

Andre Hedrick
LAD Storage Consulting Group

On Thu, 8 Aug 2002, Petr Vandrovec wrote:

> On  8 Aug 02 at 3:50, Andre Hedrick wrote:
> > On Wed, 7 Aug 2002, Bill Davidsen wrote:
> > 
> > > I would just as soon use a boot option as to try and make it a compile
> > > option, and I think that many people just use a compiled kernel and never
> > > change, which argues for a reasonable default (most pdc20265) ARE
> > > currently offboard, and an easy way to change it.
> > 
> > There are ZERO pdc20265's offboard, only pdc20267's were in both options.
> > This is the direct asic packaging.  Thus all pdc20265 have the right to be
> > listed as onboard.  If you have a pdc20265 on an add-on card please send
> > me a digital photo so I can question promise as to why.
> 
> They are on the mainboard, but mainboard has also (in my case VIA) IDE
> chipset on the shelf, and BIOS shows everywhere (autodetection, IDE config)
> that VIA is the primary chipset, and PDC ('UDMA100' interface in the BIOS)
> is an additional, optional, interface. So forcing PDC20265 as primary is 
> a bug - it is not consistent with BIOS, it is not consistent with Windows, 
> and it is not consistent with other Linux versions.
> 
> Up to now nobody showed me mainboard which has PDC20265, but which does
> not have other IDE chipset integrated in the southbridge, or at least
> mainbord with BIOS which names disks connected to the PDC primary/secondary
> master/slave. It is 3rd/4th channel on all mainboards I ever saw.
>                                                     Petr Vandrovec
>                                                     vandrove@vc.cvut.cz
>                                                     
> 

