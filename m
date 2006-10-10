Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWJJWik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWJJWik (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWJJWik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:38:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:62082 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932267AbWJJWig
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:38:36 -0400
To: torvalds@osdl.org
Subject: [PATCH 11/16] smbfs endianness annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXQF9-00004u-U7@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 23:38:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Sat, 24 Dec 2005 14:32:38 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/smb_fs.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/smb_fs.h b/include/linux/smb_fs.h
index 367d6c3..13b3af5 100644
--- a/include/linux/smb_fs.h
+++ b/include/linux/smb_fs.h
@@ -43,17 +43,17 @@ static inline struct smb_inode_info *SMB
 
 /* macro names are short for word, double-word, long value (?) */
 #define WVAL(buf,pos) \
-	(le16_to_cpu(get_unaligned((u16 *)((u8 *)(buf) + (pos)))))
+	(le16_to_cpu(get_unaligned((__le16 *)((u8 *)(buf) + (pos)))))
 #define DVAL(buf,pos) \
-	(le32_to_cpu(get_unaligned((u32 *)((u8 *)(buf) + (pos)))))
+	(le32_to_cpu(get_unaligned((__le32 *)((u8 *)(buf) + (pos)))))
 #define LVAL(buf,pos) \
-	(le64_to_cpu(get_unaligned((u64 *)((u8 *)(buf) + (pos)))))
+	(le64_to_cpu(get_unaligned((__le64 *)((u8 *)(buf) + (pos)))))
 #define WSET(buf,pos,val) \
-	put_unaligned(cpu_to_le16((u16)(val)), (u16 *)((u8 *)(buf) + (pos)))
+	put_unaligned(cpu_to_le16((u16)(val)), (__le16 *)((u8 *)(buf) + (pos)))
 #define DSET(buf,pos,val) \
-	put_unaligned(cpu_to_le32((u32)(val)), (u32 *)((u8 *)(buf) + (pos)))
+	put_unaligned(cpu_to_le32((u32)(val)), (__le32 *)((u8 *)(buf) + (pos)))
 #define LSET(buf,pos,val) \
-	put_unaligned(cpu_to_le64((u64)(val)), (u64 *)((u8 *)(buf) + (pos)))
+	put_unaligned(cpu_to_le64((u64)(val)), (__le64 *)((u8 *)(buf) + (pos)))
 
 /* where to find the base of the SMB packet proper */
 #define smb_base(buf) ((u8 *)(((u8 *)(buf))+4))
-- 
1.4.2.GIT


