Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262695AbUKLXbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbUKLXbx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbUKLXbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:31:03 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:28547 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262695AbUKLXWr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:47 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <1100301717159@kroah.com>
Date: Fri, 12 Nov 2004 15:21:57 -0800
Message-Id: <11003017173174@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2026.66.17, 2004/11/05 15:06:47-08:00, hannal@us.ibm.com

[PATCH] cyclades.c: replace pci_find_device

As pci_find_device is going away I've replaced it with pci_get_device.
If someone with this hardware could test it I would appreciate it.


Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/char/cyclades.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/char/cyclades.c b/drivers/char/cyclades.c
--- a/drivers/char/cyclades.c	2004-11-12 15:12:50 -08:00
+++ b/drivers/char/cyclades.c	2004-11-12 15:12:50 -08:00
@@ -4725,7 +4725,7 @@
         for (i = 0; i < NR_CARDS; i++) {
                 /* look for a Cyclades card by vendor and device id */
                 while((device_id = cy_pci_dev_id[dev_index]) != 0) {
-                        if((pdev = pci_find_device(PCI_VENDOR_ID_CYCLADES,
+                        if((pdev = pci_get_device(PCI_VENDOR_ID_CYCLADES,
                                         device_id, pdev)) == NULL) {
                                 dev_index++;    /* try next device id */
                         } else {

