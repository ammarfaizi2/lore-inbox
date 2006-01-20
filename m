Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWATTHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWATTHG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWATTFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:05:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:33744 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751173AbWATTFE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:05:04 -0500
Cc: bunk@stusta.de
Subject: [PATCH] PCI: drivers/pci/pci.c: #if 0 pci_find_ext_capability()
In-Reply-To: <1137783877218@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Jan 2006 11:04:37 -0800
Message-Id: <11377838771790@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: drivers/pci/pci.c: #if 0 pci_find_ext_capability()

This patch #if 0's the unused global function pci_find_ext_capability().

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit fcac4238faf5cace3946d6c0102c176370483ed6
tree aadecf0a10301aebeeb69d12d6709e14e6fef511
parent ac142f4e6f34d59ae0554dc96fe5bb030df02ab9
author Adrian Bunk <bunk@stusta.de> Fri, 06 Jan 2006 03:25:37 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 10:29:33 -0800

 drivers/pci/pci.c   |    2 ++
 include/linux/pci.h |    2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d2a633e..d2d1879 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -163,6 +163,7 @@ int pci_bus_find_capability(struct pci_b
 	return __pci_bus_find_cap(bus, devfn, hdr_type & 0x7f, cap);
 }
 
+#if 0
 /**
  * pci_find_ext_capability - Find an extended capability
  * @dev: PCI device to query
@@ -210,6 +211,7 @@ int pci_find_ext_capability(struct pci_d
 
 	return 0;
 }
+#endif  /*  0  */
 
 /**
  * pci_find_parent_resource - return resource region of parent bus of given region
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0a44072..fe1a2b0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -406,7 +406,6 @@ struct pci_dev *pci_find_device_reverse 
 struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn);
 int pci_find_capability (struct pci_dev *dev, int cap);
 int pci_find_next_capability (struct pci_dev *dev, u8 pos, int cap);
-int pci_find_ext_capability (struct pci_dev *dev, int cap);
 struct pci_bus * pci_find_next_bus(const struct pci_bus *from);
 
 struct pci_dev *pci_get_device (unsigned int vendor, unsigned int device, struct pci_dev *from);
@@ -626,7 +625,6 @@ static inline int pci_register_driver(st
 static inline void pci_unregister_driver(struct pci_driver *drv) { }
 static inline int pci_find_capability (struct pci_dev *dev, int cap) {return 0; }
 static inline int pci_find_next_capability (struct pci_dev *dev, u8 post, int cap) { return 0; }
-static inline int pci_find_ext_capability (struct pci_dev *dev, int cap) {return 0; }
 static inline const struct pci_device_id *pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev) { return NULL; }
 
 /* Power management related routines */

