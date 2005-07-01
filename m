Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262713AbVGAU7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbVGAU7E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 16:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVGAU5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 16:57:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:51681 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262713AbVGAUtj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 16:49:39 -0400
Cc: hare@suse.de
Subject: [PATCH] PCI: Remove newline from pci MODALIAS variable
In-Reply-To: <11202509121851@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Jul 2005 13:48:32 -0700
Message-Id: <11202509122229@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: Remove newline from pci MODALIAS variable

the pci core sends out a hotplug event variable MODALIAS with a trailing
newline. This is inconsistent with all other event variables and breaks
some hotplug tools. This patch removes the said newline.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit c6e21e1683c2508a2b23588e1fc2e7bf6fc2549e
tree 17e925938d956a3eb17aa59ce0d3add0957906e1
parent 5823d100ae260d022b4dd5ec9cc0b85f0bf0d646
author Hannes Reinecke <hare@suse.de> Tue, 28 Jun 2005 14:57:10 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 01 Jul 2005 13:35:51 -0700

 drivers/pci/hotplug.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
--- a/drivers/pci/hotplug.c
+++ b/drivers/pci/hotplug.c
@@ -54,7 +54,7 @@ int pci_hotplug (struct device *dev, cha
 
 	envp[i++] = scratch;
 	length += scnprintf (scratch, buffer_size - length,
-			    "MODALIAS=pci:v%08Xd%08Xsv%08Xsd%08Xbc%02Xsc%02Xi%02x\n",
+			    "MODALIAS=pci:v%08Xd%08Xsv%08Xsd%08Xbc%02Xsc%02Xi%02x",
 			    pdev->vendor, pdev->device,
 			    pdev->subsystem_vendor, pdev->subsystem_device,
 			    (u8)(pdev->class >> 16), (u8)(pdev->class >> 8),

