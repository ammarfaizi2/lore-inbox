Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbRBTJa1>; Tue, 20 Feb 2001 04:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129363AbRBTJaR>; Tue, 20 Feb 2001 04:30:17 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:7722 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129170AbRBTJaG>; Tue, 20 Feb 2001 04:30:06 -0500
Date: Tue, 20 Feb 2001 03:30:02 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Bill Nottingham <notting@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: unresloved symbols in 2.4.1
In-Reply-To: <20010220012710.A5267@nostromo.devel.redhat.com>
Message-ID: <Pine.LNX.3.96.1010220032921.23246G-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2001, Bill Nottingham wrote:
> Eugene Danilchenko (eugene@kriljon.ru) said: 
> > cd /lib/modules/2.4.1; \
> > mkdir -p pcmcia; \
> > find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
> > if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.1; fi
> > depmod: *** Unresolved symbols in /lib/modules/2.4.1/kernel/fs/binfmt_elf.o
> > depmod:         get_pte_slow
> > depmod:         __handle_bad_pmd                                                                              
> > 
> > System: RedHat 6.2 
> > on system installed:
> > modutils-2.4.2-1
> > 
> > What does it mean.
> 
> It means that compiling ELF binary support as a module doesn't work right.
> 
> > and what have i to do to avoid it?
> 
> Compile it in (CONFIG_BINFMT_ELF=y). If you're using Red Hat Linux 6.2,
> compiling it as a module is an incredibly bad idea anyway.

I wonder if we shouldn't disable CONFIG_BINFMT_ELF=m, until we have a
good use case and some good testers.

	Jeff



