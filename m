Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290236AbSBKT3t>; Mon, 11 Feb 2002 14:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290249AbSBKT3f>; Mon, 11 Feb 2002 14:29:35 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:56582 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S290237AbSBKT2k>; Mon, 11 Feb 2002 14:28:40 -0500
Date: Mon, 11 Feb 2002 14:26:36 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Rohland <cr@sap.com>,
        Andries.Brouwer@cwi.nl, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <Pine.LNX.4.33L2.0202111010560.10878-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.3.96.1020211142113.642E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2002, Randy.Dunlap wrote:

> On Sat, 9 Feb 2002, Bill Davidsen wrote:
> 
> | On Wed, 6 Feb 2002, Randy.Dunlap wrote:
> |
> | > I still prefer your suggestion to append it to the kernel image
> | > as __initdata so that it's discarded from memory but can be
> | > read with some tool(s).
> |
> | The problem is that it make the kernel image larger, which lives in /boot
> | on many systems. Putting it in a module directory, even if not a module,
> | would be a better place for creative boot methods, of which there are
> | many.
> 
> Yes, it can add a few KB to a kernel image.
> Some people could think that it's worth it...especially
> if it's a build option.

The capability is definitely desirable, I think it's just implementation
being discussed.
 
> I prefer this to using /proc/config.gz (which SuSE currently does),
> since the config data won't be in permanent memory, and it's
> attached to a kernel image on disk -- the kernel doesn't have to
> be loaded in memory to view it.  (or maybe there's a way to
> view config.gz in a SuSE kernel image ?)
> 
> I don't see how making it a binary module (living in
> /lib/modules/version/kernel/configs.o e.g.) has any advantages
> over kbuild (?) just copying the .config file to
> /lib/modules/2.5.4/.config .

There are already uncompressed pure text files in the modules directory,
such as modules.dep. Adding one more is probably not a space issue on most
systems, while kernel size may be, since it has to be present at boot.

I don't have any issue with allowing a symbolic link in /proc down to the
config, if people want it there. I always Slink the /lib/modules/xxx dir
to /boot/Modules and the current symbols to /boot/System.map as well.
Links in known places are good.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

