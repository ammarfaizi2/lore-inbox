Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265972AbUAQBNj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 20:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUAQBNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 20:13:39 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:28399 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265972AbUAQBMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 20:12:50 -0500
Date: Sat, 17 Jan 2004 02:12:47 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jan Hubicka <jh@suse.cz>
Cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add -Winline
Message-ID: <20040117011246.GC12027@fs.tum.de>
References: <20040114090743.GA1975@averell> <20040115124204.GY23383@fs.tum.de> <20040115125544.GL5018@kam.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115125544.GL5018@kam.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 01:55:44PM +0100, Jan Hubicka wrote:
> > On Wed, Jan 14, 2004 at 10:07:43AM +0100, Andi Kleen wrote:
> > > 
> > > Add -Winline by default. This makes the compiler warn when something
> > > marked inline is not getting inlined. This is often because the 
> > > 
> > > It should only make a difference with gcc 3.4, because in earlier
> > > compilers we use always_inline and not inlining with always_inline
> > > is an error already.
> > >...
> > 
> > Attached are all inlining warnings I get with this patch applied in
> > 2.6.1-mm3 using gcc 3.3.3 20040110 (prerelease) (Debian).
> > 
> > I've gzip'ed it since it was > 100 kB.
> > 
> > A few warnings might be missing since I used a .config with 
> > CONFIG_SMP=y.
> 
> Are you sure that you do use always_inline?  (ie can you look into one
> of preprocessed file for declaration of some of failed functions?)

Yes, e.g. in drivers/ieee1394/eth1394.c:

<--  snip  -->

...
static __inline__ __attribute__((always_inline)) __attribute__((always_inline)) 
void purge_partial_datagram(struct list_head *old)
{
...

<--  snip  -->


> Honza

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

