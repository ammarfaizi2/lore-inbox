Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262647AbVG2P6C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbVG2P6C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 11:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbVG2P6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 11:58:02 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34067 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262643AbVG2P4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 11:56:32 -0400
Date: Fri, 29 Jul 2005 17:56:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: RFC: Raise required gcc version to 3.2 ?
Message-ID: <20050729155630.GF3563@stusta.de>
References: <200507281648.j6SGmnf0023871@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507281648.j6SGmnf0023871@harpo.it.uu.se>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 06:48:49PM +0200, Mikael Pettersson wrote:
> On Thu, 28 Jul 2005 14:00:12 +0200, Adrian Bunk wrote:
> >What is the oldest gcc we want to support in kernel 2.6?
> >
> >Currently, it's 2.95 .
> >
> >I'd suggest raising this to 3.2 which should AFAIK not be a problem for 
> >any distribution supporting kernel 2.6 .
> >
> >Is there any good reason why we should not drop support for older 
> >compilers?
> 
> You're asking the wrong question. The right question would be:
> "Is there any good reason to drop support for older compilers?"
> 
> At least on i386, gcc-2.95.3 still works and has the advantage
> of being much faster compile-time wise on older machines with
> limited memory (like my 486 test box). And I'm not the only
> one with that POV -- akpm also uses 2.95.
> 
> Of course, if keeping 2.95.3 support would somehow hinder the
> kernel's development, then it should be removed. But so far I
> haven't seen any real(*) evidence that this is the case.
>...

The advantages are:
- reducing the number of supported gcc versions from 8 to 4 [1]
  allows the removal of several #ifdef's and workarounds
- my impression is that the older compilers are only rarely
  used, so miscompilations of a driver with an old gcc might
  not be detected for a longer amount of time

My personal opinion about the time and space a compilation requires is 
that this is no longer that much of a problem for modern hardware, and 
in the worst case you can compile the kernels for older machines on more 
recent machines.

> /Mikael

cu
Adrian

[1] support removed: 2.95, 2.96, 3.0, 3.1
    still supported: 3.2, 3.3, 3.4, 4.0

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

