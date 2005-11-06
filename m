Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbVKFLRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVKFLRq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 06:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVKFLRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 06:17:46 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12304 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932361AbVKFLRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 06:17:45 -0500
Date: Sun, 6 Nov 2005 12:17:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/video/: possible cleanups
Message-ID: <20051106111743.GA3847@stusta.de>
References: <20051106005026.GE3668@stusta.de> <436D9AF3.8040008@pol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436D9AF3.8040008@pol.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 01:56:03PM +0800, Antonino A. Daplas wrote:
> Adrian Bunk wrote:
> > This patch contains the possible cleanups including the following:
> > - every file should #include the headers containing the prototypes for
> >   it's global functions
> > - make needlessly global functions static
> > - kyro/STG4000Interface.h: #include video/kyro.h and linux/pci.h
> >   instead of a manual "struct pci_dev"
> > - i810_main.{c,h}: prototypes for static functions belong to the
> >                    C file
> > 
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > ---
> > 
> >  drivers/video/arcfb.c                     |    8 +--
> >  drivers/video/console/softcursor.c        |    2 
> >  drivers/video/i810/i810-i2c.c             |    1 
> >  drivers/video/i810/i810_accel.c           |    1 
> >  drivers/video/i810/i810_gtf.c             |    1 
> >  drivers/video/i810/i810_main.c            |   51 ++++++++++++++++++--
> >  drivers/video/i810/i810_main.h            |   56 +---------------------
> >  drivers/video/kyro/STG4000InitDevice.c    |    1 
> >  drivers/video/kyro/STG4000Interface.h     |    3 -
> >  drivers/video/kyro/STG4000OverlayDevice.c |    1 
> >  drivers/video/matrox/matroxfb_g450.c      |    2 
> >  drivers/video/nvidia/nv_hw.c              |    1 
> >  drivers/video/tdfxfb.c                    |    2 
> >  13 files changed, 68 insertions(+), 62 deletions(-)
> > 
> > --- linux-2.6.14-rc5-mm1-full/drivers/video/console/softcursor.c.old	2005-11-06 00:31:15.000000000 +0100
> > +++ linux-2.6.14-rc5-mm1-full/drivers/video/console/softcursor.c	2005-11-06 00:31:30.000000000 +0100
> > @@ -17,6 +17,8 @@
> >  #include <asm/uaccess.h>
> >  #include <asm/io.h>
> >  
> > +#include "fbcon.h"
> 
> I don't think softcursor needs anything in fbcon.h. The rest looks okay.

fbcon.h contains the function prototype for soft_cursor().

> Tony

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

