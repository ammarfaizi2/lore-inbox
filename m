Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937183AbWLDWTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937183AbWLDWTn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 17:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937408AbWLDWTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 17:19:42 -0500
Received: from h151.mvista.com ([63.81.120.158]:36410 "EHLO
	localhost.localdomain" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S937183AbWLDWTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 17:19:42 -0500
Message-Id: <20061204221905.792586000@mvista.com>
User-Agent: quilt/0.45-1
Date: Mon, 04 Dec 2006 14:19:05 -0800
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -rt] drop one spin_lock_irqsave()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This gave me some really odd compile errors.. Theres
a static inline for this function right above this define
so I just dropped the define.


Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 include/linux/spinlock.h |    1 -
 1 files changed, 1 deletion(-)

Index: linux-2.6.19/include/linux/spinlock.h
===================================================================
--- linux-2.6.19.orig/include/linux/spinlock.h
+++ linux-2.6.19/include/linux/spinlock.h
@@ -202,7 +202,6 @@ static inline unsigned long __lockfunc _
 # define _spin_lock_irq(l)		do { } while (0)
 # define _spin_lock(l)			do { } while (0)
 # define _spin_lock_bh(l)		do { } while (0)
-# define _spin_lock_irqsave(l)		do { } while (0)
 # define _spin_lock_irqsave_nested(l, s) \
 					do { } while (0)
 # define _spin_unlock(l)		do { } while (0)
--
