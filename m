Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268317AbUIMRf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268317AbUIMRf0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 13:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268346AbUIMRf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 13:35:26 -0400
Received: from ozlabs.org ([203.10.76.45]:35757 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268317AbUIMRfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 13:35:16 -0400
Date: Tue, 14 Sep 2004 03:30:31 +1000
From: Anton Blanchard <anton@samba.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5 compile errors
Message-ID: <20040913173031.GG12514@krispykreme>
References: <1095093355.3628.152.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095093355.3628.152.camel@dyn318077bld.beaverton.ibm.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> arch/ppc64/kernel/pSeries_pci.c: In function `pcibios_fixup_bus':
> arch/ppc64/kernel/pSeries_pci.c:607: error: redeclaration of `dev'
> arch/ppc64/kernel/pSeries_pci.c:604: error: `dev' previously declared
> here
> arch/ppc64/kernel/pSeries_pci.c:604: warning: unused variable `dev'

I sent this to Andrew earlier.

Anton

diff -puN arch/ppc64/kernel/pSeries_pci.c~fix_pseries arch/ppc64/kernel/pSeries_pci.c
--- 2.6.9-rc1-mm5/arch/ppc64/kernel/pSeries_pci.c~fix_pseries	2004-09-13 19:58:29.941874428 +1000
+++ 2.6.9-rc1-mm5-anton/arch/ppc64/kernel/pSeries_pci.c	2004-09-13 19:59:21.967773089 +1000
@@ -601,7 +601,6 @@ EXPORT_SYMBOL(pcibios_fixup_device_resou
 void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 {
 	struct pci_controller *hose = PCI_GET_PHB_PTR(bus);
-	struct pci_dev *dev;
 
 	/* XXX or bus->parent? */
 	struct pci_dev *dev = bus->self;
_
