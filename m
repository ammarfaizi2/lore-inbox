Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbTD1WfH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 18:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbTD1WfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 18:35:07 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:26247 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S261359AbTD1WfF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 18:35:05 -0400
Subject: [PATCH] Make struct alt_instr acceptable to userland
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Andrew Morton <akpm@digeo.com>, ak@suse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1051570042.12949.67.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 28 Apr 2003 15:47:22 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi's new struct alt_instr is visible to klibc.  The attached patch
changes the types it uses, so that klibc becomes happy.

	<b

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1142  -> 1.1143 
#	include/asm-i386/system.h	1.27    -> 1.28   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/04/28	bos@serpentine.com	1.1143
# struct alt_instr is visible to userland, so change the types it uses
# --------------------------------------------
#
diff -Nru a/include/asm-i386/system.h b/include/asm-i386/system.h
--- a/include/asm-i386/system.h	Mon Apr 28 15:43:42 2003
+++ b/include/asm-i386/system.h	Mon Apr 28 15:43:42 2003
@@ -278,11 +278,11 @@
 #endif
 
 struct alt_instr { 
-	u8 *instr; 		/* original instruction */
-	u8  cpuid;		/* cpuid bit set for replacement */
-	u8  instrlen;		/* length of original instruction */
-	u8  replacementlen; 	/* length of new instruction, <= instrlen */ 
-	u8  replacement[0];   	/* new instruction */
+	__u8 *instr; 		/* original instruction */
+	__u8  cpuid;		/* cpuid bit set for replacement */
+	__u8  instrlen;		/* length of original instruction */
+	__u8  replacementlen; 	/* length of new instruction, <= instrlen */ 
+	__u8  replacement[0];	/* new instruction */
 }; 
 
 /* 



