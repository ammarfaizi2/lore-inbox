Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263887AbRFNSah>; Thu, 14 Jun 2001 14:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263894AbRFNSa1>; Thu, 14 Jun 2001 14:30:27 -0400
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:32775 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S263887AbRFNSa0>; Thu, 14 Jun 2001 14:30:26 -0400
Date: Thu, 14 Jun 2001 12:30:16 -0600
From: Michal Jaegermann <michal@harddata.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Michal Jaegermann <michal@harddata.com>, linux-kernel@vger.kernel.org
Subject: Re: Minor "cleanup" patches for 2.4.5-ac kernels
Message-ID: <20010614123016.B11134@mail.harddata.com>
In-Reply-To: <20010612183832.A29923@mail.harddata.com> <E15AbVD-00053n-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15AbVD-00053n-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jun 14, 2001 at 07:05:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2001 at 07:05:55PM +0100, Alan Cox wrote:
> > --- linux-2.4.5ac/drivers/pci/quirks.c~	Tue Jun 12 16:31:12 2001
> > +++ linux-2.4.5ac/drivers/pci/quirks.c	Tue Jun 12 17:13:18 2001
> > @@ -18,6 +18,7 @@
> >  #include <linux/pci.h>
> >  #include <linux/init.h>
> >  #include <linux/delay.h>
> > +#include <linux/sched.h>
> 
> Ok

Jeff Garzik had some comments here and other, architecture dependent,
propositions.

> >  
> > This one is replacing a symbol in sg.c to one which is exported
> > so 'sg.o' can be compiled as a valid module.
> 
> Export the right symbol on Alpha ?

I do not see how this one is Alpha specific.  Patches from 'ac' series
added one reference to 'simple_strtol' in drivers/scsi/sg.c. Sure, one
more symbol can be exported, but results of this call are used only as a
zero/non-zero flag so an already exported 'simple_strtoul' will serve
instead (or we have an extra export for _one_ call in the whole kernel).

  Michal
