Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263793AbRGCKRx>; Tue, 3 Jul 2001 06:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263703AbRGCKRn>; Tue, 3 Jul 2001 06:17:43 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:29096 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263437AbRGCKR2>;
	Tue, 3 Jul 2001 06:17:28 -0400
Message-ID: <3B419BB6.32C38FD@mandrakesoft.com>
Date: Tue, 03 Jul 2001 06:17:26 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mochel@transmeta.com
Subject: PATCH 2.4.6.9: pci_set_power_state stub defined twice
Content-Type: multipart/mixed;
 boundary="------------2FE3BDBBEC6847EC15E722F9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2FE3BDBBEC6847EC15E722F9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Seems both Patrick and my change went in, presumeably breaking the
compile for !CONFIG_PCI folks including pci.h.
-- 
Jeff Garzik      | "I respect faith, but doubt is
Building 1024    |  what gives you an education."
MandrakeSoft     |           -- Wilson Mizner
--------------2FE3BDBBEC6847EC15E722F9
Content-Type: text/plain; charset=us-ascii;
 name="pci.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci.patch"

Index: include/linux/pci.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/include/linux/pci.h,v
retrieving revision 1.2
diff -u -r1.2 pci.h
--- include/linux/pci.h	2001/07/02 13:39:28	1.2
+++ include/linux/pci.h	2001/07/03 10:15:32
@@ -642,7 +642,6 @@
 static inline void pci_disable_device(struct pci_dev *dev) { }
 static inline int pci_module_init(struct pci_driver *drv) { return -ENODEV; }
 static inline int pci_set_dma_mask(struct pci_dev *dev, dma_addr_t mask) { return -EIO; }
-static inline int pci_set_power_state(struct pci_dev *dev, int state) { return 0; }
 static inline int pci_assign_resource(struct pci_dev *dev, int i) { return -EBUSY;}
 static inline int pci_register_driver(struct pci_driver *drv) { return 0;}
 static inline void pci_unregister_driver(struct pci_driver *drv) { }

--------------2FE3BDBBEC6847EC15E722F9--

