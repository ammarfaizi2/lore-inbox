Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbTIHOaE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 10:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbTIHOaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 10:30:04 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:3066 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262425AbTIHOaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 10:30:00 -0400
Date: Mon, 8 Sep 2003 16:29:21 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, robert@schwebel.de
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030908142920.GB28062@fs.tum.de>
References: <20030907112813.GQ14436@fs.tum.de> <20030908020812.3A48F2C186@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908020812.3A48F2C186@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 10:46:30AM +1000, Rusty Russell wrote:
> In message <20030907112813.GQ14436@fs.tum.de> you write:
> > - @Rusty:
> >   what's your opinion on making MODULE_PROC_FAMILY in 
> >   include/asm-i386/module.h some kind of bitmask?
> 
> The current one is readable, which is good, and Linus asked for it,
> which makes it kinda moot.  And really, if you compile a module with
> M686 and insert it in a kernel with M586, *WHATEVER* scheme you we use
> for CPU seleciton, I want the poor user to have to use "modprobe -f".

I agree, my thoughts go in the direction

bit 0 CPU_386
bit 1 CPU_486
bit 2 CPU_586
...

And you should need a "modprobe -f" if the bitmask in the module differs 
from the bitmask in the kernel.

> Hope that clarifies,
> Rusty.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

