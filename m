Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWIOFKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWIOFKT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 01:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWIOFKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 01:10:19 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:24530 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1750702AbWIOFKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 01:10:18 -0400
Date: Fri, 15 Sep 2006 07:15:19 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PATCH] kbuild fix for 2.6.18-rc
Message-ID: <20060915051519.GA24314@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

Please apply following simple kbuild fix to 2.6.18-rc.
Can be pulled from:

	git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild-2.6.18.git

The full changelog and patch is below.

	Sam

------------------------------------------------------
Subject: Add a missing space that prevents building modules that require host programs
From: Ross Biro <rossb@google.com>

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

 scripts/Makefile.host |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN scripts/Makefile.host~add-a-missing-space-that-prevents-building-modules-that-require-host-programs scripts/Makefile.host
--- a/scripts/Makefile.host~add-a-missing-space-that-prevents-building-modules-that-require-host-programs
+++ a/scripts/Makefile.host
@@ -30,7 +30,7 @@
 # libkconfig.so as the executable conf.
 # Note: Shared libraries consisting of C++ files are not supported
 
-__hostprogs := $(sort $(hostprogs-y)$(hostprogs-m))
+__hostprogs := $(sort $(hostprogs-y) $(hostprogs-m))
 
 # hostprogs-y := tools/build may have been specified. Retreive directory
 host-objdirs := $(foreach f,$(__hostprogs), $(if $(dir $(f)),$(dir $(f))))
_

