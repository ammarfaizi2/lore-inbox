Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161275AbWASTDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161275AbWASTDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161283AbWASTDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:03:24 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:31137 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161275AbWASTDX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:03:23 -0500
Date: Thu, 19 Jan 2006 19:03:15 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Adrian Bunk <bunk@stusta.de>, starvik@axis.com, dev-etrax@axis.com,
       linux-kernel@vger.kernel.org
Subject: Re: cris: asm-offsets related build failure
Message-ID: <20060119190315.GQ27946@ftp.linux.org.uk>
References: <20060119001852.GO19398@stusta.de> <20060119085730.GP27946@ftp.linux.org.uk> <20060119163433.GA12724@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119163433.GA12724@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 05:34:33PM +0100, Sam Ravnborg wrote:
> On Thu, Jan 19, 2006 at 08:57:30AM +0000, Al Viro wrote:
> > On Thu, Jan 19, 2006 at 01:18:52AM +0100, Adrian Bunk wrote:
> > > Hi Sam,
> > > 
> > > the following build failure is present on the cris architecture:
> > > 
> > > <--  snip  -->
> > > 
> > > ...
> > > make[1]: *** No rule to make target `arch/cris/kernel/asm-offsets.c', 
> > > needed by `arch/cris/kernel/asm-offsets.s'.  Stop.
> > > make: *** [prepare0] Error 2
> > 
> > Subject: [PATCH] fix a typo in arch/cris/Makefile
> > 
> > fallout from "kbuild: cris use generic asm-offsets.h support" - symlink
> > target was wrong
> Hi Al.
> 
> Can I have a Signed-off-by: ... patch
> or do you submit it yourself?

Subject: [PATCH] fix a typo in arch/cris/Makefile

fallout from "kbuild: cris use generic asm-offsets.h support" - symlink
target was wrong

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 arch/cris/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

9812c3418f4068bb8940924a871e5bc0713d4e41
diff --git a/arch/cris/Makefile b/arch/cris/Makefile
index ea65d58..ee11469 100644
--- a/arch/cris/Makefile
+++ b/arch/cris/Makefile
@@ -119,7 +119,7 @@ $(SRC_ARCH)/.links:
 	@ln -sfn $(SRC_ARCH)/$(SARCH)/lib $(SRC_ARCH)/lib
 	@ln -sfn $(SRC_ARCH)/$(SARCH) $(SRC_ARCH)/arch
 	@ln -sfn $(SRC_ARCH)/$(SARCH)/vmlinux.lds.S $(SRC_ARCH)/kernel/vmlinux.lds.S
-	@ln -sfn $(SRC_ARCH)/$(SARCH)/asm-offsets.c $(SRC_ARCH)/kernel/asm-offsets.c
+	@ln -sfn $(SRC_ARCH)/$(SARCH)/kernel/asm-offsets.c $(SRC_ARCH)/kernel/asm-offsets.c
 	@touch $@
 
 # Create link to sub arch includes
-- 
0.99.9.GIT
