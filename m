Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWIXVDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWIXVDM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWIXVDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:03:12 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:27345 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S932094AbWIXVDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:03:11 -0400
Date: Sun, 24 Sep 2006 23:08:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PATCHES] kbuild.git updates for 2.6.19
Message-ID: <20060924210827.GA26969@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild updates for 2.6.19.

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git

All patches except a bunch of documentation fixes has been in -mm at least
a couple of -mm's with no or little feedback.
The headlines:

o Added unifdef to the kernel tree to provide better support for headers_*
o Build fails if there are undefined symbols in a module
o Run modpost on vmlinux also in case of non-module build

Patches will be sent to lkml as follow-up to this mail.

	Sam


___Shortlog___

Aron Griffis:
      kbuild: Extend kbuild/defconfig tags support to exuberant ctags

Bryce Harrington:
      kbuild: fix for some typos in Documentation/makefiles.txt

Jan Engelhardt:
      kconfig: linguistic fixes for Documentation/kbuild/kconfig-language.txt
      kbuild: linguistic fixes for Documentation/kbuild/modules.txt
      kbuild: linguistic fixes for Documentation/kbuild/makefiles.txt

Jesper Juhl:
      kbuild: add distclean info to 'make help' and more details for 'clean'

Kirill Korotaev:
      kbuild: fail kernel compilation in case of unresolved module symbols

Magnus Damm:
      kbuild: ignore references from ".pci_fixup" to ".init.text"

Matthew Wilcox:
      kconfig: support DOS line endings

Olaf Hering:
      remove RPM_BUILD_ROOT from asm-offsets.h

Randy Dunlap:
      dontdiff: add utsrelease.h

Robert P. J. Day:
      kbuild: update help in top level Makefile
      Documentaion: update Documentation/Changes with minimum versions
      kbuild: clarify "make C=" build option
      kbuild: fixup Documentation/kbuild/modules.txt
      kbuild: correct and clarify versioning info in Makefile

Rolf Eike Beer:
      kbuild: fix "mkdir -p" usage in scripts/package/mkspec

Sam Ravnborg:
      kbuild: consistently decide when to rebuild a target
      kbuild: add unifdef
      kbuild: replace use of strlcpy with a dedicated implmentation in unifdef
      kbuild: use in-kernel unifdef
      kbuild: modpost on vmlinux regardless of CONFIG_MODULES
      kbuild: make V=2 tell why a target is rebuild
      kbuild: make -rR is now default
      kbuild: preperly align SYSMAP output
      kbuild: add missing return statement in modpost.c:secref_whitelist()
      kbuild: create output directory for hostprogs with O=.. build
      kbuild: remove debug left-over from Makefile.host

___git diff --stat --summary___

 Documentation/Changes                     |    7 
 Documentation/dontdiff                    |    1 
 Documentation/kbuild/kconfig-language.txt |   12 
 Documentation/kbuild/makefiles.txt        |  265 ++++----
 Documentation/kbuild/modules.txt          |  161 ++---
 Documentation/sparse.txt                  |    8 
 Kbuild                                    |    2 
 Makefile                                  |  134 +++-
 scripts/Kbuild.include                    |   93 ++-
 scripts/Makefile                          |    5 
 scripts/Makefile.build                    |    5 
 scripts/Makefile.headersinst              |    2 
 scripts/Makefile.host                     |   20 -
 scripts/Makefile.modpost                  |   13 
 scripts/kconfig/Makefile                  |    1 
 scripts/kconfig/confdata.c                |    8 
 scripts/mod/modpost.c                     |   42 +
 scripts/package/mkspec                    |    4 
 scripts/unifdef.c                         | 1005 +++++++++++++++++++++++++++++
 usr/Makefile                              |    2 
 20 files changed, 1471 insertions(+), 319 deletions(-)
 create mode 100644 scripts/unifdef.c
