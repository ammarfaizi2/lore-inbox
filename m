Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbVKNVRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVKNVRz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbVKNVRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:17:55 -0500
Received: from www.swissdisk.com ([216.144.233.50]:39299 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S932138AbVKNVRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:17:54 -0500
Date: Mon, 14 Nov 2005 12:09:55 -0800
From: Ben Collins <bcollins@ubuntu.com>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2.6.15-rc1] Add missing EXPORT_SYMBOLS() for __ide_mm_* functions on powerpc
Message-ID: <20051114200955.GC15937@swissdisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These exported symbols are in arch/ppc/ but missing from arch/powerpc/ for
ppc32 builds.


--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -105,6 +105,11 @@ EXPORT_SYMBOL(__clear_user);
 EXPORT_SYMBOL(__strncpy_from_user);
 EXPORT_SYMBOL(__strnlen_user);
 
+EXPORT_SYMBOL(__ide_mm_insl);
+EXPORT_SYMBOL(__ide_mm_outsw);
+EXPORT_SYMBOL(__ide_mm_insw);
+EXPORT_SYMBOL(__ide_mm_outsl);
+
 EXPORT_SYMBOL(_insb);
 EXPORT_SYMBOL(_outsb);
 EXPORT_SYMBOL(_insw);

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux
