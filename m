Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266893AbUHOUYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266893AbUHOUYj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 16:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266883AbUHOUYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 16:24:39 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:17097 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266893AbUHOUVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 16:21:18 -0400
Date: Sun, 15 Aug 2004 22:21:11 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: menuconfig displays dependencies [Was: select FW_LOADER -> depends HOTPLUG]
Message-ID: <20040815202111.GR1387@fs.tum.de>
References: <20040809195656.GX26174@fs.tum.de> <20040809203840.GB19748@mars.ravnborg.org> <Pine.LNX.4.58.0408100130470.20634@scrub.home> <20040810084411.GI26174@fs.tum.de> <20040810211656.GA7221@mars.ravnborg.org> <Pine.LNX.4.58.0408120027330.20634@scrub.home> <20040814074953.GA20123@mars.ravnborg.org> <20040814210523.GG1387@fs.tum.de> <20040814223749.GA7243@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040814223749.GA7243@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 12:37:49AM +0200, Sam Ravnborg wrote:
> 
> If I ever find time to look into it then my plan is to give
> the user the possibility to see _all_ menus + symbols with a prompt.
> 
> And for all symbols with a promt and with dependency information
> to let the user enable a pop up window giving the possibility
> to select all "Depends on" symbols.
> 
> 
> 
> So consider:
> config FOO
> 	depends on BAR
> 
> config BAR
> 	select BAZ
> 
> config BAZ
> 
> 
> Then when pressing 'd' on the FOO symbol (which is marked
> as invisible) the user will be prompted with:
> 
> CONFIG_FOO
> 
> Depends on:
> CONFIG_BAR: [ ] "Prompt for BAR"


Assuming I'm configuring a kernel for i386, what should I see when 
pressing 'd' on the following driver?


config OAKNET
        tristate "National DP83902AV (Oak ethernet) support"
        depends on NET_ETHERNET && PPC && BROKEN
        select CRC32



> ...
> 
> 	Sam

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

