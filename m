Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282400AbRLDRsR>; Tue, 4 Dec 2001 12:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281228AbRLDRqz>; Tue, 4 Dec 2001 12:46:55 -0500
Received: from host5.mileniumnet.com.br ([200.199.222.5]:29709 "EHLO
	strauss.mileniumnet.com.br") by vger.kernel.org with ESMTP
	id <S283218AbRLDRpY>; Tue, 4 Dec 2001 12:45:24 -0500
Date: Tue, 4 Dec 2001 14:55:26 -0200 (BRST)
From: Thiago Rondon <maluco@mileniumnet.com.br>
X-X-Sender: <maluco@freak.linuxms.com.br>
To: Michael Zhu <apiggyjj@yahoo.ca>
cc: Tyler BIRD <BIRDTY@uvsc.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: Insmod problems
In-Reply-To: <20011204170642.78487.qmail@web20209.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33L.0112041454390.2229-100000@freak.linuxms.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


_KERNEL_ != __KERNEL__

gcc -D__KERNEL__ -DMODULE -c hello.c

> gcc -D_KERNEL_ -DMODULE -c hello.c
>
> --- Tyler BIRD <BIRDTY@uvsc.edu> wrote:
> > You need to define the __KERNEL__ and MODULE symbols
> >
> > #define __KERNEL__
> > #define MODULE
> >
> >
> > >>> Nav Mundi <nmundi@karthika.com> 12/04/01 09:33AM
> > >>>
> > What are we doing wrong? - Nav & Michael
> > **************************************************
> >
> > hello.c Source:
> >
> > #include "/home/mzhu/linux/include/linux/config.h"
> > /*retrieve the CONFIG_* macros */
> > #if defined(CONFIG_MODVERSIONS) &&
> > !defined(MODVERSIONS)
> > #define MODVERSIONS  /* force it on */
> > #endif
> >
> > #ifdef MODVERSIONS
> > #include
> > "/home/mzhu/linux/include/linux/modversions.h"
> > #endif
> >
> > #include "/home/mzhu/linux/include/linux/module.h"
> >
> > int init_module(void)  { printk("<1>Hello,
> > world\n");  return 0; }
> > void cleanup_module(void) { printk("<1>Goodbye cruel
> > world\n"); }
> >
> > Output:
> >
> > #>gcc -D_KERNEL_ -DMODULE -c hello.c
> >
> > [This builds the hello.o file. ]
> >
> > #>insmod hello.o
> >
> > hello.o : unresolved symbol printk
> > hello.o : Note: modules without a GPL compatible
> > license cannot use
> > GPONLY_symbols
> >
> >
> >
> >
> > -
> > To unsubscribe from this list: send the line
> > "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>
> ______________________________________________________
> Send your holiday cheer with http://greetings.yahoo.ca
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

