Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285584AbRLRFMz>; Tue, 18 Dec 2001 00:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285574AbRLRFMq>; Tue, 18 Dec 2001 00:12:46 -0500
Received: from zok.SGI.COM ([204.94.215.101]:57248 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S285137AbRLRFMe>;
	Tue, 18 Dec 2001 00:12:34 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.11 is available 
In-Reply-To: Your message of "Mon, 17 Dec 2001 16:04:55 +1100."
             <4738.1008565495@kao2.melbourne.sgi.com> 
Date: Tue, 18 Dec 2001 16:12:20 +1100
Message-ID: <2601.1008652340@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Patch for IA64 support using kbuild 2.5 for 2.4.16-ia64-011214.
Build the kbuild 2.5 for ia64-011214 tree in this order:

  Linus's 2.4.16 kernel.
  kbuild-2.5-2.4.16-2 (common and ix86 patches).
  linux-2.4.16-ia64-011214.diff (ia64 changes from Linus's tree).
  kbuild-2.5-2.4.16-ia64-011214-2 (ia64 specific kbuild 2.5 patches).

Then proceed with kbuild 2.5, see Documentation/kbuild/kbuild-2.5.txt.

If you are still using 2.4.16-ia64-011128 you can patch in this order:

  Linus's 2.4.16 kernel.
  kbuild-2.5-2.4.16-2 (common and ix86 patches).
  linux-2.4.16-ia64-011128.diff (older ia64 changes from Linus's tree).
  kbuild-2.5-2.4.16-ia64-011214-2 (the current ia64 kbuild patch).
  Manually edit arch/ia64/kernel/Makefile.in to remove salinfo.o from
  the select list.

NOTE: The previous kbuild 2.5 ia64 patch prevented the use of kbuild
      2.4, this patch attempts to preserve the use of kbuild 2.4 on
      ia64.  It makes the patch quite a bit uglier but is probably
      worth the effort.

This conversion to kbuild 2.5 has only been tested with CONFIG_IA64_DIG=y.  I
could not test with CONFIG_IA64_HP_SIM=y (compile and build errors),
CONFIG_IA64_SGI_SN[12]=y (no asm/mmzone.h) or CONFIG_IA64_GENERIC=y (all the
problems of each platform).

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE8HtAzi4UHNye0ZOoRAhEGAKDy9ekVxfNGbkCBdvBBeBG+IZgAUQCg5MLU
LaQF7+Dll48XejzyEXDZdTk=
=Ky+a
-----END PGP SIGNATURE-----

