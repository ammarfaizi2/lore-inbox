Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWBAJTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWBAJTz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWBAJD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:03:27 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:45385 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751126AbWBAJDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:03:22 -0500
Message-Id: <20060201090321.678259000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date: Wed, 01 Feb 2006 18:02:27 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: dev-etrax@axis.com, Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 03/44] cris: remove unnecessary local_irq_restore()
Content-Disposition: inline; filename=cris-cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary local_irq_restore() after cris_atomic_restore() in
test_and_set_bit().

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-cris/bitops.h |    1 -
 1 files changed, 1 deletion(-)

Index: 2.6-git/include/asm-cris/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-cris/bitops.h
+++ 2.6-git/include/asm-cris/bitops.h
@@ -101,7 +101,6 @@ static inline int test_and_set_bit(int n
 	retval = (mask & *adr) != 0;
 	*adr |= mask;
 	cris_atomic_restore(addr, flags);
-	local_irq_restore(flags);
 	return retval;
 }
 

--
