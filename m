Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932686AbWB1Xmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbWB1Xmr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbWB1Xmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:42:47 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:29151 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S932686AbWB1Xmq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:42:46 -0500
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Transfer-Encoding: 7bit
Message-Id: <2A4AF27A-15CC-4827-A764-C865122617AF@bootc.net>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linux-kernel@vger.kernel.org
From: Chris Boot <bootc@bootc.net>
Subject: libata PATA patch for 2.6.16-rc5
Date: Tue, 28 Feb 2006 23:42:43 +0000
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

2.6.16-rc4-ide2 correctly identified my HP Colorado tape drive (which  
I haven't had a chance to use yet...), but 2.6.16-rc5-ide1 doesn't at  
all:

[4294687.689000] pata_via 0000:00:0f.1: version 0.1.4
[4294687.689000] ACPI: PCI Interrupt 0000:00:0f.1[A] -> Link [ALKA] - 
 > GSI 20 (level, low) -> IRQ 177
[4294687.689000] PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 1
[4294687.689000] ata5: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma  
0xD000 irq 14
[4294687.841000] via_do_set_mode: Mode=8 ast broken=Y udma=133 mul=4
[4294688.021000] ata5: dev 0 cfg 49:0f00 82:0218 83:4000 84:4000  
85:0218 86:0000 87:4000 88:101f
[4294688.021000] ata5: dev 0 ATAPI, max UDMA/66
[4294688.021000] via_do_set_mode: Mode=8 ast broken=Y udma=133 mul=4
[4294688.021000] via_do_set_mode: Mode=12 ast broken=Y udma=133 mul=4
[4294688.021000] via_do_set_mode: Mode=68 ast broken=Y udma=133 mul=4
[4294688.021000] ata5: dev 0 configured for UDMA/66
[4294688.021000] scsi4 : pata_via
[4294688.027000]   Vendor: PIONEER   Model: DVD-RW  DVR-110D  Rev: 1.39
[4294688.027000]   Type:   CD-ROM                             ANSI  
SCSI revision: 05
[4294688.127000] sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2  
cdda tray
[4294688.127000] Uniform CD-ROM driver Revision: 3.20
[4294688.128000] sr 4:0:0:0: Attached scsi CD-ROM sr0
[4294688.128000] sr 4:0:0:0: Attached scsi generic sg4 type 5
[4294688.128000] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma  
0xD008 irq 15
[4294688.588000] via_do_set_mode: Mode=8 ast broken=Y udma=133 mul=4
[4294688.745000] ata6: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000  
85:0000 86:0000 87:0000 88:0000
[4294688.745000] ata6: dev 0 ATAPI, max MWDMA2
[4294688.745000] via_do_set_mode: Mode=8 ast broken=Y udma=133 mul=4
[4294688.785000] usb 1-1: new low speed USB device using uhci_hcd and  
address 4
[4294688.896000] ata6: PIO error
[4294688.896000] via_do_set_mode: Mode=12 ast broken=Y udma=133 mul=4
[4294688.896000] via_do_set_mode: Mode=34 ast broken=Y udma=133 mul=4
[4294688.896000] ata6: dev 0 configured for MWDMA2
[4294688.896000] scsi5 : pata_via

I'm guessing it's the PIO error, but I really don't have a clue.

HTH,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/


