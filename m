Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267921AbUHPT56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267921AbUHPT56 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 15:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267922AbUHPT55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 15:57:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:14797 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267921AbUHPT5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 15:57:41 -0400
Date: Mon, 16 Aug 2004 21:57:33 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: menuconfig displays dependencies [Was: select FW_LOADER -> depends HOTPLUG]
Message-ID: <20040816195733.GZ1387@fs.tum.de>
References: <20040809203840.GB19748@mars.ravnborg.org> <Pine.LNX.4.58.0408100130470.20634@scrub.home> <20040810084411.GI26174@fs.tum.de> <20040810211656.GA7221@mars.ravnborg.org> <Pine.LNX.4.58.0408120027330.20634@scrub.home> <20040814074953.GA20123@mars.ravnborg.org> <20040814210523.GG1387@fs.tum.de> <Pine.LNX.4.61.0408151932370.12687@scrub.home> <20040815174028.GM1387@fs.tum.de> <Pine.LNX.4.61.0408160043270.12687@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0408160043270.12687@scrub.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 12:47:05AM +0200, Roman Zippel wrote:
> Hi,
> 
> On Sun, 15 Aug 2004, Adrian Bunk wrote:
> 
> > And what's the correct handling of dependencies the selected symbol has?
> > 
> > FW_LOADER depends on HOTPLUG, and this was the issue that started the 
> > whole thread.
> 
> The use of select is already a crotch here, so there's no real correct 
> handling. There are a few possibilities:
> - if you select FW_LOADER, you have to select HOTPLUG too
> - if you select FW_LOADER, you have to depend on HOTPLUG
> - FW_LOADER itself can select HOTPLUG

Solution 2 is what my patch tried.

Thinking about them, I'd prefer solution 3. But with solution 1 or 3, 
I'm sure people like Russell King will scream since this will make it 
non-trivial to de-select HOTPLUG.

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

