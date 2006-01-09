Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWAIVMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWAIVMQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWAIVMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:12:16 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:34830 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750744AbWAIVMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:12:16 -0500
Date: Mon, 9 Jan 2006 22:11:57 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: [GIT PATCHES] kbuild updates
Message-ID: <20060109211157.GA14477@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

Please pull from:
	ssh://master.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git

Important changes:
	o do not build vmlinux as part of make install.
	     Error out if file is missing
	o no longer use git as part of make install

The changes has not been in -mm, But most are trivial and it works for
me.
The lxdialog change is a preparation for linking in lxdialog with
menuconfig.

	Sam
	
 Documentation/kbuild/makefiles.txt         |    4 -
 Kbuild                                     |    6 -
 Makefile                                   |   99 +++++++++++++++--------------
 arch/frv/boot/Makefile                     |    5 -
 arch/i386/Makefile                         |    9 +-
 arch/i386/boot/Makefile                    |    2 
 arch/i386/boot/install.sh                  |   14 ++++
 arch/ia64/Makefile                         |    7 --
 arch/powerpc/Makefile                      |    6 -
 arch/ppc/Makefile                          |    4 -
 arch/x86_64/Makefile                       |    5 +
 arch/x86_64/boot/Makefile                  |    2 
 arch/x86_64/boot/install.sh                |   41 ------------
 fs/xfs/Kbuild                              |    7 +-
 scripts/kconfig/lxdialog/Makefile          |   48 +++-----------
 scripts/kconfig/lxdialog/check-lxdialog.sh |   68 +++++++++++++++++++
 scripts/mod/file2alias.c                   |    3 
 scripts/reference_discarded.pl             |    7 +-
 scripts/setlocalversion                    |    3 
 19 files changed, 182 insertions(+), 158 deletions(-)

Brian Gerst:
      kbuild: clean up asm-offsets.h creation
      modpost/file2alias: Fix typo

Dave Jones:
      kbuild: reference_discarded addition

H. Peter Anvin:
      kbuild: drop vmlinux dependency from "make install"

Ryan Anderson:
      kbuild: In setlocalversion change -git_dirty to just -dirty

Sam Ravnborg:
      kconfig: factor out ncurses check in a shell script
      kbuild: remove GCC_VERSION
      frv: Use KERNELRELEASE
      kbuild/xfs: introduce fs/xfs/Kbuild
      kbuild: KERNELRELEASE is only re-defined when buiding the kernel

Tore Anderson:
      kbuild: ensure mrproper removes .old_version

