Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWA2X6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWA2X6z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 18:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWA2X6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 18:58:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39941 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932095AbWA2X6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 18:58:54 -0500
Date: Mon, 30 Jan 2006 00:58:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: akpm@osdl.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4
Message-ID: <20060129235853.GD3777@stusta.de>
References: <20060129144533.128af741.akpm@osdl.org> <20060129233403.GA3777@stusta.de> <20060129154002.360c7294.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060129154002.360c7294.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 03:40:02PM -0800, Randy.Dunlap wrote:
> On Mon, 30 Jan 2006 00:34:03 +0100 Adrian Bunk wrote:
> 
> > On Sun, Jan 29, 2006 at 02:45:33PM -0800, Andrew Morton wrote:
> > >...
> > > Changes since 2.6.16-rc1-mm3:
> > >...
> > > +i386-add-a-temporary-to-make-put_user-more-type-safe.patch
> > > 
> > >  x86 fixes/features
> > >...
> > 
> > This patch generates so many "ISO C90 forbids mixed declarations and code"
> > warnings that I start to consider Andrew's rejection of my "mark 
> > virt_to_bus/bus_to_virt as __deprecated on i386" patch due to the 
> > warnings it generates a personal insult...
> 
> I prefer to think of it as reasons why neither of them
> should be merged.


Some remarks:


I forgot the smiley.


If we want to get rid of a long deprecated API (as in the 
virt_to_bus/bus_to_virt case), adding warnings could help making 
maintainers aware of the fact that the API is deprecated.

In such cases the warnings are supposed to be present only temporarily 
until the code using the deprecated API got fixed.

It might not be visible for people only using allyesconfig/allmodconfig, 
but BROKEN_ON_SMP drivers often spit screenfuls of warnings. That's OK, 
and most of them have been fixed during the last years.

And otherwise, we could simply remove __deprecated from the kernel.

Andrew rejected my patch to add -Werror-implicit-function-declaration to 
the CFLAGS which helps us to avoid a certain class of nasty runtime 
errors because it turned virt_to_bus/bus_to_virt link errors on powerpc 
into compile errors (sic).


> ~Randy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

