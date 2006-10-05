Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751758AbWJESAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbWJESAJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 14:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbWJESAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 14:00:09 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.8]:54541 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751758AbWJESAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 14:00:08 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: 2.6.19-rc1: libata PATA CDROM poor performance
Date: Thu, 5 Oct 2006 19:00:11 +0100
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051900.11402.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

I've been experimenting with your PATA drivers again on 2.6.19-rc1. I notice 
that optical drives don't seem to behave correctly. I can't tell what the 
exact problem is, but if I put a CD in, the drive never really spins up, and 
read performance is very poor (~3.0MB/s).

Any ideas?

pata_amd 0000:00:06.0: version 0.2.4
PCI: Setting latency timer of device 0000:00:06.0 to 64
ata5: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xE800 irq 14
ata6: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xE808 irq 15
scsi4 : pata_amd
ata5.00: ATAPI, max UDMA/33
ata5.00: configured for UDMA/33
scsi5 : pata_amd
ATA: abnormal status 0x8 on port 0x177
scsi 4:0:0:0: CD-ROM            _NEC     DVD_RW ND-4570A  1.03 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 4:0:0:0: Attached scsi CD-ROM sr0

(OTOH, I tried putting a damaged CD in the drive and the error handling on the 
new libata PATA code is marvellous. I was able to unmount and eject the disk 
within a couple of seconds of the first media error, a vast improvement over 
the CONFIG_IDE alternative..)

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
