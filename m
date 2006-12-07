Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032384AbWLGQml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032384AbWLGQml (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 11:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032394AbWLGQml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 11:42:41 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2283 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1032384AbWLGQmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 11:42:40 -0500
Date: Thu, 7 Dec 2006 17:42:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Michael Krufky <mkrufky@linuxtv.org>
Cc: mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] [2.6 patch] cx88/saa7134: remove unused -DHAVE_VIDEO_BUF_DVB
Message-ID: <20061207164245.GK8963@stusta.de>
References: <20061207150028.GJ8963@stusta.de> <457834E1.1090406@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457834E1.1090406@linuxtv.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 10:36:01AM -0500, Michael Krufky wrote:
> Adrian Bunk wrote:
> > This patch removes the unused HAVE_VIDEO_BUF_DVB define.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > --- linux-2.6.19-rc6-mm2/drivers/media/video/cx88/Makefile.old	2006-12-07 15:04:11.000000000 +0100
> > +++ linux-2.6.19-rc6-mm2/drivers/media/video/cx88/Makefile	2006-12-07 15:05:04.000000000 +0100
> > @@ -13,7 +13,6 @@
> >  EXTRA_CFLAGS += -Idrivers/media/dvb/dvb-core
> >  EXTRA_CFLAGS += -Idrivers/media/dvb/frontends
> >  
> > -extra-cflags-$(CONFIG_VIDEO_BUF_DVB) += -DHAVE_VIDEO_BUF_DVB=1
> >  extra-cflags-$(CONFIG_VIDEO_CX88_VP3054)+= -DHAVE_VP3054_I2C=1
> >  
> >  EXTRA_CFLAGS += $(extra-cflags-y) $(extra-cflags-m)
> > --- linux-2.6.19-rc6-mm2/drivers/media/video/saa7134/Makefile.old	2006-12-07 15:04:45.000000000 +0100
> > +++ linux-2.6.19-rc6-mm2/drivers/media/video/saa7134/Makefile	2006-12-07 15:04:58.000000000 +0100
> > @@ -15,6 +15,3 @@
> >  EXTRA_CFLAGS += -Idrivers/media/dvb/dvb-core
> >  EXTRA_CFLAGS += -Idrivers/media/dvb/frontends
> >  
> > -extra-cflags-$(CONFIG_VIDEO_BUF_DVB) += -DHAVE_VIDEO_BUF_DVB=1
> > -
> > -EXTRA_CFLAGS += $(extra-cflags-y) $(extra-cflags-m)
> 
> NACK.
> 
> HAVE_VIDEO_BUF_DVB is not "unused" ... This symbol is tested for in the
> following locations:
> 
> cx88.h:34:#ifdef HAVE_VIDEO_BUF_DVB
> cx88.h:327:#ifdef HAVE_VIDEO_BUF_DVB
> cx88.h:503:#ifdef HAVE_VIDEO_BUF_DVB
> cx88-i2c.c:157:#ifdef HAVE_VIDEO_BUF_DVB
> saa7134.h:51:#ifdef HAVE_VIDEO_BUF_DVB
> saa7134.h:569:#ifdef HAVE_VIDEO_BUF_DVB
> 
> ...We need this in order to allow compilation of the cx88 / saa7134 modules
> without DVB support. (analog only)
>...
 
Ah, you added them in v4l-dvb last year.

But they are neither in Linus' tree nor in the v4l-dvb git tree that is 
in the latest -mm.

Compilation of cx88 and saa7134 without DVB works fine in these trees, 
so what's the story behind this?

> Regards,
> 
> Michael Krufky

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

