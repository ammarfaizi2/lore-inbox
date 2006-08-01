Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932652AbWHALFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbWHALFr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWHALFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:05:46 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1245 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932646AbWHALFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:05:41 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 22/33] x86_64: Fix gdt table size in trampoline.S
Date: Tue,  1 Aug 2006 05:03:37 -0600
Message-Id: <11544302413302-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/trampoline.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86_64/kernel/trampoline.S b/arch/x86_64/kernel/trampoline.S
index 23a03eb..c79b99a 100644
--- a/arch/x86_64/kernel/trampoline.S
+++ b/arch/x86_64/kernel/trampoline.S
@@ -64,7 +64,7 @@ idt_48:
 	.word	0, 0			# idt base = 0L
 
 gdt_48:
-	.short	__KERNEL32_CS + 7	# gdt limit
+	.short	GDT_ENTRIES*8 - 1	# gdt limit
 	.long	cpu_gdt_table-__START_KERNEL_map
 
 .globl trampoline_end
-- 
1.4.2.rc2.g5209e

