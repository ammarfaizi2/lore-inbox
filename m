Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWHVOId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWHVOId (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 10:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWHVOId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 10:08:33 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56585 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932169AbWHVOIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 10:08:32 -0400
Date: Tue, 22 Aug 2006 16:08:32 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>,
       virtualization <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] paravirt.h
Message-ID: <20060822140832.GW11651@stusta.de>
References: <1155202505.18420.5.camel@localhost.localdomain> <44DB7596.6010503@goop.org> <20060819012133.GH7813@stusta.de> <44E67B6E.10706@goop.org> <Pine.LNX.4.62.0608201047520.4809@pademelon.sonytel.be> <44EAFEE3.8080700@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EAFEE3.8080700@goop.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 05:56:03AM -0700, Jeremy Fitzhardinge wrote:
> Geert Uytterhoeven wrote:
> >>relicensing them.
> >>    
> >
> >That's a pretty strong statement...
> >  
> 
> Well, I'm not making any kind of legal statement.  I'm just pointing out 
> that from a technical perspective, there's a large visible functional 
> change from before if we use EXPORT_SYMBOL_GPL(paravirt_ops) vs 
> EXPORT_SYMBOL(paravirt_ops).  Given that the whole point of paravirt_ops 
> is to minimize visible changes, this seems counterproductive.

It only affects kernels with the new functionality PARAVIRT=y, not 
kernels with the same functionality as today.

The alternative is to keep the EXPORT_SYMBOL_GPL(paravirt_ops) and make 
the functions using it out of line functions.

>    J

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

