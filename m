Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVA2Tnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVA2Tnx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 14:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVA2Tlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 14:41:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:31759 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261559AbVA2TOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 14:14:37 -0500
Date: Sat, 29 Jan 2005 20:14:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] mark the mcd cdrom driver as BROKEN
Message-ID: <20050129191430.GF28047@stusta.de>
References: <3s4gX-P6-45@gated-at.bofh.it> <20050129182255.37b8fe2c.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050129182255.37b8fe2c.khali@linux-fr.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 06:22:55PM +0100, Jean Delvare wrote:
> Hi Adrian,
> 
> > The mcd driver drives only very old hardware (some single and double 
> > speed CD drives that were connected either via the soundcard or a 
> > special ISA card), and the mcdx driver offers more functionality for
> > the  same hardware.
> > 
> > My plan is to mark MCD as broken in 2.6.11 and if noone complains 
> > completely remove this driver some time later.
> > (...)
> > -	depends on CD_NO_IDESCSI
> > +	depends on CD_NO_IDESCSI && BROKEN
> 
> Shouldn't we introduce a DEPRECATED option for use in cases like this
> one?

We could.

We could also list MCD in Documentation/feature-removal-schedule.txt 
first.

But in this case I doubt it makes any difference.

This driver is for hardware where I doubt many users exist today, and it 
should have been removed nearly ten years ago when the better mcdx 
driver for the same now-obsolete hardware entered the kernel.

> Thanks,

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

