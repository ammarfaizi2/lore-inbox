Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSECVFy>; Fri, 3 May 2002 17:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315716AbSECVFx>; Fri, 3 May 2002 17:05:53 -0400
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:4046 "EHLO
	mhw.ULib.IUPUI.Edu") by vger.kernel.org with ESMTP
	id <S315717AbSECVFw>; Fri, 3 May 2002 17:05:52 -0400
Date: Fri, 3 May 2002 16:05:52 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <Pine.GSO.4.21.0205021738410.17171-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0205031554180.10456-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2002, Alexander Viro wrote:
[quote snipped]
> Sigh...  Configurations with /usr/include/{linux,asm} being symlinks
> are BROKEN.  Please, look through the archives - it had been discussed
> a lot of times.  Userland has no business using kernel headers directly
> and that's precisely what had bitten you - setup where /usr/include/asm
> comes not from libc but from the (currently being built) kernel.

There is a reason that this issue keesp rising from the grave.  I just
downloaded the glibc 2.2.5 source tarball and in INSTALL I find
this:

[begin quote]
Specific advice for Linux systems
=================================

   If you are installing GNU libc on a Linux system, you need to have
the header files from a 2.2 kernel around for reference.  You do not
need to use the 2.2 kernel, just have its headers where glibc can access
at them.  The easiest way to do this is to unpack it in a directory
such as `/usr/src/linux-2.2.1'.  In that directory, run `make config'
and accept all the defaults.  Then run `make include/linux/version.h'.
Finally, configure glibc with the option
`--with-headers=/usr/src/linux-2.2.1/include'.  Use the most recent
kernel you can get your hands on.

   An alternate tactic is to unpack the 2.2 kernel and run `make
config' as above.  Then rename or delete `/usr/include', create a new
`/usr/include', and make the usual symbolic links of
`/usr/include/linux' and `/usr/include/asm' into the 2.2 kernel
sources.  You can then configure glibc with no special options.  This
tactic is recommended if you are upgrading from libc5, since you need
to get rid of the old header files anyway.

   Note that `/usr/include/net' and `/usr/include/scsi' should *not* be
symlinks into the kernel sources.  GNU libc provides its own versions
of these files.
[end quote]

Note the bit about "usual symbolic links...into the...kernel sources".

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
MS Windows *is* user-friendly, but only for certain values of "user".

