Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264596AbSIVXEy>; Sun, 22 Sep 2002 19:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264609AbSIVXEy>; Sun, 22 Sep 2002 19:04:54 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:65042 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264596AbSIVXEx>; Sun, 22 Sep 2002 19:04:53 -0400
Date: Mon, 23 Sep 2002 01:07:36 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] linux kernel conf 0.6
In-Reply-To: <Pine.LNX.4.44.0209221744150.11808-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0209230102170.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 22 Sep 2002, Kai Germaschewski wrote:

> > One cosmetic thing I mentioned to Roman, Config.new needs to be changed
> > to something better, like conf.in or build.conf or somesuch.
>
> I agree. (But I'm not particularly good at coming up with names ;)
> build.conf is maybe not too bad considering that there may be a day where
> it is extended to support "<driver>.conf" as well.

Maybe it should start with a capital letter like Makefile/Config.in, so
it's at the top of a directory listing.

> I intentionally only printed a message and errored out in this case, and I
> think that's more useful, particularly for people doing
>
> make all 2>&1 > make.log
>
> which now may take forever waiting for input.

You should have tried this first :) :

$ make | cat
make[1]: Entering directory `/home/roman/src/linux-lkc/scripts'
make[1]: Leaving directory `/home/roman/src/linux-lkc/scripts'
make[1]: Entering directory `/home/roman/src/lc'
make[1]: `conf' is up to date.
make[1]: Leaving directory `/home/roman/src/lc'
./scripts/lkc/conf -s arch/i386/config.new
#
# using defaults found in .config
#
*
* Restart config...
*
Enable loadable module support (MODULES) [Y/n/?] y
  Set version information on all module symbols (MODVERSIONS) [N/y/?] (NEW) aborted!

Console input/output is redirected. Run 'make oldconfig' to update configuration.

make: *** [include/linux/autoconf.h] Error 1

bye, Roman

