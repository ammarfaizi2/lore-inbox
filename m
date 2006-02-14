Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030355AbWBNFE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030355AbWBNFE7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbWBNFE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:04:57 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:12494 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030357AbWBNFEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:04:54 -0500
Message-Id: <20060214050442.489692000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:03:55 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, dev-etrax@axis.com, Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 04/47] cris: remove unnecessary local_irq_restore()
Content-Disposition: inline; filename=cris-cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary local_irq_restore() after cris_atomic_restore() in
test_and_set_bit().

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-cris/bitops.h |    1 -
 1 files changed, 1 deletion(-)

Index: 2.6-rc/include/asm-cris/bitops.h
===================================================================
--- 2.6-rc.orig/include/asm-cris/bitops.h
+++ 2.6-rc/include/asm-cris/bitops.h
@@ -101,7 +101,6 @@ static inline int test_and_set_bit(int n
 	retval = (mask & *adr) != 0;
 	*adr |= mask;
 	cris_atomic_restore(addr, flags);
-	local_irq_restore(flags);
 	return retval;
 }
 

--
