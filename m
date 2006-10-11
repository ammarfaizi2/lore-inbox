Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161177AbWJKSVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161177AbWJKSVU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 14:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161178AbWJKSVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 14:21:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59859 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161177AbWJKSVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 14:21:19 -0400
Date: Wed, 11 Oct 2006 14:21:05 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: ak@suse.de
Subject: x86-64 mmconfig missing printk levels.
Message-ID: <20061011182105.GA1974@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, ak@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial bits..

Signed-off-by: Dave Jones <davej@redhat.com>

--- local-git/arch/x86_64/pci/mmconfig.c~	2006-10-11 14:18:57.000000000 -0400
+++ local-git/arch/x86_64/pci/mmconfig.c	2006-10-11 14:19:28.000000000 -0400
@@ -220,7 +220,7 @@ void __init pci_mmcfg_init(int type)
 
 	pci_mmcfg_virt = kmalloc(sizeof(*pci_mmcfg_virt) * pci_mmcfg_config_num, GFP_KERNEL);
 	if (pci_mmcfg_virt == NULL) {
-		printk("PCI: Can not allocate memory for mmconfig structures\n");
+		printk(KERN_ERR "PCI: Can not allocate memory for mmconfig structures\n");
 		return;
 	}
 	for (i = 0; i < pci_mmcfg_config_num; ++i) {
@@ -228,7 +228,7 @@ void __init pci_mmcfg_init(int type)
 		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].base_address,
 							 MMCONFIG_APER_MAX);
 		if (!pci_mmcfg_virt[i].virt) {
-			printk("PCI: Cannot map mmconfig aperture for segment %d\n",
+			printk(KERN_ERR "PCI: Cannot map mmconfig aperture for segment %d\n",
 			       pci_mmcfg_config[i].pci_segment_group_number);
 			return;
 		}

-- 
http://www.codemonkey.org.uk
