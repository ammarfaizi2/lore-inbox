Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314057AbSEFByr>; Sun, 5 May 2002 21:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314065AbSEFByq>; Sun, 5 May 2002 21:54:46 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:53489
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S314057AbSEFByp>; Sun, 5 May 2002 21:54:45 -0400
Date: Sun, 5 May 2002 18:54:44 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Mark H. Wood" <mwood@IUPUI.Edu>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Message-ID: <20020506015444.GK2392@matchmail.com>
Mail-Followup-To: "Mark H. Wood" <mwood@IUPUI.Edu>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0205021738410.17171-100000@weyl.math.psu.edu> <Pine.LNX.4.33.0205031554180.10456-100000@mhw.ULib.IUPUI.Edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 04:05:52PM -0500, Mark H. Wood wrote:
> There is a reason that this issue keesp rising from the grave.  I just
> downloaded the glibc 2.2.5 source tarball and in INSTALL I find
> this:
> 
> [begin quote]
> Specific advice for Linux systems
> =================================
> 
>    If you are installing GNU libc on a Linux system, you need to have
> the header files from a 2.2 kernel around for reference.  You do not
> need to use the 2.2 kernel, just have its headers where glibc can access
> at them.  The easiest way to do this is to unpack it in a directory
> such as `/usr/src/linux-2.2.1'.  In that directory, run `make config'
> and accept all the defaults.  Then run `make include/linux/version.h'.
> Finally, configure glibc with the option
> `--with-headers=/usr/src/linux-2.2.1/include'.  Use the most recent
> kernel you can get your hands on.
> 
>    An alternate tactic is to unpack the 2.2 kernel and run `make
> config' as above.  Then rename or delete `/usr/include', create a new
> `/usr/include', and make the usual symbolic links of
> `/usr/include/linux' and `/usr/include/asm' into the 2.2 kernel
> sources.  You can then configure glibc with no special options.  This
> tactic is recommended if you are upgrading from libc5, since you need
> to get rid of the old header files anyway.
> 
>    Note that `/usr/include/net' and `/usr/include/scsi' should *not* be
> symlinks into the kernel sources.  GNU libc provides its own versions
> of these files.
> [end quote]

I believe this is only for building Glibc, but all apps that depend on Glibc
should use whatever kernel headers that glibc is using...
