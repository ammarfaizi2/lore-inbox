Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWGLHsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWGLHsa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 03:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWGLHsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 03:48:06 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:63648 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1750801AbWGLHsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 03:48:03 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Remove pci_dac_set_dma_mask() from Documentation/DMA-mapping.txt
Date: Wed, 12 Jul 2006 09:47:16 +0200
User-Agent: KMail/1.9.3
References: <200607120942.23071@bilbo.math.uni-mannheim.de>
In-Reply-To: <200607120942.23071@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607120947.17034@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pci_dac_set_dma_mask() gives only a single match in the whole kernel tree
and that's in this doc file. The best candidate for replacement is
pci_dac_dma_supported().

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

---
commit 609c9a2c7a61f6fab9cb8507bb01e8bb8fa9f183
tree 6fccc01d3ac08c9a4bcec67a7ff430aa368b68c2
parent 7471539cb5e9cdd7ca7e48a247e15797d0e53708
author Rolf Eike Beer <eike-kernel@sf-tec.de> Wed, 12 Jul 2006 09:36:05 +0200
committer Rolf Eike Beer <beer@siso-eb-i34d.silicon-software.de> Wed, 12 Jul 2006 09:36:05 +0200

 Documentation/DMA-mapping.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/DMA-mapping.txt b/Documentation/DMA-mapping.txt
index 7c71769..63392c9 100644
--- a/Documentation/DMA-mapping.txt
+++ b/Documentation/DMA-mapping.txt
@@ -698,12 +698,12 @@ these interfaces.  Remember that, as def
 always going to be SAC addressable.
 
 The first thing your driver needs to do is query the PCI platform
-layer with your devices DAC addressing capabilities:
+layer if it is capable of handling your devices DAC addressing
+capabilities:
 
-	int pci_dac_set_dma_mask(struct pci_dev *pdev, u64 mask);
+	int pci_dac_dma_supported(struct pci_dev *hwdev, u64 mask);
 
-This routine behaves identically to pci_set_dma_mask.  You may not
-use the following interfaces if this routine fails.
+You may not use the following interfaces if this routine fails.
 
 Next, DMA addresses using this API are kept track of using the
 dma64_addr_t type.  It is guaranteed to be big enough to hold any
