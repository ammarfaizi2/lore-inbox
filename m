Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266832AbUAOMzp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 07:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266834AbUAOMzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 07:55:44 -0500
Received: from nikam.ms.mff.cuni.cz ([195.113.18.106]:43195 "EHLO
	nikam.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266832AbUAOMzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 07:55:43 -0500
Date: Thu, 15 Jan 2004 13:55:44 +0100
From: Jan Hubicka <jh@suse.cz>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jh@suse.cz
Subject: Re: [PATCH] Add -Winline
Message-ID: <20040115125544.GL5018@kam.mff.cuni.cz>
References: <20040114090743.GA1975@averell> <20040115124204.GY23383@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115124204.GY23383@fs.tum.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Jan 14, 2004 at 10:07:43AM +0100, Andi Kleen wrote:
> > 
> > Add -Winline by default. This makes the compiler warn when something
> > marked inline is not getting inlined. This is often because the 
> > 
> > It should only make a difference with gcc 3.4, because in earlier
> > compilers we use always_inline and not inlining with always_inline
> > is an error already.
> >...
> 
> Attached are all inlining warnings I get with this patch applied in
> 2.6.1-mm3 using gcc 3.3.3 20040110 (prerelease) (Debian).
> 
> I've gzip'ed it since it was > 100 kB.
> 
> A few warnings might be missing since I used a .config with 
> CONFIG_SMP=y.

Are you sure that you do use always_inline?  (ie can you look into one
of preprocessed file for declaration of some of failed functions?)

Honza
> 
> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> 


