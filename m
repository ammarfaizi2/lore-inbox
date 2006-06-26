Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbWFZBLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbWFZBLE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbWFZA6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 20:58:43 -0400
Received: from terminus.zytor.com ([192.83.249.54]:17039 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964980AbWFZA62
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:58:28 -0400
Date: Sun, 25 Jun 2006 17:58:01 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 13/43] UML: the klibc architecture is the underlying architecture
Message-Id: <klibc.200606251757.13@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On UML: the klibc architecture is the underlying architecture, so set
KLIBCARCH to SUBARCH.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 018604e070e143657abcf0cb256a1e2dda205d97
tree 1b853903ca6af49d9f437cfd694aec61ef1d488e
parent baacd5d81ff7151e8df3893850ec363441886a1e
author H. Peter Anvin <hpa@zytor.com> Mon, 15 May 2006 21:25:33 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 18 Jun 2006 18:50:51 -0700

 arch/um/Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index f6ad832..f8e96f2 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -50,6 +50,8 @@ ARCH_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)
 endif
 SYS_DIR		:= $(ARCH_DIR)/include/sysdep-$(SUBARCH)
 
+KLIBCARCH	:= $(SUBARCH)
+
 # -Dvmap=kernel_vmap prevents anything from referencing the libpcap.o symbol so
 # named - it's a common symbol in libpcap, so we get a binary which crashes.
 #
