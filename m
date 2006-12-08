Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424764AbWLHGRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424764AbWLHGRJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 01:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424762AbWLHGRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 01:17:09 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:49556 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424764AbWLHGRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 01:17:05 -0500
Date: Thu, 7 Dec 2006 22:16:48 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: info-linux@geode.amd.com, akpm <akpm@osdl.org>
Subject: [PATCH] geode crypto is PCI device
Message-Id: <20061207221648.655c7182.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

This driver seems to be for a PCI device.

drivers/crypto/geode-aes.c:384: warning: implicit declaration of function 'pci_release_regions'
drivers/crypto/geode-aes.c:397: warning: implicit declaration of function 'pci_request_regions'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/crypto/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-git11.orig/drivers/crypto/Kconfig
+++ linux-2.6.19-git11/drivers/crypto/Kconfig
@@ -53,7 +53,7 @@ config CRYPTO_DEV_PADLOCK_SHA
 
 config CRYPTO_DEV_GEODE
 	tristate "Support for the Geode LX AES engine"
-	depends on CRYPTO && X86_32
+	depends on CRYPTO && X86_32 && PCI
 	select CRYPTO_ALGAPI
 	select CRYPTO_BLKCIPHER
 	default m


---
