Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbWEBVnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWEBVnT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 17:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWEBVnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 17:43:19 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:35286 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964991AbWEBVnS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 17:43:18 -0400
Date: Tue, 2 May 2006 16:42:28 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ia64: remove asm-ia64/bitops.h self-inclusion
Message-ID: <20060502214228.GF8713@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

asm-ia64/bitops.h includes itself.  The #ifndef _ASM_IA64_BITOPS_H
prevents this from being an issue, but it should still be removed.

Cross-compile tested.

Thanks,
Jon

Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 62dc1eb0c5e2 include/asm-ia64/bitops.h
--- a/include/asm-ia64/bitops.h	Wed Apr 26 16:12:39 2006
+++ b/include/asm-ia64/bitops.h	Tue May  2 16:27:46 2006
@@ -11,7 +11,6 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
-#include <asm/bitops.h>
 #include <asm/intrinsics.h>
 
 /**
