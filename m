Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVEFSia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVEFSia (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 14:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVEFSia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 14:38:30 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:38024 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261245AbVEFSiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 14:38:25 -0400
Date: Fri, 6 May 2005 13:38:05 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc32: Fix POWER3/POWER4 compiler error
Message-ID: <Pine.LNX.4.61.0505061336250.28348@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In separating out support for hardware floating point we missed the fact that
both POWER3 and POWER4 have HW FP.  Enable CONFIG_PPC_FPU for POWER3 
and POWER4 fixes the issue.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit c196b5792abdb89f18ee55fb5a84afe89b0fc92d
tree 82bf0144d326efbdfe33c81eb1a7e23bb9dc081b
parent 6741f3a7f9922391cd02b3ca1329e669497dc22f
author Kumar K. Gala <kumar.gala@freescale.com> 1115399859 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> 1115399859 -0500

Index: arch/ppc/Kconfig
===================================================================
--- cda5ab7ce1bc4b36cb164e6daee18c7649348fb4/arch/ppc/Kconfig  (mode:100644 sha1:d0d94e56b90b9ec8ab65c4780c4b0804663482af)
+++ 82bf0144d326efbdfe33c81eb1a7e23bb9dc081b/arch/ppc/Kconfig  (mode:100644 sha1:600f23d7fd33aae9e5115875ada43a289e075b5d)
@@ -77,9 +77,11 @@
 	bool "44x"
 
 config POWER3
+	select PPC_FPU
 	bool "POWER3"
 
 config POWER4
+	select PPC_FPU
 	bool "POWER4 and 970 (G5)"
 
 config 8xx
