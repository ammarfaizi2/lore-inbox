Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbWASUFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbWASUFI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWASUFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:05:08 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30987 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030330AbWASUFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:05:06 -0500
Date: Thu, 19 Jan 2006 21:04:57 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] cris: asm-offsets related build failure
Message-ID: <20060119200457.GC3557@mars.ravnborg.org>
References: <20060119200216.GA3557@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119200216.GA3557@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH 2/3] cris: asm-offsets related build failure
From: Al Viro <viro@ftp.linux.org.uk>
Date: 1137697395 +0000

fallout from "kbuild: cris use generic asm-offsets.h support" - symlink
target was wrong

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 arch/cris/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

6dd84484328cf9a0d7b8d100f506333a80033db5
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
1.0.GIT
