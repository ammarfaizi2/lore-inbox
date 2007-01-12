Return-Path: <linux-kernel-owner+w=401wt.eu-S1161028AbXALH5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbXALH5T (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 02:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161030AbXALH5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 02:57:19 -0500
Received: from mail.first.fraunhofer.de ([194.95.169.2]:55303 "EHLO
	mail.first.fraunhofer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161028AbXALH5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 02:57:18 -0500
Subject: SATA hotplug from the user side ?
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 12 Jan 2007 08:57:09 +0100
Message-Id: <1168588629.5403.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I'd like to try out SATA hotplugging using a SIL3114. Though I was
harvesting the web, I could not find any useful information how this is
done in practice.

Well I realized that I can still use scsiadd to print and remove
devices, e.g.:

# scsiadd -p

Attached devices:
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3400832AS      Rev: 3.01
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3400620AS      Rev: 3.AA
  Type:   Direct-Access                    ANSI SCSI revision: 05

# scsiadd -r 3 0 0 0

Is this all one has to do for hotplugging ? I am asking as I find this
in dmesg when I do so (2.6.19.* kernel):

Synchronizing SCSI cache for disk sdb: 
ata4.00: disabled
ata4: exception Emask 0x10 SAct 0x0 SErr 0x10000 action 0x2 frozen
ata4: hard resetting port
ata4: SATA link down (SStatus 0 SControl 310)
ata4: EH complete
ata4: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
ata4: hard resetting port
ata4: port is slow to respond, please be patient (Status 0xff)
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata4.00: ATA-7, max UDMA/133, 781422768 sectors: LBA48 NCQ (depth 0/32)
ata4.00: configured for UDMA/100
ata4: EH complete
scsi 3:0:0:0: rejecting I/O to dead device
scsi 3:0:0:0: rejecting I/O to dead device


Soeren
-- 
For the one fact about the future of which we can be certain is that it
will be utterly fantastic. -- Arthur C. Clarke, 1962
