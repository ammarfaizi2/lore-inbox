Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264671AbUETDRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264671AbUETDRx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 23:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264829AbUETDRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 23:17:53 -0400
Received: from ozlabs.org ([203.10.76.45]:18822 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264671AbUETDRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 23:17:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16556.9036.564371.398823@cargo.ozlabs.ibm.com>
Date: Thu, 20 May 2004 13:17:32 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, dwg@au.ibm.com
Subject: [PATCH][PPC64] Move kmem_bufctl_t inside #ifndef __ASSEMBLY__
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the kmem_bufctl_t typedef got added to include/asm-ppc64/types.h,
it got added outside the #ifndef __ASSEMBLY__ section, causing
assembler errors.  This patch, from David Gibson, moves it inside the
#ifndef __ASSEMBLY__ region.

Please apply.

Thanks,
Paul.

Index: working-2.6/include/asm-ppc64/types.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/types.h	2004-05-20 11:03:59.000000000 +1000
+++ working-2.6/include/asm-ppc64/types.h	2004-05-20 13:12:48.012124216 +1000
@@ -71,9 +71,9 @@
 	unsigned long toc;
 	unsigned long env;
 } func_descr_t;
-#endif /* __ASSEMBLY__ */
 
 typedef unsigned int kmem_bufctl_t;
+#endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
 
