Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263406AbTIGRwZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 13:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263410AbTIGRwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 13:52:25 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:12026 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263406AbTIGRwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 13:52:22 -0400
Date: Sun, 7 Sep 2003 19:51:50 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, robert@schwebel.de, rusty@rustcorp.com.au
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030907175149.GE14436@fs.tum.de>
References: <200309071647.h87Glp4t014359@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309071647.h87Glp4t014359@harpo.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 06:47:51PM +0200, Mikael Pettersson wrote:
> On Sun, 7 Sep 2003 13:28:13 +0200, Adrian Bunk wrote:
> >The patch below tries to implement a better i386 CPU selection.
> >
> >In 2.4 selecting e.g. M486 has the semantics to get a kernel that runs 
> >on a 486 and above.
> >
> >In 2.6 selecting M486 means that only the 486 is supported.
> 
> Can you prove your claim about 2.6?
> 
> There is to the best of my knowledge nothing in 2.6.0-test4
> that prevents a kernel compiled for CPU type N from working
> with CPU types >N. Just to prove it, I built a CONFIG_M486
> 2.6.0-test4 and booted it w/o problems on P4, PIII, and K6-III.

Look at X86_L1_CACHE_SHIFT in arch/i386/Kconfig.

> >There are two different needs:
> >1. the installation kernel of a distribution should support all CPUs 
> >   this distribution supports (perhaps starting with the 386)
> >2. a sysadmin might e.g. want a kernel that support both a Pentium-III
> >   and a Pentium 4, but doesn't need to support a 386
> 
> How are 1 and 2 different? Both need support for CPU type N
> or higher. Since a kernel configured for a lower CPU type
> still works on higher CPU types, where is the problem?
> (In case 2 configure for PIII and use that on PIII and P4.)
> 
> Maybe I'm missing something but I don't see any problem here.

In current 2.6 this is only legal with X86_GENERIC enabled.

> /Mikael

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

