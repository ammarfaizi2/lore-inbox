Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266407AbSL2PaG>; Sun, 29 Dec 2002 10:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266411AbSL2PaG>; Sun, 29 Dec 2002 10:30:06 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6638 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266407AbSL2PaF>; Sun, 29 Dec 2002 10:30:05 -0500
Date: Sun, 29 Dec 2002 16:38:21 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Erik Andersen <andersen@codepoet.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, bcollins@debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix 2.4.x ieee1394
Message-ID: <20021229153821.GN27658@fs.tum.de>
References: <200212172033.gBHKX6A32611@hera.kernel.org> <20021222112613.GA8743@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021222112613.GA8743@codepoet.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 22, 2002 at 04:26:13AM -0700, Erik Andersen wrote:
> On Tue Dec 17, 2002 at 04:14:22PM +0000, linux-kernel wrote:
>...
> > --- a/drivers/ieee1394/Makefile	Tue Dec 17 12:33:07 2002
> > +++ b/drivers/ieee1394/Makefile	Tue Dec 17 12:33:07 2002
> > @@ -2,11 +2,8 @@
> >  # Makefile for the Linux IEEE 1394 implementation
> >  #
> >  
> > -O_TARGET := ieee1394drv.o
> > -
> 
> After this change, firewire doesn't build for me when adding
> 1394 stuff directly into the kernel, i.e.
> 
>     CONFIG_IEEE1394=y
>     CONFIG_IEEE1394_OHCI1394=m
>     CONFIG_IEEE1394_SBP2=m
>     CONFIG_IEEE1394_RAWIO=y
> 
> The top level kernel Makefile has:
>     DRIVERS-$(CONFIG_IEEE1394) += drivers/ieee1394/ieee1394drv.o
> but there is no longer a ieee1394drv.o target.  This patch fixes 
> the problem.
>...

When I try 2.4.21-pre2 with your patch and the IEEE 1394 options you 
mention in your mail _nothing_ gets built inside the drivers/ieee1394 
directory and the error message at the final linking is:

<--  snip  -->

...
        -o vmlinux
ld: cannot open drivers/ieee1394/ieee1394.o: No such file or directory
make: *** [vmlinux] Error 1

<--  snip  -->


How did you manage to get a kernel that actually compiles?


>  -Erik

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

