Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423341AbWF1OOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423341AbWF1OOr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423343AbWF1OOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:14:47 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:37893 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1423341AbWF1OOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:14:46 -0400
Date: Wed, 28 Jun 2006 16:13:39 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] s390: remove unused macros from binfmt_elf32.c
Message-ID: <20060628141339.GC14375@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] remove unused macros from binfmt_elf32.c

The two macros NEW_TO_OLD_UID and NEW_TO_OLD_GID in binfmt_elf32.c
are not used by any code. Remove them.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/binfmt_elf32.c |    5 -----
 1 files changed, 5 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/binfmt_elf32.c linux-2.6-patched/arch/s390/kernel/binfmt_elf32.c
--- linux-2.6/arch/s390/kernel/binfmt_elf32.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/binfmt_elf32.c	2006-06-28 14:43:52.000000000 +0200
@@ -177,11 +177,6 @@ struct elf_prpsinfo32
 
 #include <linux/highuid.h>
 
-#undef NEW_TO_OLD_UID
-#undef NEW_TO_OLD_GID
-#define NEW_TO_OLD_UID(uid) ((uid) > 65535) ? (u16)overflowuid : (u16)(uid)
-#define NEW_TO_OLD_GID(gid) ((gid) > 65535) ? (u16)overflowgid : (u16)(gid) 
-
 #define elf_addr_t	u32
 /*
 #define init_elf_binfmt init_elf32_binfmt
