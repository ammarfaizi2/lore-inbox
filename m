Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266890AbUHOUqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266890AbUHOUqJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 16:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266891AbUHOUqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 16:46:09 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25800 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266890AbUHOUqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 16:46:03 -0400
Date: Sun, 15 Aug 2004 22:45:55 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: menuconfig displays dependencies [Was: select FW_LOADER -> depends HOTPLUG]
Message-ID: <20040815204555.GS1387@fs.tum.de>
References: <20040809203840.GB19748@mars.ravnborg.org> <Pine.LNX.4.58.0408100130470.20634@scrub.home> <20040810084411.GI26174@fs.tum.de> <20040810211656.GA7221@mars.ravnborg.org> <Pine.LNX.4.58.0408120027330.20634@scrub.home> <20040814074953.GA20123@mars.ravnborg.org> <20040814210523.GG1387@fs.tum.de> <20040814223749.GA7243@mars.ravnborg.org> <20040815202111.GR1387@fs.tum.de> <20040815203245.GA14336@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040815203245.GA14336@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 10:32:45PM +0200, Sam Ravnborg wrote:
> On Sun, Aug 15, 2004 at 10:21:11PM +0200, Adrian Bunk wrote:
> > > CONFIG_FOO
> > > 
> > > Depends on:
> > > CONFIG_BAR: [ ] "Prompt for BAR"
> > 
> > 
> > Assuming I'm configuring a kernel for i386, what should I see when 
> > pressing 'd' on the following driver?
> > 
> > 
> > config OAKNET
> >         tristate "National DP83902AV (Oak ethernet) support"
> >         depends on NET_ETHERNET && PPC && BROKEN
> >         select CRC32
> > 
> What about:
> Depends on:
>   [ ] "Prompt for NET_ETHERNET"	(CONFIG_NET_ETHERNET)
>   --- "Promt ..." (CONFIG_PPC)
>   --- " Prompt ... " (CONFIG_BROKEN)

CONFIG_BROKEN is available.

And in other cases, e.g. I2C_ALGOBIT might be a dependency, but depends 
itself on I2C which might be disabled.

> Selects
>   "Prompt for CRC32)" (CONFIG_CRC32)
> 
> That would make sense to me at least.

Showing all !i386 drivers on i386 will make it harder for people to find 
the drivers they actually need.

> If I ever look into it I will touch upon the corner cases for sure.

Thanks.

BTW:
"make oldconfig" will need a similar treatment before we can start 
changing selects to depends.

> 	Sam

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

