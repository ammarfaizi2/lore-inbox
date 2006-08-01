Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422781AbWHALOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422781AbWHALOc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWHALFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:05:54 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63196 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932639AbWHALFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:05:34 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 20/33] x86_64: fix early_printk to use the standard ISA mapping
Date: Tue,  1 Aug 2006 05:03:35 -0600
Message-Id: <11544302404090-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/early_printk.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/x86_64/kernel/early_printk.c b/arch/x86_64/kernel/early_printk.c
index 140051e..d2b4cfb 100644
--- a/arch/x86_64/kernel/early_printk.c
+++ b/arch/x86_64/kernel/early_printk.c
@@ -11,11 +11,10 @@ #include <asm/fcntl.h>
 
 #ifdef __i386__
 #include <asm/setup.h>
-#define VGABASE		(__ISA_IO_base + 0xb8000)
 #else
 #include <asm/bootsetup.h>
-#define VGABASE		((void __iomem *)0xffffffff800b8000UL)
 #endif
+#define VGABASE		(__ISA_IO_base + 0xb8000)
 
 static int max_ypos = 25, max_xpos = 80;
 static int current_ypos = 25, current_xpos = 0;
-- 
1.4.2.rc2.g5209e

