Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282861AbRLBMtA>; Sun, 2 Dec 2001 07:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282863AbRLBMsu>; Sun, 2 Dec 2001 07:48:50 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:42765 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S282861AbRLBMsq>;
	Sun, 2 Dec 2001 07:48:46 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Announce: Kernel Build for 2.5, Release 1.10 is available
Date: Sun, 02 Dec 2001 23:48:29 +1100
Message-ID: <26392.1007297309@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Release 1.10 of kernel build for kernel 2.5 (kbuild 2.5) has been
released.  http://sourceforge.net/projects/kbuild/, Package kbuild-2.5,
download release 1.10.

This is now ready to go to Linus for inclusion in 2.5.[12].  There are
still items on the todo list but none are show stoppers, the code works
as is.  The sooner this is in 2.5 and other architectures the better,
otherwise I will just be chasing releases and getting no useful work
done.

kbuild 2.5 currently supports i386 (2.4.16), ia64 (2.4.16-011128),
sparc32 (2.4.16), sparc64 (2.4.16).

Thanks to Debian for providing a sparc system and Ben Collins for
testing sparc32 and doing the sparc64 conversion.  The sparc support is
against Linus's 2.4.16 kernel, not against the vger tree, the latter is
moving too fast.  I expect that some tweaking will be required for the
vger sparc changes, in particular the removal of config options for
netlink.

http://marc.theaimsgroup.com/?l=linux-kernel&m=99725412902968&w=2
contains information about the base release.

Changelog:

  Upgrade to kernel 2.4.16, this release will also work on kernel 2.5.0.

  Separate nostdinc into its own [ca]flags so it can be temporarily
  overridden.

  Add make defconfig.

  Correct selections in drivers/pcmcia/Makefile.in.

  Standardize the asm/offset vs asm-offset include code.

  Add sparc64 support, Ben Collins did most of the work.

  Update ia64 support for sn/hp/generic platforms, cannot be tested
  because none of those platforms compile under kbuild 2.4.

  Partial work on CML2 support.  This release does not fully support
  CML2, only use it with CML1.  CML2 support in progress.

TODO:

  Complete CML2 support.
  Rewrite core code to improve performance.
  Handle setup() dependencies correctly, nothing uses setup() yet.
  Fallback processing for make clean/mrproper using a common
  source/object tree when .config is not available.
  Require make *config after any change to [Cc]onfig.in.
  Add a variable containing the basename of the installable kernel, for
  use in install scripts.
  Help convert other architectures to kbuild 2.5.
  Sleep.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE8CiMai4UHNye0ZOoRAuwbAJ9tRVFdDuQ8fJI1xL8B9HqsVHE6lQCgv5ZI
/nGzbMnMMnvaxTXTLBDa64E=
=IwBF
-----END PGP SIGNATURE-----

