Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934190AbWKXXtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934190AbWKXXtd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 18:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934382AbWKXXtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 18:49:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5381 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S934190AbWKXXtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 18:49:32 -0500
Date: Sat, 25 Nov 2006 00:49:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: paulus@samba.org, Kumar Gala <galak@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org
Subject: RFC: powerpc: remove GEMINI support?
Message-ID: <20061124234935.GJ28363@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just saw the commit message below.

There seems to have been some although unmerged work on APUS support by 
Roman, but I didn't find any recent work on bringing the GEMINI support 
back into life.

Is this a wrong impression, or would a patch to remove it be OK?

cu
Adrian


commit e8be1c8e065691c332fd8e9bae70c7096a69c31d
Author: Kumar Gala <galak@freescale.com>
Date:   Sun Jul 31 22:34:51 2005 -0700

    [PATCH] ppc32: Mark boards that don't build as BROKEN
    
    Marked APUS and GEMINI as BROKEN since they do not build at the platform
    level.  We have requested that the maintainers of these boards/platforms
    fix them by the time 2.6.15 is released or we plan on concerning them
    unmaintained and thus removing them.
    
    Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index 2c2da9b..f6db3b3 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -558,6 +558,7 @@ config PPC_MULTIPLATFORM
 
 config APUS
 	bool "Amiga-APUS"
+	depends on BROKEN
 	help
 	  Select APUS if configuring for a PowerUP Amiga.
 	  More information is available at:
@@ -647,6 +648,7 @@ config PAL4
 
 config GEMINI
 	bool "Synergy-Gemini"
+	depends on BROKEN
 	help
 	  Select Gemini if configuring for a Synergy Microsystems' Gemini
 	  series Single Board Computer.  More information is available at:

