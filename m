Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262446AbVAEO2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbVAEO2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 09:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVAEO2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 09:28:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16773 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262446AbVAEO2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 09:28:09 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FRV: vperfctr syscalls don't exist in -bk8
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 05 Jan 2005 14:28:03 +0000
Message-ID: <28475.1104935283@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch marks the vperfctr syscalls as unavailable as they aren't
actually implemented in -bk8.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat frv-no-vperfctr-2610bk8.diff 
 entry.S |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.10-bk8/arch/frv/kernel/entry.S linux-2.6.10-bk8-frv/arch/frv/kernel/entry.S
--- /warthog/kernels/linux-2.6.10-bk8/arch/frv/kernel/entry.S	2005-01-05 13:21:26.123275023 +0000
+++ linux-2.6.10-bk8-frv/arch/frv/kernel/entry.S	2005-01-05 13:47:01.027785577 +0000
@@ -1421,11 +1421,11 @@ sys_call_table:
 	.long sys_add_key
 	.long sys_request_key
 	.long sys_keyctl
-	.long sys_vperfctr_open
-	.long sys_vperfctr_control	/* 290 */
-	.long sys_vperfctr_unlink
-	.long sys_vperfctr_iresume
-	.long sys_vperfctr_read
+	.long sys_ni_syscall // sys_vperfctr_open
+	.long sys_ni_syscall // sys_vperfctr_control	/* 290 */
+	.long sys_ni_syscall // sys_vperfctr_unlink
+	.long sys_ni_syscall // sys_vperfctr_iresume
+	.long sys_ni_syscall // sys_vperfctr_read
 
 
 syscall_table_size = (. - sys_call_table)
