Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWGGHfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWGGHfg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 03:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWGGHfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 03:35:36 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34569 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750887AbWGGHff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 03:35:35 -0400
Date: Fri, 7 Jul 2006 09:35:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Auke Kok <sofar@foo-projects.org>
Cc: cramerj@intel.com, john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com, auke-jan.h.kok@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] drivers/net/e1000/: possible cleanups
Message-ID: <20060707073535.GA26941@stusta.de>
References: <20060703030355.420c7155.akpm@osdl.org> <20060706203736.GS26941@stusta.de> <44AD76E5.90905@foo-projects.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AD76E5.90905@foo-projects.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 01:47:33PM -0700, Auke Kok wrote:
> Adrian Bunk wrote:
> >On Mon, Jul 03, 2006 at 03:03:55AM -0700, Andrew Morton wrote:
> >>...
> >>Changes since 2.6.17-mm5:
> >>...
> >> git-e1000.patch
> >>...
> >> git trees.
> >>...
> >
> >This patch contains the following possible cleanups:
> >- make needlessly global functions static
> 
> I'm fine with those
> 
> >- #if 0 the following unused global functions:
> >  - e1000_hw.c: e1000_mc_addr_list_update()
> >  - e1000_hw.c: e1000_read_reg_io()
> >  - e1000_hw.c: e1000_enable_pciex_master()
> >  - e1000_hw.c: e1000_ife_disable_dynamic_power_down()
> >  - e1000_hw.c: e1000_ife_enable_dynamic_power_down()
> >  - e1000_hw.c: e1000_write_ich8_word()
> >  - e1000_hw.c: e1000_duplex_reversal()
> >  - e1000_main.c: e1000_io_read()
> 
> I'm wondering if we should not remove those alltogether, or are we 
> preferring to keep the #if 0'd now?

#if 0 is the compromise between not bloating the kernel binary with 
unused code and not immediately removing the currently unused code.

If you as a maintainer of this driver say you want a patch to remove 
these unused functions I can also send this patch.

> Cheers,
> 
> Auke
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

