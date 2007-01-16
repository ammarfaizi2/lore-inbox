Return-Path: <linux-kernel-owner+w=401wt.eu-S1750860AbXAPLOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbXAPLOy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 06:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbXAPLOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 06:14:54 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:48626 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbXAPLOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 06:14:54 -0500
X-Originating-Ip: 74.109.98.130
Date: Tue, 16 Jan 2007 06:04:38 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: Ian Molton <spyro@f2s.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Remove the last reference to rwlock_is_locked() macro.
Message-ID: <Pine.LNX.4.64.0701160603100.17180@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Remove the lone, remaining reference to the long-deceased
rwlock_is_locked() macro.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

diff --git a/include/asm-arm/spinlock.h b/include/asm-arm/spinlock.h
index 861092f..800ba52 100644
--- a/include/asm-arm/spinlock.h
+++ b/include/asm-arm/spinlock.h
@@ -85,7 +85,6 @@ static inline void __raw_spin_unlock(raw_spinlock_t *lock)
  * Write locks are easy - we just set bit 31.  When unlocking, we can
  * just write zero since the lock is exclusively held.
  */
-#define rwlock_is_locked(x)	(*((volatile unsigned int *)(x)) != 0)

 static inline void __raw_write_lock(raw_rwlock_t *rw)
 {
