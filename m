Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVAJR06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVAJR06 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVAJRYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:24:40 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:60115 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262359AbVAJRVG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:21:06 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI patches for 2.6.10
User-Agent: Mutt/1.5.6i
In-Reply-To: <11053776582@kroah.com>
Date: Mon, 10 Jan 2005 09:20:58 -0800
Message-Id: <11053776582977@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.447.10, 2004/12/17 14:02:40-08:00, greg@kroah.com

[PATCH] PCI: fix up function calls for CONFIG_PCI=N

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/pci.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2005-01-10 09:01:43 -08:00
+++ b/include/linux/pci.h	2005-01-10 09:01:43 -08:00
@@ -933,8 +933,8 @@
 /* Power management related routines */
 static inline int pci_save_state(struct pci_dev *dev) { return 0; }
 static inline int pci_restore_state(struct pci_dev *dev) { return 0; }
-static inline int pci_set_power_state(struct pci_dev *dev, int state) { return 0; }
-static inline int pci_enable_wake(struct pci_dev *dev, u32 state, int enable) { return 0; }
+static inline int pci_set_power_state(struct pci_dev *dev, pci_power_t state) { return 0; }
+static inline int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable) { return 0; }
 
 #define	isa_bridge	((struct pci_dev *)NULL)
 

