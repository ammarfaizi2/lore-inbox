Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965098AbWACX3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbWACX3o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbWACX3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:29:42 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:35992 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965098AbWACX3g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:29:36 -0500
To: torvalds@osdl.org
Subject: [PATCH 38/41] m68k: fix reference to init_task in vmlinux-sun3.lds
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1Etvax-0003Po-Q7@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:29:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135379268 -0500

it's *(.data.init_task), not init_task...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
(cherry picked from d626a118ee82e1c5ec3d1155d91825b5aca5bfd9 commit)

---

 arch/m68k/kernel/vmlinux-sun3.lds |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

f526c250f704ae3a076a98cdb14dc9ad438a9ebd
diff --git a/arch/m68k/kernel/vmlinux-sun3.lds b/arch/m68k/kernel/vmlinux-sun3.lds
index f814e66..65cc39c 100644
--- a/arch/m68k/kernel/vmlinux-sun3.lds
+++ b/arch/m68k/kernel/vmlinux-sun3.lds
@@ -67,7 +67,7 @@ __init_begin = .;
 	__initramfs_end = .;
 	. = ALIGN(8192);
 	__init_end = .;
-	.init.task : { *(init_task) }
+	.data.init.task : { *(.data.init_task) }
 
 
   .bss : { *(.bss) }		/* BSS */
-- 
0.99.9.GIT

