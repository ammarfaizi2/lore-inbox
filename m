Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292087AbSBTRaG>; Wed, 20 Feb 2002 12:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292083AbSBTR30>; Wed, 20 Feb 2002 12:29:26 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:49638 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S292085AbSBTR3O>; Wed, 20 Feb 2002 12:29:14 -0500
Date: Wed, 20 Feb 2002 10:46:34 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: ioremap()/PCI sickness in 2.4.18-rc2
Message-ID: <20020220104634.A32301@vger.timpanogas.org>
In-Reply-To: <20020220103320.A32211@vger.timpanogas.org> <20020220103539.B32211@vger.timpanogas.org> <3C73DC34.E83CCD35@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C73DC34.E83CCD35@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Feb 20, 2002 at 12:26:12PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2002 at 12:26:12PM -0500, Jeff Garzik wrote:
> "Jeff V. Merkey" wrote:
> > #ifdef CPU_ARCH_IS_ALPHA
> > #warning This looks quite suspect out
> >         if ((as->vaddr = (vkaddr_t)(dense_mem((unsigned)as->ioaddr)+(unsigned)as->ioaddr)) == 0) {
> > #else
> > 
> > =====> we are failing at this point
> > 
> >         if ((as->vaddr = (vkaddr_t)ioremap((unsigned)as->ioaddr, as->msize)) == 0) {
> > #endif
> 
> ioremap works just fine on alpha.
> 
> type abuse aside, and alpha bugs aside, this looks ok... what is the
> value of as->msize?


Size is "sz" as reported in the sci adapter log file.

Feb 20 09:49:45 lnx1 kernel: Mapping address space PREFETCH space: phaddr c0000000 sz 469762048 out of 469762048.

size = 469762048.

Jeff


> 
> -- 
> Jeff Garzik      | "Why is it that attractive girls like you
> Building 1024    |  always seem to have a boyfriend?"
> MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
>                  |             - BBC TV show "Coupling"
