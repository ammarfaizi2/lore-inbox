Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266139AbTIKGWx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 02:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266140AbTIKGWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 02:22:53 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25574 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266139AbTIKGWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 02:22:51 -0400
Date: Thu, 11 Sep 2003 08:22:44 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030911062243.GW27368@fs.tum.de>
References: <20030908142920.GB28062@fs.tum.de> <20030909023011.BF25E2C014@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030909023011.BF25E2C014@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 11:11:21AM +1000, Rusty Russell wrote:
> In message <20030908142920.GB28062@fs.tum.de> you write:
> > On Mon, Sep 08, 2003 at 10:46:30AM +1000, Rusty Russell wrote:
> > > In message <20030907112813.GQ14436@fs.tum.de> you write:
> > > > - @Rusty:
> > > >   what's your opinion on making MODULE_PROC_FAMILY in 
> > > >   include/asm-i386/module.h some kind of bitmask?
> > > 
> > > The current one is readable, which is good, and Linus asked for it,
> > > which makes it kinda moot.  And really, if you compile a module with
> > > M686 and insert it in a kernel with M586, *WHATEVER* scheme you we use
> > > for CPU seleciton, I want the poor user to have to use "modprobe -f".
> > 
> > I agree, my thoughts go in the direction
> > 
> > bit 0 CPU_386
> > bit 1 CPU_486
> > bit 2 CPU_586
> 
> We had a bitmask, which Linus said to replace with a string.  We have
> 21 architectures, and a string works well in practice.  We could have
> a bitmask *and* a string, but why the complexity?
>...

My intention is that the user (= person compiling the kernel) selects 
all CPUs he wants to support and to move the answer to questions like 
"Which CPU type should I choose to support both an AMD Athlon and a
Pentium 4?" into the Kconfig/Makefile where it's automatically selected.

> Hope that clarifies,
> Rusty.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

