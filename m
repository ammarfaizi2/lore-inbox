Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269886AbUJMW2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269886AbUJMW2u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 18:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269888AbUJMWUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 18:20:50 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:36050 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269885AbUJMWTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 18:19:31 -0400
Date: Wed, 13 Oct 2004 15:19:30 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>
cc: Hanna Linder <hannal@us.ibm.com>, greg@kroah.com, chas@cmf.nrl.navy.mil
Subject: [PATCH 2.6] horizon.c: replace pci_find_device with pci_get_device
Message-ID: <197250000.1097705970@w-hlinder.beaverton.ibm.com>
In-Reply-To: <194130000.1097705759@w-hlinder.beaverton.ibm.com>
References: <194130000.1097705759@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



As pci_find_device is going away soon I have converted this file to use
pci_get_device instead. I have compile tested it. If anyone has this ATM card
and could test it that would be great.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---

diff -Nrup linux-2.6.9-rc4-mm1cln/drivers/atm/horizon.c linux-2.6.9-rc4-mm1patch/drivers/atm/horizon.c
--- linux-2.6.9-rc4-mm1cln/drivers/atm/horizon.c	2004-10-12 14:15:10.000000000 -0700
+++ linux-2.6.9-rc4-mm1patch/drivers/atm/horizon.c	2004-10-13 14:52:43.218426992 -0700
@@ -2727,7 +2727,7 @@ static int __init hrz_probe (void) {
   
   devs = 0;
   pci_dev = NULL;
-  while ((pci_dev = pci_find_device
+  while ((pci_dev = pci_get_device
 	  (PCI_VENDOR_ID_MADGE, PCI_DEVICE_ID_MADGE_HORIZON, pci_dev)
 	  )) {
     hrz_dev * dev;

