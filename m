Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263315AbTCTXXz>; Thu, 20 Mar 2003 18:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263316AbTCTXXz>; Thu, 20 Mar 2003 18:23:55 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:14979 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S263315AbTCTXXx>; Thu, 20 Mar 2003 18:23:53 -0500
Date: Fri, 21 Mar 2003 00:34:48 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Hank Leininger <hlein@progressive-comp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Deprecating .gz format on kernel.org
Message-ID: <20030320233448.GA10771@wohnheim.fh-wedel.de>
References: <20030320221332.GA13641@wohnheim.fh-wedel.de> <010303201736060.23184-100000@timmy.spinoli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <010303201736060.23184-100000@timmy.spinoli.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 March 2003 18:14:53 -0500, Hank Leininger wrote:
> On Thu, 20 Mar 2003, [iso-8859-1] Jörn Engel wrote:
> 
> > "Come to mind" doesn't sound line "that'd break our environment." ;)
> 
> Well, no ;)  But I could see how they might break some, and/or would
> cause real problems even though they wouldn't be insurmountable ones.

might/could doesn't matter. does matters. ;)

> > > -To verify and then use a .tar.[bg]z2?, you must gpg --verify and then
> > >   tar -x[jz]vf, but to unpack, then verify, then use you must uncompress
> > >   to a tempfile or pipe to gpg, then verify, then untar.  Silly waste of
> > >   CPU and/or disk space.[*]
> >
> > Veryfy and use are two action. You need a script or a human, changing
> > either one won't be hard.
> 
> Right, but if the uncompressed file is what's signed, then you must
> waste either CPU uncompressing twice (once to verify, once to untar) or
> waste disk (to store the uncompressed file, then verify, then untar).

Waste the disk. You'll waste it anyway, once you start to compile and
by that time, the temporary tar is deleted.

> > real-world?
> 
> Sure.  You're net-connected only intermittantly, and want to verify
         ^^^
> downloads as soon as you get them, so you can re-get before
                       ^^^              ^^^
> disconnecting.  Or you're pulling files down to burn to CD, you'd like
                     ^^^                                      ^^^
> to know if they are bad before you've burned the CD and try to use it
                                 ^^^
> elsewhere; unpacking just to verify is a waste.

*I* don't have any of those problems. But it is good to know that you
are concerned about me. :)

> Hell, here's an easy example: the kernel.org mirror sites.  I don't know
> for sure if any of them --verify the tarball+sig files that they mirror,
> but it sure would make a lot of sense.  With signatures of the
> compressed tarballs, that would be trivial.  With signatures of the .tar
> files, it would be far more resource-intensive for them to implement.

Agreed, that would be a problem. 

> Another flavor I hit personally is: I want to hack on and/or upgrade my
> laptop to some new version of something while on a flight.  Before
> leaving I pull down the tarballs and sig files to my main workstation,
> verify the signatures, scp to the laptop.  It'd be a waste to unpack
> just to verify before pushing it, a pain to have to unpack and verify on
> the laptop right away, and a showstopper if I didn't verify until I was
> at 30,000 feet.

Malicious packages should be rare enough to ignore the showstopper
argument. If that problem bites you on a regular basis,...

> > > [*] ...Now if tar had a --sig option to chain gpg between gunzip and
> > >     untar... but that would just be Wrong.
> >
> > unzip && checksig && tar?
> 
> Yes, but all as one pipeline, not seperate commands with tempfiles.
> After all there is a reason the [Zzj] flags were added to tar.  Signing
> the intermediate .tar instead of the .tar.(gz|bs2) breaks that.
> 
> But that's inventing questionable features in GNU tar that won't be
> present in other tars or archive-managing tools, creating dependencies
> on GPG/PGP/tool of choice, etc.  Unnecessary complexity.
> 
> Actually, unlike gzip | tar -xf -, you can't start feeding the
> signature-checked tar file to tar -xf until all of it has been read in
> to be verified, so really, it can't be done in a single pass.

Yup, I'm convinced. signatures for plain tars would still be a nice
thing to have, but they cannot replace those for .gz and .bz2.

Jörn

-- 
Victory in war is not repetitious.
-- Sun Tzu
