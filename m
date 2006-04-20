Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWDTMG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWDTMG0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 08:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWDTMGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 08:06:25 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25867 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750759AbWDTMGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 08:06:25 -0400
Date: Thu, 20 Apr 2006 14:06:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
Subject: Re: [RFC: 2.6 patch] let arm use drivers/Kconfig
Message-ID: <20060420120624.GO25047@stusta.de>
References: <20060417144823.GC7429@stusta.de> <1145285754.13200.15.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145285754.13200.15.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2006 at 03:55:54PM +0100, David Woodhouse wrote:
> On Mon, 2006-04-17 at 16:48 +0200, Adrian Bunk wrote:
> > --- linux-2.6.17-rc1-mm2-arm/drivers/mtd/Kconfig.old    2006-04-17 14:32:35.000000000 +0200
> > +++ linux-2.6.17-rc1-mm2-arm/drivers/mtd/Kconfig        2006-04-17 15:00:57.000000000 +0200
> > @@ -1,6 +1,7 @@
> >  # $Id: Kconfig,v 1.11 2005/11/07 11:14:19 gleixner Exp $
> >  
> >  menu "Memory Technology Devices (MTD)"
> > +       depends on (ALIGNMENT_TRAP || !ARM)
> >  
> >  config MTD
> >         tristate "Memory Technology Device (MTD) support"
> 
> This dependency is incorrect. It's only one or two chip-specific drivers
> which require that the architecture correctly handle alignment traps,
> and even then it's only actually apparent when used with JFFS2 which
> actually _gives_ it an unaligned buffer occasionally. Everything else
> works fine.
> 
> Also, I don't want to see this dependency expressed in the MTD Kconfig
> file unless it's not arch-specific. Please make a generic
> BROKEN_UNALIGNED config option, and set it on all architectures which
> need it. Then propose a saner place to put the restriction instead of on
> CONFIG_MTD.

Can anyone tell me which chip-specific drivers are affected by this 
issue so that I can send a patch?

> dwmw2

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

