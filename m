Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbWAFVD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbWAFVD3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWAFVD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:03:29 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30736 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932511AbWAFVD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:03:29 -0500
Date: Fri, 6 Jan 2006 22:03:16 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [GIT PATCHES] kbuild updates
Message-ID: <20060106210316.GA566@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

Please pull in a small number of kbuild updates.
The most important one is the "un-stringnify KBUILD_MODNAME".
It fixes a commandline parsing error, and let ls /sys/module look sane
again.

Pull from:

ssh://master.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git

All patches has been sent to lkml previously so they are not repeated
here.

	Sam

 .gitignore                              |    1 
 Documentation/kbuild/modules.txt        |   41 ++++++++++++++++++
 arch/x86_64/ia32/.gitignore             |    2 
 drivers/media/dvb/cinergyT2/cinergyT2.c |    2 
 drivers/media/dvb/ttpci/budget.h        |    2 
 drivers/media/video/tda9840.c           |    2 
 drivers/media/video/tea6415c.c          |    2 
 drivers/media/video/tea6420.c           |    2 
 include/linux/moduleparam.h             |    2 
 include/media/saa7146.h                 |    6 +-
 net/ipv4/netfilter/ip_nat_ftp.c         |    2 
 net/ipv4/netfilter/ip_nat_irc.c         |    2 
 scripts/kconfig/Makefile                |    9 +---
 scripts/setlocalversion                 |   71 ++++++++------------------------
 security/capability.c                   |    7 ---
 15 files changed, 76 insertions(+), 77 deletions(-)


Adrian Bunk:
      kconfig: fix gconfig with POSIXLY_CORRECT=1

Brian Gerst:
      gitignore: ignore shared objects

Rene Scharfe:
      kbuild: Use git in scripts/setlocalversion

Sam Ravnborg:
      kbuild: document howto build external modules using several directories
      kbuild: un-stringnify KBUILD_MODNAME

