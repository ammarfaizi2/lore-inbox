Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUHNVFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUHNVFe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 17:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUHNVFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 17:05:34 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25086 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266155AbUHNVFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 17:05:31 -0400
Date: Sat, 14 Aug 2004 23:05:24 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: menuconfig displays dependencies [Was: select FW_LOADER -> depends HOTPLUG]
Message-ID: <20040814210523.GG1387@fs.tum.de>
References: <20040809195656.GX26174@fs.tum.de> <20040809203840.GB19748@mars.ravnborg.org> <Pine.LNX.4.58.0408100130470.20634@scrub.home> <20040810084411.GI26174@fs.tum.de> <20040810211656.GA7221@mars.ravnborg.org> <Pine.LNX.4.58.0408120027330.20634@scrub.home> <20040814074953.GA20123@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040814074953.GA20123@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 09:49:53AM +0200, Sam Ravnborg wrote:
> On Thu, Aug 12, 2004 at 01:05:47AM +0200, Roman Zippel wrote:
>  
> > > It would be nice in menuconfig to see what config symbol
> > > that has dependencies and/or side effects. 
> > 
> > xconfig has something like this, if you enable 'Debug Info', although it 
> > rather dumps the internal representation.
> > Adding something like this to menuconfig, would mean hacking lxdialog, 
> > which is rather at the bottom of the list of things I want to do. :)
> 
> Did a quick hack on this.
> When choosing help on "HCI BlueFRITZ! USB driver" menuconfig now displays:
> 
> -------------------------------------------------
> Depends on (select to enable this option):
> BT & USB
> Selects (will be enabled by this option): 
> FW_LOADER
>...
 
Unless I misunderstood Roman, FW_LOADER should be no longer selected.

But if the dependencies of BT_HCIBFUSB were
  depends on BT && USB && FW_LOADER
the dependency information was useless since the option itself isn't 
shown for FW_LOADER=n.

And even if the option was shown:
How should an average sysadmin configuring his own kernel know where on 
earth the FW_LOADER option is he has to enable?

> 	Sam
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

