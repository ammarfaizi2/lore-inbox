Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbUKUSBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbUKUSBy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 13:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbUKUSBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 13:01:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29451 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261742AbUKUSBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 13:01:51 -0500
Date: Sun, 21 Nov 2004 19:01:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@redhat.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] MTD: some cleanups
Message-ID: <20041121180150.GE2924@stusta.de>
References: <20041112135322.GB7707@stusta.de> <1100629567.8191.6993.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100629567.8191.6993.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 06:26:07PM +0000, David Woodhouse wrote:
> On Fri, 2004-11-12 at 14:53 +0100, Adrian Bunk wrote:
> > The patch below makes the following cleanups for code under drivers/mtd/ :
> > - make some needlessly global code static
> 
> OK.

Thanks.

> > - remove the following unused code:
> >   - function ftl_freepart in drivers/mtd/ftl.c
> 
> It's a bug that we never free these. We should call the function
> occasionally instead of deleting it.

OK.

> >   - functions nettel_eraseconfig and nettel_erasecallback,
> >    struct nettel_erase in drivers/mtd/maps/nettel.c
> 
> The nettel_eraseconfig() function isn't static -- I assume it was called
> from the nettel-specific platform code.

>From some platform code where the merging into the kernel is pending?

> >   - function physmap_set_partitions in drivers/mtd/maps/physmap.c
> 
> Again that's called from elsewhere.

The merging of the code calling it into the kernel is pending?

> dwmw2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

