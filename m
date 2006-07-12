Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWGLVuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWGLVuW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWGLVuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:50:21 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32673 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932448AbWGLVuU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:50:20 -0400
Subject: Re: resource_size_t and printk()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060712213723.GB9049@kroah.com>
References: <44AAD59E.7010206@drzeus.cx> <20060704214508.GA23607@kroah.com>
	 <44AB3DF7.8080107@drzeus.cx> <20060711231537.GC18973@kroah.com>
	 <44B4B041.9050808@drzeus.cx>  <20060712213723.GB9049@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Jul 2006 23:08:26 +0100
Message-Id: <1152742106.22943.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-07-12 am 14:37 -0700, ysgrifennodd Greg KH:
> Like Randy said, please use "unsigned long long".
> 
> Care to redo this?


While you are at it someone did 8139cp and used "%l" not "%ll"

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc1/drivers/net/8139cp.c linux-2.6.18-rc1/drivers/net/8139cp.c
--- linux.vanilla-2.6.18-rc1/drivers/net/8139cp.c	2006-07-12 12:16:46.000000000 +0100
+++ linux-2.6.18-rc1/drivers/net/8139cp.c	2006-07-12 12:47:20.000000000 +0100
@@ -1916,7 +1916,7 @@
 	regs = ioremap(pciaddr, CP_REGS_SIZE);
 	if (!regs) {
 		rc = -EIO;
-		dev_err(&pdev->dev, "Cannot map PCI MMIO (%lx@%lx)\n",
+		dev_err(&pdev->dev, "Cannot map PCI MMIO (%llx@%llx)\n",
 		       (unsigned long long)pci_resource_len(pdev, 1),
 		       (unsigned long long)pciaddr);
 		goto err_out_res;

