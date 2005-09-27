Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbVI0Scg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbVI0Scg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 14:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbVI0ScQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 14:32:16 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:57340 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1750924AbVI0ScO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 14:32:14 -0400
Subject: [PATCH] RT:  unwritten_done_lock to DEFINE_SPINLOCK
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 27 Sep 2005 11:32:08 -0700
Message-Id: <1127845928.4004.26.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert unwritten_done_lock xfs lock to the new syntax.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.13/fs/xfs/linux-2.6/xfs_aops.c
===================================================================
--- linux-2.6.13.orig/fs/xfs/linux-2.6/xfs_aops.c
+++ linux-2.6.13/fs/xfs/linux-2.6/xfs_aops.c
@@ -192,7 +192,7 @@ linvfs_unwritten_done(
 	int			uptodate)
 {
 	xfs_ioend_t		*ioend = bh->b_private;
-	static spinlock_t	unwritten_done_lock = SPIN_LOCK_UNLOCKED;
+	static DECLARE_SPINLOCK(unwritten_done_lock);
 	unsigned long		flags;
 
 	ASSERT(buffer_unwritten(bh));


