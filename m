Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265220AbSJWVur>; Wed, 23 Oct 2002 17:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265251AbSJWVur>; Wed, 23 Oct 2002 17:50:47 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:11261 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S265220AbSJWVuo>;
	Wed, 23 Oct 2002 17:50:44 -0400
Date: Wed, 23 Oct 2002 14:55:13 -0700
To: "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>
Cc: linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net
Subject: Re: 2.5.42: IrDA issues
Message-ID: <20021023215513.GB24788@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <7886757.1035409088586.JavaMail.nobody@web155>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7886757.1035409088586.JavaMail.nobody@web155>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 01:38:08PM -0800, ALESSANDRO.SUARDI wrote:
> > On Mon, Oct 21, 2002 at 11:19:35AM +0200, Alessandro Suardi wrote:
> > > Jean Tourrilhes wrote:
> 
> [snip]
> 
> > > Will provide irdadump stuff soon[-ish], I'm wading through a backlog
> > >  of, uhm, too much email. The short-form report really meant "is this
> > >  a known issue ?"...
> >      irtty is busted, that's why I asked for the driver you are
> > using (its clearly a driver issue). I believe smc-ircc and irport are
> > sick as well.
> > > Anyway - the box is a Dell Latitude CPx750J with this:
> > > 
> > > [root@dolphin root]# findchip -v
> > > Found SMC FDC37N958FR Controller at 0x3f0, DevID=0x01, Rev. 1
> > >     SIR Base 0x3e8, FIR Base 0x290
> > >     IRQ = 4, DMA = 3
> > >     Enabled: yes, Suspended: no
> > >     UART compatible: yes
> > >     Half duplex delay = 3 us
> > > 
> > > So clearly I'm using smc-ircc.o.
> > > 
> > > (Of course I'll try and reproduce in 2.5.44 tonight or tomorrow).
> >      Stop ! Daniele Peri has just released a new version of the SMC
> > driver (smc-ircc2, link on my web page). I would like you to try this
> > new driver and report to me. I plan to push this new driver in the
> > kernel soon. So, don't waste too much time on the old driver.
> 
> Unfortunately I can't compile the new driver. I modified the Makefile to
>  comment out versioning (which i don't use) and change kernelversion
>  to an appropriate 2.5.44, but it fails like this:
> 
> In file included from /usr/src/linux-2.5.44/include/linux/irq.h:19,
>                  from /usr/src/linux-2.5.44/include/asm/hardirq.h:6,
>                  from /usr/src/linux-2.5.44/include/linux/interrupt.h:25,
>                  from /usr/src/linux-2.5.44/include/linux/netdevice.h:454,
>                  from smsc-ircc2.c:47:
> /usr/src/linux-2.5.44/include/asm/irq.h:16:25: irq_vectors.h: No such file or directory

	Wow ! That's a weird one.
	The file in question is in .../arch/i386/mach-generic/. You
may be able to modify the compile directive to add that to the
compilation (a "-I" argument).
	Alternatively, you can drop the source code directly in the
kernel (you just replace the old smc-ircc.o with the new one and
recompile).

> This happens with both drivers pointed by your page.
> Perhaps 2.5.44 is too new for this driver ?

	Ask Daniele...

> --alessandro

	Have fun...

	Jean
