Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965231AbVINPJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965231AbVINPJc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 11:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbVINPJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 11:09:32 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:29145 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965231AbVINPJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 11:09:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=O4mA4prPVBNfXCMYgBNtw8k0yKfIVLgg1UZz/eUy8FYvzYXFsIiq60gmleR8XQP4SBbF8g8lVjusOIe8O/97pZFWyAn5XZ2/QUNayImL1rKyzxpa3f5K3YLKJxYF6iRcIlNXgQ0SqWPSMXV3jyAqfAY+4EiOR9hCxVYBnWuGvIg=
Date: Wed, 14 Sep 2005 19:19:30 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] arch/i386/pci/acpi.c: use for_each_pci_dev
Message-ID: <20050914151930.GA19491@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hanna Linder <hannal@us.ibm.com>

Compile and boot tested.

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/i386/pci/acpi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- a/arch/i386/pci/acpi.c
+++ b/arch/i386/pci/acpi.c
@@ -54,7 +54,7 @@ static int __init pci_acpi_init(void)
 		 * don't use pci_enable_device().
 		 */
 		printk(KERN_INFO "PCI: Routing PCI interrupts for all devices because \"pci=routeirq\" specified\n");
-		while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
+		for_each_pci_dev(dev)
 			acpi_pci_irq_enable(dev);
 	} else
 		printk(KERN_INFO "PCI: If a device doesn't work, try \"pci=routeirq\".  If it helps, post a report\n");

