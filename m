Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTDUFDS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 01:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTDUFDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 01:03:15 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:36511 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263764AbTDUFDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 01:03:14 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Add leading underline to new linker-script symbols on the v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030421051303.66A583711@mcspd15.ucom.lsi.nec.co.jp>
Date: Mon, 21 Apr 2003 14:13:03 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed to match the output of the C compiler.

diff -ruN -X../cludes linux-2.5.68-uc0/arch/v850/vmlinux.lds.S linux-2.5.68-uc0-v850-20030421/arch/v850/vmlinux.lds.S
--- linux-2.5.68-uc0/arch/v850/vmlinux.lds.S	2003-04-21 10:52:40.000000000 +0900
+++ linux-2.5.68-uc0-v850-20030421/arch/v850/vmlinux.lds.S	2003-04-21 11:39:51.000000000 +0900
@@ -105,9 +110,9 @@
 #define RAMK_INIT_CONTENTS_NO_END					      \
 		. = ALIGN (4096) ;					      \
 		__init_start = . ;					      \
-			_sinittext = .;					      \
+			__sinittext = .;				      \
 			*(.init.text)	/* 2.5 convention */		      \
-			_einittext = .;					      \
+			__einittext = .;				      \
 			*(.init.data)					      \
 			*(.text.init)	/* 2.4 convention */		      \
 			*(.data.init)					      \
