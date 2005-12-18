Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbVLRLrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbVLRLrG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 06:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbVLRLrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 06:47:06 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5137 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932511AbVLRLrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 06:47:05 -0500
Date: Sun, 18 Dec 2005 12:47:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [-mm patch] more updates for the gcc >= 3.2 requirement
Message-ID: <20051218114706.GZ23349@stusta.de>
References: <20051216190126.GF23349@stusta.de> <200512170104.jBH143Hj005327@quelen.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512170104.jBH143Hj005327@quelen.inf.utfsm.cl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 10:04:03PM -0300, Horst von Brand wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> > On Fri, Dec 16, 2005 at 03:28:40PM -0300, Horst von Brand wrote:
> > > Adrian Bunk <bunk@stusta.de> wrote:
> > > > This patch contains some documentation updates and removes some code 
> > > > paths for gcc < 3.2.
> > > 
> > > [...]
> > > 
> > > > --- linux-2.6.15-rc5-mm3-full/arch/arm/kernel/asm-offsets.c.old	2005-12-15 13:34:55.000000000 +0100
> > > > +++ linux-2.6.15-rc5-mm3-full/arch/arm/kernel/asm-offsets.c	2005-12-15 13:35:11.000000000 +0100
> > > > @@ -27,11 +27,11 @@
> > > >   * GCC 3.2.0: incorrect function argument offset calculation.
> > > >   * GCC 3.2.x: miscompiles NEW_AUX_ENT in fs/binfmt_elf.c
> > > >   *            (http://gcc.gnu.org/PR8896) and incorrect structure
> > > >   *	      initialisation in fs/jffs2/erase.c
> > > >   */
> > > > -#if __GNUC__ < 3 || (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
> > > > +#if (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
> > > >  #error Your compiler is too buggy; it is known to miscompile kernels.
> > > >  #error    Known good compilers: 3.3
> > > >  #endif
> > > 
> > > Better leave the original, in case some clown comes along with an ancient
> > > compiler.
> > >...
> 
> > That's what the check in init/main.c is for.
> 
> But in that case this is redundant, no? Or move the checks into there.

No, the kernel now generally requires gcc >= 3.2, but on arm it requires 
gcc >= 3.3.

Whether the arm specifically check is in init/main.c or 
arch/arm/kernel/asm-offsets.c doesn't matter, and traditionally it is at 
the latter place.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

