Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWGKMoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWGKMoM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 08:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWGKMoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 08:44:10 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:1254 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751256AbWGKMnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 08:43:55 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 4/7] AVR32: Turn off support for DISCONTIGMEM and SPARSEMEM
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 11 Jul 2006 14:43:19 +0200
Message-Id: <11526218021659-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11526218021811-git-send-email-hskinnemoen@atmel.com>
References: <11526218021728-git-send-email-hskinnemoen@atmel.com> <11526218022840-git-send-email-hskinnemoen@atmel.com> <11526218024091-git-send-email-hskinnemoen@atmel.com> <11526218021811-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just gave CONFIG_DISCONTIGMEM a try on AVR32 and it turned out it
didn't compile.

Since there's only a single board available, and that board has no
use for discontigmem or sparsemem anyway, I figured it's better to
just turn it off until a need for it arises.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/Kconfig |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/avr32/Kconfig b/arch/avr32/Kconfig
index 89d7456..b12216a 100644
--- a/arch/avr32/Kconfig
+++ b/arch/avr32/Kconfig
@@ -132,12 +132,11 @@ config ARCH_FLATMEM_ENABLE
 
 config ARCH_DISCONTIGMEM_ENABLE
 	bool
-	default y
+	default n
 
 config ARCH_SPARSEMEM_ENABLE
 	bool
-	depends on EXPERIMENTAL
-	default y
+	default n
 
 source "mm/Kconfig"
 
-- 
1.4.0

