Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265875AbUATXDd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 18:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265876AbUATXDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 18:03:32 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59620 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265875AbUATXDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 18:03:23 -0500
Date: Wed, 21 Jan 2004 00:03:14 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Diego Calleja <grundig@teleline.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] disallow DRM on 386
Message-ID: <20040120230313.GA6441@fs.tum.de>
References: <20040120212421.GF12027@fs.tum.de> <20040120234403.73be7b2a.grundig@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040120234403.73be7b2a.grundig@teleline.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 11:44:03PM +0100, Diego Calleja wrote:
> El Tue, 20 Jan 2004 22:24:21 +0100 Adrian Bunk <bunk@fs.tum.de> escribió:
> 
> > I got the following compile error in 2.6.1-mm5 with X86_CMPXCHG=n.
> > This problem is not specific to -mm, and it always occurs when you 
> > include support for the 386 cpu (oposed to the 486 or later cpus) since 
> > in this case X86_CMPXCHG=n and therefoore cmpxchg isn't defined in 
> > include/asm-i386/system.h .
> > 
> > The patch below disallows DRM if X86_CMPXCHG=n.
> 
> I got a "cmpxchg not defined" error when compiling the drm stuff in -mm5.
> When I looked at the configuration, I saw that all the cpus types had been selected
> (I didn't even realize of your stuuf and menuconfig put the defaults). I removed
> all types of cpus except PIII and it compiled.

Yup, that's exactly the problem.

Selecting CPU_386 in -mm4 or -mm5 or selecting M386 in other kernels 
triggers it.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

