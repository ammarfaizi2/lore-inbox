Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266054AbUFDXFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266054AbUFDXFl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 19:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266043AbUFDXFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 19:05:40 -0400
Received: from ozlabs.org ([203.10.76.45]:15079 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266040AbUFDXFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 19:05:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16577.172.594575.31066@cargo.ozlabs.ibm.com>
Date: Sat, 5 Jun 2004 09:07:24 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       trini@kernel.crashing.org
Subject: [PATCH][PPC32] Fix typo in ppc32 spinlock.h
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brown-paper bag time... I put a typo in the asm for _raw_write_trylock
(left in a spurious \n\).  This patch fixes it.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/include/asm-ppc/spinlock.h power3-2.5/include/asm-ppc/spinlock.h
--- linux-2.5/include/asm-ppc/spinlock.h	2004-06-04 07:19:01.000000000 +1000
+++ power3-2.5/include/asm-ppc/spinlock.h	2004-06-04 09:30:09.000000000 +1000
@@ -140,7 +140,7 @@
 	unsigned int tmp;
 
 	__asm__ __volatile__(
-"2:	lwarx	%0,0,%1\n\	# write_trylock\n\
+"2:	lwarx	%0,0,%1		# write_trylock\n\
 	cmpwi	0,%0,0\n\
 	bne-	1f\n"
 	PPC405_ERR77(0,%1)
