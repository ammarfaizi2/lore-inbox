Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422697AbWHUQtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422697AbWHUQtP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 12:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422699AbWHUQtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 12:49:14 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:31674 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1422697AbWHUQtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 12:49:14 -0400
From: Daniel Drake <dsd@gentoo.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Cc: ferdy@gentoo.org
Cc: rth@twiddle.net
Cc: ink@jurassic.park.msu.ru
Subject: [PATCH] alpha: Fix ALPHA_EV56 dependencies typo
Message-Id: <20060821165004.912097B409F@zog.reactivated.net>
Date: Mon, 21 Aug 2006 17:50:04 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fernando J. Pereda <ferdy@gentoo.org>

There appears to be a typo in the EV56 config option. NORITAKE and PRIMO are
different kinds of machines so it sounds silly that you need to set _both_ to
be able to set a variation of either.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 213c785..2b36afd 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -381,7 +381,7 @@ config ALPHA_EV56
 
 config ALPHA_EV56
 	prompt "EV56 CPU (speed >= 333MHz)?"
-	depends on ALPHA_NORITAKE && ALPHA_PRIMO
+	depends on ALPHA_NORITAKE || ALPHA_PRIMO
 
 config ALPHA_EV56
 	prompt "EV56 CPU (speed >= 400MHz)?"
