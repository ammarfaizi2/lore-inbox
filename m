Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVAWHE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVAWHE3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 02:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVAWHE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 02:04:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:30386 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261238AbVAWHEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 02:04:21 -0500
Date: Sat, 22 Jan 2005 22:52:22 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: phil.el@wanadoo.fr, akpm <akpm@osdl.org>
Subject: [PATCH] oprofile: use NULL for pointer
Message-Id: <20050122225222.0c3baf45.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use NULL instead of 0 for pointer:

arch/x86_64/oprofile/../../i386/oprofile/backtrace.c:30:10: warning: Using plain integer as NULL pointer

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 arch/i386/oprofile/backtrace.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./arch/i386/oprofile/backtrace.c~oprofile_null ./arch/i386/oprofile/backtrace.c
--- ./arch/i386/oprofile/backtrace.c~oprofile_null	2005-01-22 19:06:29.923734008 -0800
+++ ./arch/i386/oprofile/backtrace.c	2005-01-22 22:05:44.485792064 -0800
@@ -27,7 +27,7 @@ dump_backtrace(struct frame_head * head)
 	/* frame pointers should strictly progress back up the stack
 	 * (towards higher addresses) */
 	if (head >= head->ebp)
-		return 0;
+		return NULL;
 
 	return head->ebp;
 }

--
