Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161043AbWJPR7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbWJPR7r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 13:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbWJPR7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 13:59:47 -0400
Received: from hoboe1bl1.telenet-ops.be ([195.130.137.72]:23518 "EHLO
	hoboe1bl1.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1161043AbWJPR7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 13:59:47 -0400
Date: Mon, 16 Oct 2006 19:59:43 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Mark Gross <mark.gross@intel.com>
Subject: [PATCH] CONFIG_TELCLOCK depends on X86
Message-ID: <Pine.LNX.4.64.0610161957520.10901@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The telecom clock driver for MPBL0010 ATCA SBC depends on X86

Signed-Off-By: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Gross <mark.gross@intel.com>

--- linux-2.6.19-rc2/drivers/char/Kconfig.orig	2006-10-05 11:16:43.000000000 +0200
+++ linux-2.6.19-rc2/drivers/char/Kconfig	2006-10-16 09:26:10.000000000 +0200
@@ -1046,7 +1046,7 @@ source "drivers/char/tpm/Kconfig"
 
 config TELCLOCK
 	tristate "Telecom clock driver for MPBL0010 ATCA SBC"
-	depends on EXPERIMENTAL
+	depends on EXPERIMENTAL && X86
 	default n
 	help
 	  The telecom clock device is specific to the MPBL0010 ATCA computer and

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
