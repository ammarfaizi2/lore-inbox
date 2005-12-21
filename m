Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbVLUWma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbVLUWma (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbVLUWma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:42:30 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39436 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964895AbVLUWm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:42:28 -0500
Date: Wed, 21 Dec 2005 23:42:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       James Courtier-Dutton <James@superbug.co.uk>,
       Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>,
       mchehab@brturbo.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] 2.6.15-rc6: boot failure in saa7134-alsa.c
Message-ID: <20051221224227.GD3917@stusta.de>
References: <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local> <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de> <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org> <43A86B20.1090104@superbug.co.uk> <Pine.LNX.4.64.0512201248481.4827@g5.osdl.org> <s5hpsnqzf86.wl%tiwai@suse.de> <Pine.LNX.4.64.0512211026190.4827@g5.osdl.org> <s5hwthyxoz1.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hwthyxoz1.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 07:52:02PM +0100, Takashi Iwai wrote:
> At Wed, 21 Dec 2005 10:32:41 -0800 (PST),
> Linus Torvalds wrote:
>...
> > > So, a "safe" solution for the time being appears to be either
> > > - to look through the whole codes and adjust *_initcall() levels,
> > > - to force to build saa7134-alsa as a module, or
> > > - to move saa7134-alsa.c to sound/ directory.
> > 
> > Well, you dropped the easiest: make saa7134 just use "late_initcall()".
> > 
> > It's not "correct", but it's certainly no less correct than just forcing a 
> > driver to be moved for link order reasons.
> 
> Yep, that's obviously the easiest one.  I'd vote for this, at least
> for 2.6.15, once after it's confirmed to work.

I've already stated somewhere in this thread that this did fix it for 
me.

> Takashi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

