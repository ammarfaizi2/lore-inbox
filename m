Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129304AbRBTNQ0>; Tue, 20 Feb 2001 08:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129592AbRBTNQQ>; Tue, 20 Feb 2001 08:16:16 -0500
Received: from pptp1.speedcast.com ([202.174.129.4]:14610 "EHLO ns.kriljon.ru")
	by vger.kernel.org with ESMTP id <S129304AbRBTNP4>;
	Tue, 20 Feb 2001 08:15:56 -0500
Message-Id: <200102201412.f1KECjh21709@ns.kriljon.ru>
Date: Tue, 20 Feb 2001 23:12:39 +0000
From: Eugene Danilchenko <eugene@kriljon.ru>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: notting@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: unresloved symbols in 2.4.1
In-Reply-To: <Pine.LNX.3.96.1010220032921.23246G-100000@mandrakesoft.mandrakesoft.com>
In-Reply-To: <20010220012710.A5267@nostromo.devel.redhat.com>
	<Pine.LNX.3.96.1010220032921.23246G-100000@mandrakesoft.mandrakesoft.com>
X-Mailer: stuphead version 0.5.0 (GTK+ 1.2.8; Linux 2.4.1; i686)
Organization: Kriljon
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JG> On Tue, 20 Feb 2001, Bill Nottingham wrote:
JG> > Eugene Danilchenko (eugene@kriljon.ru) said: 
JG> > > cd /lib/modules/2.4.1; \
JG> > > mkdir -p pcmcia; \
JG> > > find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
JG> > > if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.1; fi
JG> > > depmod: *** Unresolved symbols in /lib/modules/2.4.1/kernel/fs/binfmt_elf.o
JG> > > depmod:         get_pte_slow
JG> > > depmod:         __handle_bad_pmd                                                                              
JG> > > 
JG> > > System: RedHat 6.2 
JG> > > on system installed:
JG> > > modutils-2.4.2-1
JG> > > 
JG> > > What does it mean.
JG> > 
JG> > It means that compiling ELF binary support as a module doesn't work right.
JG> > 
JG> > > and what have i to do to avoid it?
JG> > 
JG> > Compile it in (CONFIG_BINFMT_ELF=y). If you're using Red Hat Linux 6.2,
JG> > compiling it as a module is an incredibly bad idea anyway.
JG> 
JG> I wonder if we shouldn't disable CONFIG_BINFMT_ELF=m, until we have a
JG> good use case and some good testers.

I think that if this module cant install this way, making as module must be disabled

Eugene
