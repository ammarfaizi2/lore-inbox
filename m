Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315630AbSFJSah>; Mon, 10 Jun 2002 14:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315720AbSFJSag>; Mon, 10 Jun 2002 14:30:36 -0400
Received: from mail.cafes.net ([207.65.182.3]:21448 "EHLO mail.cafes.net")
	by vger.kernel.org with ESMTP id <S315630AbSFJSae>;
	Mon, 10 Jun 2002 14:30:34 -0400
To: "Rui Sousa" <rui.p.m.sousa@clix.pt>, Cory Watson <gphat@cafes.net>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
From: gphat@cafes.net
Subject: Re: emu10k1, 2.5.21
Date: Mon, 10 Jun 2002 18:26:43 GMT
X-Originating-IP: 63.64.121.199
Message-Id: <20020610182643.B64856828AC8@mail.cafes.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, I'm sorry.  I didn't look for the difference. 
 
Thanks ;) 
 
> Cory Watson writes: 
>  
> This is for the ALSA emu10k1 driver, not the OSS. 
>  
> Rui Sousa 
>  
> > emu10k1 wouldn't compile for me, this patch fixes it via #including  
> > linux/init.h.  Perhaps this is the wrong way, but it works for me. 
> >  
> > Attached, and below: 
> >  
> > iff -urN a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c 
> > --- a/sound/pci/emu10k1/emufx.c Sun May  5 22:37:52 2002 
> > +++ b/sound/pci/emu10k1/emufx.c Sun Jun  9 15:04:01 2002 
> > @@ -29,6 +29,7 @@ 
> >  #include <sound/driver.h> 
> >  #include <linux/delay.h> 
> >  #include <linux/slab.h> 
> > +#include <linux/init.h> 
> >  #include <sound/core.h> 
> >  #include <sound/emu10k1.h> 
> >   
> > diff -urN a/sound/pci/emu10k1/emumixer.c 
b/sound/pci/emu10k1/emumixer.c 
> > --- a/sound/pci/emu10k1/emumixer.c Sun May  5 22:37:58 2002 
> > +++ b/sound/pci/emu10k1/emumixer.c Sun Jun  9 15:03:36 2002 
> > @@ -29,6 +29,7 @@ 
> >  #define __NO_VERSION__ 
> >  #include <sound/driver.h> 
> >  #include <linux/time.h> 
> > +#include <linux/init.h> 
> >  #include <sound/core.h> 
> >  #include <sound/emu10k1.h> 
> >   
> > diff -urN a/sound/pci/emu10k1/emumpu401.c 
b/sound/pci/emu10k1/emumpu401.c 
> > --- a/sound/pci/emu10k1/emumpu401.c Sun May  5 22:37:55 2002 
> > +++ b/sound/pci/emu10k1/emumpu401.c Sun Jun  9 15:01:36 2002 
> > @@ -22,6 +22,7 @@ 
> >  #define __NO_VERSION__ 
> >  #include <sound/driver.h> 
> >  #include <linux/time.h> 
> > +#include <linux/init.h> 
> >  #include <sound/core.h> 
> >  #include <sound/emu10k1.h> 
> >   
> > diff -urN a/sound/pci/emu10k1/emupcm.c 
b/sound/pci/emu10k1/emupcm.c 
> > --- a/sound/pci/emu10k1/emupcm.c Sun May  5 22:37:53 2002 
> > +++ b/sound/pci/emu10k1/emupcm.c Sun Jun  9 15:02:52 2002 
> > @@ -29,6 +29,7 @@ 
> >  #include <sound/driver.h> 
> >  #include <linux/slab.h> 
> >  #include <linux/time.h> 
> > +#include <linux/init.h> 
> >  #include <sound/core.h> 
> >  #include <sound/emu10k1.h> 
> >   
> > diff -urN -X dontdiff a/sound/pci/emu10k1/emuproc.c  
> > b/sound/pci/emu10k1/emuproc.c 
> > --- a/sound/pci/emu10k1/emuproc.c Sun May  5 22:37:59 2002 
> > +++ b/sound/pci/emu10k1/emuproc.c Sun Jun  9 15:03:15 2002 
> > @@ -28,6 +28,7 @@ 
> >  #define __NO_VERSION__ 
> >  #include <sound/driver.h> 
> >  #include <linux/slab.h> 
> > +#include <linux/init.h> 
> >  #include <sound/core.h> 
> >  #include <sound/emu10k1.h> 
> >   
> > --  
> > Cory 'G' Watson 
> >  
> > "You know the old saying -- any technology sufficiently advanced is  
> > indistinguishable from a Perl script." 
> >      - "Programming Perl", page 301 
>  
>  
>  
>  
>  
> -- 
> Crie o seu Email Grátis no Clix em 
> http://registo.clix.pt/ 
> 



