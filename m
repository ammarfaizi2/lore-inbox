Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVHHRVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVHHRVD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVHHRVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:21:02 -0400
Received: from fmr24.intel.com ([143.183.121.16]:17385 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932122AbVHHRVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:21:02 -0400
From: Jesse Barnes <jesse.barnes@intel.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ata_piix hang in 2.6.13-rc5
Date: Mon, 8 Aug 2005 10:20:48 -0700
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508081020.48945.jesse.barnes@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently tried to upgrade an ICH5 based box I have to see if a PCI 
resource allocation bug went away, but was stymied by the fact that 
recent kernels (2.6.12 from Fedora and 2.6.13-rc5) hang when ata_piix 
probes for drives.  The last messages I get are these:

Loading ata_piix.ko module
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 177
ata1: SATA max UDMA/133 cmd 0xC800 ctl 0xC482 bmdma 0xC000 irq 177
ata2: SATA max UDMA/133 cmd 0xC400 ctl 0xC082 bmdma 0xC008 irq 177
ata1: SATA port has no device.
scsi0: ata_piix
ata2: dev 0 ata, max UDMA/133, 312581808 sectors, lba48
<hang>

Is this a known problem?  Is there anything in particular I should try?

Thanks,
Jesse

