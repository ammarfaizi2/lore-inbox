Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWHWK43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWHWK43 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 06:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWHWK43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 06:56:29 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:51452 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S964839AbWHWK42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 06:56:28 -0400
Date: Wed, 23 Aug 2006 12:56:15 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] AVR32: asm/io.h should include asm/byteorder.h
Message-ID: <20060823125615.19440d35@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The {in,out}[bwl] macros use byte order conversion macros, so we
need to include asm/byteorder.h from asm/io.h.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 include/asm-avr32/io.h |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.18-rc3-mm2/include/asm-avr32/io.h
===================================================================
--- linux-2.6.18-rc3-mm2.orig/include/asm-avr32/io.h	2006-08-08 14:11:15.000000000 +0200
+++ linux-2.6.18-rc3-mm2/include/asm-avr32/io.h	2006-08-08 14:11:24.000000000 +0200
@@ -6,6 +6,7 @@
 #ifdef __KERNEL__
 
 #include <asm/addrspace.h>
+#include <asm/byteorder.h>
 
 /* virt_to_phys will only work when address is in P1 or P2 */
 static __inline__ unsigned long virt_to_phys(volatile void *address)
