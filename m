Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbVHOQat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbVHOQat (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 12:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbVHOQat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 12:30:49 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17414 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964827AbVHOQas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 12:30:48 -0400
Date: Mon, 15 Aug 2005 18:30:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Arjan van de Ven <arjan@infradead.org>, Denis Vlasenko <vda@ilport.com.ua>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] make kcalloc() a static inline
Message-ID: <20050815163046.GC3614@stusta.de>
References: <20050808223842.GM4006@stusta.de> <200508151233.46523.vda@ilport.com.ua> <1124098918.3228.25.camel@laptopd505.fenrus.org> <200508151517.52171.vda@ilport.com.ua> <1124108737.3228.35.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0508151601540.3068@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508151601540.3068@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 04:06:22PM +0300, Pekka J Enberg wrote:
> On Mon, 2005-08-15 at 15:17 +0300, Denis Vlasenko wrote:
> > > Seems like that optimization is not helping.
> > > Do you have better example?
> 
> On Mon, 15 Aug 2005, Arjan van de Ven wrote:
> > you need gcc 4.1 (eg CVS) for the value range propagation stuff.
> 
> For Denis' example, it does not seem to help. I must admit I did not know 
> GCC 3.x does not have this optimization. I am also bit confused as Adrian 
> and  I saw small reduction in kernel text with kcalloc() inlined. If GCC 
> is, in fact, spreading the extra operations everywhere, shouldn't kernel 
> text be bigger?

Denis' example is a case where gcc might not produce the best code 
possible, but anyway his example isn't the typical in-kernel example.

In most in-kernel cases the first two arguments of kcalloc() are 
constant at compile-time - and in these cases all gcc versions supported 
by the kernel are able to optimize away the checks.

> 			Pekka
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

