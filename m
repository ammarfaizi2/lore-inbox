Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbUKSWCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbUKSWCv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUKSWBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:01:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:42647 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261625AbUKSV5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:57:53 -0500
Date: Fri, 19 Nov 2004 13:57:22 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc2
Message-ID: <20041119215722.GD15863@kroah.com>
References: <20041119215618.GA15863@kroah.com> <20041119215640.GB15863@kroah.com> <20041119215659.GC15863@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119215659.GC15863@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.2166, 2004/11/19 10:02:19-08:00, rddunlap@osdl.org

[PATCH] PCI Hotplug: cpcihp_generic: fix module_param data type

drivers/pci/hotplug/cpcihp_generic.c:214: warning: return from
incompatible pointer type

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/cpcihp_generic.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/pci/hotplug/cpcihp_generic.c b/drivers/pci/hotplug/cpcihp_generic.c
--- a/drivers/pci/hotplug/cpcihp_generic.c	2004-11-19 13:20:04 -08:00
+++ b/drivers/pci/hotplug/cpcihp_generic.c	2004-11-19 13:20:04 -08:00
@@ -63,7 +63,7 @@
 
 /* local variables */
 static int debug;
-static char bridge[256];
+static char *bridge;
 static u8 bridge_busnr;
 static u8 bridge_slot;
 static struct pci_bus *bus;
