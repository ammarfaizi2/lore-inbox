Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262457AbSKMUui>; Wed, 13 Nov 2002 15:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262528AbSKMUui>; Wed, 13 Nov 2002 15:50:38 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:33550 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262457AbSKMUuh>; Wed, 13 Nov 2002 15:50:37 -0500
Date: Wed, 13 Nov 2002 21:57:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp for 2.5.47 [not for inclusion]
Message-ID: <20021113205727.GB24922@atrey.karlin.mff.cuni.cz>
References: <76C83295DE1@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76C83295DE1@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This is patch I'm using. With this swsusp in 2.5.47 should work.
> > 
> > --- clean/arch/i386/kernel/Makefile 2002-11-12 18:40:26.000000000 +0100
> > +++ linux-swsusp/arch/i386/kernel/Makefile  2002-11-12 22:22:53.000000000 +0100
> > @@ -24,7 +24,7 @@
> >  obj-$(CONFIG_X86_MPPARSE)  += mpparse.o
> >  obj-$(CONFIG_X86_LOCAL_APIC)   += apic.o nmi.o
> >  obj-$(CONFIG_X86_IO_APIC)  += io_apic.o
> > -obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
> > +obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o suspend_asm.o
> >  obj-$(CONFIG_X86_NUMAQ)        += numaq.o
> >  obj-$(CONFIG_PROFILING)        += profile.o
> >  obj-$(CONFIG_EDD)              += edd.o
> 
> With 2.5.47-bk-current, your patch is apparently included.

Thanx for info.

> I had to modify this Makefile (in 2.5.47-bk) to include suspend.o 
> unconditionally because of saved_* is declared here, and they are 
> needed by ACPI. Of course, it is also possible to do
> 
> obj-$(CONFIG_ACPI_SLEEP) += acpi_wakeup.o suspend.o

Uff. Right. I'll have to deal with that somehow. Thanx.

...

...

CONFIG_ACPI_SLEEP should imply CONFIG_SOFTWARE_SUSPEND is
enabled. I'll have to check those configs...
							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
