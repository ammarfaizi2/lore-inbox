Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVL2NX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVL2NX5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 08:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbVL2NX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 08:23:57 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:35087 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750721AbVL2NX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 08:23:57 -0500
Date: Thu, 29 Dec 2005 14:23:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz,
       alsa-devel@alsa-project.org
Subject: Re: 2.6.15-rc6: known regressions in the kernel Bugzilla
Message-ID: <20051229132355.GA3811@stusta.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org> <20051222011320.GL3917@stusta.de> <20051222071557.GA17346@suse.de> <s5hpsnpxrqw.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hpsnpxrqw.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 01:04:23PM +0100, Takashi Iwai wrote:
> At Wed, 21 Dec 2005 23:15:57 -0800,
> Greg KH wrote:
> > 
> > On Thu, Dec 22, 2005 at 02:13:20AM +0100, Adrian Bunk wrote:
> > > The following bug in the kernel Bugzilla contains a regressions in 
> > > 2.6.15-rc without a patch:
> > > - #5760 No sound with snd_intel8x0 & ALi M5455 chipset
> > >         (kobject_register failed)
> > 
> > We put code in the kobjet to report when callers fail, due to problems
> > in them, and the kobject code is blamed...
> > 
> > Looks like a sound driver issue, nothing has changed in the kobject
> > code.
> 
> But there is no relevant change in sound stuff between 2.6.15-rc4 and
> rc6 (except for minor fix of OSS drivers).  If it really worked with
> 2.6.15-rc4, something else got broken.

I don't know whether this is related to the problem, but the code giving 
the "AC'97 1 does not respond - RESET" warning that is present in both 
the working and the non-working cases for the submitter looks a bit 
fragile.

> Takashi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

