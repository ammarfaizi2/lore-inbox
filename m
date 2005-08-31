Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbVHaKiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbVHaKiZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 06:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVHaKiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 06:38:25 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:10114 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932318AbVHaKiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 06:38:24 -0400
Message-ID: <43158800.6010303@gmail.com>
Date: Wed, 31 Aug 2005 12:35:44 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Brett Russ <russb@emc.com>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.13] Marvell SATA support (PIO mode)
References: <20050830183625.BEE1520F4C@lns1058.lss.emc.com>
In-Reply-To: <20050830183625.BEE1520F4C@lns1058.lss.emc.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brett Russ napsal(a):

>This is the first public release of my libata compatible low level driver for
>the Marvell SATA family.  Currently it successfully runs in PIO mode on a 6081
>chip.  EDMA support is in the works and should be done shortly.  Review,
>testing (especially on other flavors of Marvell), comments welcome.
>  
>
[snip]

>+static struct pci_device_id mv_pci_tbl[] = {
>+	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5040), 0, 0, chip_504x},
>+	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5041), 0, 0, chip_504x},
>+	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5080), 0, 0, chip_508x},
>+	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5081), 0, 0, chip_508x},
>+
>+	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6040), 0, 0, chip_604x},
>+	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6041), 0, 0, chip_604x},
>+	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6080), 0, 0, chip_608x},
>+	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6081), 0, 0, chip_608x},
>+	{}			/* terminate list */
>+};
> <http://localhost/lxr/ident?i=MODULE_DEVICE_TABLE>
>
MODULE_DEVICE_TABLE(pci, 
<http://localhost/lxr/ident?i=MODULE_DEVICE_TABLE>mv_pci_tbl);  here for 
hotplug

>+
>+static struct pci_driver mv_pci_driver = {
>+	.name			= DRV_NAME,
>+	.id_table		= mv_pci_tbl,
>+	.probe			= mv_init_one,
>+	.remove			= ata_pci_remove_one,
>+};
>  
>
[snip]

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

