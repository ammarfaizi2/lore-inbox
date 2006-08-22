Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWHVMhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWHVMhh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 08:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWHVMhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 08:37:37 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:39108 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932210AbWHVMhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 08:37:36 -0400
Date: Tue, 22 Aug 2006 14:37:27 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] AVR32: kprobes compile fix
Message-ID: <20060822143727.169a2938@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haavard Skinnemoen <hskinnemoen@atmel.com>

Add dummy flush_insn_slot define required by kprobes.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>

---
 include/asm-avr32/kprobes.h |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.18-rc4-mm2/include/asm-avr32/kprobes.h
===================================================================
--- linux-2.6.18-rc4-mm2.orig/include/asm-avr32/kprobes.h	2006-08-22 08:38:00.000000000 +0200
+++ linux-2.6.18-rc4-mm2/include/asm-avr32/kprobes.h	2006-08-22 08:38:50.000000000 +0200
@@ -29,4 +29,6 @@ struct arch_specific_insn {
 extern int kprobe_exceptions_notify(struct notifier_block *self,
 				    unsigned long val, void *data);
 
+#define flush_insn_slot(p)	do { } while (0)
+
 #endif /* __ASM_AVR32_KPROBES_H */
