Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbTE0JL0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 05:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbTE0JKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 05:10:30 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:21210 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263062AbTE0JIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 05:08:32 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Add leading underline to new linker-script symbols on the v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030527092133.8C0613774@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 27 May 2003 18:21:33 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed to match the output of the C compiler.

diff -ruN -X../cludes linux-2.5.70/arch/v850/vmlinux.lds.S linux-2.5.70-v850-20030527/arch/v850/vmlinux.lds.S
--- linux-2.5.70/arch/v850/vmlinux.lds.S	2003-04-21 10:52:40.000000000 +0900
+++ linux-2.5.70-v850-20030527/arch/v850/vmlinux.lds.S	2003-05-27 16:09:43.000000000 +0900
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
