Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263000AbUDYQJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbUDYQJB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 12:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbUDYQJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 12:09:01 -0400
Received: from tench.street-vision.com ([212.18.235.100]:45513 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S263000AbUDYQI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 12:08:59 -0400
Subject: sata_sil bug
From: Justin Cormack <justin@street-vision.com>
To: Jeff Garzik <jgarzik@pobox.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1082909255.21233.22.camel@lotte.street-vision.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 25 Apr 2004 17:07:36 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Using sata_sil on sii3112A on 2.6.5-rc2 (sorry a bit old, will update
but I dont think there are any changes to the driver) I got an error:

ata1: DMA timeout, stat 0x0
ATA: abnormal status 0xD8 on port 0xF8807087
scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x2a 00 17 9b d9 80 00 00
20 00
Current sda: sense = 70  3
ASC= c ASCQ= 2
Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00
0x00 0x0c
end_request: I/O error, dev sda, sector 396089728
ATA: abnormal status 0xD8 on port 0xF8807087
ATA: abnormal status 0xD8 on port 0xF8807087
ATA: abnormal status 0xD8 on port 0xF8807087

Then all accesses to the drive got stuck in D state.
I think the disk has bad sectors or other faults - had read errors
earlier, but this is the first bad disk I have had that has had problems
recovering. Could I have hit the state that requires the watchdog?

Justin


