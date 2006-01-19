Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161282AbWASI5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161282AbWASI5d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 03:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161283AbWASI5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 03:57:33 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38561 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161282AbWASI5c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 03:57:32 -0500
Date: Thu, 19 Jan 2006 08:57:30 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: sam@ravnborg.org, starvik@axis.com, dev-etrax@axis.com,
       linux-kernel@vger.kernel.org
Subject: Re: cris: asm-offsets related build failure
Message-ID: <20060119085730.GP27946@ftp.linux.org.uk>
References: <20060119001852.GO19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119001852.GO19398@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 01:18:52AM +0100, Adrian Bunk wrote:
> Hi Sam,
> 
> the following build failure is present on the cris architecture:
> 
> <--  snip  -->
> 
> ...
> make[1]: *** No rule to make target `arch/cris/kernel/asm-offsets.c', 
> needed by `arch/cris/kernel/asm-offsets.s'.  Stop.
> make: *** [prepare0] Error 2

Subject: [PATCH] fix a typo in arch/cris/Makefile

fallout from "kbuild: cris use generic asm-offsets.h support" - symlink
target was wrong

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
