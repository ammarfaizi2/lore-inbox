Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265462AbUHNWf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265462AbUHNWf3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 18:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbUHNWf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 18:35:29 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:30001 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S265462AbUHNWfV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 18:35:21 -0400
Date: Sun, 15 Aug 2004 00:37:49 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: menuconfig displays dependencies [Was: select FW_LOADER -> depends HOTPLUG]
Message-ID: <20040814223749.GA7243@mars.ravnborg.org>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20040809195656.GX26174@fs.tum.de> <20040809203840.GB19748@mars.ravnborg.org> <Pine.LNX.4.58.0408100130470.20634@scrub.home> <20040810084411.GI26174@fs.tum.de> <20040810211656.GA7221@mars.ravnborg.org> <Pine.LNX.4.58.0408120027330.20634@scrub.home> <20040814074953.GA20123@mars.ravnborg.org> <20040814210523.GG1387@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040814210523.GG1387@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 11:05:24PM +0200, Adrian Bunk wrote:
> 
> And even if the option was shown:
> How should an average sysadmin configuring his own kernel know where on 
> earth the FW_LOADER option is he has to enable?

If I ever find time to look into it then my plan is to give
the user the possibility to see _all_ menus + symbols with a prompt.
And for all symbols with a promt and with dependency information
to let the user enable a pop up window giving the possibility
to select all "Depends on" symbols.



So consider:
config FOO
	depends on BAR

config BAR
	select BAZ

config BAZ


Then when pressing 'd' on the FOO symbol (which is marked
as invisible) the user will be prompted with:

CONFIG_FOO

Depends on:
CONFIG_BAR: [ ] "Prompt for BAR"

...

	Sam
