Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVADT4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVADT4m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 14:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVADTxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 14:53:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4993 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261832AbVADTtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 14:49:36 -0500
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add initdata variable spec in a header file
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Tue, 04 Jan 2005 19:49:25 +0000
Message-ID: <17767.1104868165@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch marks a variable as __initdata in a header file so that the
FRV gcc generates the correct access method as initdata variables are too far
from the GPREL pointer to access directly.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat initdata-2610mm1.diff 
 bootmem.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -uNrp /warthog/kernels/linux-2.6.10-mm1/include/linux/bootmem.h linux-2.6.10-mm1-frv/include/linux/bootmem.h
--- /warthog/kernels/linux-2.6.10-mm1/include/linux/bootmem.h	2005-01-04 11:15:26.000000000 +0000
+++ linux-2.6.10-mm1-frv/include/linux/bootmem.h	2005-01-04 14:59:53.000000000 +0000
@@ -91,7 +91,7 @@ extern void *__init alloc_large_system_h
 #else
 #define HASHDIST_DEFAULT 0
 #endif
-extern int hashdist;		/* Distribute hashes across NUMA nodes? */
+extern int __initdata hashdist;		/* Distribute hashes across NUMA nodes? */
 
 
 #endif /* _LINUX_BOOTMEM_H */
