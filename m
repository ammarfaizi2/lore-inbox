Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVF0PEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVF0PEb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 11:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVF0PCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:02:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33960 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262064AbVF0OKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 10:10:39 -0400
Date: Mon, 27 Jun 2005 10:09:14 -0400
From: Neil Horman <nhorman@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, jeff.garzik@pobox.com, akpm@osdl.org, torvalds@osdl.org
Subject: [Patch] Janitorial cleanup of GET_INDEX macro in arch/i386/pci/fixup.c
Message-ID: <20050627140914.GD20880@hmsendeavour.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to clean up the implementation of the GET_INDEX macro in the i386 pci
fixup code so that it uses the PCI_DEVFN macro, rather than re-implements it.

Thanks and Regards
Neil

Signed-off-by: Neil Horman <nhorman@redhat.com>

 fixup.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


--- linux-2.6.git/arch/i386/pci/fixup.c.orig	2005-06-27 09:42:31.000000000 -0400
+++ linux-2.6.git/arch/i386/pci/fixup.c	2005-06-27 09:43:46.000000000 -0400
@@ -253,7 +253,7 @@
 #define MAX_PCIEROOT	6
 static int quirk_aspm_offset[MAX_PCIEROOT << 3];
 
-#define GET_INDEX(a, b) ((((a) - PCI_DEVICE_ID_INTEL_MCH_PA) << 3) + ((b) & 7))
+#define GET_INDEX(a, b) PCI_DEVFN((a - PCI_DEVICE_ID_INTEL_MCH_PA),b)
 
 static int quirk_pcie_aspm_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/
