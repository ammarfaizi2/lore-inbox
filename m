Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129185AbRBTG2N>; Tue, 20 Feb 2001 01:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129458AbRBTG2C>; Tue, 20 Feb 2001 01:28:02 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:12567 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129185AbRBTG1v>; Tue, 20 Feb 2001 01:27:51 -0500
Date: Tue, 20 Feb 2001 01:27:10 -0500
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: unresloved symbols in 2.4.1
Message-ID: <20010220012710.A5267@nostromo.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200102200718.f1K7ICh32337@ns.kriljon.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200102200718.f1K7ICh32337@ns.kriljon.ru>; from eugene@kriljon.ru on Tue, Feb 20, 2001 at 04:21:20PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eugene Danilchenko (eugene@kriljon.ru) said: 
> cd /lib/modules/2.4.1; \
> mkdir -p pcmcia; \
> find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.1; fi
> depmod: *** Unresolved symbols in /lib/modules/2.4.1/kernel/fs/binfmt_elf.o
> depmod:         get_pte_slow
> depmod:         __handle_bad_pmd                                                                              
> 
> System: RedHat 6.2 
> on system installed:
> modutils-2.4.2-1
> 
> What does it mean.

It means that compiling ELF binary support as a module doesn't work right.

> and what have i to do to avoid it?

Compile it in (CONFIG_BINFMT_ELF=y). If you're using Red Hat Linux 6.2,
compiling it as a module is an incredibly bad idea anyway.

Bill
