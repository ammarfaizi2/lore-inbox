Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267720AbUIGPBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267720AbUIGPBn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268213AbUIGPA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:00:26 -0400
Received: from verein.lst.de ([213.95.11.210]:15770 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268209AbUIGOyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:54:50 -0400
Date: Tue, 7 Sep 2004 16:54:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mark proc_bus_pci_dir static
Message-ID: <20040907145444.GA9109@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- 1.39/drivers/pci/proc.c	2004-05-29 11:12:56 +02:00
+++ edited/drivers/pci/proc.c	2004-09-07 14:57:36 +02:00
@@ -379,7 +379,7 @@
 	.show	= show_device
 };
 
-struct proc_dir_entry *proc_bus_pci_dir;
+static struct proc_dir_entry *proc_bus_pci_dir;
 
 int pci_proc_attach_device(struct pci_dev *dev)
 {
@@ -612,6 +612,5 @@
 EXPORT_SYMBOL(pci_proc_attach_device);
 EXPORT_SYMBOL(pci_proc_attach_bus);
 EXPORT_SYMBOL(pci_proc_detach_bus);
-EXPORT_SYMBOL(proc_bus_pci_dir);
 #endif
 
