Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265305AbSKFBeb>; Tue, 5 Nov 2002 20:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbSKFBeb>; Tue, 5 Nov 2002 20:34:31 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:14608 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265305AbSKFBe3>;
	Tue, 5 Nov 2002 20:34:29 -0500
Date: Tue, 5 Nov 2002 17:37:08 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI hotplug changes for 2.5.46
Message-ID: <20021106013708.GR18627@kroah.com>
References: <20021106013615.GQ18627@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106013615.GQ18627@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.875.1.1, 2002/11/02 22:25:32-08:00, rmk@arm.linux.org.uk

[PATCH] PCI hotplug comment fixes

Fix comments about /sbin/hotplug; pci_insert_device does not call
/sbin/hotplug.


diff -Nru a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
--- a/drivers/pci/hotplug.c	Tue Nov  5 17:26:33 2002
+++ b/drivers/pci/hotplug.c	Tue Nov  5 17:26:33 2002
@@ -71,8 +71,7 @@
  * @bus: where to insert it
  *
  * Link the device to both the global PCI device chain and the 
- * per-bus list of devices, add the /proc entry, and notify
- * userspace (/sbin/hotplug).
+ * per-bus list of devices, add the /proc entry.
  */
 void
 pci_insert_device(struct pci_dev *dev, struct pci_bus *bus)
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Tue Nov  5 17:26:33 2002
+++ b/drivers/pci/probe.c	Tue Nov  5 17:26:33 2002
@@ -480,8 +480,7 @@
 
 		/*
 		 * Link the device to both the global PCI device chain and
-		 * the per-bus list of devices and call /sbin/hotplug if we
-		 * should.
+		 * the per-bus list of devices and add the /proc entry.
 		 */
 		pci_insert_device (dev, bus);
 
