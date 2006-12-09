Return-Path: <linux-kernel-owner+w=401wt.eu-S936887AbWLIP3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936887AbWLIP3B (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 10:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936899AbWLIP3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 10:29:01 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:56378 "EHLO
	alpha.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936887AbWLIP3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 10:29:01 -0500
Date: Sat, 9 Dec 2006 16:28:59 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.6.19 does not boot, while 2.6.19-rc4 does
Message-ID: <20061209152859.GA14037@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

[Please Cc]

I copied my old config-2.6.19-rc4 to a clean linux-2.6.19 tree, called
make oldconfig; make, installed the kernel and modules, but the kernel
cannot find the root file system.

I diffed the two config files and the only not-comment diff is:
-# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_SYSCTL_SYSCALL=y
(how did this happen?)


a part of the dmesg is included here (from -rc4):

libata version 2.00 loaded.
ata_piix 0000:00:1f.2: version 2.00ac6
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x18B0 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x18B8 irq 15
scsi0 : ata_piix
PM: Adding info for No Bus:host0
ata1.00: ATA-7, max UDMA/133, 195371568 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : ata_piix

Hardware: Acer TravelMate 3012


Any suggestions what to do next?

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>                    Università di Siena
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
HARBLEDOWN (vb.)
To manoeuvre a double mattress down a winding staircase.
			--- Douglas Adams, The Meaning of Liff
