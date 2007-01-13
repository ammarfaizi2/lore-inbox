Return-Path: <linux-kernel-owner+w=401wt.eu-S1422816AbXAMXKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422816AbXAMXKt (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 18:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbXAMXKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 18:10:25 -0500
Received: from gw.goop.org ([64.81.55.164]:59876 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030526AbXAMXKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 18:10:23 -0500
Message-Id: <20070113014647.100536225@goop.org>
References: <20070113014539.408244126@goop.org>
User-Agent: quilt/0.46-1
Date: Fri, 12 Jan 2007 17:45:40 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com
Subject: [patch 01/20] XEN-paravirt: Fix typo in sync_constant_test_bit()s name.
Content-Disposition: inline; filename=fix-sync-bitops.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in sync_constant_test_bit()s name.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

===================================================================
--- a/include/asm-i386/sync_bitops.h
+++ b/include/asm-i386/sync_bitops.h
@@ -130,7 +130,7 @@ static inline int sync_test_and_change_b
 	return oldbit;
 }
 
-static __always_inline int sync_const_test_bit(int nr, const volatile unsigned long *addr)
+static __always_inline int sync_constant_test_bit(int nr, const volatile unsigned long *addr)
 {
 	return ((1UL << (nr & 31)) &
 		(((const volatile unsigned int *)addr)[nr >> 5])) != 0;

-- 

