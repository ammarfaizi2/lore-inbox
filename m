Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbUCaBp0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 20:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbUCaBp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 20:45:26 -0500
Received: from s2.org ([195.197.64.39]:42882 "EHLO kalahari.s2.org")
	by vger.kernel.org with ESMTP id S261292AbUCaBpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 20:45:18 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [sata] libata update
References: <4064E691.2070009@pobox.com> <4069FBC3.2080104@scssoft.com>
	<4069FF46.7090604@pobox.com>
From: Jarno Paananen <jpaana@s2.org>
Date: Wed, 31 Mar 2004 04:43:39 +0300
In-Reply-To: <4069FF46.7090604@pobox.com> (Jeff Garzik's message of "Tue, 30
 Mar 2004 18:14:14 -0500")
Message-ID: <m34qs5iyes.fsf@kalahari.s2.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> Petr Sebor wrote:
>> Hi Jeff,
>> I have upgraded from 2.6.3 to 2.6.5-rc3 and can't see the secondary
>> sata drive anymore...
>
> Does this patch fix it?

I'm using the 2.4 kernel version (would be using 2.6 if there was
support for IT8212 ide-"raid" controller, hint hint Bart :) and had
the same problem. This fixed it:

libata version 1.02 loaded.
sata_via version 0.20
sata_via(00:0f.0): routed to hard irq line 5
ata1: SATA max UDMA/133 cmd 0xB400 ctl 0xB802 bmdma 0xC400 irq 20
ata2: SATA max UDMA/133 cmd 0xBC00 ctl 0xC002 bmdma 0xC408 irq 20
ata1: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3e01
87:4003 88:407f
ata1: dev 0 ATA, max UDMA/133, 72303840 sectors (lba48)
ata1: dev 0 configured for UDMA/133
ata2: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3e01
87:4003 88:203f
ata2: dev 0 ATA, max UDMA/100, 488397168 sectors (lba48)
ata2: dev 0 configured for UDMA/100
scsi1 : sata_via
scsi2 : sata_via
  Vendor: ATA       Model: WDC WD360GD-00FN  Rev: 1.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD2500JD-22F  Rev: 1.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
Attached scsi disk sda at scsi0, channel 0, id 3, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
SCSI device sda: 71833096 512-byte hdwr sectors (36779 MB)
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
SCSI device sdb: 72303840 512-byte hdwr sectors (37020 MB)
 sdb: sdb1
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
 sdc: sdc1 < sdc5 sdc6 >

(sda is a real SCSI disk)

Thanks,

// Jarno
