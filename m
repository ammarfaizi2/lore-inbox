Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWJATip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWJATip (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 15:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWJATio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 15:38:44 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:6796 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932246AbWJATio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 15:38:44 -0400
Message-ID: <45201943.7050408@verkstad.net>
Date: Sun, 01 Oct 2006 21:38:43 +0200
From: Theo Kanter <theo@verkstad.net>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.18 PATA support for sata_promise not working for PDC20378
 on MSI 865PE-NEO FISR2 motherboard
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.6.18 claims to provide PATA support for sata_promise according 
to the changelog. However, 2.6.18 does not properly load the IDE disks 
that are attached to an onboard raid-controller Promise PDC200378 (aka 
Fastrak 378 or Fastrak S150 TX4) which resides on an MSI 865PE-NEO FISR2 
motherboard as a "south bridge" for a maximum of two IDE disks and two 
SATA disks. I configured the BIOS for two IDE disks and RAID1 or as SATA 
and no change. The errors from sata_promise seen in the dmesg file as 
error messages (attached):

    ata1: SATA max UDMA/133 cmd 0xF8802200 ctl 0xF8802238 bmdma 0x0 irq 11
    ata2: SATA max UDMA/133 cmd 0xF8802280 ctl 0xF88022B8 bmdma 0x0 irq 11
    scsi2 : sata_promise
    ata1: SATA link down (SStatus 0 SControl 300)
    scsi3 : sata_promise
    ata2: SATA link down (SStatus 0 SControl 300)

Please Cc: theo@verkstad.net in your reply as I am not subscribed to 
this list.
Thanks in advance
--theo

