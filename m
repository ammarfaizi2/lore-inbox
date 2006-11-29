Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758347AbWK2WDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758347AbWK2WDz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758344AbWK2WDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:03:53 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:56020 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1758267AbWK2WDi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:03:38 -0500
Message-Id: <20061129220526.952590000@sous-sol.org>
References: <20061129220111.137430000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 14:00:26 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Daniel Drake <dsd@gentoo.org>,
       ferdy@gentoo.org, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: [patch 15/23] alpha: Fix ALPHA_EV56 dependencies typo
Content-Disposition: inline; filename=alpha-fix-alpha_ev56-dependencies-typo.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Fernando J. Pereda <ferdy@gentoo.org>

There appears to be a typo in the EV56 config option. NORITAKE and PRIMO are
be able to set a variation of either.

Signed-off-by: Daniel Drake <dsd@gentoo.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/alpha/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.4.orig/arch/alpha/Kconfig
+++ linux-2.6.18.4/arch/alpha/Kconfig
@@ -381,7 +381,7 @@ config ALPHA_EV56
 
 config ALPHA_EV56
 	prompt "EV56 CPU (speed >= 333MHz)?"
-	depends on ALPHA_NORITAKE && ALPHA_PRIMO
+	depends on ALPHA_NORITAKE || ALPHA_PRIMO
 
 config ALPHA_EV56
 	prompt "EV56 CPU (speed >= 400MHz)?"

--
