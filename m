Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbTI3Wx1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 18:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbTI3WtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 18:49:01 -0400
Received: from mail.kroah.org ([65.200.24.183]:39131 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261828AbTI3WrY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 18:47:24 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1064961348862@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test6
In-Reply-To: <1064961348799@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Sep 2003 15:35:48 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1305.5.2, 2003/09/26 09:18:44-07:00, mochel@osdl.org

[pci] Remove ->save_state() from struct pci_driver.

It is not called, and unused.


 include/linux/pci.h |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Tue Sep 30 15:21:11 2003
+++ b/include/linux/pci.h	Tue Sep 30 15:21:11 2003
@@ -515,7 +515,6 @@
 	const struct pci_device_id *id_table;	/* must be non-NULL for probe to be called */
 	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
-	int  (*save_state) (struct pci_dev *dev, u32 state);    /* Save Device Context */
 	int  (*suspend) (struct pci_dev *dev, u32 state);	/* Device suspended */
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
 	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */

