Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbSKFBoW>; Tue, 5 Nov 2002 20:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265477AbSKFBnY>; Tue, 5 Nov 2002 20:43:24 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:20496 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265474AbSKFBms>;
	Tue, 5 Nov 2002 20:42:48 -0500
Date: Tue, 5 Nov 2002 17:45:28 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI hotplug changes for 2.5.46
Message-ID: <20021106014528.GY18627@kroah.com>
References: <20021106013615.GQ18627@kroah.com> <20021106013708.GR18627@kroah.com> <20021106013741.GS18627@kroah.com> <20021106013835.GT18627@kroah.com> <20021106013915.GU18627@kroah.com> <20021106014304.GV18627@kroah.com> <20021106014358.GW18627@kroah.com> <20021106014444.GX18627@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106014444.GX18627@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.875.1.8, 2002/11/02 23:43:53-08:00, greg@kroah.com

[PATCH] PCI Hotplug: fix compiler warning.


diff -Nru a/drivers/hotplug/pci_hotplug_util.c b/drivers/hotplug/pci_hotplug_util.c
--- a/drivers/hotplug/pci_hotplug_util.c	Tue Nov  5 17:25:58 2002
+++ b/drivers/hotplug/pci_hotplug_util.c	Tue Nov  5 17:25:58 2002
@@ -96,7 +96,7 @@
 {
 	struct pci_bus *bus;
 	struct pci_bus_wrapped wrapped_bus;
-	int result;
+	int result = 0;
 
 	dbg("scanning bridge %02x, %02x\n", PCI_SLOT(wrapped_dev->dev->devfn),
 	    PCI_FUNC(wrapped_dev->dev->devfn));
