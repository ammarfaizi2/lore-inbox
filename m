Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVDDAGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVDDAGI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 20:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVDDAGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 20:06:08 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55305 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261280AbVDDAGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 20:06:01 -0400
Date: Mon, 4 Apr 2005 02:05:59 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Dag Arne Osvik <da@osvik.no>
Cc: Andreas Schwab <schwab@suse.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Use of C99 int types
Message-ID: <20050404000559.GF3953@stusta.de>
References: <424FD9BB.7040100@osvik.no> <20050403220508.712e14ec.sfr@canb.auug.org.au> <424FE1D3.9010805@osvik.no> <jezmwgxa5v.fsf@sykes.suse.de> <425072A4.7080804@osvik.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425072A4.7080804@osvik.no>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 12:48:04AM +0200, Dag Arne Osvik wrote:
> Andreas Schwab wrote:
> 
> >Dag Arne Osvik <da@osvik.no> writes:
> >
> > 
> >
> >>Yes, but wouldn't it be much better to avoid code like the following, 
> >>which may also be wrong (in terms of speed)?
> >>
> >>#ifdef CONFIG_64BIT  // or maybe CONFIG_X86_64?
> >>#define fast_u32 u64
> >>#else
> >>#define fast_u32 u32
> >>#endif
> >>   
> >>
> >
> >How about using just unsigned long instead?
> > 
> >
> 
> unsigned long happens to coincide with uint_fast32_t for x86 and x86-64, 
> but there's no guarantee that it will on other architectures.
>...

The stdint.h shipped with glibc says:

<--  snip  -->

/* Unsigned.  */
typedef unsigned char           uint_fast8_t;
#if __WORDSIZE == 64
typedef unsigned long int       uint_fast16_t;
typedef unsigned long int       uint_fast32_t;
typedef unsigned long int       uint_fast64_t;
#else
typedef unsigned int            uint_fast16_t;
typedef unsigned int            uint_fast32_t;
__extension__
typedef unsigned long long int  uint_fast64_t;
#endif

<--  snip  -->

>  Dag Arne

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

