Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVATQuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVATQuG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 11:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbVATQrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 11:47:32 -0500
Received: from smtp0.libero.it ([193.70.192.33]:29585 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S262775AbVATQqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 11:46:19 -0500
Message-ID: <41EFE05E.1050501@libero.it>
Date: Thu, 20 Jan 2005 17:46:22 +0100
From: Marco Cipullo <cipullo@libero.it>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Typo in [AGPGART] i915GM support patch
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From last changeset:

--- a/drivers/char/agp/intel-agp.c	2005-01-20 08:38:39 -08:00
+++ b/drivers/char/agp/intel-agp.c	2005-01-20 08:38:39 -08:00

@@ -415,14 +415,16 @@
  			break;
  		case I915_GMCH_GMS_STOLEN_48M:
  			/* Check it's really I915G */
- if (agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82915G_HB)
+ if (agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82915G_HB ||
+     agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82915G_HB)
  	gtt_entries = MB(48) - KB(size);
  else
  	gtt_entries = 0;
  break;


Peraphs is:

@@ -415,14 +415,16 @@
  			break;
  		case I915_GMCH_GMS_STOLEN_48M:
  			/* Check it's really I915G */
- if (agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82915G_HB)
+ if (agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82915G_HB ||
+     agp_bridge->dev->device == PCI_DEVICE_ID_INTEL_82915GM_HB)
  	gtt_entries = MB(48) - KB(size);
  else
  	gtt_entries = 0;
  break;



The same applies few lines below....


Hope can help. Bye
Marco
