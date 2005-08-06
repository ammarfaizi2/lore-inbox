Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263455AbVHFTkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263455AbVHFTkq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 15:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbVHFTjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 15:39:20 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26894 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263455AbVHFTjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 15:39:06 -0400
Date: Sat, 6 Aug 2005 21:38:59 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Simon Morgan <sjmorgan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Outdated Sangoma Drivers
Message-ID: <20050806193859.GW4029@stusta.de>
References: <de63970c05080602496c2c8b11@mail.gmail.com> <42F5090E.4070608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F5090E.4070608@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2005 at 09:01:34PM +0200, Jiri Slaby wrote:
> Simon Morgan napsal(a):
> 
> >Hi,
> >
> >I couldn't help noticing that the Sangoma drivers distributed with the
> >current kernel are slightly out of date and was wondering whether there
> >was any reason for this?
> >
> >For example the kernel copy of sdla.c was last updated Mar 20, 2001 while
> >the version contained in the drivers distributed on sangoma.com[1] was
> >last updated Dec 15. 2003.
> >
> Hi,
> this is letter from sangoma:
> <cite>
> the sdla.c is not Sangoma's file :) or if it is it should be erased.  
> The sdla.c
> has not been used since 2001.
> 
> It is true that wanpipe drivers are not part of linux 2.6 kernel.  We have
> been so busy developing that there is no way the linux kernel could
> keep up with the changes.
> 
> Bottom line we have to put a whole new wanpipe driver into the kernel
> source, and that is a big task.
> It is much easier for us to ask people to use our drivers from the web.
> Once the wanpipe drivers stop changing so fast we will be able
> to push the new release into the kernel.  It doesn't make sense to do it 
> now
> because if anyone wants to use wanpipe, that person would have to
> get the latest drivers from the web!
> </cite>
> 
> So what do you think we would do?
> Add some lines to Kconfig with address of ftp sangoma?
> Delete old version from the tree and wait for the new one?

The common way to handle this is to simply keep the version that is now 
in the kernel.

If someone wants to send updates for a driver for review he can always 
do so. If they dont want to get their driver updated in the kernel it's 
their problem - and not a reason to reward them with a link to their 
site.

Oh, one reason why they don't want to submit their latest driver might 
be that their driver is using with binary-only code if you activate 
their ADSL or ATM code...

OTOH, I don't see a compelling reason for removing the version currently 
in the tree (part of the drivers is BROKEN, but even this doesn't do 
much harm).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

