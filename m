Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161022AbWBHGp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbWBHGp4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbWBHGpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:45:55 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:50563 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161022AbWBHGpJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:45:09 -0500
Message-Id: <20060208064905.800252000@sorel.sous-sol.org>
References: <20060208064503.924238000@sorel.sous-sol.org>
Date: Tue, 07 Feb 2006 22:45:17 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Adrian Bunk <bunk@stusta.de>, linville@tuxdriver.com
Subject: [PATCH 14/23] [PATCH] PCMCIA=m, HOSTAP_CS=y is not a legal configuration
Content-Disposition: inline; filename=pcmcia-m-hostap_cs-y-is-not-a-legal-configuration.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

CONFIG_PCMCIA=m, CONFIG_HOSTAP_CS=y doesn't compile.

Reported by "Gabriel C." <crazy@pimpmylinux.org>.

This patch was already included in 2.6.16-rc2.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/net/wireless/hostap/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.15.3/drivers/net/wireless/hostap/Kconfig
===================================================================
--- linux-2.6.15.3.orig/drivers/net/wireless/hostap/Kconfig
+++ linux-2.6.15.3/drivers/net/wireless/hostap/Kconfig
@@ -61,7 +61,7 @@ config HOSTAP_PCI
 
 config HOSTAP_CS
 	tristate "Host AP driver for Prism2/2.5/3 PC Cards"
-	depends on PCMCIA!=n && HOSTAP
+	depends on PCMCIA && HOSTAP
 	---help---
 	Host AP driver's version for Prism2/2.5/3 PC Cards.
 

--
