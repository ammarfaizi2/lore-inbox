Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVA2WSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVA2WSf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 17:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVA2WSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 17:18:35 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:23215 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261573AbVA2WSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 17:18:30 -0500
Date: Sat, 29 Jan 2005 23:18:26 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] Kconfig: cleanup the menu structure
Message-ID: <Pine.LNX.4.61.0501292301470.7147@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patches cleans up some of the worst offenders, which mess up 
the kconfig menu structure. The patches apply to 2.6.11-rc2-mm2 and 
2.6.11-rc2-bk7, the only exception is the one below. Andrew, I leave it 
to you what to do with it, maybe fold it directly into kgdb-ga.patch?

bye, Roman

---

 Kconfig.debug |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.11/arch/i386/Kconfig.debug
===================================================================
--- linux-2.6.11.orig/arch/i386/Kconfig.debug	2005-01-29 22:56:22.470544173 +0100
+++ linux-2.6.11/arch/i386/Kconfig.debug	2005-01-29 22:58:15.270112850 +0100
@@ -56,6 +56,8 @@ config 4KSTACKS
 	  on the VM subsystem for higher order allocations. This option
 	  will also use IRQ stacks to compensate for the reduced stackspace.
 
+source "arch/i386/Kconfig.kgdb"
+
 config X86_FIND_SMP_CONFIG
 	bool
 	depends on X86_LOCAL_APIC || X86_VOYAGER
@@ -66,6 +68,4 @@ config X86_MPPARSE
 	depends on X86_LOCAL_APIC && !X86_VISWS
 	default y
 
-source "arch/i386/Kconfig.kgdb"
-
 endmenu
