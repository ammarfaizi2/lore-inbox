Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWJAKvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWJAKvm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 06:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWJAKvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 06:51:42 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:11230 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1751469AbWJAKvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 06:51:41 -0400
Date: Sun, 1 Oct 2006 12:51:40 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
Cc: Sam Ravnborg <sam@uranus.ravnborg.org>
Subject: [GOT PATCHES] kbuild+kconfig/lxdialog updates
Message-ID: <20061001105140.GA10269@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

Please pull following kbuild updates.

	git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git

The lxdialog parts has been in -mm for a while with suprisingly 
little feedback.
I have a few patches pending from Jan Engelhart that add a few more color
selections - need to try them out first.


The color part was acked by Roman Zippel.
The lxdialog refactoring I have had limited feedbcak despite being
part of -mm for a while now. A few initial issues was fixed when
it first hit -mm.
The single kconfig fix has remain unreviewd (and not tested in -mm).

Patches will follow to lkml.

	Sam



Robert P. J. Day:
      kbuild: trivial documentation fixes

Sam Ravnborg:
      kconfig/lxdialog: refactor color support
      kconfig/lxdialog: add support for color themes and add blackbg theme
      kconfig/lxdialog: add a new theme bluetitle which is now default
      kconfig/menuconfig: lxdialog is now built-in
      kconfig/lxdialog: let <ESC><ESC> behave as expected
      kconfig/lxdialog: support resize
      kconfig/lxdialog: fix make mrproper
      kbuild: do not build mconf & lxdialog unless needed
      kconfig/lxdialog: clear long menu lines
      kconfig/menuconfig: do not let ncurses clutter screen on exit
      kbuild: make modpost processing configurable
      kconfig: fix saving alternate kconfig file in parent dir

 Documentation/kbuild/modules.txt     |    9 -
 scripts/Makefile.modpost             |   11 +
 scripts/kconfig/Makefile             |   31 ++
 scripts/kconfig/confdata.c           |    2 
 scripts/kconfig/lxdialog/Makefile    |   21 -
 scripts/kconfig/lxdialog/checklist.c |  183 ++++++------
 scripts/kconfig/lxdialog/colors.h    |  154 ----------
 scripts/kconfig/lxdialog/dialog.h    |  144 ++++++----
 scripts/kconfig/lxdialog/inputbox.c  |   48 ++-
 scripts/kconfig/lxdialog/lxdialog.c  |  204 --------------
 scripts/kconfig/lxdialog/menubox.c   |  166 ++++++-----
 scripts/kconfig/lxdialog/msgbox.c    |   71 -----
 scripts/kconfig/lxdialog/textbox.c   |  416 +++++++++-------------------
 scripts/kconfig/lxdialog/util.c      |  502 ++++++++++++++++++++++++++-------
 scripts/kconfig/lxdialog/yesno.c     |   26 +-
 scripts/kconfig/mconf.c              |  511 +++++++++++-----------------------
 16 files changed, 1053 insertions(+), 1446 deletions(-)
 delete mode 100644 scripts/kconfig/lxdialog/Makefile
 delete mode 100644 scripts/kconfig/lxdialog/colors.h
 delete mode 100644 scripts/kconfig/lxdialog/lxdialog.c
 delete mode 100644 scripts/kconfig/lxdialog/msgbox.c
