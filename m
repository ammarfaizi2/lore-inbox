Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266841AbSKHRfZ>; Fri, 8 Nov 2002 12:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266842AbSKHRfZ>; Fri, 8 Nov 2002 12:35:25 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43791 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266841AbSKHRfW>; Fri, 8 Nov 2002 12:35:22 -0500
Date: Fri, 8 Nov 2002 17:41:53 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Mackerras <paulus@samba.org>, Jens Axboe <axboe@suse.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       benh@kernel.crashing.org
Subject: Re: [PATCH] Fix typo in sl82c105.c driver
Message-ID: <20021108174153.B24905@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Paul Mackerras <paulus@samba.org>, Jens Axboe <axboe@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	benh@kernel.crashing.org
References: <15817.54799.955377.260781@argo.ozlabs.ibm.com> <1036777109.16651.43.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1036777109.16651.43.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Fri, Nov 08, 2002 at 05:38:29PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 05:38:29PM +0000, Alan Cox wrote:
> On Thu, 2002-11-07 at 02:55, Paul Mackerras wrote:
> > This patch fixes a minor typo in sl82c105.c which stops it from
> > compiling.
> > 
> > Jens and/or Linus, please apply.
> > 
> > Paul.
> > 
> > diff -urN linux-2.5/drivers/ide/pci/sl82c105.c pmac-2.5/drivers/ide/pci/sl82c105.c
> > --- linux-2.5/drivers/ide/pci/sl82c105.c	2002-10-12 14:40:28.000000000 +1000
> > +++ pmac-2.5/drivers/ide/pci/sl82c105.c	2002-10-30 12:32:48.000000000 +1100
> > @@ -284,7 +284,7 @@
> >  
> >  static int __devinit sl82c105_init_one(struct pci_dev *dev, const struct pci_device_id *id)
> >  {
> > -	ide_pci_device_t *d = &slc82c105_chipsets[id->driver_data];
> > +	ide_pci_device_t *d = &sl82c105_chipsets[id->driver_data];
> >  	if (dev->device != d->device)
> >  		BUG();
> >  	ide_setup_pci_device(dev, d);
> 
> Looks good to me

It may look good.  Shame that the DMA state machine gets screwed if you
have an ATAPI device on either channel, and needs code to reset it prior
to issuing a command.

Sorry, I've not been able to push the fixes forward yet.  Its on my todo
list though.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

