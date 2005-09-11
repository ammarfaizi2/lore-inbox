Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbVIKVq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbVIKVq6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 17:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbVIKVq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 17:46:58 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:23937 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1750935AbVIKVq5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 17:46:57 -0400
Date: Sun, 11 Sep 2005 23:48:50 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [GIT PATCHES] kbuild fixes
Message-ID: <20050911214850.GA2177@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

First round of small kbuild fixes (it's monday here in 15 minutes).

o Rename prepare to archprepare to get dependency order correct
o fix silentoldconfig with make O=
o rename mips/kernel/offset.c to asm-offsets.c

Can be pulled from:

	www.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git

I've started suing the alternate format as you described.
So I cannot pull from that respository myself.
http: + rsync: failed?

I hope you know a few smart tricks.


diffstat - the major part is the rename.
The rest is only a few lines / one-liners.

 Makefile                             |    1 
 arch/mips/kernel/offset.c            |  314 -----------------------------------
 b/Documentation/kbuild/makefiles.txt |   14 -
 b/Makefile                           |   23 +-
 b/arch/arm/Makefile                  |    2 
 b/arch/cris/Makefile                 |    2 
 b/arch/ia64/Makefile                 |    2 
 b/arch/mips/kernel/asm-offsets.c     |  314 +++++++++++++++++++++++++++++++++++
 b/arch/ppc/Makefile                  |    2 
 b/arch/sh/Makefile                   |    2 
 b/arch/sh64/Makefile                 |    2 
 b/arch/um/Makefile                   |    2 
 b/arch/xtensa/Makefile               |    2 
 13 files changed, 345 insertions(+), 337 deletions(-)

Patches will follow.

	Sam
