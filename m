Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932735AbWAKEm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932735AbWAKEm6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 23:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932752AbWAKEm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 23:42:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:8904 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932735AbWAKEm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 23:42:57 -0500
Date: Tue, 10 Jan 2006 22:36:37 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
cc: linux-kernel@vger.kernel.org, <linuxppc-dev@ozlabs.org>,
       <linuxppc64-dev@gate.crashing.org>
Subject: [PATCH] powerpc: Fix arch/powerpc/boot Makefile
Message-ID: <Pine.LNX.4.44.0601102236050.15456-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

clean-files was being set twice rather than being appended to.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit aa30a75885b935a7f09a1312e792f96cc338e505
tree 2be29cf7aacbf9ac89e3c99dcf0a0502e940ae36
parent b718d4872e6ad557b9751785b596ed57b9e6b023
author Kumar Gala <galak@kernel.crashing.org> Tue, 10 Jan 2006 22:41:48 -0600
committer Kumar Gala <galak@kernel.crashing.org> Tue, 10 Jan 2006 22:41:48 -0600

 arch/powerpc/boot/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 22726ae..b53d677 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -176,4 +176,4 @@ $(obj)/uImage: $(obj)/vmlinux.gz
 install: $(CONFIGURE) $(BOOTIMAGE)
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" "$(BOOTIMAGE)"
 
-clean-files := $(addprefix $(objtree)/, $(obj-boot) vmlinux.strip)
+clean-files += $(addprefix $(objtree)/, $(obj-boot) vmlinux.strip)

