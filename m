Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266540AbSKGNSv>; Thu, 7 Nov 2002 08:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266541AbSKGNSv>; Thu, 7 Nov 2002 08:18:51 -0500
Received: from surf.cadcamlab.org ([156.26.20.182]:14745 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S266540AbSKGNSu>; Thu, 7 Nov 2002 08:18:50 -0500
Date: Thu, 7 Nov 2002 07:22:45 -0600
To: Roman Zippel <zippel@linux-m68k.org>
Cc: kbuild-devel <kbuild-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [kbuild] Possibility to sanely link against off-directory .so
Message-ID: <20021107132245.GO4182@cadcamlab.org>
References: <20021106185230.GD5219@pasky.ji.cz> <20021106212952.GB1035@mars.ravnborg.org> <20021106220347.GE5219@pasky.ji.cz> <20021107100021.GL4182@cadcamlab.org> <Pine.LNX.4.44.0211071149200.13258-100000@serv> <20021107114747.GM4182@cadcamlab.org> <Pine.LNX.4.44.0211071258550.13258-100000@serv> <20021107123753.GN4182@cadcamlab.org> <Pine.LNX.4.44.0211071352270.13258-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211071352270.13258-100000@serv>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Roman Zippel]
> New features will be added and only the parser that comes with the kernel 
> will understand them. It's less likley that the library API will change.

Even if this is true - I'll grant you that it may be - let the vendor
package /usr/bin/qconf as a shell script that links /usr/lib/qconf.o
with -lqt and $(LINUX)/scripts/kconfig/libkconfig.a .  It's a little
unorthodox, but it removes the hackery of figuring out how HOSTCC is
supposed to build a shared library and whether any magic is needed at
runtime.  Removes the need for the horrible stuff libtool was invented
for, in other words.

Remember, the whole point of HOSTCC is to support a build environment
different from the compile target - arbitrarily different, even.

Peter
