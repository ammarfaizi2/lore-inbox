Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266678AbSKUNSb>; Thu, 21 Nov 2002 08:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266686AbSKUNSa>; Thu, 21 Nov 2002 08:18:30 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:57322 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266678AbSKUNS2>; Thu, 21 Nov 2002 08:18:28 -0500
Date: Thu, 21 Nov 2002 14:24:59 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 kconfig doesn't handle "&& m" correctly
Message-ID: <20021121132459.GC18869@fs.tum.de>
References: <20021121083912.GE11952@fs.tum.de> <Pine.LNX.4.44.0211211350270.2113-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211211350270.2113-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 01:57:30PM +0100, Roman Zippel wrote:

> Hi,

Hi Roman,

> On Thu, 21 Nov 2002, Adrian Bunk wrote:
> 
> > config SOUND_WAVEFRONT
> > 	tristate "Full support for Turtle Beach WaveFront (Tropez Plus, Tropez, Maui) synth/soundcards"
> > 	depends on SOUND_OSS && m
> > ...
> > 
> > <--  snip  -->
> > 
> > 
> > It seems the "&& m" (a common way to ensure that something can only be
> > built modular) isn't handled correctly.
> 
> Did you disable modules? When modules are disabled tristate symbols are 

yes, this was with a .config without modules support.

> treated like booleans, that means they are visible if the dependencies are 
> different than 'n'. For this it should be possible to automatically add 
> '&& MODULES' if the parser sees a 'm'. I'll have to check this out.

My first thought is that this sounds like a workaround. Is there a good
reason not to restore the semantics of the old kconfig that interpreted
dependencies as a restriction of the input range?

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

