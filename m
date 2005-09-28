Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbVI1XbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbVI1XbQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 19:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVI1XbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 19:31:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:434 "EHLO ZenIV.linux.org.uk")
	by vger.kernel.org with ESMTP id S1751236AbVI1XbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 19:31:15 -0400
Date: Thu, 29 Sep 2005 00:31:14 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc32 ld.script fix for building on ppc64
Message-ID: <20050928233114.GJ7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	In arch/ppc/boot/ld.script we need OUTPUT_ARCH(powerpc:common) for
the same reasons why we need it in vmlinux.lds.S; when we build on ppc64
box, we need to be explicit about the target.
	See http://linus.bkbits.net:8080/linux-2.5/cset@1.1784.8.10 for
the corresponding fix in vmlinux.lds.S.
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-uml-kconfig/arch/ppc/boot/ld.script RC14-rc2-git6-ppc-arch/arch/ppc/boot/ld.script
--- RC14-rc2-git6-uml-kconfig/arch/ppc/boot/ld.script	2005-08-28 23:09:40.000000000 -0400
+++ RC14-rc2-git6-ppc-arch/arch/ppc/boot/ld.script	2005-09-28 13:02:21.000000000 -0400
@@ -1,4 +1,4 @@
-OUTPUT_ARCH(powerpc)
+OUTPUT_ARCH(powerpc:common)
 SECTIONS
 {
   /* Read-only sections, merged into text segment: */
