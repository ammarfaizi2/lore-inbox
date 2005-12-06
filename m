Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751591AbVLFEJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbVLFEJF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 23:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbVLFEJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 23:09:04 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:28827 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751591AbVLFEJA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 23:09:00 -0500
Message-ID: <43951003.1070501@student.ltu.se>
Date: Tue, 06 Dec 2005 05:13:55 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: [PATCH 2.6.15-rc5-mm1] drivers: Replace pci_module_init() with pci_register_driver()
 (-mm only)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

Replace obsolete pci_module_init() with pci_register_driver().

This patch is for -mm only. There is (for now) no drivers/hwmon/vt8231.c 
file and drivers/net/sk98lin/skge.c already have pci_register_driver() 
instead of pci_module_init() in the linus-tree.

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

 hwmon/vt8231.c     |    2 +-
 net/sk98lin/skge.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -Narup a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
--- a/drivers/hwmon/vt8231.c	2005-12-06 03:35:12.000000000 +0100
+++ b/drivers/hwmon/vt8231.c	2005-12-06 03:31:50.000000000 +0100
@@ -842,7 +842,7 @@ static int __devinit vt8231_pci_probe(st
 
 static int __init sm_vt8231_init(void)
 {
-	return pci_module_init(&vt8231_pci_driver);
+	return pci_register_driver(&vt8231_pci_driver);
 }
 
 static void __exit sm_vt8231_exit(void)
diff -Narup a/drivers/net/sk98lin/skge.c b/drivers/net/sk98lin/skge.c
--- a/drivers/net/sk98lin/skge.c	2005-12-06 03:35:17.000000000 +0100
+++ b/drivers/net/sk98lin/skge.c	2005-12-06 03:30:21.000000000 +0100
@@ -5107,7 +5107,7 @@ static struct pci_driver skge_driver = {
 
 static int __init skge_init(void)
 {
-	return pci_module_init(&skge_driver);
+	return pci_register_driver(&skge_driver);
 }
 
 static void __exit skge_exit(void)


