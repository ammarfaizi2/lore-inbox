Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbVKFC5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVKFC5j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 21:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbVKFC5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 21:57:39 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:27922 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932207AbVKFC5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 21:57:38 -0500
Date: Sat, 5 Nov 2005 21:57:04 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linuxppc-embedded@ozlabs.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 2.6.14] fec_8xx: make CONFIG_FEC_8XX depend on CONFIG_8xx
Message-ID: <20051106025701.GA9698@tuxdriver.com>
Mail-Followup-To: linuxppc-embedded@ozlabs.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make CONFIG_FEC_8XX depend on CONFIG_8xx.  This keeps allmodconfig from
breaking on non-8xx (PPC) platforms.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/fec_8xx/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/fec_8xx/Kconfig b/drivers/net/fec_8xx/Kconfig
index 4560026..a84c232 100644
--- a/drivers/net/fec_8xx/Kconfig
+++ b/drivers/net/fec_8xx/Kconfig
@@ -1,6 +1,6 @@
 config FEC_8XX
 	tristate "Motorola 8xx FEC driver"
-	depends on NET_ETHERNET
+	depends on NET_ETHERNET && 8xx
 	select MII
 
 config FEC_8XX_GENERIC_PHY
-- 
John W. Linville
linville@tuxdriver.com
