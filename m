Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966393AbWKTWa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966393AbWKTWa6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934279AbWKTWa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:30:58 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:61435 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S934272AbWKTWa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:30:57 -0500
Date: Mon, 20 Nov 2006 16:30:50 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net
Subject: [POWERPC][PATCH 1/2] Revert "[POWERPC] Enable generic rtc hook for
 the MPC8349 mITX"
Message-Id: <20061120163050.1ce160b8.kim.phillips@freescale.com>
Organization: Freescale Semiconductor
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAQ=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a8ed4f7ec3aa472134d7de6176f823b2667e450b.

As advised by David Brownell:

http://marc.theaimsgroup.com/?l=linux-kernel&m=116387226902131&w=2
---
 arch/powerpc/platforms/83xx/mpc834x_itx.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index e152d06..314c42a 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -108,10 +108,6 @@ static int __init mpc834x_itx_probe(void
 	return 1;
 }
 
-#ifdef CONFIG_RTC_CLASS
-late_initcall(rtc_class_hookup);
-#endif
-
 define_machine(mpc834x_itx) {
 	.name			= "MPC834x ITX",
 	.probe			= mpc834x_itx_probe,
-- 
1.4.2.3

