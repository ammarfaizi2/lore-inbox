Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261922AbSJIR35>; Wed, 9 Oct 2002 13:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261921AbSJIR35>; Wed, 9 Oct 2002 13:29:57 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26129 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261922AbSJIR34>; Wed, 9 Oct 2002 13:29:56 -0400
Date: Wed, 9 Oct 2002 10:37:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.8
In-Reply-To: <20021009191600.A1708@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0210091033200.7355-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Oct 2002, Sam Ravnborg wrote:
> 
> Another suggestion about naming:
> Take for example drivers/net:
> cat Config.* | wc => 2149 lines
> 
> A bit a structure could be needed here.
> Net.conf  <= Name equals directory with upper-case first letter
> 	- Cover the whole directory, and either implicit
> 	  or explicit include other .conf files in that directory
> 3c5xx.conf <= All the configuration for the 3c5xxx chipset drivers
> rrunner.conf <= All configuration for rrunner driver

Good point. Splitting up the big Config.in files is a good idea anyway, 
and it becomes even more important when the Config.help information was 
included in the file.

However, I disagree with the naming - I'd rather have one common name for
the "main" directory entry than have magic rules like "basename of the
directory capitalized". I don't want to have to search for it.

I also think I'd perfer to have them all start with the same thing, so 
that (again) it's clear when a directory has multiple configuration files. 

So instead: how about just "Config" for the main per-directory
configuration file, with sub-config's being "Config.3c5xx" and
"Config.rrunner".

		Linus

