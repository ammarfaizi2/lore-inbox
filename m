Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266903AbUHOUbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266903AbUHOUbD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 16:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUHOUa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 16:30:58 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:28541 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S266897AbUHOUaJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 16:30:09 -0400
Date: Sun, 15 Aug 2004 22:32:45 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: menuconfig displays dependencies [Was: select FW_LOADER -> depends HOTPLUG]
Message-ID: <20040815203245.GA14336@mars.ravnborg.org>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20040809195656.GX26174@fs.tum.de> <20040809203840.GB19748@mars.ravnborg.org> <Pine.LNX.4.58.0408100130470.20634@scrub.home> <20040810084411.GI26174@fs.tum.de> <20040810211656.GA7221@mars.ravnborg.org> <Pine.LNX.4.58.0408120027330.20634@scrub.home> <20040814074953.GA20123@mars.ravnborg.org> <20040814210523.GG1387@fs.tum.de> <20040814223749.GA7243@mars.ravnborg.org> <20040815202111.GR1387@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040815202111.GR1387@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 10:21:11PM +0200, Adrian Bunk wrote:
> > CONFIG_FOO
> > 
> > Depends on:
> > CONFIG_BAR: [ ] "Prompt for BAR"
> 
> 
> Assuming I'm configuring a kernel for i386, what should I see when 
> pressing 'd' on the following driver?
> 
> 
> config OAKNET
>         tristate "National DP83902AV (Oak ethernet) support"
>         depends on NET_ETHERNET && PPC && BROKEN
>         select CRC32
> 
What about:
Depends on:
  [ ] "Prompt for NET_ETHERNET"	(CONFIG_NET_ETHERNET)
  --- "Promt ..." (CONFIG_PPC)
  --- " Prompt ... " (CONFIG_BROKEN)

Selects
  "Prompt for CRC32)" (CONFIG_CRC32)

That would make sense to me at least.
If I ever look into it I will touch upon the corner cases for sure.

	Sam
