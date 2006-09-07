Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161057AbWIGBCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057AbWIGBCi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 21:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161058AbWIGBCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 21:02:38 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:19973 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161057AbWIGBCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 21:02:37 -0400
Date: Thu, 7 Sep 2006 03:02:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] re-add -ffreestanding
Message-ID: <20060907010235.GE25473@stusta.de>
References: <20060830175727.GI18276@stusta.de> <200608302013.58122.ak@suse.de> <20060830183905.GB31594@flint.arm.linux.org.uk> <20060906223748.GC12157@stusta.de> <Pine.LNX.4.64.0609070115270.6761@scrub.home> <20060906235029.GC25473@stusta.de> <Pine.LNX.4.64.0609070202040.6761@scrub.home> <20060907003758.GD25473@stusta.de> <Pine.LNX.4.64.0609070245100.6761@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609070245100.6761@scrub.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 02:47:42AM +0200, Roman Zippel wrote:
> Hi,
> 
> On Thu, 7 Sep 2006, Adrian Bunk wrote:
> 
> > > BS, even without it gcc can't make such assumption.
> > > There is not a single optimization, which would be invalid in a kernel 
> > > environment and would be "fixed" by this option, so please stop this 
> > > nonsense.
> > 
> > You are wrong.
> > 
> > Section 5.1.2.2.2 of ISO/IEC 9899:1999 says:
> > In a hosted environment, a program may use all functions, macros, type 
> > definitions, and objects described in the library clause (clause 7).
> > 
> > Since a hosted environment means gcc+libc, it's therefore clear that gcc 
> > can assume the presence of a full libc if gcc isn't told that it's used 
> > as a freestanding environment.
> 
> Define "full libc".

Everything described in clause 7 of ISO/IEC 9899:1999.

> Explain what exactly -ffreestanding fixes, which is not valid for the 
> kernel.

It's simply correct since the kernel doesn't provide everything 
described in clause 7 of ISO/IEC 9899:1999.

And it fixes compile errors caused by the fact that gcc is otherwise 
allowed to replace calls to any standard C function with semantically 
equivalent calls to other standard C functions - in a hosted environment 
the latter are guaranteed to be present.

> byem Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

