Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbTEFC6W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 22:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTEFC5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 22:57:49 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:35216 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262294AbTEFC5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 22:57:07 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Add leading underline to new linker-script symbols on the v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030506030925.388CC3760@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue,  6 May 2003 12:09:25 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed to match the output of the C compiler.

diff -ruN -X../cludes linux-2.5.69-uc0/arch/v850/vmlinux.lds.S linux-2.5.69-uc0-v850-20030506/arch/v850/vmlinux.lds.S
--- linux-2.5.69-uc0/arch/v850/vmlinux.lds.S	2003-04-21 10:52:40.000000000 +0900
+++ linux-2.5.69-uc0-v850-20030506/arch/v850/vmlinux.lds.S	2003-05-06 10:40:26.000000000 +0900
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
