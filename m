Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314056AbSERWfs>; Sat, 18 May 2002 18:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314057AbSERWfr>; Sat, 18 May 2002 18:35:47 -0400
Received: from ns.suse.de ([213.95.15.193]:8211 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314056AbSERWfq>;
	Sat, 18 May 2002 18:35:46 -0400
Date: Sun, 19 May 2002 00:35:46 +0200
From: Dave Jones <davej@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Drivers.conf and kbuild-2.5 [Was: kbuild 2.5 is ready ...]
Message-ID: <20020519003546.D15417@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Sam Ravnborg <sam@ravnborg.org>, Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.44.0205172157540.4117-100000@xanadu.home> <15163.1021688371@ocs3.intra.ocs.com.au> <20020519001434.A4153@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Does it make sense to introduce limited support for the drivers.conf idea
 > in kbuild-2.5 already now?

kbuild-2.5 is big enough to already be a problem to be accepted
'all in one go'. Adding driver.conf support will just make this problem
bigger. What Keith has already needs to somehow be done gradually.

How this happens isn't exactly obvious to me however. Due to the way
things like dependancy calculation have changed, you can't for example
do the merging on a per-directory basis and say "drivers this time",
"now the filesystems" etc..

Whilst kbuild2.5 lives happily with the old kbuild still being in the
tree, it doesn't support building one dir with newstyle, and another
with oldstyle. I don't even want to *think* about whats involved to
make that work, and I imagine Keith doesn't either.

 > The first step could be to support it in kbuild, next step could be to support
 > it in for example "make config" or even better mconfig from Michael Chastain.

Don't confuse the build system with the configuration system.
Whilst they are somewhat intertwined, they are not dependant on each other.
 
 > IMHO it would also be plain stupid to put a lot of effort in
 > supporting the old makefile syntax, when the files are already converted.

That effort has already been done. kbuild2.5 can live alongside the
existing build system.
 
 > --
 > Those that can, do.  Those that can't, troll on linux-kernel.

Sadly, all too true these days.

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
