Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030620AbWJJWjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030620AbWJJWjZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030624AbWJJWjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:39:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:63618 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030620AbWJJWjI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:39:08 -0400
To: torvalds@osdl.org
Subject: [PATCH 14/16] fs/partitions endianness annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXQFd-00005g-VP@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 23:39:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Sat, 24 Dec 2005 14:39:13 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/partitions/msdos.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/partitions/msdos.c b/fs/partitions/msdos.c
index 4f8df71..8c7af17 100644
--- a/fs/partitions/msdos.c
+++ b/fs/partitions/msdos.c
@@ -32,13 +32,11 @@ #include "efi.h"
 #include <asm/unaligned.h>
 
 #define SYS_IND(p)	(get_unaligned(&p->sys_ind))
-#define NR_SECTS(p)	({ __typeof__(p->nr_sects) __a =	\
-				get_unaligned(&p->nr_sects);	\
+#define NR_SECTS(p)	({ __le32 __a =	get_unaligned(&p->nr_sects);	\
 				le32_to_cpu(__a); \
 			})
 
-#define START_SECT(p)	({ __typeof__(p->start_sect) __a =	\
-				get_unaligned(&p->start_sect);	\
+#define START_SECT(p)	({ __le32 __a =	get_unaligned(&p->start_sect);	\
 				le32_to_cpu(__a); \
 			})
 
-- 
1.4.2.GIT


