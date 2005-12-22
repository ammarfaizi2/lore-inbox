Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbVLVEto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbVLVEto (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbVLVEtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:49:40 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:21200 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965045AbVLVEtP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:49:15 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 02/36] m68k: compile fix - updated vmlinux.lds to include LOCK_TEXT
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIOA-0004pz-Ez@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:49:14 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133442562 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68k/kernel/vmlinux-std.lds  |    1 +
 arch/m68k/kernel/vmlinux-sun3.lds |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

5abd81a0eec683133b4362d47863af009d393703
diff --git a/arch/m68k/kernel/vmlinux-std.lds b/arch/m68k/kernel/vmlinux-std.lds
index e58654f..69d1d3d 100644
--- a/arch/m68k/kernel/vmlinux-std.lds
+++ b/arch/m68k/kernel/vmlinux-std.lds
@@ -13,6 +13,7 @@ SECTIONS
   .text : {
 	*(.text)
 	SCHED_TEXT
+	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} :text = 0x4e75
diff --git a/arch/m68k/kernel/vmlinux-sun3.lds b/arch/m68k/kernel/vmlinux-sun3.lds
index cc37e8d..f814e66 100644
--- a/arch/m68k/kernel/vmlinux-sun3.lds
+++ b/arch/m68k/kernel/vmlinux-sun3.lds
@@ -14,6 +14,7 @@ SECTIONS
 	*(.head)
 	*(.text)
 	SCHED_TEXT
+	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} :text = 0x4e75
-- 
0.99.9.GIT

