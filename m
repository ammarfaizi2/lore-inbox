Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbVDLTw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVDLTw0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVDLTum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:50:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:53704 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262109AbVDLKb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:57 -0400
Message-Id: <200504121031.j3CAViF8005391@shell0.pdx.osdl.net>
Subject: [patch 066/198] x86-64: i386 vDSO: add PT_NOTE segment
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, roland@redhat.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roland McGrath <roland@redhat.com>

Use the i386 PT_NOTE segment in x86_64 as well.

Signed-off-by: Roland McGrath <roland@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/ia32/vsyscall-sigreturn.S |    3 +++
 1 files changed, 3 insertions(+)

diff -puN arch/x86_64/ia32/vsyscall-sigreturn.S~x86-64-i386-vdso-add-pt_note-segment arch/x86_64/ia32/vsyscall-sigreturn.S
--- 25/arch/x86_64/ia32/vsyscall-sigreturn.S~x86-64-i386-vdso-add-pt_note-segment	2005-04-12 03:21:19.362193400 -0700
+++ 25-akpm/arch/x86_64/ia32/vsyscall-sigreturn.S	2005-04-12 03:21:19.365192944 -0700
@@ -118,3 +118,6 @@ __kernel_rt_sigreturn:
 
 	.align 4
 .LENDFDE3:
+
+#include "../../i386/kernel/vsyscall-note.S"
+
_
