Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWHIWTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWHIWTD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 18:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWHIWTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 18:19:03 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18706 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751399AbWHIWTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 18:19:01 -0400
Date: Thu, 10 Aug 2006 00:18:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: /dev/sd*
Message-ID: <20060809221857.GG3691@stusta.de>
References: <1155144599.5729.226.camel@localhost.localdomain> <20060809212124.GC3691@stusta.de> <1155160903.5729.263.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155160903.5729.263.camel@localhost.localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 11:01:43PM +0100, Alan Cox wrote:
> Ar Mer, 2006-08-09 am 23:21 +0200, ysgrifennodd Adrian Bunk:
> > It might be a bit out of the scope of this thread, but why do some many 
> > subsystems use the /dev/sd* namespace?
> > 
> > Real SCSI devices use it.
> > The USB mass storage driver uses it.
> 
> USB storage is real SCSI.

Real SCSI for a developer, for a user it's USB.

And things become even more confusing considering that the drive might 
show up as /dev/sda or /dev/uba depending on the driver used.

> > libata uses it.
> > 
> > I'd expext SATA or PATA devices at /dev/hd* or perhaps at /dev/ata* - 
> > but why are they at /dev/sd*?
> 
> ATA uses the top half of the scsi stack so ends up using the top layer
> scsi drivers. Its probably more efficient than writing new driver
> clones, especially as non disk ATA is also real SCSI (or very close).

You are talking about kernel<->kernel and kernel<->hardware interfaces.

I'm more concerned about the kernel<->userspace interface.

> You can use /dev/ata if you want - its just a udev problem ;)

Or by adding some manual links if using a static /dev.

But I'm still not getting the point why the /dev/sd* namespace has to be 
used.

> Alan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

