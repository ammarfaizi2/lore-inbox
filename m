Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbTCGIEX>; Fri, 7 Mar 2003 03:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261441AbTCGIEX>; Fri, 7 Mar 2003 03:04:23 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:49423 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S261426AbTCGIEW>; Fri, 7 Mar 2003 03:04:22 -0500
To: alan@redhat.com
Cc: rth@twiddle.net, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix vmlinux.lds.S on alpha
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 07 Mar 2003 09:13:36 +0100
Message-ID: <wrpr89j61cf.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[A previous mail was sent without subject and wrong address... sorry
about that]

Alan, Richard,

The console initcall patch that went in contains a typo that prevents
alpha from building. The included patch fixes it.

Thanks,

        M.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1045  -> 1.1046 
#	arch/alpha/vmlinux.lds.S	1.19    -> 1.20   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/07	maz@hina.wild-wind.fr.eu.org	1.1046
# Fix arch/alpha/vmlinux.lds.S typos.
# --------------------------------------------
#
diff -Nru a/arch/alpha/vmlinux.lds.S b/arch/alpha/vmlinux.lds.S
--- a/arch/alpha/vmlinux.lds.S	Fri Mar  7 08:58:06 2003
+++ b/arch/alpha/vmlinux.lds.S	Fri Mar  7 08:58:06 2003
@@ -63,8 +63,8 @@
   .init.ramfs : { *(.init.ramfs) }
   __initramfs_end = .;
 
-  . = ALIGN(8)
-  .con_initcall.init: {
+  . = ALIGN(8);
+  .con_initcall.init : {
 	__con_initcall_start = .;
 	*(.con_initcall.init)
 	__con_initcall_end = .;

-- 
Places change, faces change. Life is so very strange.
