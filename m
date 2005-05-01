Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262681AbVEAVUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbVEAVUx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 17:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbVEAVTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 17:19:23 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:21267 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262681AbVEAVSZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:18:25 -0400
Message-Id: <200505012112.j41LCVs9016424@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH 8/22] UML - Fix missing subdir in x86_64
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 May 2005 17:12:31 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Al Viro:

	make distclean et.al. are missing arch/um/sys-x86_64/utils; fixed
the same way we have it done for sys-i386 counterpart.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11-mm/arch/um/sys-x86_64/Makefile
===================================================================
--- linux-2.6.11-mm.orig/arch/um/sys-x86_64/Makefile	2005-04-30 12:57:43.000000000 -0400
+++ linux-2.6.11-mm/arch/um/sys-x86_64/Makefile	2005-04-30 13:06:31.000000000 -0400
@@ -23,4 +23,6 @@
 
 CFLAGS_csum-partial.o := -Dcsum_partial=arch_csum_partial
 
+subdir- := util
+
 include arch/um/scripts/Makefile.rules

