Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265904AbUAUA2g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 19:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265906AbUAUA2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 19:28:36 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2015 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265904AbUAUA2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 19:28:30 -0500
Date: Wed, 21 Jan 2004 01:28:27 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Dri-devel] [2.6 patch] disallow DRM on 386
Message-ID: <20040121002827.GG6441@fs.tum.de>
References: <20040120212421.GF12027@fs.tum.de> <1074643498.25861.14.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074643498.25861.14.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 12:04:59AM +0000, Alan Cox wrote:
> On Maw, 2004-01-20 at 21:24, Adrian Bunk wrote:
> > I got the following compile error in 2.6.1-mm5 with X86_CMPXCHG=n.
> > This problem is not specific to -mm, and it always occurs when you 
> > include support for the 386 cpu (oposed to the 486 or later cpus) since 
> > in this case X86_CMPXCHG=n and therefoore cmpxchg isn't defined in 
> > include/asm-i386/system.h .
> > 
> > The patch below disallows DRM if X86_CMPXCHG=n.
> 
> Ugly.
> 
> Fix system.h to always define cmpxchg.h and check its presence at
> runtime when the DRM module loads, then you can build 386 kernels that
> support DRI on higher machines.
> 
> The problem isnt that cmpxchg definitely doesn't exist, so system.h is
> wrong IMHO

???

AFAIR cmpxchg wasn't present in cpus earlier than the 486.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

