Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWG3Txv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWG3Txv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 15:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWG3Txv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 15:53:51 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:21918 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932455AbWG3Txv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 15:53:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=DMADYY8Mn5vJujWu704hoJOh0RJ2qk+XACfk3I819BKnH10jy1uHsoQDJavtu80I/tV00WB46O43PtbDARs50FTTFVtIfLiYmrXIRXkUUSx5UjdznGlXYW/Z2a4DXJXkH1V8QB839+YjUWo9t49+n+vBpKDYrpzpZfMVcYb2ZZQ=
Message-ID: <44CD0E55.4020206@gmail.com>
Date: Mon, 31 Jul 2006 04:53:57 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?=22J=2EA=2E_Magall=F3n=22?= <jamagallon@ono.com>
CC: "Linux-Kernel, " <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [2.6.18-rc2-mm1] libata ate one PATA channel
References: <20060728134550.030a0eb8@werewolf.auna.net>
In-Reply-To: <20060728134550.030a0eb8@werewolf.auna.net>
Content-Type: multipart/mixed;
 boundary="------------000805050705030801010902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000805050705030801010902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

J.A. Magallón wrote:
> Hi...
> 
> I've been out for more than a week. Just went to try -rc2-mm1 and
> it ate one ide channel...
> 
> This was -rc1-mm2:
> libata version 2.00 loaded.
> ata_piix 0000:00:1f.1: version 2.00ac6
> ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:00:1f.1 to 64
> ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
> scsi0 : ata_piix
> ata1.00: ATAPI, max UDMA/33
> ata1.01: ATAPI, max MWDMA0, CDB intr
> ata1.00: configured for PIO3
> ata1.01: configured for PIO3
>   Vendor: HL-DT-ST  Model: DVDRAM GSA-4120B  Rev: A111
>   Type:   CD-ROM                             ANSI SCSI revision: 05
>   Vendor: IOMEGA    Model: ZIP 250           Rev: 51.G
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
> scsi1 : ata_piix
> ata2.00: ATA-6, max UDMA/100, 234441648 sectors: LBA48
> ata2.00: ata2: dev 0 multi count 16
> ata2.01: ATAPI, max UDMA/33
> ata2.00: configured for UDMA/33
> ata2.01: configured for UDMA/33
>   Vendor: ATA       Model: ST3120022A        Rev: 3.06
>   Type:   Direct-Access                      ANSI SCSI revision: 05
>   Vendor: TOSHIBA   Model: DVD-ROM SD-M1712  Rev: 1004
>   Type:   CD-ROM                             ANSI SCSI revision: 05
> ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
> ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> ata3: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
> ata4: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
> 
> 
> This is -rc2-mm1, a PATA channel is missing...
> 
> libata version 2.00 loaded.
> ata_piix 0000:00:1f.1: version 2.00ac6
> ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:00:1f.1 to 64
> ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
> scsi0 : ata_piix
> ata1.00: ATAPI, max UDMA/33 
> ata1.01: ATAPI, max MWDMA0, CDB intr
> ata1.00: configured for UDMA/33
> ata1.01: configured for PIO3
>   Vendor: HL-DT-ST  Model: DVDRAM GSA-4120B  Rev: A111 
>   Type:   CD-ROM                             ANSI SCSI revision: 05
>   Vendor: IOMEGA    Model: ZIP 250           Rev: 51.G 
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ] 
> ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> ata2: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
> ata3: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
> 
> Any idea ?
> Any more info needed ?

lspci -n please.  Also, can you report what the kernel says with the 
attached patch applied?

Thanks.

-- 
tejun

--------------000805050705030801010902
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 9ce221f..9397f0b 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -1070,6 +1070,10 @@ int ata_pci_init_one (struct pci_dev *pd
 		goto err_out_regions;
 	}
 
+	dev_printk(KERN_INFO, &pdev->dev,
+		   "XXX: legacy_mode=%x probe_ent=%p probe_ent2=%p\n",
+		   legacy_mode, probe_ent, probe_ent2);
+
 	pci_set_master(pdev);
 
 	/* FIXME: check ata_device_add return */
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 66feebd..9756ee6 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5401,8 +5401,11 @@ int ata_device_add(const struct ata_prob
 	/* alloc a container for our list of ATA ports (buses) */
 	host_set = kzalloc(sizeof(struct ata_host_set) +
 			   (ent->n_ports * sizeof(void *)), GFP_KERNEL);
-	if (!host_set)
+	if (!host_set) {
+		printk(KERN_ERR "ata_device_add() alloc failed, n_ports=%d\n",
+		       ent->n_ports);
 		return 0;
+	}
 	spin_lock_init(&host_set->lock);
 
 	host_set->dev = dev;
@@ -5419,8 +5422,10 @@ int ata_device_add(const struct ata_prob
 		unsigned long xfer_mode_mask;
 
 		ap = ata_host_add(ent, host_set, i);
-		if (!ap)
+		if (!ap) {
+			printk(KERN_ERR "ata_host_add() failed\n");
 			goto err_out;
+		}
 
 		host_set->ports[i] = ap;
 		xfer_mode_mask =(ap->udma_mask << ATA_SHIFT_UDMA) |
@@ -5537,7 +5542,7 @@ err_out:
 	}
 err_free_ret:
 	kfree(host_set);
-	VPRINTK("EXIT, returning 0\n");
+	printk(KERN_ERR "ata_device_add() ERROR, returning 0\n");
 	return 0;
 }
 

--------------000805050705030801010902--
