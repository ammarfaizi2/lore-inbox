Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262654AbTCTWEb>; Thu, 20 Mar 2003 17:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbTCTWDT>; Thu, 20 Mar 2003 17:03:19 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:2944 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S262659AbTCTWCg>; Thu, 20 Mar 2003 17:02:36 -0500
Date: Thu, 20 Mar 2003 23:13:32 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Hank Leininger <hlein@progressive-comp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Deprecating .gz format on kernel.org
Message-ID: <20030320221332.GA13641@wohnheim.fh-wedel.de>
References: <200303202154.h2KLsDcT009516@marc2.theaimsgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200303202154.h2KLsDcT009516@marc2.theaimsgroup.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 March 2003 16:54:13 -0500, Hank Leininger wrote:
> On 2003-03-20, Joern Engel <joern () wohnheim ! fh-wedel ! de> wrote:
> 
> > That shouldn't matter, most of the times. If you want to build the
> > code, you have to [bg]unzip anyway, so there is no extra cost.
> > And I have a hard time to think of a real-world application where you
                                         ^^^^^^^^^^
> > don't want to unpack but need to verify the signature.
> 
> A few come to mind:

"Come to mind" doesn't sound line "that'd break our environment." ;)

> -To verify and then use a .tar.[bg]z2?, you must gpg --verify and then
>   tar -x[jz]vf, but to unpack, then verify, then use you must uncompress
>   to a tempfile or pipe to gpg, then verify, then untar.  Silly waste of
>   CPU and/or disk space.[*]

Veryfy and use are two action. You need a script or a human, changing
either one won't be hard.

> -Verifying downloads immediately, when they won't necessarily be needed /
>   used right away; no need to unpack until it's needed, but would like to
>   know the download is bad right away.

real-world?

> -Verifying something pulled down to one machine before scp'ing it elsewhere
>   where it will actually be used.

real-world?

> -Verifying before [bg]unzip means you won't expose [bg]unzip to likely
>   malicious data (think bugs in [bg]unzip which make them crash on bad
>   compressed files).  Of course GPG/PGP is still subject to input-based 
>   bugs, but they are in any case; no need for the decompression tools to
>   be as well.

Crashes don't matter. Exploits would, so that point is actually valid.

> [*] ...Now if tar had a --sig option to chain gpg between gunzip and 
>     untar... but that would just be Wrong.

unzip && checksig && tar?

Jörn

-- 
More computing sins are committed in the name of efficiency (without
necessarily achieving it) than for any other single reason - including
blind stupidity.
-- W. A. Wulf 
