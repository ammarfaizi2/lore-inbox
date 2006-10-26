Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965267AbWJZCTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965267AbWJZCTG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 22:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965290AbWJZCTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 22:19:06 -0400
Received: from isilmar.linta.de ([213.239.214.66]:28383 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S965267AbWJZCTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 22:19:03 -0400
Date: Wed, 25 Oct 2006 22:14:56 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-pcmcia@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, adobriyan@gmail.com
Subject: [RFC PATCH 6/11] i82092: wire up errors from pci_register_driver()
Message-ID: <20061026021456.GG20473@dominikbrodowski.de>
Mail-Followup-To: linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, adobriyan@gmail.com
References: <20061026021027.GA20473@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026021027.GA20473@dominikbrodowski.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Fri, 20 Oct 2006 14:44:13 -0700
Subject: [PATCH] i82092: wire up errors from pci_register_driver()

debugging goo removed to not leave assymetry in it after possible "leave"
removal.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/pcmcia/i82092.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index d316d95..c2ea07a 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -709,10 +709,7 @@ static int i82092aa_set_mem_map(struct p
 
 static int i82092aa_module_init(void)
 {
-	enter("i82092aa_module_init");
-	pci_register_driver(&i82092aa_pci_drv);
-	leave("i82092aa_module_init");
-	return 0;
+	return pci_register_driver(&i82092aa_pci_drv);
 }
 
 static void i82092aa_module_exit(void)
-- 
1.4.3

