Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbULAAXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbULAAXZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbULAAUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:20:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:51684 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261285AbULAAOZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:14:25 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] More PCI fixes for 2.6.10-rc2
User-Agent: Mutt/1.5.6i
In-Reply-To: <11018598042649@kroah.com>
Date: Tue, 30 Nov 2004 16:10:04 -0800
Message-Id: <1101859804154@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2223.2.5, 2004/11/30 11:54:13-08:00, greg@kroah.com

PCI: fix build warning in pci-sysfs.c

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci-sysfs.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


diff -Nru a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
--- a/drivers/pci/pci-sysfs.c	2004-11-30 15:47:05 -08:00
+++ b/drivers/pci/pci-sysfs.c	2004-11-30 15:47:05 -08:00
@@ -45,8 +45,7 @@
 
 static ssize_t local_cpus_show(struct device *dev, char *buf)
 {		
-	struct pci_dev *pdev = to_pci_dev(dev);
-	cpumask_t mask = pcibus_to_cpumask(pdev->bus->number);
+	cpumask_t mask = pcibus_to_cpumask(to_pci_dev(dev)->bus->number);
 	int len = cpumask_scnprintf(buf, PAGE_SIZE-2, mask);
 	strcat(buf,"\n"); 
 	return 1+len;

