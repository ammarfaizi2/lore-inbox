Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262701AbUKLXop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbUKLXop (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbUKLXof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:44:35 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:54166 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262701AbUKLXWv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:51 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017191779@kroah.com>
Date: Fri, 12 Nov 2004 15:22:00 -0800
Message-Id: <1100301720892@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.16, 2004/11/12 14:09:21-08:00, hannal@us.ibm.com

[PATCH] isa.c: replace pci_find_device with pci_get_device

As pci_find_device is going away I've replaced it with pci_get_device.

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/sparc64/kernel/isa.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/arch/sparc64/kernel/isa.c b/arch/sparc64/kernel/isa.c
--- a/arch/sparc64/kernel/isa.c	2004-11-12 15:10:04 -08:00
+++ b/arch/sparc64/kernel/isa.c	2004-11-12 15:10:04 -08:00
@@ -262,7 +262,7 @@
 	device = PCI_DEVICE_ID_AL_M1533;
 
 	pdev = NULL;
-	while ((pdev = pci_find_device(vendor, device, pdev)) != NULL) {
+	while ((pdev = pci_get_device(vendor, device, pdev)) != NULL) {
 		struct pcidev_cookie *pdev_cookie;
 		struct pci_pbm_info *pbm;
 		struct sparc_isa_bridge *isa_br;

