Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031183AbWKPMQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031183AbWKPMQZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 07:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031185AbWKPMQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 07:16:25 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57357 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1031183AbWKPMQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 07:16:24 -0500
Date: Thu, 16 Nov 2006 13:16:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [2.6 patch] make arch/i386/pci/common.c:pci_bf_sort static
Message-ID: <20061116121623.GE31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global pci_bf_sort static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/arch/i386/pci/common.c.old	2006-11-16 00:20:15.000000000 +0100
+++ linux-2.6.19-rc5-mm2/arch/i386/pci/common.c	2006-11-16 00:20:32.000000000 +0100
@@ -20,7 +20,7 @@
 unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2 |
 				PCI_PROBE_MMCONF;
 
-int pci_bf_sort;
+static int pci_bf_sort;
 int pci_routeirq;
 int pcibios_last_bus = -1;
 unsigned long pirq_table_addr;

