Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267391AbUJBKvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267391AbUJBKvN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 06:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267397AbUJBKvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 06:51:13 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57361 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S267391AbUJBKvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 06:51:10 -0400
Date: Sat, 2 Oct 2004 12:50:38 +0200
From: Adrian Bunk <adrian.bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm1 build failure
Message-ID: <20041002105038.GB2470@stusta.mhn.de>
References: <20041002091644.GA8431@gamma.logic.tuwien.ac.at> <20041002022921.0e1aceb3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041002022921.0e1aceb3.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 02, 2004 at 02:29:21AM -0700, Andrew Morton wrote:
> Norbert Preining <preining@logic.at> wrote:
> >
> > ..
> >    LD      .tmp_vmlinux1
> >  arch/i386/kernel/built-in.o(.text+0x111f5): In function `end_level_ioapic_irq':
> >  : undefined reference to `irq_mis_count'
> >  kernel/built-in.o(.text+0x1eba7): In function `ack_none':
> >  : undefined reference to `ack_APIC_irq'
> >  make[1]: *** [.tmp_vmlinux1] Fehler 1
> >  make[1]: Leaving directory `/usr/src/linux-2.6.9-rc3-mm1'
> 
> hm, that's clever.
> 
> See if arch/i386/kernel/io_apic.c needs

s/io_apic.c/irq.c/ and it should solve Norberts problem.

> #include <asm/io_apic.h>
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

