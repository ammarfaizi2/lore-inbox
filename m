Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266514AbUA3Bgu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUA3Bgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:36:31 -0500
Received: from mail.kroah.org ([65.200.24.183]:13020 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266514AbUA3BcG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:32:06 -0500
Subject: Re: [PATCH] PCI Update for 2.6.2-rc2
In-Reply-To: <10754263082016@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 29 Jan 2004 17:31:48 -0800
Message-Id: <10754263082060@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1514, 2004/01/29 14:45:26-08:00, greg@kroah.com

[PATCH] PCI: add .owner field to the config sysfs file to be "correct"

This is in case others copy this code (which has already happened...)


 drivers/pci/pci-sysfs.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
--- a/drivers/pci/pci-sysfs.c	Thu Jan 29 17:24:27 2004
+++ b/drivers/pci/pci-sysfs.c	Thu Jan 29 17:24:27 2004
@@ -160,6 +160,7 @@
 	.attr =	{
 		.name = "config",
 		.mode = S_IRUGO | S_IWUSR,
+		.owner = THIS_MODULE,
 	},
 	.size = 256,
 	.read = pci_read_config,

