Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbTI3Wst (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 18:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTI3WsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 18:48:01 -0400
Received: from mail.kroah.org ([65.200.24.183]:36059 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261824AbTI3WrW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 18:47:22 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1064961348799@kroah.com>
Subject: [PATCH] PCI fixes for 2.6.0-test6
In-Reply-To: <20030930223436.GA21200@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Sep 2003 15:35:48 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1305.5.1, 2003/09/26 09:11:22-07:00, mochel@osdl.org

[pci] Remove drivers/pci/power.c

The old-school method of power management, using the pm_send() interface, is 
superceded by the centralized driver model, which handles walking the tree
and calling each device's suspend/resume methods. 



 drivers/pci/Makefile |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	Tue Sep 30 15:21:18 2003
+++ b/drivers/pci/Makefile	Tue Sep 30 15:21:18 2003
@@ -4,7 +4,6 @@
 
 obj-y		+= access.o bus.o probe.o remove.o pci.o pool.o quirks.o \
 			names.o pci-driver.o search.o pci-sysfs.o
-obj-$(CONFIG_PM)  += power.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
 ifndef CONFIG_SPARC64

