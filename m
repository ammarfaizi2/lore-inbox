Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbTCaJxr>; Mon, 31 Mar 2003 04:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261555AbTCaJxr>; Mon, 31 Mar 2003 04:53:47 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:60648 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261550AbTCaJxq>; Mon, 31 Mar 2003 04:53:46 -0500
Date: Mon, 31 Mar 2003 12:05:03 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Peter Waechtler <pwaechtler@mac.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] fix sound/oss/ics2101.c compilation
Message-ID: <20030331100503.GD22827@fs.tum.de>
References: <20030321201012.GO6940@fs.tum.de> <1048443066.1936.2.camel@picklock> <20030330093048.GF10005@fs.tum.de> <1049068012.2798.13.camel@picklock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049068012.2798.13.camel@picklock>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 02:04:04AM +0200, Peter Waechtler wrote:
> 
> There's a problem when compiling the GUS driver into the kernel
> instead of as a module. I renamed the global "lock" to "gus_lock"
> and made sure that it's used (shared by gus_midi, gus_wave, ics2101)
> 
> [snippet of sound/oss/Makefile]
> obj-$(CONFIG_SOUND_GUS)         += gus.o ad1848.o
> gus-objs        := gus_card.o gus_midi.o gus_vol.o gus_wave.o ics2101.o
> 
> 
> Adrian: Do you have a GUS and can test this?

Unfortunately not, I noticed this problem while doing compile-only tests 
with a .config that has as much as possible enabled.

BTW:
The sound/oss/mad16.c part of your patch doesn't belong to this problem?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

