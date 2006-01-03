Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbWACXoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbWACXoy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbWACXo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:44:28 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52955 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964893AbWACX0g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:26:36 -0500
To: torvalds@osdl.org
Subject: [PATCH 02/41] m68k: compile fix - updated vmlinux.lds to include LOCK_TEXT
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1EtvY3-0003L4-Ed@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:26:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133442562 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68k/kernel/vmlinux-std.lds  |    1 +
 arch/m68k/kernel/vmlinux-sun3.lds |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

3e2f15535f3832b702b30f395108ba09be5ff2f3
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

