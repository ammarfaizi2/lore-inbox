Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWFMMJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWFMMJf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 08:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWFMMJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 08:09:35 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:4746 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S932067AbWFMMJe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 08:09:34 -0400
Date: Tue, 13 Jun 2006 14:09:16 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: [patch] s390: missing ifdef in bitops.h
Message-ID: <20060613120916.GA9405@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cedric Le Goater <clg@fr.ibm.com>

Add missing #ifdef __KERNEL__ to asm-s390/bitops.h

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

Patch is for -mm tree only and resolves a merge conflict.

 include/asm-s390/bitops.h |    3 +++
 1 file changed, 3 insertions(+)

diff -purN a/include/asm-s390/bitops.h b/include/asm-s390/bitops.h
--- a/include/asm-s390/bitops.h	2006-06-13 07:38:53.000000000 +0200
+++ b/include/asm-s390/bitops.h	2006-06-13 07:41:20.000000000 +0200
@@ -12,6 +12,9 @@
  *    Copyright (C) 1992, Linus Torvalds
  *
  */
+
+#ifdef __KERNEL__
+
 #include <linux/compiler.h>
 
 /*
