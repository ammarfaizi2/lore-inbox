Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263871AbUEHCkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbUEHCkz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 22:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbUEHCkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 22:40:55 -0400
Received: from main.gmane.org ([80.91.224.249]:59853 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263871AbUEHCkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 22:40:53 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: sean <seandarcy@hotmail.com>
Subject: can't see drive on promise 20375 ATA card
Date: Fri, 07 May 2004 22:32:25 -0400
Message-ID: <c7hgrq$5bv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ool-4356fe48.dyn.optonline.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a) Gecko/20040501
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

got a maxtor sata/i50 combo card today. It uses the promise 20375 chip 
with 2 SATA ports and one ATA port.

Using 2.6.6-rc3-bk8.

grep SATA .config
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_SVW is not set
CONFIG_SCSI_SATA_PROMISE=y

Also:

# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set

should they be?

dmesg has:

libata version 1.02 loaded.
sata_promise version 0.92
ata1: SATA max UDMA/133 cmd 0xE1863200 ctl 0xE1863238 bmdma 0x0 irq 19
ata2: SATA max UDMA/133 cmd 0xE1863280 ctl 0xE18632B8 bmdma 0x0 irq 19
ata1: no device found (phy stat 00000000)
ata1: thread exiting
scsi0 : sata_promise
ata2: no device found (phy stat 00000000)
ata2: thread exiting
scsi1 : sata_promise


So it can see the SATA ports.

How do I get the kernel to see the ATA port on the card?

thanks

sean

