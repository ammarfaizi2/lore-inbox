Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262379AbVAENio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbVAENio (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 08:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbVAENin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 08:38:43 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:1784 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262379AbVAENim
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 08:38:42 -0500
Date: Wed, 5 Jan 2005 14:37:42 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] s390: add missing pte_read function
Message-ID: <20050105133742.GA9147@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

this patch adds the missing pte_read function and makes s390 compile again.

Thanks,
Heiko

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

diff -urN linux-2.6/include/asm-s390/pgtable.h linux-2.6-patched/include/asm-s390/pgtable.h
--- linux-2.6/include/asm-s390/pgtable.h	2005-01-05 11:46:12.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/pgtable.h	2005-01-05 14:31:14.000000000 +0100
@@ -418,6 +418,14 @@
 	return 0;
 }
 
+extern inline int pte_read(pte_t pte)
+{
+	/* All pages are readable since we don't use the fetch
+	 * protection bit in the storage key.
+	 */
+	return 1;
+}
+
 /*
  * pgd/pmd/pte modification functions
  */
