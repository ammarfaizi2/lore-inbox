Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWGKMoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWGKMoD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 08:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWGKMnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 08:43:42 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:14035 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751253AbWGKMnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 08:43:40 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 5/7] AVR32: Always enable CONFIG_EMBEDDED
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 11 Jul 2006 14:43:20 +0200
Message-Id: <1152621802839-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11526218021659-git-send-email-hskinnemoen@atmel.com>
References: <11526218021728-git-send-email-hskinnemoen@atmel.com> <11526218022840-git-send-email-hskinnemoen@atmel.com> <11526218024091-git-send-email-hskinnemoen@atmel.com> <11526218021811-git-send-email-hskinnemoen@atmel.com> <11526218021659-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_EMBEDDED is not defined, we are unable to deselect some
options which are unnecessary on most AVR32 setups. This patch
unconditionally selects CONFIG_EMBEDDED so that "make allnoconfig"
produces something closer to a minimal setup.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/avr32/Kconfig b/arch/avr32/Kconfig
index b12216a..dd3190b 100644
--- a/arch/avr32/Kconfig
+++ b/arch/avr32/Kconfig
@@ -8,6 +8,9 @@ mainmenu "Linux Kernel Configuration"
 config AVR32
 	bool
 	default y
+	# With EMBEDDED=n, we get lots of stuff automatically selected
+	# that we usually don't need on AVR32.
+	select EMBEDDED
 	help
 	  AVR32 is a high-performance 32-bit RISC microprocessor core,
 	  designed for cost-sensitive embedded applications, with particular
-- 
1.4.0

