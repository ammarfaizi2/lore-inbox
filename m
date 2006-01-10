Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWAJRIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWAJRIk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 12:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWAJRIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 12:08:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:42502 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932284AbWAJRIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 12:08:38 -0500
Date: Tue, 10 Jan 2006 18:08:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Alsa-devel] [2.6 patch] let SND_SUPPORT_OLD_API depend on SND_PCM
Message-ID: <20060110170836.GP3911@stusta.de>
References: <20060110164449.GN3911@stusta.de> <s5hmzi4f26q.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hmzi4f26q.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 06:00:29PM +0100, Takashi Iwai wrote:
> At Tue, 10 Jan 2006 17:44:49 +0100,
> Adrian Bunk wrote:
> > 
> > SND_SUPPORT_OLD_API only has an effect if SND_PCM is set.
> > 
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > --- linux-2.6.15-mm2-full/sound/core/Kconfig.old	2006-01-10 17:35:35.000000000 +0100
> > +++ linux-2.6.15-mm2-full/sound/core/Kconfig	2006-01-10 17:36:07.000000000 +0100
> > @@ -124,7 +124,7 @@
> >  
> >  config SND_SUPPORT_OLD_API
> >  	bool "Support old ALSA API"
> > -	depends on SND
> > +	depends on SND_PCM
> >  	default y
> >  	help
> >  	  Say Y here to support the obsolete ALSA PCM API (ver.0.9.0 rc3
> 
> Does it work?  CONFIG_SND_PCM is selected by the drivers.  So, it will
> be N until any drivers are selected.

It does work and "make oldconfig" handles it perfectly, but I understand 
your point that it might be accidentially set to N if a user later 
selects a driver in "make {menu,x}oldconfig", and that this case is most 
likely better handled without my patch.

> Takashi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

