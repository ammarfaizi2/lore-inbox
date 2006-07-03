Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWGCTky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWGCTky (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 15:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWGCTky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 15:40:54 -0400
Received: from web33514.mail.mud.yahoo.com ([68.142.206.163]:63931 "HELO
	web33514.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751251AbWGCTkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 15:40:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Jx6uiaeXabr045C8X9dmE+F3oxXv9WSAd6MAPoOu0WB6J+ZlKTwc9Jp5rwovY1+faHe2onRcbnbrxJaLHUSa8IpgeIuQcK/jtJi2eIuxCiqZVqENWEkfWm8hDfXJC4dDPW3dd1GvAHHmYvljb8HbegBQIy/Qxm4uY/u2g9Vn82Q=  ;
Message-ID: <20060703194052.905.qmail@web33514.mail.mud.yahoo.com>
Date: Mon, 3 Jul 2006 12:40:52 -0700 (PDT)
From: Narendra Hadke <nhadke@yahoo.com>
Subject: Fwd: Re: sata_mv driver on 88sx6041 ( 2.6.14):DriveReady SeekComplete
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2017456613-1151955652=:821"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-2017456613-1151955652=:821
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,
   I have backported the 0.25 verion of sata_mv.c to
 2.6.14. This the patched version with DMA Boundry
fixes. I need a backport as kernel is supported for
a specific hardware (Cavium Octeon).
 This looks somewaht stable on the hardware as
compared
 to 0.5 and 07 which are very unstable and gets struct
in middle. I can send those logs if needed. Please
note
 that in PIO mode everything looks OK with this setup.
   Apreciate your help.
Thanks,
Narendra
   Here is the log for  0.25 with DMA bounryfixes. I 
few erros are follows 
------------------------------------------------
CSI device sda: drive cache: write back
 sda:<4>ata3: status=0x50 { DriveReady SeekComplete }
ata3: error=0x01 { AddrMarkNotFound }
sata_mv: PCI ERROR; PCI IRQ cause=0x00000400
sda: Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
 unknown partition table

---------------------------------------------
Here is log  SCSI messages....
ata_mv 0000:00:0d.0: version 0.25
PCI: Enabling device 0000:00:0d.0 (0000 -> 0003)
sata_mv 0000:00:0d.0: 32 slots 4 ports SCSI mode IRQ
via INTx
ata1: SATA max UDMA/133 cmd 0x0 ctl 0x80011B0008022120
bmdma 0x0 irq 47
ata2: SATA max UDMA/133 cmd 0x0 ctl 0x80011B0008024120
bmdma 0x0 irq 47
ata3: SATA max UDMA/133 cmd 0x0 ctl 0x80011B0008026120
bmdma 0x0 irq 47
ata4: SATA max UDMA/133 cmd 0x0 ctl 0x80011B0008028120
bmdma 0x0 irq 47
ata1: no device found (phy stat 00000000)
scsi0 : sata_mv
ata2: no device found (phy stat 00000000)
scsi1 : sata_mv
ata3: dev 0 ATA-7, max UDMA/100, 156301488 sectors:
LBA48
ata3: dev 0 configured for UDMA/100
scsi2 : sata_mv
ata4: no device found (phy stat 00000000)
scsi3 : sata_mv
  Vendor: ATA       Model: HTS721080G9SA00   Rev: MC4O
  Type:   Direct-Access                      ANSI SCSI
revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors
(80026 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors
(80026 MB)
SCSI device sda: drive cache: write back
 sda:<4>ata3: status=0x50 { DriveReady SeekComplete }
ata3: error=0x01 { AddrMarkNotFound }
sata_mv: PCI ERROR; PCI IRQ cause=0x00000400
sda: Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
 unknown partition table
Attached scsi disk sda at scsi2, channel 0, id 0, lun
0
Attached scsi generic sg0 at scsi2, channel 0, id 0,
lun 0,  type 0


Note: forwarded message attached.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-2017456613-1151955652=:821
Content-Type: message/rfc822
Content-Transfer-Encoding: 8bit

Received: from [69.26.216.147] by web33514.mail.mud.yahoo.com via HTTP; Thu, 29 Jun 2006 18:09:26 PDT
Date: Thu, 29 Jun 2006 18:09:26 -0700 (PDT)
From: Narendra Hadke <nhadke@yahoo.com>
Subject: Re: sata_mv driver on 88sx6041 (kernel version 2.6.14)
To: linux-kernel@vger.kernel.org
Cc: nhadke@yahoo.com
In-Reply-To: <4496B47B.7070602@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


Got it working. Thanks.
This works in PIO mode hence performance is horrible.
I see the udma mode is set to 0 in driver 2.6.14
sata_mv version 0.12.  Is is possible to Back port
sata_mv from versin 2.6.17 to 2.6.14 to get a stable
drive. 
   Please let me know.
Thanks,
Narendra 

--- Mark Lord <lkml@rtr.ca> wrote:

> Narendra Hadke wrote:
> > Hi,
> > I am using sata_mv driver as exists in kernel
> 2.6.13,
> > reached to a stage where after detecting the disk,
> > control gets struck. Any ideas? 
> 
> No surprises there.  The sata_mv driver is horribly
> buggy
> in all kernels prior to 2.6.16, and even there it
> still has
> some serious bugs.  The 2.6.17 kernel version is
> MUCH better.
> 
> Cheers
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--0-2017456613-1151955652=:821--
