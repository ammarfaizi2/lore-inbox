Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285015AbRLQFFZ>; Mon, 17 Dec 2001 00:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285014AbRLQFFQ>; Mon, 17 Dec 2001 00:05:16 -0500
Received: from zok.SGI.COM ([204.94.215.101]:13782 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S285007AbRLQFFE>;
	Mon, 17 Dec 2001 00:05:04 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Announce: Kernel Build for 2.5, Release 1.11 is available
Date: Mon, 17 Dec 2001 16:04:55 +1100
Message-ID: <4738.1008565495@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Release 1.11 of kernel build for kernel 2.5 (kbuild 2.5) is available.
http://sourceforge.net/projects/kbuild/, Package kbuild-2.5, download
release 1.11.

This is ready to go to Linus for inclusion in 2.5.[12].  There is one
item on the todo list but it is not a show stopper, the code works as
is.  The sooner this is in 2.5 and other architectures the better,
otherwise I will just be chasing releases and getting no useful work
done.

kbuild 2.5 currently supports i386 (2.4.16, 2.5.1), ia64
(2.4.16-011214), sparc32 (2.4.16), sparc64 (2.4.16).  Alpha is in
progress.

The sparc support is against Linus's 2.4.16 kernel, not against the
vger tree, the latter is moving too fast.  I expect that some tweaking
will be required for the vger sparc changes, in particular the removal
of config options for netlink.  Release 1.11 does not contain any
changes to the sparc patches, use the release 1.10 patches for sparc.

http://marc.theaimsgroup.com/?l=linux-kernel&m=99725412902968&w=2
contains information about the base release of kbuild 2.5.

Changelog:

  Add standard targets for vmlinux.srec and .bin, David Woodhouse.

  New variables KERNELFULLNAME and KERNELBASENAME for config options
  and install scripts.

  New variable KERNEL_INCLUDELIST for host compiles within kbuild that
  need to read the current kernel headers.

  New optional target to flatten the shadow trees into a single source
  tree.  make $(KBUILD_OBJTREE).tmp_src

  Changes to setup() targets are detected during the build that changes
  them, instead of being delayed until the next build.  Nothing uses
  setup() yet.

  make clean and mrproper no longer require a working .config, you no
  longer have to make oldconfig before make clean or mrproper.  The
  clean and mrproper lists are still automatically generated, no manual
  definitions for us.

  CML2 support now works, it requires CML2 1.9.9 or better.  For the
  moment, CML2 is distributed separately so kbuild does not have to
  change when ESR update CML2.  See http://www.tuxedo.org/~esr/kbuild/
  and the instructions in Documentation/kbuild/kbuild-2.5.txt.  Only
  i386 and ia64 have the arch specific CML2 files, other architectures
  are easy to add.

  Any change to a CML file ([Cc]onfig.in, Configure.help, rules*.cml,
  symbols*.cml) requires the user to rerun make *config.  This helps to
  ensure that the build is from a valid config.

  extra_{c,a,ld}flags support a STRIP option to strip selected flags
  from the global flags.  Useful when a small set of sources cannot be
  compiled with certain options.

  As always, Documentation/kbuild/kbuild-2.5.txt is your friend.

TODO:

  Rewrite core code to improve performance.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE8HXz1i4UHNye0ZOoRAu6sAJ9MUv7bUlQx2VhSyDAhGjblSaYS0ACbBL7I
zE+nfa0msvPA1R3efLJS9EI=
=buWJ
-----END PGP SIGNATURE-----

