Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263139AbUJ2IQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263139AbUJ2IQm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 04:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbUJ2IQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 04:16:42 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:739 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263139AbUJ2IPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 04:15:54 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Add __param linker section
Cc: linux-kernel@vger.kernel.org
From: Miles Bader <miles@gnu.org>
Message-Id: <20041029081547.5E5984D9@mctpc71>
Date: Fri, 29 Oct 2004 17:15:47 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 arch/v850/kernel/vmlinux.lds.S |    5 +++++
 1 files changed, 5 insertions(+)

diff -ruN -X../cludes linux-2.6.9-uc0/arch/v850/kernel/vmlinux.lds.S linux-2.6.9-uc0-v850-20041028/arch/v850/kernel/vmlinux.lds.S
--- linux-2.6.9-uc0/arch/v850/kernel/vmlinux.lds.S	2004-10-25 15:14:32 +0900
+++ linux-2.6.9-uc0-v850-20041028/arch/v850/kernel/vmlinux.lds.S	2004-10-28 18:33:44 +0900
@@ -60,6 +60,11 @@
 		___start___kcrctab_gpl = .;				      \
 			*(__kcrctab_gpl)				      \
 		___stop___kcrctab_gpl = .;				      \
+		/* Built-in module parameters */			      \
+		___start___param = .;					      \
+		*(__param)						      \
+		___stop___param = .;
+
 
 /* Kernel text segment, and some constant data areas.  */
 #define TEXT_CONTENTS							      \
