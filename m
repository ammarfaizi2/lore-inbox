Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbULACgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbULACgs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 21:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbULACgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 21:36:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:51723 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261171AbULACgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 21:36:45 -0500
Date: Wed, 1 Dec 2004 03:36:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Manfred Schwarb <manfred99@gmx.ch>, chas@cmf.nrl.navy.mil,
       linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net
Subject: Re: [2.6 patch] Build Error 2: build of pca200e.bin fails
Message-ID: <20041201023643.GB2650@stusta.de>
References: <20041119100327.32511.6195.54797@tp-meteodat6.cyberlink.ch> <20041128192121.GE4390@stusta.de> <20041130170031.GD5009@dmt.cyclades>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041130170031.GD5009@dmt.cyclades>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 03:00:31PM -0200, Marcelo Tosatti wrote:
> On Sun, Nov 28, 2004 at 08:21:21PM +0100, Adrian Bunk wrote:
> > 
> > I have no problems with this patch, but shouldn't the same be done
> > in 2.6?
> > 
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > --- linux-2.6.10-rc2-mm3-full/drivers/atm/Makefile.old	2004-11-28 20:18:04.000000000 +0100
> > +++ linux-2.6.10-rc2-mm3-full/drivers/atm/Makefile	2004-11-28 20:18:15.000000000 +0100
> > @@ -68,4 +68,4 @@
> >  # deal with the various suffixes of the binary firmware images
> >  $(obj)/%.bin $(obj)/%.bin1 $(obj)/%.bin2: $(src)/%.data
> >  	objcopy -Iihex $< -Obinary $@.gz
> > -	gzip -df $@.gz
> > +	gzip -n -df $@.gz
> 
> Isnt it exactly the same of what has been merged in v2.4?
> 
> I can't see any difference.
> 
> [marcelo@dmt atm]$ bk diffs -u -r1.8 -r1.9 Makefile 
> ===== Makefile 1.8 vs 1.9 =====
> --- 1.8/drivers/atm/Makefile    Mon Jul 28 11:35:31 2003
> +++ 1.9/drivers/atm/Makefile    Mon Nov 22 21:54:09 2004
> @@ -92,7 +92,7 @@
>  # deal with the various suffixes of the binary firmware images
>  %.bin %.bin1 %.bin2: %.data
>         objcopy -Iihex $< -Obinary $@.gz
> -       gzip -df $@.gz
> +       gzip -n -df $@.gz
>  
>  fore_200e.o: $(fore_200e-objs)
>         $(LD) -r -o $@ $(fore_200e-objs)

It is exactly the same except for the patch context (note that in 2.6, 
the gzip is the last line of the Makefile).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

