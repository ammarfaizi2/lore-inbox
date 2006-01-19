Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161170AbWASUDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161170AbWASUDA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbWASUDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:03:00 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:29962 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030326AbWASUC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:02:59 -0500
Date: Thu, 19 Jan 2006 21:02:16 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@mars.ravnborg.org>
Subject: [GIT PATCHES] kbuild fixes
Message-ID: <20060119200216.GA3557@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

Please pull from:

	ssh://master.kernel.org/pub/linux/kernel/git/sam/kbuild.git

This will fix the issue that executing make menuconfig and make mrproper
will change permissions on /dev/null and sometimes convert it to a
regular file.
gcc ... -o /dev/null was causing the trouble so we avoid it now.

Two other fixes included:

Al Viro:
      cris: asm-offsets related build failure

Sam Ravnborg:
      kconfig: fix /dev/null breakage
      kbuild: fix build with O=..


diffstat:

 Makefile                                   |   12 ++++++------
 arch/cris/Makefile                         |    6 ++----
 scripts/kconfig/lxdialog/Makefile          |    7 +++++--
 scripts/kconfig/lxdialog/check-lxdialog.sh |   15 +++++++++------
 4 files changed, 22 insertions(+), 18 deletions(-)
