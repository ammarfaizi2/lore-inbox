Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWB1KjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWB1KjU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 05:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWB1KjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 05:39:20 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:41652 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S932157AbWB1KjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 05:39:19 -0500
Message-ID: <44042863.2050703@dgreaves.com>
Date: Tue, 28 Feb 2006 10:39:31 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca>
In-Reply-To: <4403CEA9.4080603@rtr.ca>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:

> Tejun Heo wrote:
>
>> BTW, can you let me know what drive we're talking about now (model
>> name and firmware revision)?
>
>
> David:  we need to see the output from "hdparm --Istdout /dev/sda
> (or whichever drive it was that was failing on your system).
>
> Cheers
>
So here's the info for sda and sdb (see below for related log data).

/dev/sda:
 IO_support   =  0 (default 16-bit)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 24321/255/63, sectors = 390721968, start = 0
0040 3fff c837 0010 0000 0000 003f 0000
0000 0000 4234 3033 3852 5248 2020 2020
2020 2020 2020 2020 0003 4000 0004 4241
4e43 3139 3830 4d61 7874 6f72 2036 4232
3030 4d30 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 2f00 4000 0200 0000 0007 3fff 0010
003f fc10 00fb 0100 ffff 0fff 0000 0007
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 0000 0002 0000 0000 0000
00fe 001e 7869 7d09 4043 7869 3c01 4043
203f 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 f1b0 1749 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0113 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 d3a5

/dev/sdb:
 IO_support   =  0 (default 16-bit)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 24792/255/63, sectors = 398297088, start = 0
0040 3fff c837 0010 0000 0000 003f 0000
0000 0000 4234 3152 5641 3148 2020 2020
2020 2020 2020 2020 0003 4000 0004 4241
4e43 3142 5930 4d61 7874 6f72 2036 4232
3030 4d30 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 2f00 4000 0200 0000 0007 3fff 0010
003f fc10 00fb 0100 ffff 0fff 0000 0007
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 001f 0102 0000 0000 0000
00fe 001e 7c6b 7f09 4063 7c69 3e01 4063
207f 0000 0000 0000 fffe 0000 c0fe 0000
0000 0000 0000 0000 8800 17bd 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0001 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0113 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 d8a5

The info below is from the log I saved booted with 2.6.16-rc4
I got these errors:

sd 0:0:0:0: SCSI error: return code = 0x8000002
sda: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 390716735
raid5: Disk failure on sda1, disabling device. Operation continuing on 2
devices
ata2: no sense translation for op=0x2a cmd=0x3d status: 0x51
ata2: status=0x51 { DriveReady SeekComplete Error }
sd 1:0:0:0: SCSI error: return code = 0x8000002
sdb: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdb, sector 390716735
raid5: Disk failure on sdb1, disabling device. Operation continuing on 1
devices

They are both attached to:
libata version 1.20 loaded.
sata_sil 0000:00:0a.0: version 0.9
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 16 (level, low) -> IRQ 17
ata1: SATA max UDMA/100 cmd 0xF8804080 ctl 0xF880408A bmdma 0xF8804000
irq 17
ata2: SATA max UDMA/100 cmd 0xF88040C0 ctl 0xF88040CA bmdma 0xF8804008
irq 17
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:7869 83:7d09 84:4043 85:7869 86:3c01 87:4043
88:203f
ata1: dev 0 ATA-7, max UDMA/100, 390721968 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063
88:007f
ata2: dev 0 ATA-7, max UDMA/133, 398297088 sectors: LBA48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
  Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05

Are there any other tests; like swapping the disks to the other
controller (sata_via) and seeing what happens. With and without the patch?

David

-- 

