Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758839AbWLDKnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758839AbWLDKnQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 05:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758899AbWLDKnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 05:43:16 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:52620 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1758839AbWLDKnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 05:43:15 -0500
Date: Mon, 4 Dec 2006 03:43:14 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] VIA and SiS AGP chipsets are x86-only
Message-ID: <20061204104314.GB3013@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's no point in troubling the Alpha, IA-64, PowerPC and PARISC
people with SiS and VIA options.  Andrew thinks it helps find bugs,
but there's no evidence of that.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

diff --git a/drivers/char/agp/Kconfig b/drivers/char/agp/Kconfig
index c603bf2..a9f9c48 100644
--- a/drivers/char/agp/Kconfig
+++ b/drivers/char/agp/Kconfig
@@ -86,7 +86,7 @@ config AGP_NVIDIA
 
 config AGP_SIS
 	tristate "SiS chipset support"
-	depends on AGP
+	depends on AGP && X86
 	help
 	  This option gives you AGP support for the GLX component of
 	  X on Silicon Integrated Systems [SiS] chipsets.
@@ -103,7 +103,7 @@ config AGP_SWORKS
 
 config AGP_VIA
 	tristate "VIA chipset support"
-	depends on AGP
+	depends on AGP && X86
 	help
 	  This option gives you AGP support for the GLX component of
 	  X on VIA MVP3/Apollo Pro chipsets.
