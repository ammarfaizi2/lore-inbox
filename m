Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWGSXpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWGSXpI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 19:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWGSXpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 19:45:08 -0400
Received: from mailrelay3.sunrise.ch ([194.158.229.31]:37016 "EHLO
	obelix.sunrise.ch") by vger.kernel.org with ESMTP id S964875AbWGSXpH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 19:45:07 -0400
Date: Wed, 19 Jul 2006 19:40:44 -0400
To: gregkh@suse.de
Cc: Richard Knutsson <ricknu-0@student.ltu.se>, linux-kernel@vger.kernel.org
Subject: [PATCH] doc: pci_module_init() removal
Message-ID: <20060719234044.GB8584@krypton>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
From: apgo@patchbomb.org (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pci_module_init() is deprecated and on it's way out in favor of
pci_register_driver(). Remove all documentation references to it.

Signed-off-by: Arthur Othieno <apgo@patchbomb.org>
---
 Documentation/PCIEBUS-HOWTO.txt |    2 +-
 Documentation/pci.txt           |    2 --
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/Documentation/PCIEBUS-HOWTO.txt b/Documentation/PCIEBUS-HOWTO.txt
index c93f42a..7369219 100644
--- a/Documentation/PCIEBUS-HOWTO.txt
+++ b/Documentation/PCIEBUS-HOWTO.txt
@@ -93,7 +93,7 @@ the PCI Express Port Bus driver from loa
 
 int pcie_port_service_register(struct pcie_port_service_driver *new)
 
-This API replaces the Linux Driver Model's pci_module_init API. A
+This API replaces the Linux Driver Model's pci_register_driver API. A
 service driver should always calls pcie_port_service_register at
 module init. Note that after service driver being loaded, calls
 such as pci_enable_device(dev) and pci_set_master(dev) are no longer
diff --git a/Documentation/pci.txt b/Documentation/pci.txt
index 2b395e4..b75a481 100644
--- a/Documentation/pci.txt
+++ b/Documentation/pci.txt
@@ -236,8 +236,6 @@ pci_find_slot()			Find pci_dev correspon
 pci_set_power_state()		Set PCI Power Management state (0=D0 ... 3=D3)
 pci_find_capability()		Find specified capability in device's capability
 				list.
-pci_module_init()		Inline helper function for ensuring correct
-				pci_driver initialization and error handling.
 pci_resource_start()		Returns bus start address for a given PCI region
 pci_resource_end()		Returns bus end address for a given PCI region
 pci_resource_len()		Returns the byte length of a PCI region
-- 
1.4.0

