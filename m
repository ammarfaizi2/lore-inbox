Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbVLDP2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbVLDP2Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 10:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbVLDP2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 10:28:25 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16400 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932253AbVLDP2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 10:28:24 -0500
Date: Sun, 4 Dec 2005 16:28:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Helge Hafting <helgehaf@aitel.hist.no>,
       Jeff Garzik <jgarzik@pobox.com>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tejun Heo <htejun@gmail.com>
Subject: Re: Linux 2.6.15-rc3 problem found - scsi order changed
Message-ID: <20051204152825.GP31395@stusta.de>
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org> <20051129213656.GA8706@aitel.hist.no> <Pine.LNX.4.64.0511291340340.3029@g5.osdl.org> <438D69FF.2090002@aitel.hist.no> <438EB150.2090502@pobox.com> <20051204004302.GA2188@aitel.hist.no> <Pine.LNX.4.64.0512031702110.3099@g5.osdl.org> <Pine.LNX.4.64.0512040110280.27389@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512040110280.27389@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 01:34:18AM -0800, Zwane Mwaikambo wrote:
> On Sat, 3 Dec 2005, Linus Torvalds wrote:
> 
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index fac1e16..ea410b6 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -5,7 +5,7 @@
> >  # Rewritten to use lists instead of if-statements.
> >  #
> >  
> > -obj-$(CONFIG_PCI)		+= pci/ usb/
> > +obj-$(CONFIG_PCI)		+= pci/
> >  obj-$(CONFIG_PARISC)		+= parisc/
> >  obj-$(CONFIG_RAPIDIO)		+= rapidio/
> >  obj-y				+= video/
> > @@ -49,6 +49,7 @@ obj-$(CONFIG_ATA_OVER_ETH)	+= block/aoe/
> >  obj-$(CONFIG_PARIDE) 		+= block/paride/
> >  obj-$(CONFIG_TC)		+= tc/
> >  obj-$(CONFIG_USB)		+= usb/
> > +obj-$(CONFIG_PCI)		+= usb/
> >  obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
> >  obj-$(CONFIG_GAMEPORT)		+= input/gameport/
> >  obj-$(CONFIG_INPUT)		+= input/
> 
> Yes that fixed it, but why walk into usb/ on CONFIG_PCI?

Because of drivers/usb/host/pci-quirks.c .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

