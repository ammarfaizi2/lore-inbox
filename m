Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWJDX0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWJDX0a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 19:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWJDX03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 19:26:29 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:22145 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751226AbWJDX02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 19:26:28 -0400
Message-Id: <20061004232458.353183000@linux-m68k.org>
References: <20061004232414.730831000@linux-m68k.org>
User-Agent: quilt/0.45-1
Date: Thu, 05 Oct 2006 01:24:17 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] m68k: fix type in __generic_copy_to_user
Content-Disposition: inline; filename=uaccess_fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jump to the correct exit label after exception

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---
 arch/m68k/lib/uaccess.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/m68k/lib/uaccess.c
===================================================================
--- linux-2.6.orig/arch/m68k/lib/uaccess.c
+++ linux-2.6/arch/m68k/lib/uaccess.c
@@ -84,7 +84,7 @@ unsigned long __generic_copy_to_user(voi
 		"	.even\n"
 		"20:	lsl.l	#2,%0\n"
 		"50:	add.l	%5,%0\n"
-		"	jra	7b\n"
+		"	jra	8b\n"
 		"	.previous\n"
 		"\n"
 		"	.section __ex_table,\"a\"\n"

--

