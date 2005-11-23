Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030465AbVKWWyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030465AbVKWWyo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030469AbVKWWyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:54:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21011 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030468AbVKWWyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:54:41 -0500
Date: Wed, 23 Nov 2005 23:54:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [-mm patch] init/main.c: dummy mark_rodata_ro() should be static
Message-ID: <20051123225440.GJ3963@stusta.de>
References: <20051123033550.00d6a6e8.akpm@osdl.org> <20051123223505.GF3963@stusta.de> <Pine.LNX.4.58.0511231443420.20189@shark.he.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0511231443420.20189@shark.he.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 02:46:51PM -0800, Randy.Dunlap wrote:
> On Wed, 23 Nov 2005, Adrian Bunk wrote:
> 
> > Every inline dummy function should be static.
> 
> Please explain why it matters in this case.

We don't need an additional global copy of the function.

> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> >
> > --- linux-2.6.15-rc2-mm1-full/init/main.c.old	2005-11-23 16:50:45.000000000 +0100
> > +++ linux-2.6.15-rc2-mm1-full/init/main.c	2005-11-23 16:50:55.000000000 +0100
> > @@ -101,7 +101,7 @@
> >  static inline void acpi_early_init(void) { }
> >  #endif
> >  #ifndef CONFIG_DEBUG_RODATA
> > -inline void mark_rodata_ro(void) { }
> > +static inline void mark_rodata_ro(void) { }
> >  #endif
> >
> >  #ifdef CONFIG_TC
> 
> -- 
> ~Randy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

