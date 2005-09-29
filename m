Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbVI2H4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVI2H4h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 03:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbVI2H4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 03:56:37 -0400
Received: from port-83-236-157-249.static.qsc.de ([83.236.157.249]:12936 "EHLO
	kaasa.com") by vger.kernel.org with ESMTP id S932188AbVI2H4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 03:56:36 -0400
Message-ID: <433B9E31.5040406@gmail.com>
Date: Thu, 29 Sep 2005 09:56:33 +0200
From: Matteo Brusa <matteo.brusa@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: libata/ata_piix stuck in combined mode
X-Enigmail-Version: 0.90.1.1
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm running Sarge on a Dell PE 750, official Debian kernel 2.6.8-2-686,
with 2 SATA disks. The disk controller is an Intel ICH5.
Since I upgraded from kernel 2.4 to 2.6, the DMA disk access doesn't
work anymore, because libata and ata_piix goes in combined mode:

# grep -i ata /var/log/dmesg
 BIOS-e820: 000000003ffc0000 - 000000003ffcfc00 (ACPI data)
Memory: 1031108k/1048320k available (1551k kernel code, 16284k reserved, 690k data, 148k init,
130816k highmem)
libata version 1.02 loaded.
ata_piix version 1.02
ata_piix: combined mode detected
ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xFEA0 irq 14
ata1: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0407
ata1: dev 0 ATAPI, max UDMA/33
ata1: dev 0 configured for UDMA/33
scsi0 : ata_piix
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFEA8 irq 15
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 88:207f
ata2: dev 0 ATA, max UDMA/133, 156250000 sectors:
ata2: dev 0 configured for UDMA/133
scsi1 : ata_piix
  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
EXT3-fs: mounted filesystem with ordered data mode.

I've read some posts here about disabling the PATA/SATA mixed mode in the BIOS; too bad there's no
such a switch in Dell servers.
I tried to disable the IDE cdrom in the BIOS, with no luck. Also kernel 2.6.12 from Knoppix 4.0.2
couldn't help.
Is there a way to force the ata_piix module out of combined mode?

Thanks in advance.
