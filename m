Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291508AbSBMKTw>; Wed, 13 Feb 2002 05:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291509AbSBMKTn>; Wed, 13 Feb 2002 05:19:43 -0500
Received: from panoramix.vasoftware.com ([198.186.202.147]:17061 "EHLO
	mail2.vasoftware.com") by vger.kernel.org with ESMTP
	id <S291508AbSBMKTX>; Wed, 13 Feb 2002 05:19:23 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15466.15457.959849.250396@argo.ozlabs.ibm.com>
Date: Wed, 13 Feb 2002 21:13:53 +1100 (EST)
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] fs/ext2/balloc.c compile fix (v2.5.4)
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus' linux-2.5 bitkeeper tree needs this patch to compile...

diff -urN linux-2.5/fs/ext2/balloc.c pmac-2.5/fs/ext2/balloc.c
--- linux-2.5/fs/ext2/balloc.c	Tue Feb 12 19:17:37 2002
+++ pmac-2.5/fs/ext2/balloc.c	Wed Feb 13 16:13:00 2002
@@ -518,7 +518,7 @@
 		dq_alloc -= n;
 		group_alloc -= n;
 	}
-	write_unlock(&EXT2_I(inode->i_meta_lock);
+	write_unlock(&EXT2_I(inode)->i_meta_lock);
 
 	mark_buffer_dirty(bh);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
