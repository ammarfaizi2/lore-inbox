Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWAIVu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWAIVu6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWAIVu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:50:58 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:56591 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750783AbWAIVu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:50:57 -0500
Date: Mon, 9 Jan 2006 22:50:38 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 12/11] kbuild: re-export VERSION, PATCHLEVEL, SUBLEVEL
Message-ID: <20060109215038.GB17315@mars.ravnborg.org>
References: <20060109211157.GA14477@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109211157.GA14477@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One last minute patch added to the tree:

kbuild: re-export VERSION, PATCHLEVEL, SUBLEVEL

Eric Sandeen <sandeen@sgi.com> pointed out that it is usefull to have
access to VERSION, PATCHLEVEL, SUBLEVEL in external modules, and gooling
a litte confirmed this.
So re-export them.
Usage within the kernel is still discouraged but possible.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---
commit 4f0210b9c4889eede9f8f379f93570c01998ccb9
tree 0883096acb3bc46e65a6873b777f01214d6a7852
parent cb58455c48dc43536e5548bdba4e916b2f0cf13d
author Sam Ravnborg <sam@mars.ravnborg.org> Mon, 09 Jan 2006 22:48:34 +0100
committer Sam Ravnborg <sam@mars.ravnborg.org> Mon, 09 Jan 2006 22:48:34 +0100

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index df60aa1..1d1afa5 100644
--- a/Makefile
+++ b/Makefile
@@ -338,7 +338,7 @@ AFLAGS		:= -D__ASSEMBLY__
 # Read KERNELRELEASE from .kernelrelease (if it exists)
 KERNELRELEASE = $(shell cat .kernelrelease 2> /dev/null)
 
-export	KERNELRELEASE \
+export	VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE \
 	ARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
 	CPP AR NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS PERL UTS_MACHINE \
 	HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
