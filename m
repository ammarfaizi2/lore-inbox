Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311667AbSCNQuH>; Thu, 14 Mar 2002 11:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311670AbSCNQt7>; Thu, 14 Mar 2002 11:49:59 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:40454 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S311667AbSCNQtw>; Thu, 14 Mar 2002 11:49:52 -0500
Date: Thu, 14 Mar 2002 17:49:49 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Martin Dalecki <martin@dalecki.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PIIX rewrite patch, pre-final
Message-ID: <20020314174949.A14742@ucw.cz>
In-Reply-To: <20020314001449.A31068@ucw.cz> <20020314164725.GD706@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020314164725.GD706@opus.bloom.county>; from trini@kernel.crashing.org on Thu, Mar 14, 2002 at 09:47:25AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 09:47:25AM -0700, Tom Rini wrote:
> On Thu, Mar 14, 2002 at 12:14:49AM +0100, Vojtech Pavlik wrote:
> 
> [snip]
> > diff -urN linux-2.5.6-timing/drivers/ide/Config.in linux-2.5.6-piix/drivers/ide/Config.in
> > --- linux-2.5.6-timing/drivers/ide/Config.in	Mon Mar 11 08:46:22 2002
> > +++ linux-2.5.6-piix/drivers/ide/Config.in	Wed Mar 13 23:37:20 2002
> > @@ -67,10 +67,7 @@
> >    	    dep_bool '    HPT34X chipset support' CONFIG_BLK_DEV_HPT34X $CONFIG_BLK_DEV_IDEDMA_PCI
> >  	    dep_mbool '      HPT34X AUTODMA support (WIP)' CONFIG_HPT34X_AUTODMA $CONFIG_BLK_DEV_HPT34X $CONFIG_IDEDMA_PCI_WIP
> >  	    dep_bool '    HPT366 chipset support' CONFIG_BLK_DEV_HPT366 $CONFIG_BLK_DEV_IDEDMA_PCI
> > -	    if [ "$CONFIG_X86" = "y" -o "$CONFIG_IA64" = "y" ]; then
> > -	       dep_mbool '    Intel PIIXn chipsets support' CONFIG_BLK_DEV_PIIX $CONFIG_BLK_DEV_IDEDMA_PCI
> > -	       dep_mbool '      PIIXn Tuning support' CONFIG_PIIX_TUNING $CONFIG_BLK_DEV_PIIX $CONFIG_IDEDMA_PCI_AUTO
> > -	    fi
> > +	    dep_bool '    Intel PIIX, ICH and Efar Victory66 chipsets support' CONFIG_BLK_DEV_PIIX $CONFIG_BLK_DEV_IDEDMA_PCI
> >  	    if [ "$CONFIG_MIPS_ITE8172" = "y" -o "$CONFIG_MIPS_IVR" = "y" ]; then
> >  	       dep_mbool '    IT8172 IDE support' CONFIG_BLK_DEV_IT8172 $CONFIG_BLK_DEV_IDEDMA_PCI
> >  	       dep_mbool '      IT8172 IDE Tuning support' CONFIG_IT8172_TUNING $CONFIG_BLK_DEV_IT8172 $CONFIG_IDEDMA_PCI_AUTO
> > @@ -83,7 +80,6 @@
> >  	    dep_bool '      Special FastTrak Feature' CONFIG_PDC202XX_FORCE $CONFIG_BLK_DEV_PDC202XX
> >  	    dep_bool '    ServerWorks OSB4/CSB5 chipsets support' CONFIG_BLK_DEV_SVWKS $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
> >  	    dep_bool '    SiS5513 chipset support' CONFIG_BLK_DEV_SIS5513 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
> > -	    dep_bool '    SLC90E66 chipset support' CONFIG_BLK_DEV_SLC90E66 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
> >  	    dep_bool '    Tekram TRM290 chipset support (EXPERIMENTAL)' CONFIG_BLK_DEV_TRM290 $CONFIG_BLK_DEV_IDEDMA_PCI
> >  	    dep_bool '    VIA82CXXX chipset support' CONFIG_BLK_DEV_VIA82CXXX $CONFIG_BLK_DEV_IDEDMA_PCI
> >           fi
> 
> This reminds (and I'm about to submit a patch to fix it..) but the above
> is wrong, and should look like:
> if [ "$CONFIG_X86" = "y" -o "$CONFIG_IA64" = "y" ]; then
>    dep_bool '    Intel PIIX, ICH and Efar Victory66 chipsets support' CONFIG_BLK_DEV_PIIX $CONFIG_BLK_DEV_IDEDMA_PCI
> fi
> 
> Unless the Efar Victory66 is showing up in other arches now...

No, but Intel PIIX certainly is used at least on Alphas, and I've seen
it used together with an ARM.

-- 
Vojtech Pavlik
SuSE Labs
