Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286692AbRL1Cc0>; Thu, 27 Dec 2001 21:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286693AbRL1CcH>; Thu, 27 Dec 2001 21:32:07 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:64007 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S286692AbRL1Cb6>;
	Thu, 27 Dec 2001 21:31:58 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Announce: Kernel Build for 2.5, Release 1.12 is available 
Date: Fri, 28 Dec 2001 13:31:42 +1100
Message-ID: <19466.1009506702@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Release 1.12 of kernel build for kernel 2.5 (kbuild 2.5) is available.
http://sourceforge.net/projects/kbuild/, Package kbuild-2.5, download
release 1.12.

This is ready to go to Linus for inclusion in 2.5.[12].  There is one
item on the todo list but it is not a show stopper, the code works as
is.

kbuild 2.5 currently supports i386, ia64, sparc32, sparc64, alpha and
ppc (incomplete).  All are supported on 2.4.16 and 2.4.17, i386 is
supported on 2.5.1.

This announcement is for the base kbuild 2.5 code, i386 against 2.4.16.
Patches for other architectures and kernels will be out later today, it
takes time to generate and test patches for 6 architectures against 3
different kernel trees.  The sooner Linus takes the base patch, the
sooner I will be able to rewrite the core code to speed it up, instead
of spending all my time tracking multiple trees.

http://marc.theaimsgroup.com/?l=linux-kernel&m=99725412902968&w=2
contains information about the base release of kbuild 2.5.

Changelog:

  CML2 changes to handle install formats.

  Add KBUILD_INCLUDE_PATHS for patches that have their own separate
  include tree, including asm-$(ARCH).  selinux does this, I am not
  100% convinced that it is a sensible thing to do but I will support
  it for now.

  Add KBUILD_BASENAME, used when replacing .text.lock with .subsection.

  Documentation corrections by Ghozlane Toumi.

  Move include of arch/$(ARCH)/Makefile.defs.config from global
  makefile to top level.  Needed for PPC.  Have a barf bag ready when
  you read the code in scripts/Makefile-2.5.

  Support include of asm files for other architectures (APUS does this).

  Do not regenerate files on make clean/mrproper.

  Correct bug in $(dir)/$(notdir) with unexpanded variables.

  Handle empty $(arch_head).

  Improve propagation of y/m onto sub-objects.

  As always, Documentation/kbuild/kbuild-2.5.txt is your friend.

TODO:

  Rewrite core code to improve performance.  Not until the existing
  code is in the kernel.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE8K9mNi4UHNye0ZOoRAjG3AKCU9dCejUPFUj0rI4qy+CgN4VA0rQCdHPIc
zUqFaLZ5sZQ0F8Oytn+90zk=
=Jskx
-----END PGP SIGNATURE-----

