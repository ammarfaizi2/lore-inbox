Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbVAJRsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbVAJRsG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbVAJRrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:47:03 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:54739 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262349AbVAJRVC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:21:02 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI patches for 2.6.10
User-Agent: Mutt/1.5.6i
In-Reply-To: <110537765846@kroah.com>
Date: Mon, 10 Jan 2005 09:20:58 -0800
Message-Id: <11053776585@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.447.13, 2004/12/21 11:57:56-08:00, pavel@suse.cz

[PATCH] PCI: add prototype for pci_choose_state()

This adds missing prototype for pci_choose_state.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/pci.h |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2005-01-10 09:00:36 -08:00
+++ b/include/linux/pci.h	2005-01-10 09:00:36 -08:00
@@ -806,6 +806,7 @@
 int pci_save_state(struct pci_dev *dev);
 int pci_restore_state(struct pci_dev *dev);
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
+pci_power_t pci_choose_state(struct pci_dev *dev, u32 state);
 int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable);
 
 /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
@@ -934,6 +935,7 @@
 static inline int pci_save_state(struct pci_dev *dev) { return 0; }
 static inline int pci_restore_state(struct pci_dev *dev) { return 0; }
 static inline int pci_set_power_state(struct pci_dev *dev, pci_power_t state) { return 0; }
+static inline pci_power_t pci_choose_state(struct pci_dev *dev, u32 state) { return PCI_D0; }
 static inline int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable) { return 0; }
 
 #define	isa_bridge	((struct pci_dev *)NULL)

