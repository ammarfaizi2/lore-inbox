Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132554AbQKWGca>; Thu, 23 Nov 2000 01:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132568AbQKWGcU>; Thu, 23 Nov 2000 01:32:20 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:43783 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S132554AbQKWGcK>; Thu, 23 Nov 2000 01:32:10 -0500
Date: Thu, 23 Nov 2000 00:02:07 -0600
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch(?): pci_device_id tables for drivers/scsi in 2.4.0-test11
Message-ID: <20001123000207.O2918@wire.cadcamlab.org>
In-Reply-To: <20001122045154.A13572@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001122045154.A13572@baldur.yggdrasil.com>; from adam@yggdrasil.com on Wed, Nov 22, 2000 at 04:51:54AM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Adam J. Richter]
> +static struct pci_device_id atp870u_pci_tbl[] __initdata = {
> +{vendor: 0x1191, device: 0x8002, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
> +{vendor: 0x1191, device: 0x8010, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
> +{vendor: 0x1191, device: 0x8020, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
> +{vendor: 0x1191, device: 0x8030, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
> +{vendor: 0x1191, device: 0x8040, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
> +{vendor: 0x1191, device: 0x8050, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
> +{vendor: 0x1191, device: 0x8060, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},

You should add the ID numbers to pci_ids.h instead of hardcoding them
here.  That would make the structure a lot more readable than using
member name tags.

Peter

--- include/linux/pci_ids.h.orig	Mon Nov 13 01:43:49 2000
+++ include/linux/pci_ids.h	Wed Nov 22 23:57:51 2000
@@ -864,6 +864,13 @@
 #define PCI_DEVICE_ID_ARTOP_ATP850UF	0x0005
 #define PCI_DEVICE_ID_ARTOP_ATP860	0x0006
 #define PCI_DEVICE_ID_ARTOP_ATP860R	0x0007
+#define PCI_DEVICE_ID_ARTOP_AEC7610	0x8002
+#define PCI_DEVICE_ID_ARTOP_AEC7612UW	0x8010
+#define PCI_DEVICE_ID_ARTOP_AEC7612U	0x8020
+#define PCI_DEVICE_ID_ARTOP_AEC7612S	0x8030
+#define PCI_DEVICE_ID_ARTOP_AEC7612D	0x8040
+#define PCI_DEVICE_ID_ARTOP_AEC7612SUW	0x8050
+//#define PCI_DEVICE_ID_ARTOP_???	0x8060
 
 #define PCI_VENDOR_ID_ZEITNET		0x1193
 #define PCI_DEVICE_ID_ZEITNET_1221	0x0001
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
