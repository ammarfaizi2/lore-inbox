Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129736AbRCCUVS>; Sat, 3 Mar 2001 15:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129737AbRCCUU7>; Sat, 3 Mar 2001 15:20:59 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:63718 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S129736AbRCCUUt>;
	Sat, 3 Mar 2001 15:20:49 -0500
Date: Sat, 3 Mar 2001 21:20:42 +0100
From: David Weinehall <tao@acc.umu.se>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: davidge@jazzfree.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@redhat.com
Subject: Re: simple question about patches
Message-ID: <20010303212042.A28012@khan.acc.umu.se>
In-Reply-To: <Pine.LNX.4.21.0103031812550.1447-100000@roku.redroom.com> <200103031914.f23JEIa85558@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200103031914.f23JEIa85558@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Sat, Mar 03, 2001 at 02:14:18PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 03, 2001 at 02:14:18PM -0500, Albert D. Cahalan wrote:
> David G\363mez writes:
> 
> > Hi, i've got a newbie question about patches:
> > Are the pre* patches ( and i guess also the ac* ones) applied against the
> > last release of the kernel or against the previous patch? I mean, when
> > 2.4.3pre2 will come out, i need to get also the pre1 patch?
> 
> Really, I wouldn't bother anymore. 
> 
> [stuff for patch creators below -- please read]
> 
> Long ago, pre* and ac* patches were rare. Patches went from one
> kernel version to the next. You could hope to read a whole patch
> line-by-line before the next one came out. Patches always applied
> easily with the (pre-POSIX?) patch command. Version numbers made
> perfect sense, starting with the 1.0 release. Modems were 14.4 kB/s.

[long rant about patch snipped]

Get a clue, Albert.

I've followed the kernel-tree since v2.0.30 or so (no, I'm not
one of those that began hacking with the 0.01-kernels), and almost
every pre-patch, test-patch and ac-patch ever released. I've even
followed some of the other private trees, such as the aa-patches,
Solar Designer's ow-patches and a few others. I've so far experienced
NO problems whatsoever.

Due to the fact that I tend to do quite some bug-testing inside my
tree, I start afresh from a tarball every 10 to 20 major releases
(sometimes more often), which could be regarded as cheating, of course.

But just to give you a helping hand, here's a small primer.

Applying a patch:

cd linux 		# name of kernel-tree

# If you have an unzipped patch
cat ../patches/patch-name | patch -p1 --dry-run

# If everything goes fine
cat ../patches/patch-name | patch -p1


# If you have a gzipped patch
zcat ../patches/patch-name.gz | patch -p1 --dry-run

# If everything goes fine
zcat ../patches/patch-name.gz | patch -p1


# If you have a bz2zipped patch
bzcat ../patches/patch-name.bz2 | patch -p1 --dry-run

# If everything goes fine
bzcat ../patches/patch-name.bz2 | patch -p1


This goes both for applying pre-patches, ac-patches and normal,
version-to-version patches.

Before applying a patch, make sure that you've unapplied
all pre-patches, ac-patches etc.

This is done using the same syntax, but with a -R tacked onto it.


When creating a patch from two kernel-trees, use

diff -u --recursive --new-file linux-old linux-new > [name-of-patch]

or, for single files simply

diff -u old-file [new-file with full path] > [name-of-patch]


Some of this might not be fully correct, but most of it should be.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
