Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270114AbUJSXba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270114AbUJSXba (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270160AbUJSX0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:26:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:17546 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270159AbUJSWqj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:39 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <1098225737224@kroah.com>
Date: Tue, 19 Oct 2004 15:42:17 -0700
Message-Id: <10982257374003@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.40, 2004/10/06 13:04:14-07:00, hannal@us.ibm.com

[PATCH] PCI: Changed pci_find_device to pci_get_device for acpi.c

Another simple patch to complete the /i386 conversion to pci_get_device.
I was able to compile and boot this patch to verify it didn't break anything
(on my T22).

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/pci/acpi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/arch/i386/pci/acpi.c b/arch/i386/pci/acpi.c
--- a/arch/i386/pci/acpi.c	2004-10-19 15:24:05 -07:00
+++ b/arch/i386/pci/acpi.c	2004-10-19 15:24:05 -07:00
@@ -35,7 +35,7 @@
 	 * also do it here in case there are still broken drivers that
 	 * don't use pci_enable_device().
 	 */
-	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
+	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
 		acpi_pci_irq_enable(dev);
 
 #ifdef CONFIG_X86_IO_APIC

