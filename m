Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbUCaQQp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 11:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUCaQQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 11:16:45 -0500
Received: from mailgate4.cinetic.de ([217.72.192.167]:16613 "EHLO
	mailgate4.cinetic.de") by vger.kernel.org with ESMTP
	id S262022AbUCaQOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 11:14:39 -0500
Message-ID: <406AECD1.3010409@web.de>
Date: Wed, 31 Mar 2004 18:07:45 +0200
From: Marcus Hartig <m.f.h@web.de>
Organization: Linux of Borgs
User-Agent: Mozilla Thunderbird 0.5+ (X11/20040323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speed up SATA
References: <406A5B6E.8050302@web.de> <406A6B87.801@pobox.com>
In-Reply-To: <406A6B87.801@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Can you post the relevant 'dmesg' output?

Linux version 2.6.5-rc3-mm1 (cowboy@redtuxi) (gcc-Version 3.3.3 20040311 
(Red Hat Linux 3.3.3-3))
...
Kernel command line: ro root=/dev/sda1 doataraid noraid acpi=off rhgb
...
libata version 1.02 loaded.
sata_sil version 0.54
ata1: SATA max UDMA/100 cmd 0xE0800080 ctl 0xE080008A bmdma 0xE0800000 irq 4
ata2: SATA max UDMA/100 cmd 0xE08000C0 ctl 0xE08000CA bmdma 0xE0800008 irq 4
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 
88:207f
ata1: dev 0 ATA, max UDMA/133, 160086528 sectors
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: no device found (phy stat 00000000)
ata2: thread exiting
scsi1 : sata_sil
   Vendor: ATA       Model: Maxtor 6Y080M0    Rev: 1.02
   Type:   Direct-Access                      ANSI SCSI revision: 05
ata1: dev 0 max request 128K
SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
SCSI device sda: drive cache: write through
  sda: sda1 sda2 sda3 sda4 < sda5 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
------------------%<------------------------------------

Also my Maxtor is now configured for UDMA/100. With earlier versions of 
libata/sata_sil it was UDMA/133 wo any problems. The performance is now 
dropped a little bit from ~52MB to ~48MB with hdparm.
Best regards,

Marcus
