Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbSKGPSR>; Thu, 7 Nov 2002 10:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261258AbSKGPSQ>; Thu, 7 Nov 2002 10:18:16 -0500
Received: from pasky.ji.cz ([62.44.12.54]:58107 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S261238AbSKGPSQ>;
	Thu, 7 Nov 2002 10:18:16 -0500
Date: Thu, 7 Nov 2002 16:24:54 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [kbuild] Possibility to sanely link against off-directory .so
Message-ID: <20021107152454.GH5219@pasky.ji.cz>
Mail-Followup-To: Peter Samuelson <peter@cadcamlab.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	kbuild-devel <kbuild-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <20021106185230.GD5219@pasky.ji.cz> <20021106212952.GB1035@mars.ravnborg.org> <20021106220347.GE5219@pasky.ji.cz> <20021107100021.GL4182@cadcamlab.org> <Pine.LNX.4.44.0211071149200.13258-100000@serv> <20021107114747.GM4182@cadcamlab.org> <Pine.LNX.4.44.0211071258550.13258-100000@serv> <20021107123753.GN4182@cadcamlab.org> <Pine.LNX.4.44.0211071352270.13258-100000@serv> <20021107132245.GO4182@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021107132245.GO4182@cadcamlab.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Thu, Nov 07, 2002 at 02:22:45PM CET, I got a letter,
where Peter Samuelson <peter@cadcamlab.org> told me, that...
> Remember, the whole point of HOSTCC is to support a build environment
> different from the compile target - arbitrarily different, even.

I'm a bit lost here - the kernel uses tons of gcc extensions - how is another
compiler supposed to understand them? And if it is specifically extended to
understand them, isn't it likely that it'll understand the -shared switch in
gcc-like way as well?

Or better, what other compiler is known to build a kernel than gcc? At least
anything that doesn't define __GNUC__ should IMHO fail inside of init/main.c.
And how likely is situation when someone want to configure a kernel with
non-gcc compiler and actually build it with gcc?

I thought that the point of HOSTCC is to allow to use a non-standart version
of gcc for kernel build.

-- 
 
				Petr "Pasky" Baudis
.
This host is a black hole at HTTP wavelengths. GETs go in, and nothing
comes out, not even Hawking radiation.
                -- Graaagh the Mighty on rec.games.roguelike.angband
.
Public PGP key && geekcode && homepage: http://pasky.ji.cz/~pasky/
