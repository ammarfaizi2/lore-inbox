Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWHQNhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWHQNhg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbWHQN3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:29:13 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:26034 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964922AbWHQN3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:29:00 -0400
Date: Thu, 17 Aug 2006 13:29:36 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: eric.lemoine@gmail.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 64/75] net: drivers/net/sungem.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132936.64.SGytmW5299.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/sungem.c linux-work2/drivers/net/sungem.c
--- linux-work-clean/drivers/net/sungem.c	2006-08-16 22:41:17.000000000 +0200
+++ linux-work2/drivers/net/sungem.c	2006-08-17 05:17:28.000000000 +0200
@@ -3194,7 +3194,7 @@ static struct pci_driver gem_driver = {
 
 static int __init gem_init(void)
 {
-	return pci_module_init(&gem_driver);
+	return pci_register_driver(&gem_driver);
 }
 
 static void __exit gem_cleanup(void)
