Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbVKWXrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbVKWXrV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbVKWXqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:46:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:25282 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751330AbVKWXqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:46:31 -0500
Date: Wed, 23 Nov 2005 15:44:49 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       daniel.marjamaki@comhem.se
Subject: [patch 09/22] PCI: trivial printk updates in common.c
Message-ID: <20051123234449.GJ527@kroah.com>
References: <20051123225156.624397000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline; filename="pci-trivial-printk-updates-in-common.c.patch"
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051123234335.GA527@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Marjamäkia <daniel.marjamaki@comhem.se>


Modified common.c so it's using the appropriate KERN_* in printk() calls.

Signed-off-by: Daniel Marjamäkia <daniel.marjamaki@comhem.se>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/i386/pci/common.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- usb-2.6.orig/arch/i386/pci/common.c
+++ usb-2.6/arch/i386/pci/common.c
@@ -132,7 +132,7 @@ struct pci_bus * __devinit pcibios_scan_
 		}
 	}
 
-	printk("PCI: Probing PCI hardware (bus %02x)\n", busnum);
+	printk(KERN_DEBUG "PCI: Probing PCI hardware (bus %02x)\n", busnum);
 
 	return pci_scan_bus_parented(NULL, busnum, &pci_root_ops, NULL);
 }
@@ -144,7 +144,7 @@ static int __init pcibios_init(void)
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
 	if (!raw_pci_ops) {
-		printk("PCI: System does not support PCI\n");
+		printk(KERN_WARNING "PCI: System does not support PCI\n");
 		return 0;
 	}
 

--
