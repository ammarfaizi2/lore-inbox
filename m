Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264607AbTFQFxW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 01:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264605AbTFQFwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 01:52:08 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:22768 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S264606AbTFQFv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 01:51:59 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Add .con_initcall.init section on v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030617060539.189A63732@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 17 Jun 2003 15:05:39 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.72-moo/arch/v850/vmlinux.lds.S linux-2.5.72-moo-v850-20030617/arch/v850/vmlinux.lds.S
--- linux-2.5.72-moo/arch/v850/vmlinux.lds.S	2003-06-16 14:52:17.000000000 +0900
+++ linux-2.5.72-moo-v850-20030617/arch/v850/vmlinux.lds.S	2003-06-17 14:23:12.000000000 +0900
@@ -95,7 +97,10 @@
 			*(.initcall6.init)				      \
 			*(.initcall7.init)				      \
 		. = ALIGN (4) ;						      \
-		___initcall_end = . ;
+		___initcall_end = . ;					      \
+		___con_initcall_start = .;				      \
+			*(.con_initcall.init)				      \
+		___con_initcall_end = .;
 
 /* Contents of `init' section for a kernel that's loaded into RAM.  */
 #define RAMK_INIT_CONTENTS						      \
