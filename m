Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWGKMoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWGKMoE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 08:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWGKMoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 08:44:03 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:10471 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751258AbWGKMn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 08:43:58 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 6/7] AVR32: Export the find_*_bit() functions
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 11 Jul 2006 14:43:21 +0200
Message-Id: <11526218021435-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <1152621802839-git-send-email-hskinnemoen@atmel.com>
References: <11526218021728-git-send-email-hskinnemoen@atmel.com> <11526218022840-git-send-email-hskinnemoen@atmel.com> <11526218024091-git-send-email-hskinnemoen@atmel.com> <11526218021811-git-send-email-hskinnemoen@atmel.com> <11526218021659-git-send-email-hskinnemoen@atmel.com> <1152621802839-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several filesystems depend on at least some of these functions, and
they are exported on all other arches as far as I can tell.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/kernel/avr32_ksyms.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/avr32/kernel/avr32_ksyms.c b/arch/avr32/kernel/avr32_ksyms.c
index d9dd1fc..04f767a 100644
--- a/arch/avr32/kernel/avr32_ksyms.c
+++ b/arch/avr32/kernel/avr32_ksyms.c
@@ -46,3 +46,10 @@ EXPORT_SYMBOL(csum_partial_copy_generic)
 EXPORT_SYMBOL(__ndelay);
 EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(__const_udelay);
+
+/* Bit operations (lib/findbit.S) */
+EXPORT_SYMBOL(find_first_zero_bit);
+EXPORT_SYMBOL(find_next_zero_bit);
+EXPORT_SYMBOL(find_first_bit);
+EXPORT_SYMBOL(find_next_bit);
+EXPORT_SYMBOL(generic_find_next_zero_le_bit);
-- 
1.4.0

