Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272801AbTHKRVJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272803AbTHKQtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:49:50 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:89 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272801AbTHKQta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:49:30 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] EFI 64bit fixup
Message-Id: <E19mFqq-000685-00@tetrachloride>
Date: Mon, 11 Aug 2003 17:48:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/partitions/efi.h linux-2.5/fs/partitions/efi.h
--- bk-linus/fs/partitions/efi.h	2003-07-17 23:23:36.000000000 +0100
+++ linux-2.5/fs/partitions/efi.h	2003-07-17 23:45:00.000000000 +0100
@@ -39,7 +39,7 @@
 #define EFI_PMBR_OSTYPE_EFI_GPT 0xEE
 
 #define GPT_BLOCK_SIZE 512
-#define GPT_HEADER_SIGNATURE 0x5452415020494645L
+#define GPT_HEADER_SIGNATURE 0x5452415020494645ULL
 #define GPT_HEADER_REVISION_V1 0x00010000
 #define GPT_PRIMARY_PARTITION_TABLE_LBA 1
 
