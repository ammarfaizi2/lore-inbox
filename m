Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267937AbUHPUXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267937AbUHPUXD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 16:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267939AbUHPUXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 16:23:03 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:30924 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267937AbUHPUXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 16:23:00 -0400
Date: Mon, 16 Aug 2004 22:22:53 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: menuconfig displays dependencies [Was: select FW_LOADER -> depends HOTPLUG]
Message-ID: <20040816202253.GC1387@fs.tum.de>
References: <20040810084411.GI26174@fs.tum.de> <20040810211656.GA7221@mars.ravnborg.org> <Pine.LNX.4.58.0408120027330.20634@scrub.home> <20040814074953.GA20123@mars.ravnborg.org> <20040814210523.GG1387@fs.tum.de> <Pine.LNX.4.61.0408151932370.12687@scrub.home> <20040815174028.GM1387@fs.tum.de> <Pine.LNX.4.61.0408160043270.12687@scrub.home> <20040816195733.GZ1387@fs.tum.de> <20040816210729.A25893@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040816210729.A25893@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 09:07:30PM +0100, Russell King wrote:
> 
> Let me make my position over the use of "select" clear: I do not
> oppose its appropriate use, where that is defined as selecting
> another configuration option for which the user has no visibility.
> 
> In the above case, it _may_ make sense (I haven't looked deeply
> into it yet) to:
> 
> - make _all_ drivers which need FW_LOADER select it
> - make _all_ drivers which currently depend on HOTPLUG select it
> - make FW_LOADER select HOTPLUG
> - remove user questions for FW_LOADER and HOTPLUG
> 
> That means that FW_LOADER and HOTPLUG are automatically selected
> whenever the configuration requires them and are automatically
> deselected when it doesn't need them, and you don't have to worry
> about whether you can disable them now or after finding the
> thousand and one configuration symbols which need to be turned off
> first.
> 
> However, keeping the option user-visible _and_ using select is
> problematical to say the least.

Currently, I see no good alternative to e.g. USB_STORAGE selecting SCSI.
Enhanchements to _all_ kernel configuration tools are required before 
this can be changed.

But it still leaves the problem that modules not included in the kernel  
might require the functionality provided by such an option.
Even CRC32 is user-visible.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

