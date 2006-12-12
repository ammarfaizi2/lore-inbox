Return-Path: <linux-kernel-owner+w=401wt.eu-S932346AbWLLSy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWLLSy4 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 13:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWLLSyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 13:54:55 -0500
Received: from av1.karneval.cz ([81.27.192.123]:28403 "EHLO av1.karneval.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932342AbWLLSyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 13:54:55 -0500
Message-id: <5182276292485062@karneval.cz>
Subject: [PATCH 1/3] Char: From: Randy Dunlap <randy.dunlap@oracle.com>
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>
Date: Tue, 12 Dec 2006 19:15:18 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

isicom, fix build with PCI disabled

With CONFIG_PCI=n:
drivers/char/isicom.c: In function 'isicom_probe':
drivers/char/isicom.c:1793: warning: implicit declaration of function
'pci_request_region'
drivers/char/isicom.c:1827: warning: implicit declaration of function
'pci_release_region'

Let's CONFIG_ISI depend on CONFIG_PCI.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 1d9d86f80880cefeca436667a7824c9fe81ec6df
tree 33fb9396b07f853e05524014e6eef9ce287deb04
parent 722249cc1bbaf63d12237b16f0066df1436eb591
author Jiri Slaby <jirislaby@gmail.com> Tue, 12 Dec 2006 18:52:42 +0100
committer Jiri Slaby <jirislaby@gmail.com> Tue, 12 Dec 2006 18:52:42 +0100

 drivers/char/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index a84e37f..d9095ff 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -218,7 +218,7 @@ config MOXA_SMARTIO_NEW
 
 config ISI
 	tristate "Multi-Tech multiport card support (EXPERIMENTAL)"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && PCI
 	select FW_LOADER
 	help
 	  This is a driver for the Multi-Tech cards which provide several
