Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUF3TPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUF3TPJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 15:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUF3TOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 15:14:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11394 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261252AbUF3TOe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 15:14:34 -0400
Message-ID: <40E3110B.5070503@pobox.com>
Date: Wed, 30 Jun 2004 15:14:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Travis Morgan <lkml@bigfiber.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA problems on two different systems
References: <1088487355.16294.424.camel@castle.bigfiber.net>
In-Reply-To: <1088487355.16294.424.camel@castle.bigfiber.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Travis Morgan wrote:
> scsi1: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 03 30 b7 74 00 00
> 7d 00 
> Current sdb: sense = 70  3
> ASC=11 ASCQ= 4
> Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00
> 0x00 0x11 0x04 
> end_request: I/O error, dev sdb, sector 53524340
> scsi1: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 03 30 b7 75 00 00
> 7c 00 
> Current sdb: sense = 70  3
> ASC=11 ASCQ= 4
> Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00
> 0x00 0x11 0x04 
> end_request: I/O error, dev sdb, sector 53524341
> scsi1: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 03 30 b7 76 00 00
> 7b 00 
> Current sdb: sense = 70  3
> ASC=11 ASCQ= 4
> Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00
> 0x00 0x11 0x04 
> end_request: I/O error, dev sdb, sector 53524342
> scsi1: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 03 30 b7 77 00 00
> 7a 00 
> Current sdb: sense = 70  3
> ASC=11 ASCQ= 4
> Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00
> 0x00 0x11 0x04 
> end_request: I/O error, dev sdb, sector 53524343
> scsi1: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 03 30 b7 78 00 00
> 79 00 
> Current sdb: sense = 70  3
> ASC=11 ASCQ= 4
> Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00
> 0x00 0x11 0x04 
> end_request: I/O error, dev sdb, sector 53524344
> <SNIP>
> raid1: Disk failure on sdb3, disabling device. 
>         Operation continuing on 1 devices
> raid1: sdb: unrecoverable I/O read error for block 52737152
> md: md1: sync done.
> RAID1 conf printout:
>  --- wd:1 rd:2
>  disk 0, wo:1, o:0, dev:sdb3
>  disk 1, wo:0, o:1, dev:sda3
> RAID1 conf printout:
>  --- wd:1 rd:2
>  disk 1, wo:0, o:1, dev:sda3
> md: syncing RAID array md1
> md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
> md: using maximum available idle IO bandwith (but not more than 200000
> KB/sec) for reconstruction.
> md: using 128k window, over a total of 116824064 blocks.
> md: md1: sync done.
> RAID1 conf printout:
>  --- wd:1 rd:2
>  disk 1, wo:0, o:1, dev:sda3
> 
> This raid volume is on two Seagate Barracuda 120 gig SATA drives running
> on the system's ICH5 SATA controller.
[...]
> Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00
> 0x00 0x11 0x04 
> end_request: I/O error, dev sda, sector 91683284
> scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 05 76 f9 d5 00 00
> 72 00 
> Current sda: sense = 70  3
> ASC=11 ASCQ= 4
> Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00
> 0x00 0x11 0x04 
> end_request: I/O error, dev sda, sector 91683285
> scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 05 76 f9 d6 00 00
> 71 00 
> Current sda: sense = 70  3
> ASC=11 ASCQ= 4
> Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00
> 0x00 0x11 0x04 
> end_request: I/O error, dev sda, sector 91683286
> scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 05 76 f9 d7 00 00
> 70 00 
> Current sda: sense = 70  3
> ASC=11 ASCQ= 4
> Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00
> 0x00 0x11 0x04 
> end_request: I/O error, dev sda, sector 91683287
> scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 05 76 f9 d8 00 00
> 6f 00 
> Current sda: sense = 70  3
> ASC=11 ASCQ= 4
> Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00
> 0x00 0x11 0x04 
> end_request: I/O error, dev sda, sector 91683288
> scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 05 76 f9 d9 00 00
> 6e 00 
> Current sda: sense = 70  3
> ASC=11 ASCQ= 4
> Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00
> 0x00 0x11 0x04 
> end_request: I/O error, dev sda, sector 91683289
> scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 05 76 f9 da 00 00
> 6d 00 
> Current sda: sense = 70  3
> ASC=11 ASCQ= 4
> Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00
> 0x00 0x11 0x04 
> end_request: I/O error, dev sda, sector 91683290
> <SNIP>
> 
> This system has two Seagate Barracuda 160 gig SATA drives running on a
> PDC20376 SATA controller. 
> 
> I'm not sure if this is a problem with something I've done or a bug
> handling SATA in the kernel. I find it disturbing that both these
> systems have this problem with different hardware configurations but the
> same type of drives (only different sizes).
> 
> The first system, endeavour, was up for over 30 days. It was then
> rebooted and has crashed for an unknown reason twice since and shows
> these dmesg entries after booting up.
> 
> The second system, castle, gives me those messages when I try to copy
> some data from sda1 and hangs the process for a very long time while it
> keeps advancing 'bad sectors'.
> 
> If there's anything else I can do to test this let me know.


You certainly provided the right information, thanks :)

While I certainly would not rule out a driver bug, these errors are 
normally indicative of some sort of hardware problem.  My first guess is 
always to replace the SATA cables.

I'll be instrumenting the SATA driver to provide a lot more verbosity on 
error very soon, so getting you to test again when that is in place (a 
few days, a week at most) would be useful.

	Jeff


