Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263166AbVG3TsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbVG3TsZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 15:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263143AbVG3TpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 15:45:24 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63247 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261487AbVG3ToY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 15:44:24 -0400
Date: Sat, 30 Jul 2005 21:44:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20050730194421.GJ5590@stusta.de>
References: <20050730165202.GI5590@stusta.de> <20050730110800.0db305f1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050730110800.0db305f1.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 11:08:00AM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > Currently, using an undeclared function gives a compile warning, but it 
> > can lead to a link or even a runtime error.
> > 
> > With -Werror-implicit-function-declaration, we are getting an immediate 
> > compile error instead.
> > 
> > This patch also removes some unneeded spaces between two tabs in the 
> > following line.
> > 
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > --- linux-2.6.13-rc3-mm3-full/Makefile.old	2005-07-30 13:55:32.000000000 +0200
> > +++ linux-2.6.13-rc3-mm3-full/Makefile	2005-07-30 13:55:56.000000000 +0200
> > @@ -351,7 +351,8 @@
> >  CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
> >  
> >  CFLAGS 		:= -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
> > -	  	   -fno-strict-aliasing -fno-common \
> > +		   -Werror-implicit-function-declaration \
> > +		   -fno-strict-aliasing -fno-common \
> >  		   -ffreestanding
> >  AFLAGS		:= -D__ASSEMBLY__
> >  
> 
> heh.  Nice idea, but if I merge this I'll have tons of monkey work to do
> to get ppc64, ia64 and others compiling :(

Looking at Jan's defconfig builds [1], I don't see this.

> umm, so what to do?  I'm inclined to just slam it in post-2.6.13 then take
> a week off or something.



cu
Adrian

[1] http://l4x.org/k/

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

