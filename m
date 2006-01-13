Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161649AbWAMDTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161649AbWAMDTV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161651AbWAMDTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:19:20 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:28288 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161649AbWAMDTT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:19:19 -0500
Message-Id: <20060113032241.970014000@sorel.sous-sol.org>
References: <20060113032102.154909000@sorel.sous-sol.org>
Date: Thu, 12 Jan 2006 18:37:43 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, jacmet@sunsite.dk
Subject: [PATCH 05/17] ppc32: Re-add embed_config.c to ml300/ep405
Content-Disposition: inline; filename=ppc32-re-add-embed_configc-to-ml300-ep405.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Commit 3e9e7c1d0b7a36fb8affb973a054c5098e27baa8 (ppc32: cleanup AMCC PPC40x
eval boards to support U-Boot) broke the kernel for ML300 / EP405.

It still compiles as there's a weak definition of the function in
misc-embedded.c, but the kernel crashes as the bd_t fixup isn't performed.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/ppc/boot/simple/Makefile |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.15.y.orig/arch/ppc/boot/simple/Makefile
+++ linux-2.6.15.y/arch/ppc/boot/simple/Makefile
@@ -190,6 +190,8 @@ boot-$(CONFIG_REDWOOD_5)	+= embed_config
 boot-$(CONFIG_REDWOOD_6)	+= embed_config.o
 boot-$(CONFIG_8xx)		+= embed_config.o
 boot-$(CONFIG_8260)		+= embed_config.o
+boot-$(CONFIG_EP405)		+= embed_config.o
+boot-$(CONFIG_XILINX_ML300)	+= embed_config.o
 boot-$(CONFIG_BSEIP)		+= iic.o
 boot-$(CONFIG_MBX)		+= iic.o pci.o qspan_pci.o
 boot-$(CONFIG_MV64X60)		+= misc-mv64x60.o

--
