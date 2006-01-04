Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbWADOlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbWADOlk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 09:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWADOlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 09:41:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56327 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932551AbWADOlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 09:41:39 -0500
Date: Wed, 4 Jan 2006 15:41:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20060104144137.GM3831@stusta.de>
References: <20060103215654.GH3831@stusta.de> <20060103221314.GB23175@irc.pl> <20060103231009.GI3831@stusta.de> <Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl> <20060104000344.GJ3831@stusta.de> <Pine.BSO.4.63.0601040113340.29027@rudy.mif.pg.gda.pl> <20060104010123.GK3831@stusta.de> <Pine.BSO.4.63.0601040242190.29027@rudy.mif.pg.gda.pl> <1136364634.22598.70.camel@localhost.localdomain> <20060104132139.GA5753@athame.dynamicro.on.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104132139.GA5753@athame.dynamicro.on.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 08:21:39AM -0500, Greg Louis wrote:
> On 20060104 (Wed) at 0850:34 +0000, Alan Cox wrote:
> > On Mer, 2006-01-04 at 03:51 +0100, Tomasz K??oczko wrote:
> > > Be compliant with OSS specyfication allow save many time on applications 
> > > development level by consume (in good sense) time spend on this 
> > > applications by *BSD, Solaris and other systems developers (even on not 
> > > open source applications).
> > 
> > Both Solaris and FreeBSD contain Linux emulation code so in that sense
> > they admitted 'defeat' long ago.
> > 
> > > valuable functionalities in usable/simpler form for joe-like users .. 
> > > remember: sound support in Linux isn't for data centers/big-ass-machines :)
> > 
> > And distributions nowdays ship with ALSA by default, which is giving
> > users far better audio timing behaviour, mixing they want, digital and
> > analogue 5.1 outputs. OSS really isn't ideal for serious "end user"
> > applications like video playback
> > 
> Ok, so I'm not serious :) just wanna do fairly standard audio things.
> 
> - ALSA doesn't (AFAIK, haven't checked for a few months) support my old
>   Audiotrix sound card -- bye, machine 1

Noone wants to remove the drivers for hardware not supported by ALSA 
from OSS.

After 4 years of ALSA in the kernel we are starting to remove the OSS 
drivers from the kernel where ALSA drives the same hardware.

We might end up with a handful of OSS drivers for some ancient 
soundcards without ALSA support and keep them similar to the old CD-ROM 
drivers under drivers/cdrom/ (or someone might write ALSA drivers for 
such hardware), but we don't need two drivers for the same hardware.

> - ALSA can't be persuaded (not by me, anyway) to drive my VIA
>   ac97_codec onboard sound hardware -- everything works fine except
>   unmuting ;) -- bye, machine 2

Can you give me a bug number in the ALSA bug tracking system for this 
issue to track it?

> - ALSA does suport my i810_audio ac97_codec laptop, but so does OSS,
>   equally well (for my unsophisticated needs) and with a far less
>   elephantine footprint in memory. -- strike 3, ALSA out.
>...

How much RAM does your system have that this is really an issue for you?

Sure, it would be possible to make ALSA a bit slimmer, but if you are 
running something like KDE or Mozilla or OpenOffice on your Laptop the 
size of the kernel shouldn't be a real issue.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

