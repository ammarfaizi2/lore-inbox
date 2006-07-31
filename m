Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWGaN4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWGaN4M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 09:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWGaN4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 09:56:11 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:35797 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1750710AbWGaN4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 09:56:10 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 1/6] AVR32: Use auto.conf instead of MARKER
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Mon, 31 Jul 2006 15:55:55 +0200
Message-Id: <1154354160566-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/config/MARKER was killed by the commit
'kconfig: integrate split config into silentoldconfig', which also
updated all arches to use include/config/auto.conf instead.

This brings AVR32 in sync with everyone else.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/avr32/Makefile b/arch/avr32/Makefile
index 9c41777..fb314af 100644
--- a/arch/avr32/Makefile
+++ b/arch/avr32/Makefile
@@ -34,7 +34,7 @@ libs-y					+= arch/avr32/lib/ #$(LIBGCC)
 
 archincdir-$(CONFIG_PLATFORM_AT32AP)	:= arch-at32ap
 
-include/asm-avr32/.arch: $(wildcard include/config/platform/*.h) include/config/MARKER
+include/asm-avr32/.arch: $(wildcard include/config/platform/*.h) include/config/auto.conf
 	@echo '  SYMLINK include/asm-avr32/arch -> include/asm-avr32/$(archincdir-y)'
 ifneq ($(KBUILD_SRC),)
 	$(Q)mkdir -p include/asm-avr32
-- 
1.4.0

