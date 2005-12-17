Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbVLRETf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbVLRETf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 23:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbVLRETf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 23:19:35 -0500
Received: from quelen.inf.utfsm.cl ([200.1.19.194]:10702 "EHLO
	quelen.inf.utfsm.cl") by vger.kernel.org with ESMTP id S965077AbVLRETe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 23:19:34 -0500
Message-Id: <200512170104.jBH143Hj005327@quelen.inf.utfsm.cl>
To: Adrian Bunk <bunk@stusta.de>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [-mm patch] more updates for the gcc >= 3.2 requirement 
In-Reply-To: Message from Adrian Bunk <bunk@stusta.de> 
   of "Fri, 16 Dec 2005 20:01:26 BST." <20051216190126.GF23349@stusta.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Fri, 16 Dec 2005 22:04:03 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
> On Fri, Dec 16, 2005 at 03:28:40PM -0300, Horst von Brand wrote:
> > Adrian Bunk <bunk@stusta.de> wrote:
> > > This patch contains some documentation updates and removes some code 
> > > paths for gcc < 3.2.
> > 
> > [...]
> > 
> > > --- linux-2.6.15-rc5-mm3-full/arch/arm/kernel/asm-offsets.c.old	2005-12-15 13:34:55.000000000 +0100
> > > +++ linux-2.6.15-rc5-mm3-full/arch/arm/kernel/asm-offsets.c	2005-12-15 13:35:11.000000000 +0100
> > > @@ -27,11 +27,11 @@
> > >   * GCC 3.2.0: incorrect function argument offset calculation.
> > >   * GCC 3.2.x: miscompiles NEW_AUX_ENT in fs/binfmt_elf.c
> > >   *            (http://gcc.gnu.org/PR8896) and incorrect structure
> > >   *	      initialisation in fs/jffs2/erase.c
> > >   */
> > > -#if __GNUC__ < 3 || (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
> > > +#if (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
> > >  #error Your compiler is too buggy; it is known to miscompile kernels.
> > >  #error    Known good compilers: 3.3
> > >  #endif
> > 
> > Better leave the original, in case some clown comes along with an ancient
> > compiler.
> >...

> That's what the check in init/main.c is for.

But in that case this is redundant, no? Or move the checks into there.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
