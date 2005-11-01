Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbVKAUKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbVKAUKy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbVKAUKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:10:54 -0500
Received: from tim.rpsys.net ([194.106.48.114]:58805 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751333AbVKAUKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:10:54 -0500
Subject: Re: Make spitz compile again
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20051101193135.GA7075@elf.ucw.cz>
References: <20051031134255.GA8093@elf.ucw.cz>
	 <1130773530.8353.39.camel@localhost.localdomain>
	 <20051101193135.GA7075@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 20:10:49 +0000
Message-Id: <1130875849.8489.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 20:31 +0100, Pavel Machek wrote:
> Hi!
> 
> > > This is what I needed to do after update to latest linus
> > > kernel. Perhaps it helps someone. 
> > > 
> > > Signed-off-by: Pavel Machek <pavel@suse.cz>
> > > 
> > > , but it is against Richard's tree merged into my tree, so do not
> > > expect to apply it over mainline. Akita code movement is needed if I
> > > want to compile kernel without akita support...
> > 
> > This is an update of my tree against 2.6.14-git3:
> > 
> > http://www.rpsys.net/openzaurus/temp/total-2.6.14-git3-r0.patch.gz
> 
> I needed this to get it to compile... Please apply (probably modulo //
> part).
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> 								Pavel

> --- clean-rp/arch/arm/mach-pxa/pxa_keys.c	2005-11-01 19:32:56.000000000 +0100
> +++ linux-rp/arch/arm/mach-pxa/pxa_keys.c	2005-11-01 20:17:38.000000000 +0100

None of the Zaurus models use pxa_keys so I don't know why you're
compiling this. I'll sort it out but its only needed for the hx2750 in
the tree you have.
 
>  static struct pxaficp_platform_data spitz_ficp_platform_data = {
>  	.transceiver_cap  = IR_SIRMODE | IR_OFF,
> -	.transceiver_mode = spitz_irda_transceiver_mode,
> +//	.transceiver_mode = spitz_irda_transceiver_mode,
>  };

I'm not sure why you'd want to do that?

I'll move the akita code around and sort out the #ifdefs - it should
compile and just throw the odd warning about unused code as it stands
though?

Richard



