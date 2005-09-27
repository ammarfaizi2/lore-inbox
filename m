Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbVI0ScO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbVI0ScO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 14:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbVI0ScO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 14:32:14 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:56828 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1750926AbVI0ScN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 14:32:13 -0400
Subject: [PATCH] RT: epca_lock to DEFINE_SPINLOCK
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 27 Sep 2005 11:32:07 -0700
Message-Id: <1127845928.4004.24.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert epca_lock to the new syntax.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.13/drivers/char/epca.c
===================================================================
--- linux-2.6.13.orig/drivers/char/epca.c
+++ linux-2.6.13/drivers/char/epca.c
@@ -80,7 +80,7 @@ static int invalid_lilo_config;
 /* The ISA boards do window flipping into the same spaces so its only sane
    with a single lock. It's still pretty efficient */
 
-static spinlock_t epca_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(epca_lock);
 
 /* -----------------------------------------------------------------------
 	MAXBOARDS is typically 12, but ISA and EISA cards are restricted to 


