Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030295AbWADWXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbWADWXY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbWADWXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:23:24 -0500
Received: from europa.telenet-ops.be ([195.130.137.75]:48800 "EHLO
	europa.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1030295AbWADWXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:23:23 -0500
To: linux-kernel@vger.kernel.org, mporter@kernel.crashing.org, akpm@osdl.org
Subject: [PATCH] ppc32: Re-add embed_config.c to ml300/ep405
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 04 Jan 2006 23:24:32 +0100
Message-ID: <87y81vvdgf.fsf@48ers.dk>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Commit 3e9e7c1d0b7a36fb8affb973a054c5098e27baa8 (ppc32: cleanup AMCC
PPC40x eval boards to support U-Boot) broke the kernel for ML300 /
EP405.

It still compiles as there's a weak definition of the function in
misc-embedded.c, but the kernel crashes as the bd_t fixup isn't
performed.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

diff -urpN linux-2.6.15.orig/arch/ppc/boot/simple/Makefile linux-2.6.15/arch/ppc/boot/simple/Makefile
--- linux-2.6.15.orig/arch/ppc/boot/simple/Makefile	2006-01-03 12:04:08.000000000 +0100
+++ linux-2.6.15/arch/ppc/boot/simple/Makefile	2006-01-04 15:08:46.000000000 +0100
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
Bye, Peter Korsgaard
